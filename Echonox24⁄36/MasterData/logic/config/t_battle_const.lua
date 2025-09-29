-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_battle_const.lua

module("logic.config.t_battle_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	jsonObject = 7,
	strValues = 6,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"notCriticalInspiration",
		4,
		0,
		""
	},
	{
		"criticalRatio",
		0,
		1.3,
		""
	},
	{
		"nearRatio",
		0,
		0.3,
		""
	},
	{
		"deadSanity",
		-2,
		0,
		""
	},
	{
		"campBuffStringXingKongJiaoHui",
		0,
		0,
		"星空教会的成员可视为任意阵营的角色组成阵营效果"
	},
	{
		"campBuffStringShuiDi",
		0,
		0,
		"待定"
	},
	{
		"godlikeSanity",
		5,
		0,
		""
	},
	{
		"godlikeBuffCode",
		14001,
		0,
		""
	},
	{
		"godlikeBuffRound",
		5,
		0,
		""
	},
	{
		"weakPointRatio",
		0,
		2,
		""
	},
	{
		"weakPointBreakDizzyBuff",
		13007,
		0,
		""
	},
	{
		"roarBuff",
		11027,
		0,
		""
	},
	{
		"piercedBuff",
		11029,
		0,
		""
	},
	{
		"defaultBackCount",
		1,
		0,
		""
	},
	{
		"lowHpTag",
		2002,
		0,
		""
	},
	{
		"Chase",
		1004,
		0,
		""
	},
	{
		"MoonRing",
		1008,
		0,
		""
	},
	{
		"Bomb",
		1009,
		0,
		""
	},
	{
		"Assist",
		1010,
		0,
		""
	},
	{
		"BoreSpine",
		1011,
		0,
		""
	},
	{
		"ArcLight",
		1012,
		0,
		""
	},
	{
		"Snipe",
		1013,
		0,
		""
	},
	{
		"weakPointRestrain",
		0,
		1.5,
		""
	},
	{
		"earlyStageDungeonJudge",
		110116,
		0,
		""
	},
	{
		"curseBuffCode",
		11028,
		0,
		""
	}
}
local t_battle_const = {}

t_battle_const.dataList = dataList

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
	t_battle_const[v[1]] = v

	setmetatable(v, mt)
end

return t_battle_const
