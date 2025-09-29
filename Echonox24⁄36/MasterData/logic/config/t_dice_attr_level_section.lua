-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dice_attr_level_section.lua

module("logic.config.t_dice_attr_level_section", package.seeall)

local title = {
	id = 1,
	name = 2,
	section = 3
}
local dataList = {
	{
		1,
		"T1",
		{
			1,
			2
		}
	},
	{
		2,
		"T2",
		{
			3,
			4
		}
	},
	{
		3,
		"T3",
		{
			5,
			6
		}
	},
	{
		4,
		"T4",
		{
			7,
			8
		}
	},
	{
		5,
		"T5",
		{
			9,
			10
		}
	},
	{
		6,
		"T6",
		{
			11,
			12
		}
	}
}
local t_dice_attr_level_section = {}

t_dice_attr_level_section.dataList = dataList

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
	t_dice_attr_level_section[v[1]] = v

	setmetatable(v, mt)
end

return t_dice_attr_level_section
