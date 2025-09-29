-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_material_dungeon_depth_position.lua

module("logic.config.t_material_dungeon_depth_position", package.seeall)

local title = {
	index = 1,
	minPos = 2,
	maxPos = 3
}
local dataList = {
	{
		1,
		{
			-2.3,
			-123,
			70.4
		},
		{
			-18.9,
			-129.54,
			-312.9
		}
	},
	{
		2,
		{
			-136.5,
			89,
			175.2
		},
		{
			-136.5,
			89,
			-50
		}
	},
	{
		3,
		{
			272.5,
			279.6,
			453.7
		},
		{
			264,
			262,
			-24.7
		}
	},
	{
		4,
		{
			597.8,
			95,
			650.9
		},
		{
			559.5,
			72.1,
			1.3
		}
	},
	{
		5,
		{
			488.3,
			-175.8,
			873.1
		},
		{
			453.3,
			-155.9,
			70.4
		}
	}
}
local t_material_dungeon_depth_position = {}

t_material_dungeon_depth_position.dataList = dataList

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
	t_material_dungeon_depth_position[v[1]] = v

	setmetatable(v, mt)
end

return t_material_dungeon_depth_position
