-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_monster_action.lua

module("logic.config.t_roguelike_monster_action", package.seeall)

local title = {
	type = 5,
	showHead = 8,
	id = 1,
	tailTarget = 7,
	effect = 4,
	name = 2,
	bgIcon = 9,
	effectDesc = 3,
	icon = 6
}
local dataList = {
	{
		1,
		"邪力",
		"造成%s点伤害",
		{
			80000201
		},
		"初始卡牌",
		"1",
		{
			2
		},
		1,
		"pt_card_10006"
	},
	{
		2,
		"狡诈",
		"产生%s颗骰子护盾",
		{
			80000202
		},
		"初始卡牌",
		"2",
		{
			5
		},
		2,
		"pt_card_10001"
	},
	{
		3,
		"阴谋",
		"造成%s点伤害,产生%s颗骰子护盾",
		{
			80000203,
			80000204
		},
		"初始卡牌",
		"3",
		{
			2
		},
		2,
		"pt_card_10007"
	},
	{
		4,
		"呢喃",
		"使守秘人损失%s点理智值",
		{
			80000205
		},
		"初始卡牌",
		"4",
		{
			2
		},
		1,
		"pt_card_10003"
	},
	{
		5,
		"躲闪",
		"产生%s颗骰子护盾",
		{
			80000206
		},
		"初始卡牌",
		"5",
		{
			5
		},
		2,
		"pt_card_10006"
	},
	{
		6,
		"盗窃",
		"扣除%s个熊熊币",
		{
			80000207
		},
		"初始卡牌",
		"6",
		{
			2
		},
		1,
		"pt_card_10002"
	},
	{
		11,
		"攻击",
		"造成%s点伤害",
		{
			80000201
		},
		"初始卡牌",
		"1",
		{
			2
		},
		1,
		"pt_card_10006"
	},
	{
		12,
		"躲闪",
		"产生%s颗骰子护盾",
		{
			80000202
		},
		"初始卡牌",
		"2",
		{
			5
		},
		2,
		"pt_card_10001"
	},
	{
		13,
		"反击",
		"造成%s点伤害,产生%s颗骰子护盾",
		{
			80000203,
			80000204
		},
		"初始卡牌",
		"3",
		{
			2
		},
		2,
		"pt_card_10007"
	},
	{
		14,
		"挑衅",
		"使守秘人损失%s点理智值",
		{
			80000205
		},
		"初始卡牌",
		"4",
		{
			2
		},
		1,
		"pt_card_10003"
	},
	{
		15,
		"看破",
		"产生%s颗骰子护盾",
		{
			80000206
		},
		"初始卡牌",
		"5",
		{
			5
		},
		2,
		"pt_card_10006"
	},
	{
		16,
		"偷窃",
		"扣除%s个熊熊币",
		{
			80000207
		},
		"初始卡牌",
		"6",
		{
			2
		},
		1,
		"pt_card_10002"
	}
}
local t_roguelike_monster_action = {}

t_roguelike_monster_action.dataList = dataList

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
	t_roguelike_monster_action[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_monster_action
