-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_hero_extra_reward.lua

module("logic.config.t_lottery_hero_extra_reward", package.seeall)

local title = {
	lotteryNum = 2,
	quality = 1,
	itemCode = 3,
	itemNum = 4
}
local dataList = {
	{
		5,
		6,
		1100007,
		10
	},
	{
		5,
		-1,
		1100007,
		15
	},
	{
		4,
		6,
		1100007,
		2
	},
	{
		4,
		-1,
		1100007,
		3
	},
	{
		3,
		6,
		1100008,
		5
	},
	{
		3,
		-1,
		1100008,
		8
	}
}
local t_lottery_hero_extra_reward = {}

t_lottery_hero_extra_reward.dataList = dataList

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
	local parent1 = t_lottery_hero_extra_reward[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_lottery_hero_extra_reward[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_lottery_hero_extra_reward
