-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_limit_time_activity.lua

module("logic.config.t_limit_time_activity", package.seeall)

local title = {
	code = 1,
	cellBg = 3,
	iconName = 2
}
local dataList = {
	{
		30001,
		"足球活动",
		""
	}
}
local t_limit_time_activity = {}

t_limit_time_activity.dataList = dataList

local multiLanguageCells = {
	iconName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_limit_time_activity[v[1]] = v

	setmetatable(v, mt)
end

return t_limit_time_activity
