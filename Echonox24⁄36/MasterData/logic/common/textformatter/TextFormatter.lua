-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/TextFormatter.lua

module("logic.common.textformatter.TextFormatter", package.seeall)

local TextFormatter = class("TextFormatter")

function TextFormatter.formatDate(dateSeconds, pattern)
	return TextFormatter.format(FormatterEnum.DATE, dateSeconds, pattern)
end

function TextFormatter.formatNumber(numberValue, isInt)
	return TextFormatter.format(FormatterEnum.NUMERICAL, numberValue, isInt)
end

function TextFormatter.formatExpireTime(timeSeconds)
	return TextFormatter.format(FormatterEnum.EXPIRE_TIME, timeSeconds)
end

function TextFormatter.formatFullExpireTime(timeSeconds)
	local timeStr = TextFormatter.format(FormatterEnum.EXPIRE_TIME, timeSeconds)

	return string.format(TextFormatterConst.EXPIRE_TIME_FORMAT_PATTERN, timeStr)
end

function TextFormatter.formatPastTime(timeSeconds)
	return TextFormatter.format(FormatterEnum.PAST_TIME, timeSeconds)
end

function TextFormatter.formatFullPastTime(timeSeconds)
	local timeStr = TextFormatter.format(FormatterEnum.PAST_TIME, timeSeconds)

	if string.nilorempty(timeStr) then
		return timeStr
	end

	return string.format(TextFormatterConst.PAST_TIME_FORMAT_PATTERN, timeStr)
end

function TextFormatter.formatFullTime(timeSeconds, single)
	return TextFormatter.format(FormatterEnum.FULL_TIME, timeSeconds, single)
end

function TextFormatter.formatClockTime(timeSeconds)
	return TextFormatter.format(FormatterEnum.CLOCK_TIME, timeSeconds)
end

function TextFormatter.formatLastLogoutTime(timeSeconds)
	return TextFormatter.format(FormatterEnum.LAST_LOGOUT_TIME, timeSeconds)
end

function TextFormatter.format(formatterEnum, ...)
	return TextFormatter._instance:_formatValue(formatterEnum, ...)
end

function TextFormatter:ctor()
	self._formatterMap = {}

	self:_registerFormatter(FormatterEnum.DATE, DateFormatterImpl)
	self:_registerFormatter(FormatterEnum.NUMERICAL, NumericalFormatterImpl)
	self:_registerFormatter(FormatterEnum.EXPIRE_TIME, ExpireTimeFormatterImpl)
	self:_registerFormatter(FormatterEnum.PAST_TIME, PastTimeFormatterImpl)
	self:_registerFormatter(FormatterEnum.CLOCK_TIME, ClockTimeFormatterImpl)
	self:_registerFormatter(FormatterEnum.FULL_TIME, FullTimeFormatterImpl)
	self:_registerFormatter(FormatterEnum.LAST_LOGOUT_TIME, LastLogoutTimeFormatterImpl)
end

function TextFormatter:_formatValue(formatterEnum, ...)
	return self._formatterMap[formatterEnum]:format(...)
end

function TextFormatter:_registerFormatter(formatterEnum, formatterCls)
	self._formatterMap[formatterEnum] = formatterCls.New()
end

TextFormatter._instance = TextFormatter.New()

return TextFormatter
