#!/bin/bash

URL=http://www.suntory.co.jp/eco/birds/encyclopedia
PLAYER="mplayer -really-quiet $URL"


html=`wget -qO- $URL/nakigoe.html`
line=`echo $html | nkf --unix -S -w | grep mp3`
list=`echo "$line" | awk -F '\"' '{print $4 $7}' | sed 's/<.*>//'`
urls=`echo "$list" | sed 's/^\.//;s/>/ /'`
#echo "$urls"


IFS=$'\n'

for data in $urls; do
    cmd=`echo $data | awk -v m=$PLAYER '{print "echo " $2 ";" m $1}'`
    eval $cmd
done

