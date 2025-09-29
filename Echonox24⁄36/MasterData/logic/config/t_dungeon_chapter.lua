-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_chapter.lua

module("logic.config.t_dungeon_chapter", package.seeall)

local title = {
	multiplicityOpenCondition = 6,
	dungeonIds = 4,
	jumpChapterId = 9,
	chapterId = 1,
	canMultiplicityCost = 5,
	starRewardRequire = 8,
	mapPrefabName = 3,
	multiplicityLimit = 7,
	difficulty = 2
}
local dataList = {
	{
		1,
		1,
		"",
		{
			1101,
			1102,
			1103,
			1104,
			1105,
			1106,
			1107,
			1108,
			1109,
			1110,
			1111,
			1112
		},
		1,
		nil,
		5,
		{
			10,
			20,
			30
		},
		{
			1
		}
	},
	{
		1,
		2,
		"",
		{
			1201,
			1202,
			1203,
			1204,
			1205,
			1206,
			1207,
			1208,
			1209,
			1210,
			1211,
			1212
		},
		1,
		nil,
		6,
		{
			10,
			20,
			30
		},
		{
			1
		}
	},
	{
		1,
		3,
		"",
		{
			1301,
			1302,
			1303,
			1304,
			1305,
			1306,
			1307,
			1308,
			1309,
			1310,
			1311,
			1312
		},
		1,
		nil,
		7,
		{
			10,
			20,
			30
		},
		{
			2
		}
	},
	{
		2,
		1,
		"",
		{
			2101,
			2102,
			2103,
			2104,
			2105,
			2106,
			2107,
			2108,
			2109,
			2110,
			2111,
			2112
		},
		1,
		nil,
		8,
		{
			10,
			20,
			30
		},
		{
			3
		}
	},
	{
		2,
		2,
		"",
		{
			2201,
			2202,
			2203,
			2204,
			2205,
			2206,
			2207,
			2208,
			2209,
			2210,
			2211,
			2212
		},
		1,
		nil,
		9,
		{
			10,
			20,
			30
		},
		{
			4
		}
	},
	{
		2,
		3,
		"",
		{
			2301,
			2302,
			2303,
			2304,
			2305,
			2306,
			2307,
			2308,
			2309,
			2310,
			2311,
			2312
		},
		1,
		nil,
		10,
		{
			10,
			20,
			30
		},
		{
			5
		}
	}
}
local t_dungeon_chapter = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dungeon_chapter.dataList = dataList

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

return t_dungeon_chapter
