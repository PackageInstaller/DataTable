-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/FullTimeFormatterImpl.lua

module("logic.common.textformatter.impl.FullTimeFormatterImpl", package.seeall)

local FullTimeFormatterImpl = class("FullTimeFormatterImpl", ITextDataFormatter)

function FullTimeFormatterImpl:format(timeSeconds, single)
	if timeSeconds <= 0 then
		return string.format(TextFormatterConst.SECOND_FORMAT_PATTERN, 0)
	end

	local result = {}

	if timeSeconds >= TextFormatterConst.DAY then
		local day = math.floor(timeSeconds / TextFormatterConst.DAY)

		timeSeconds = timeSeconds - TextFormatterConst.DAY * day

		local formatStr = string.format(TextFormatterConst.DAY_FORMAT_PATTERN, day)

		if single then
			return formatStr
		end

		table.insert(result, formatStr)
	end

	if timeSeconds >= TextFormatterConst.HOUR then
		local hour = math.floor(timeSeconds / TextFormatterConst.HOUR)

		timeSeconds = timeSeconds - TextFormatterConst.HOUR * hour

		local formatStr = string.format(lang(TextFormatterConst.HOUR_FORMAT_PATTERN), hour)

		if single then
			return formatStr
		end

		table.insert(result, formatStr)
	end

	if timeSeconds >= TextFormatterConst.MINUTE then
		local minute = math.floor(timeSeconds / TextFormatterConst.MINUTE)

		timeSeconds = timeSeconds - TextFormatterConst.MINUTE * minute

		local formatStr = string.format(TextFormatterConst.MINUTE_FORMAT_PATTERN, minute)

		if single then
			return formatStr
		end

		table.insert(result, formatStr)
	end

	if timeSeconds > 0 then
		local formatStr = string.format(TextFormatterConst.SECOND_FORMAT_PATTERN, timeSeconds)

		if single then
			return formatStr
		end

		table.insert(result, formatStr)
	end

	return table.concat(result, "")
end

return FullTimeFormatterImpl
