-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_manager.lua

module("logic.config.t_house_manager", package.seeall)

local title = {
	jobCount = 8,
	name = 5,
	cost = 2,
	spRoomCount = 9,
	muduleLevel = 7,
	upgradeDesc = 14,
	holdRoomCount = 12,
	desc = 6,
	bigZoneCount = 11,
	productivity = 3,
	store = 13,
	smallZoneCount = 10,
	icon = 4,
	level = 1
}
local dataList = {
	{
		1,
		{
			{
				id = 1702001,
				num = 3
			},
			{
				id = 1100003,
				num = 200
			}
		},
		100,
		"10005",
		"主管室.Lv1",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		1,
		1,
		3,
		8,
		2,
		2,
		30,
		"库存容量<color=#cfa94e><size=24>+5</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		2,
		{
			{
				id = 1702001,
				num = 15
			},
			{
				id = 1100003,
				num = 500
			}
		},
		100,
		"10005",
		"主管室.Lv2",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		2,
		1,
		3,
		8,
		2,
		3,
		35,
		"库存容量<color=#cfa94e><size=24>+5</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		3,
		{
			{
				id = 1702001,
				num = 35
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		100,
		"10005",
		"主管室.Lv3",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		3,
		2,
		3,
		11,
		2,
		3,
		40,
		"库存容量<color=#cfa94e><size=24>+5</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		4,
		{
			{
				id = 1702002,
				num = 10
			},
			{
				id = 1702001,
				num = 16
			},
			{
				id = 1100003,
				num = 2000
			}
		},
		100,
		"10005",
		"主管室.Lv4",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		4,
		2,
		3,
		11,
		3,
		4,
		45,
		"库存容量<color=#cfa94e><size=24>+5</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		5,
		{
			{
				id = 1702002,
				num = 20
			},
			{
				id = 1702001,
				num = 30
			},
			{
				id = 1100003,
				num = 5000
			}
		},
		100,
		"10005",
		"主管室.Lv5",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		5,
		2,
		3,
		14,
		3,
		4,
		50,
		"库存容量<color=#cfa94e><size=24>+10</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		6,
		{
			{
				id = 1702002,
				num = 25
			},
			{
				id = 1702001,
				num = 40
			},
			{
				id = 1100003,
				num = 10000
			}
		},
		100,
		"10005",
		"主管室.Lv6",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		6,
		2,
		3,
		14,
		4,
		5,
		60,
		"库存容量<color=#cfa94e><size=24>+10</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		7,
		{
			{
				id = 1702003,
				num = 10
			},
			{
				id = 1702002,
				num = 25
			},
			{
				id = 1100003,
				num = 20000
			}
		},
		100,
		"10005",
		"主管室.Lv7",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		7,
		3,
		3,
		17,
		4,
		5,
		70,
		"库存容量<color=#cfa94e><size=24>+10</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		8,
		{
			{
				id = 1702003,
				num = 15
			},
			{
				id = 1702002,
				num = 30
			},
			{
				id = 1100003,
				num = 30000
			}
		},
		100,
		"10005",
		"主管室.Lv8",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		8,
		3,
		3,
		17,
		5,
		6,
		80,
		"库存容量<color=#cfa94e><size=24>+10</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		9,
		{
			{
				id = 1702003,
				num = 20
			},
			{
				id = 1702002,
				num = 40
			},
			{
				id = 1100003,
				num = 50000
			}
		},
		100,
		"10005",
		"主管室.Lv9",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		9,
		3,
		3,
		20,
		6,
		6,
		90,
		"库存容量<color=#cfa94e><size=24>+10</size></color>\r\n制造厂和贸易站等级上限<color=#cfa94e><size=24>+1</size></color>"
	},
	{
		10,
		nil,
		100,
		"10005",
		"主管室.Lv10",
		"观测，监控，处理。所有时间于此汇聚，并于此校正。",
		10,
		3,
		3,
		20,
		8,
		6,
		100,
		""
	}
}
local t_house_manager = {}

t_house_manager.dataList = dataList

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
	t_house_manager[v[1]] = v

	setmetatable(v, mt)
end

return t_house_manager
