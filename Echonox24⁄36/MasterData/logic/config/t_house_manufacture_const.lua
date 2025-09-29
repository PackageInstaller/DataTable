-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_manufacture_const.lua

module("logic.config.t_house_manufacture_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"CharacterDefaultProduction",
		10,
		0,
		""
	},
	{
		"CoproductRateTimes",
		0,
		0,
		"",
		{
			4,
			5,
			6
		}
	},
	{
		"StoreSpeedUpCostItem",
		1701001,
		0,
		""
	},
	{
		"StoreSpeedUpMinute",
		5,
		0,
		""
	}
}
local t_house_manufacture_const = {}

t_house_manufacture_const.dataList = dataList

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
	t_house_manufacture_const[v[1]] = v

	setmetatable(v, mt)
end

return t_house_manufacture_const
