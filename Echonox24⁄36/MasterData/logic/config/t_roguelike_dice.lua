-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_dice.lua

module("logic.config.t_roguelike_dice", package.seeall)

local title = {
	param = 2,
	name = 3,
	id = 1,
	patterns = 4,
	desc = 5
}
local dataList = {
	{
		1,
		"DICE_SUCCESS",
		"成功骰子",
		{
			111,
			111,
			111
		},
		""
	},
	{
		2,
		"DICE_SACRIFICE",
		"献祭骰子",
		{
			141,
			141,
			141
		},
		""
	},
	{
		3,
		"DICE_ECLIPSE",
		"蚀智骰子",
		{
			151,
			151,
			151
		},
		""
	},
	{
		4,
		"DICE_BLEED",
		"流血骰子",
		{
			121,
			121,
			121
		},
		""
	},
	{
		5,
		"DICE_TRANCE",
		"恍惚骰子",
		{
			131,
			131,
			131
		},
		""
	}
}
local t_roguelike_dice = {}

t_roguelike_dice.dataList = dataList

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
	t_roguelike_dice[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_dice
