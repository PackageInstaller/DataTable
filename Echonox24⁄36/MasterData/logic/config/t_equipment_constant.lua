-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_equipment_constant.lua

module("logic.config.t_equipment_constant", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"GoldPerExp",
		0,
		0.7,
		""
	},
	{
		"EquipmentBackpackCapacity",
		2000,
		0,
		""
	},
	{
		"DiceBackpackCapacity",
		500,
		0,
		""
	},
	{
		"DiceAttrUnlockLevels",
		0,
		0,
		"",
		{
			10,
			20,
			30
		}
	},
	{
		"DiceAttrEnhanceLevel",
		0,
		0,
		"{2:1,3:2,4:3}"
	},
	{
		"D6IconForPart1",
		2501004,
		0,
		""
	},
	{
		"D6IconForPart2",
		2501005,
		0,
		""
	},
	{
		"D6IconForPart3",
		2501006,
		0,
		""
	},
	{
		"SuitPartLimit",
		3,
		0,
		""
	},
	{
		"DefaultFilterInput",
		0,
		0,
		"[[132301,200],[132302,200],[132303,200],[132304,200],[132305,200],[132306,200],[132307,200],[132308,200]]"
	},
	{
		"EquipExtraDecomposedItem",
		1008001,
		0,
		""
	},
	{
		"DiceAttrGroupSameNumWeights",
		0,
		0,
		"",
		{
			2963,
			4444,
			2222,
			370
		}
	},
	{
		"DiceFiterTips",
		0,
		0,
		"x"
	}
}
local t_equipment_constant = {}

t_equipment_constant.dataList = dataList

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
	t_equipment_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_equipment_constant
