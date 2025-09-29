-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_task_point_reward.lua

module("logic.config.t_task_point_reward", package.seeall)

local title = {
	id = 1,
	point = 2,
	rewardId = 3
}
local dataList = {
	{
		10101,
		10,
		1601001
	},
	{
		10102,
		20,
		1601002
	},
	{
		10103,
		30,
		1601003
	},
	{
		10104,
		60,
		1601004
	},
	{
		10105,
		90,
		1601005
	},
	{
		10106,
		120,
		1601006
	},
	{
		10201,
		10,
		1602001
	},
	{
		10202,
		20,
		1602002
	},
	{
		10203,
		40,
		1602003
	},
	{
		10204,
		60,
		1602004
	},
	{
		10205,
		80,
		1602005
	},
	{
		10206,
		100,
		1602006
	},
	{
		10207,
		120,
		1602007
	},
	{
		10208,
		150,
		1602008
	}
}
local t_task_point_reward = {}

t_task_point_reward.dataList = dataList

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
	t_task_point_reward[v[1]] = v

	setmetatable(v, mt)
end

return t_task_point_reward
