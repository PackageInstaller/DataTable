-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/DateFormatterImpl.lua

module("logic.common.textformatter.impl.DateFormatterImpl", package.seeall)

local DateFormatterImpl = class("DateFormatterImpl", ITextDataFormatter)

function DateFormatterImpl:ctor()
	self.defaultFormatPattern = "%Y-%m-%d %H:%M"
end

function DateFormatterImpl:format(dateSeconds, pattern)
	dateSeconds = checkint(dateSeconds)

	print("DateFormatterImpl:format", tostring(pattern))

	return ServerTime.formatTimeServerLook(dateSeconds, pattern or self.defaultFormatPattern)
end

return DateFormatterImpl
