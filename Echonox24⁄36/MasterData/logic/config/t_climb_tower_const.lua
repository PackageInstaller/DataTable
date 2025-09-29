-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_climb_tower_const.lua

module("logic.config.t_climb_tower_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"RuleDescBGTitle",
		0,
		0,
		"【背景介绍】"
	},
	{
		"RuleDescBGIntroduction",
		0,
		0,
		"天文台所管制的异化物，归宿都将是那颗双子星——S-00。\r\nS-00以超凡之力压制着异常之物，同时也被其反噬。\r\n因此，时序在此得到校正，也迎来紊乱。\r\n明面的骚乱与暗面的隐患，总是无法预测，如同月的阴晴圆缺。\r\n但幸好……这次我们还有机会，还有时间。"
	},
	{
		"RuleDescPlayTitle",
		0,
		0,
		"【玩法说明】"
	},
	{
		"RuleDescPlay",
		0,
		0,
		"月面基地分为【明面】和【暗面】两个部分，玩家通过挑战对灾害点进行时序修复。"
	},
	{
		"RuleDescBrightSideTitle",
		0,
		0,
		"【明面】"
	},
	{
		"RuleDescBrightSide",
		0,
		0,
		"明面灾害点修复难度逐级提升，需要一步步进行修复。修复后可获得一次性奖励，重复修复不会奖励。"
	},
	{
		"RuleDescDarkSideTitle",
		0,
		0,
		"【暗面】"
	},
	{
		"RuleDescDarkSide",
		0,
		0,
		"暗面共有7个灾害点，这些暗面的灾害点，每周都会出现重置现象。灾害点难度逐级提升，需要守秘小队逐一进行修复。\r\n修复后可获得修复奖励，灾害点重置后，可再次修复获得新的奖励。\r\n重置时间：每周一 5：00"
	},
	{
		"RuleDescBuffTitle",
		0,
		0,
		"【超凡影响】"
	},
	{
		"RuleDescBuffContent",
		0,
		0,
		"暗面关卡可能出现以下影响"
	},
	{
		"DarkTowerUnlockCondition",
		21,
		0,
		"【爬塔】月亮塔（暗）解锁所需明塔通关的层数。"
	}
}
local t_climb_tower_const = {}

t_climb_tower_const.dataList = dataList

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
	t_climb_tower_const[v[1]] = v

	setmetatable(v, mt)
end

return t_climb_tower_const
