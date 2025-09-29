-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_activity_config.lua

module("logic.config.t_activity_config", package.seeall)

local title = {
	config = 2,
	logic = 1,
	redeemDays = 3
}
local dataList = {
	{
		1,
		1001,
		0
	},
	{
		1,
		1002,
		0
	},
	{
		1,
		1003,
		0
	},
	{
		1,
		7,
		0
	},
	{
		2,
		20001,
		0
	},
	{
		3,
		30001,
		0
	},
	{
		4,
		1,
		0
	},
	{
		5,
		10000,
		0
	},
	{
		6,
		60002,
		0
	},
	{
		6,
		60051,
		0
	},
	{
		6,
		60057,
		0
	},
	{
		7,
		70001,
		0
	},
	{
		8,
		80001,
		2
	},
	{
		9,
		90001,
		0
	},
	{
		9,
		90002,
		0
	},
	{
		9,
		90003,
		0
	},
	{
		9,
		90004,
		0
	},
	{
		10,
		100001,
		0
	},
	{
		10,
		100002,
		0
	},
	{
		11,
		110001,
		0
	},
	{
		12,
		120001,
		0
	}
}
local t_activity_config = {}

t_activity_config.dataList = dataList

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
	local parent1 = t_activity_config[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_activity_config[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_activity_config
