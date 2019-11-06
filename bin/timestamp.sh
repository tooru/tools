#!/bin/sh

abort() {
    exit 1
}

usage() {
    echo "# $(basename $0) file"
    abort
}

if [ $# -lt 1 ]; then
    usage
fi

FILE=$1

mkdir -p timestamp || abort

DATE=$(identify -format '%[exif:dateTimeOriginal]' "$1" | ruby -rtime -e 'puts gets.sub(/(\d+):(\d+):(\d+) \d+:\d+:\d+/, "\\1/\\2/\\3")')

convert "$1" \
-stroke '#000c' -strokewidth 10 -pointsize 125 -gravity southeast -annotate +200+200 $DATE \
-stroke none -fill orange -pointsize 125 -gravity southeast -annotate +200+200 $DATE \
timestamp/"$1"
