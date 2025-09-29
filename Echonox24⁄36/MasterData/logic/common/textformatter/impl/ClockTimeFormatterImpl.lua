-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/ClockTimeFormatterImpl.lua

module("logic.common.textformatter.impl.ClockTimeFormatterImpl", package.seeall)

local ClockTimeFormatterImpl = class("ClockTimeFormatterImpl", ITextDataFormatter)

function ClockTimeFormatterImpl:ctor()
	self.HourFormatPattern = "h:m:s"
	self.MinuteFormatPattern = "m:s"
end

function ClockTimeFormatterImpl:format(timeSeconds)
	if timeSeconds >= TextFormatterConst.HOUR then
		return TimeUtil.instance:numberToTime(timeSeconds, self.HourFormatPattern)
	end

	return TimeUtil.instance:numberToTime(timeSeconds, self.MinuteFormatPattern)
end

return ClockTimeFormatterImpl
