-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_map_plate.lua

module("logic.config.t_roguelike_map_plate", package.seeall)

local title = {
	shapeId = 2,
	id = 1,
	art = 3
}
local dataList = {
	{
		10010101,
		1,
		"map1"
	},
	{
		10010102,
		1,
		"map1-1"
	},
	{
		10010201,
		2,
		"map2"
	},
	{
		10010202,
		2,
		"map2-1"
	},
	{
		10010203,
		2,
		"map2-2"
	},
	{
		10010204,
		2,
		"map2-3"
	},
	{
		10010205,
		2,
		"map2-4"
	},
	{
		10010206,
		2,
		"map2-5"
	},
	{
		10010207,
		2,
		"map2-6"
	},
	{
		10010208,
		2,
		"map2-7"
	},
	{
		10010209,
		2,
		"map2-8"
	},
	{
		10010210,
		2,
		"map2-9"
	},
	{
		10010211,
		2,
		"map2-10"
	},
	{
		10010301,
		3,
		"map3"
	},
	{
		10010302,
		3,
		"map3-1"
	},
	{
		10010401,
		4,
		"map4"
	},
	{
		10010501,
		5,
		"map5"
	},
	{
		10010601,
		6,
		"map6"
	},
	{
		10010602,
		6,
		"map6-1"
	},
	{
		10010701,
		7,
		"map7"
	},
	{
		10010702,
		7,
		"map7-1"
	},
	{
		10010801,
		8,
		"map8"
	},
	{
		10010802,
		8,
		"map8-1"
	},
	{
		10010803,
		8,
		"map8-2"
	},
	{
		10010901,
		9,
		"map9"
	},
	{
		10011001,
		10,
		"map10"
	},
	{
		10011101,
		11,
		"map11"
	},
	{
		10011201,
		12,
		"map12"
	},
	{
		10011202,
		12,
		"map12-1"
	},
	{
		10011301,
		13,
		"map13"
	},
	{
		10011401,
		14,
		"map14"
	},
	{
		10011501,
		15,
		"map15"
	},
	{
		10011502,
		15,
		"map15-1"
	},
	{
		10011601,
		16,
		"map16"
	},
	{
		10011701,
		17,
		"map17"
	},
	{
		10011702,
		17,
		"map17-1"
	}
}
local t_roguelike_map_plate = {
	[10010101] = dataList[1],
	[10010102] = dataList[2],
	[10010201] = dataList[3],
	[10010202] = dataList[4],
	[10010203] = dataList[5],
	[10010204] = dataList[6],
	[10010205] = dataList[7],
	[10010206] = dataList[8],
	[10010207] = dataList[9],
	[10010208] = dataList[10],
	[10010209] = dataList[11],
	[10010210] = dataList[12],
	[10010211] = dataList[13],
	[10010301] = dataList[14],
	[10010302] = dataList[15],
	[10010401] = dataList[16],
	[10010501] = dataList[17],
	[10010601] = dataList[18],
	[10010602] = dataList[19],
	[10010701] = dataList[20],
	[10010702] = dataList[21],
	[10010801] = dataList[22],
	[10010802] = dataList[23],
	[10010803] = dataList[24],
	[10010901] = dataList[25],
	[10011001] = dataList[26],
	[10011101] = dataList[27],
	[10011201] = dataList[28],
	[10011202] = dataList[29],
	[10011301] = dataList[30],
	[10011401] = dataList[31],
	[10011501] = dataList[32],
	[10011502] = dataList[33],
	[10011601] = dataList[34],
	[10011701] = dataList[35],
	[10011702] = dataList[36]
}

t_roguelike_map_plate.dataList = dataList

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
	setmetatable(v, mt)
end

return t_roguelike_map_plate
