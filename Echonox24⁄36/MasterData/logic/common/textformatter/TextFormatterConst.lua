-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/TextFormatterConst.lua

module("logic.common.textformatter.TextFormatterConst", package.seeall)

local TextFormatterConst = {}

TextFormatterConst.DAY = 86400
TextFormatterConst.HOUR = 3600
TextFormatterConst.MINUTE = 60
TextFormatterConst.EMPTY = ""
TextFormatterConst.MONTH_FORMAT_PATTERN = "%s月"
TextFormatterConst.DAY_FORMAT_PATTERN = "%s天"
TextFormatterConst.HOUR_FORMAT_PATTERN = "%s小时"
TextFormatterConst.MINUTE_FORMAT_PATTERN = "%s分钟"
TextFormatterConst.SECOND_FORMAT_PATTERN = "%s秒"
TextFormatterConst.EXPIRE_TIME_FORMAT_PATTERN = "剩余%s"
TextFormatterConst.PAST_TIME_FORMAT_PATTERN = "%s前"

return TextFormatterConst
