-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_chamber_entry.lua

module("logic.config.t_chamber_entry", package.seeall)

local title = {
	param = 6,
	name = 3,
	program = 5,
	id = 1,
	pn = 4,
	description = 7,
	lv = 2
}
local dataList = {
	{
		10000,
		1,
		"理智稳定",
		1,
		"DungeonSkillAdd",
		"0",
		"抑制守秘人丧失理智后的失控症状"
	},
	{
		20000,
		1,
		"奖励升级",
		1,
		"DungeonDropUp",
		"",
		"密室时间中的夸克制药：掉落资源更丰富"
	},
	{
		20001,
		1,
		"奖励升级",
		1,
		"DungeonDropUp",
		"",
		"密室时间中的任意测验点：掉落资源更丰富"
	},
	{
		30001,
		1,
		"累积奖励",
		1,
		"DungeonDropCount",
		"3#2014002",
		"密室时间中累计完成3次主线战斗后，获得【核心补给·小】"
	},
	{
		40001,
		1,
		"额外获取",
		1,
		"DungeonDropAdd",
		"2014001",
		"密室时间中的红雾地区：额外掉落随机数量【零部件】资源"
	},
	{
		30002,
		1,
		"累积奖励",
		1,
		"DungeonDropCount",
		"6#2014003",
		"密室时间中的累计完成6次管制行动战斗后，获得【核心补给·中】"
	},
	{
		50001,
		1,
		"奖励增加",
		1,
		"DungeonDropMore",
		"10",
		"密室时间中的序列矿场：掉落的量子贝产量提高10%"
	},
	{
		60001,
		1,
		"定时伤害",
		0,
		"DungeonSkillAdd",
		"1520001",
		"密室时间中的主线战斗：每回合开始时,对所有的己方单位造成等于10%最大生命的真实伤害"
	},
	{
		60002,
		1,
		"战力提升",
		0,
		"DungeonSkillAdd",
		"1520008",
		"密室时间中的夸克制药：战斗开始时，选中敌方血量最高的单位,使得其在本次战斗中受到的伤害减少20%,且每次主动攻击后对目标发动一次锥刺"
	},
	{
		60003,
		1,
		"迷雾侵袭",
		0,
		"DungeonSkillAdd",
		"1520001",
		"密室时间中的任意测验点：每回合开始时,对所有的己方单位造成等于10%最大生命的真实伤害"
	},
	{
		60004,
		1,
		"伤害转化",
		0,
		"DungeonSkillAdd",
		"1520004",
		"密室时间中的红雾地区：敌方单位每次受到攻击后回复10%最大生命"
	},
	{
		60005,
		1,
		"攻击制约",
		0,
		"DungeonSkillAdd",
		"1520006",
		"密室时间中的管制行动：战斗开始时，诅咒我方攻击最高的角色，使得这个角色每次行动结束时获得2层衰退"
	},
	{
		60006,
		1,
		"定时治疗",
		0,
		"DungeonSkillAdd",
		"1520002",
		"密室时间中的序列矿场：每回合结束时，所有敌方回复60%的最大生命"
	},
	{
		70001,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010001",
		"密室时间的主线战斗：任意一个守秘人在一次战斗中累计收到自身最大生命值50%以上伤害而没有退场，获得400评议点"
	},
	{
		70002,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010006",
		"密室时间中的夸克制药：累计击杀5个被战力提升的敌人，获得400评议点"
	},
	{
		70003,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010003",
		"密室时间的任意测验点：任意一个守秘人在一次战斗中累计收到自身最大生命值50%以上伤害而没有退场，获得400评议点"
	},
	{
		70004,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010004",
		"密室时间的红雾地区：敌方在一次战斗中累计恢复生命值不超过1000点，获得400评议点"
	},
	{
		70005,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010005",
		"密室时间中的管制行动：被施与诅咒的守秘人累计产生10格移动，获得400评议点"
	},
	{
		70006,
		1,
		"绩效成长",
		1,
		"AddTask",
		"91010002",
		"密室时间的序列矿场：敌方在一次战斗中累计恢复生命值不超过1000点，获得400评议点"
	}
}
local t_chamber_entry = {}

t_chamber_entry.dataList = dataList

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
	local parent1 = t_chamber_entry[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_chamber_entry[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_chamber_entry
