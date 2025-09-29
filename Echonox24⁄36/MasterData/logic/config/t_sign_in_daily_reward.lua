-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sign_in_daily_reward.lua

module("logic.config.t_sign_in_daily_reward", package.seeall)

local title = {
	reward = 3,
	stage = 2,
	day = 1
}
local dataList = {
	{
		1,
		1,
		1700101
	},
	{
		2,
		1,
		1700102
	},
	{
		3,
		1,
		1700103
	},
	{
		4,
		1,
		1700104
	},
	{
		5,
		1,
		1700105
	},
	{
		6,
		1,
		1700106
	},
	{
		7,
		1,
		1700107
	},
	{
		8,
		2,
		1700108
	},
	{
		9,
		2,
		1700109
	},
	{
		10,
		2,
		1700110
	},
	{
		11,
		2,
		1700111
	},
	{
		12,
		2,
		1700112
	},
	{
		13,
		2,
		1700113
	},
	{
		14,
		2,
		1700114
	},
	{
		15,
		3,
		1700115
	},
	{
		16,
		3,
		1700116
	},
	{
		17,
		3,
		1700117
	},
	{
		18,
		3,
		1700118
	},
	{
		19,
		3,
		1700119
	},
	{
		20,
		3,
		1700120
	},
	{
		21,
		3,
		1700121
	},
	{
		22,
		4,
		1700122
	},
	{
		23,
		4,
		1700123
	},
	{
		24,
		4,
		1700124
	},
	{
		25,
		4,
		1700125
	},
	{
		26,
		4,
		1700126
	},
	{
		27,
		4,
		1700127
	},
	{
		28,
		4,
		1700128
	}
}
local t_sign_in_daily_reward = {}

t_sign_in_daily_reward.dataList = dataList

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
	t_sign_in_daily_reward[v[1]] = v

	setmetatable(v, mt)
end

return t_sign_in_daily_reward
