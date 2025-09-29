-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_terrain.lua

module("logic.config.t_terrain", package.seeall)

local title = {
	name = 2,
	height = 3,
	career_mobility_consume = 4,
	forbidBattleCamp = 5,
	code = 1
}
local dataList = {
	{
		101,
		"平地",
		0,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		}
	},
	{
		102,
		"高地",
		1.26,
		{
			-1,
			-1,
			-1,
			1,
			-1,
			-1,
			-1,
			-1
		}
	},
	{
		103,
		"边缘（无法进入）",
		0,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		}
	},
	{
		104,
		"平地(敌可进入)",
		0,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		},
		{
			2,
			3
		}
	},
	{
		105,
		"平地（我方可进入）",
		0,
		{
			1,
			1,
			1,
			1,
			1,
			1,
			1,
			1
		},
		{
			1,
			4
		}
	},
	{
		106,
		"高地(不可行走)",
		0,
		{
			-1,
			-1,
			-1,
			-1,
			-1,
			-1,
			-1,
			-1
		}
	}
}
local t_terrain = {}

t_terrain.dataList = dataList

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
	t_terrain[v[1]] = v

	setmetatable(v, mt)
end

return t_terrain
