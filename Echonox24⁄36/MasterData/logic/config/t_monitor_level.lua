-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_monitor_level.lua

module("logic.config.t_monitor_level", package.seeall)

local title = {
	multiplicityOpenCondition = 4,
	canRecord = 6,
	equipLvLimit = 10,
	powerNodeLimit = 9,
	heroLvLimit = 8,
	canMultiplicityCost = 3,
	consecutive = 7,
	multiplicityLimit = 5,
	code = 1,
	level = 2
}
local dataList = {
	{
		171001,
		1,
		1,
		2,
		6,
		1,
		6,
		15,
		1,
		1
	},
	{
		171002,
		35,
		1,
		2,
		6,
		1,
		6,
		50,
		13,
		20
	},
	{
		171003,
		45,
		1,
		2,
		6,
		1,
		6,
		70,
		18,
		25
	},
	{
		171004,
		1,
		0,
		2,
		0,
		0,
		0,
		15,
		0,
		0
	},
	{
		171005,
		1,
		0,
		2,
		0,
		0,
		0,
		15,
		0,
		0
	},
	{
		171021,
		1,
		1,
		2,
		6,
		1,
		6,
		15,
		1,
		1
	},
	{
		171022,
		35,
		1,
		2,
		6,
		1,
		6,
		50,
		13,
		20
	},
	{
		171023,
		45,
		1,
		2,
		6,
		1,
		6,
		70,
		18,
		25
	},
	{
		171024,
		1,
		0,
		2,
		0,
		0,
		0,
		15,
		0,
		0
	},
	{
		171041,
		1,
		1,
		2,
		6,
		1,
		6,
		15,
		1,
		1
	},
	{
		171042,
		35,
		1,
		2,
		6,
		1,
		6,
		50,
		13,
		20
	},
	{
		171043,
		45,
		1,
		2,
		6,
		1,
		6,
		70,
		18,
		25
	},
	{
		171044,
		1,
		0,
		2,
		0,
		0,
		0,
		15,
		0,
		0
	}
}
local t_monitor_level = {}

t_monitor_level.dataList = dataList

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
	t_monitor_level[v[1]] = v

	setmetatable(v, mt)
end

return t_monitor_level
