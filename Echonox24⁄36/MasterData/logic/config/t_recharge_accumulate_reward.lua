-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_recharge_accumulate_reward.lua

module("logic.config.t_recharge_accumulate_reward", package.seeall)

local title = {
	id = 1,
	reward = 3,
	credit = 2
}
local dataList = {
	{
		1,
		6,
		2400101
	},
	{
		2,
		18,
		2400102
	},
	{
		3,
		80,
		2400103
	},
	{
		4,
		120,
		2400104
	},
	{
		5,
		200,
		2400105
	},
	{
		6,
		480,
		2400106
	},
	{
		7,
		880,
		2400107
	},
	{
		8,
		1880,
		2400108
	},
	{
		9,
		5880,
		2400109
	},
	{
		10,
		8880,
		2400110
	},
	{
		11,
		12880,
		2400111
	},
	{
		12,
		18880,
		2400112
	}
}
local t_recharge_accumulate_reward = {}

t_recharge_accumulate_reward.dataList = dataList

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
	t_recharge_accumulate_reward[v[1]] = v

	setmetatable(v, mt)
end

return t_recharge_accumulate_reward
