-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_heroFilterRule.lua

module("logic.config.t_heroFilterRule", package.seeall)

local title = {
	filters = 2,
	code = 1
}
local dataList = {
	{
		1,
		"0#1#2#3#4#5#6#7"
	},
	{
		2,
		"0#1#2#3#4#5#6"
	},
	{
		3,
		"0#5#4#3#2"
	}
}
local t_heroFilterRule = {}

t_heroFilterRule.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_heroFilterRule[v[1]] = v

	setmetatable(v, mt)
end

return t_heroFilterRule
