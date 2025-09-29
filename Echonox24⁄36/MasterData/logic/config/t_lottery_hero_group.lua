-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_hero_group.lua

module("logic.config.t_lottery_hero_group", package.seeall)

local title = {
	floatWeight = 3,
	groupCode = 1,
	weightControl = 5,
	itemCode = 2,
	floatTimeRange = 4
}
local dataList = {
	{
		10000,
		2000016,
		0,
		"",
		""
	},
	{
		10001,
		2000005,
		0,
		"",
		""
	},
	{
		10001,
		2000012,
		0,
		"",
		""
	},
	{
		10001,
		2000019,
		0,
		"",
		""
	},
	{
		10001,
		2000039,
		0,
		"",
		""
	},
	{
		10001,
		2000008,
		0,
		"",
		""
	},
	{
		10001,
		2000055,
		0,
		"",
		"1#100#-20"
	},
	{
		10001,
		2000041,
		0,
		"",
		""
	},
	{
		10001,
		2000057,
		0,
		"",
		""
	},
	{
		10002,
		2000011,
		0,
		"",
		"1#20#-20,40#60#-20,80#100#-20"
	},
	{
		10002,
		2000013,
		0,
		"",
		""
	},
	{
		10002,
		2000007,
		0,
		"",
		""
	},
	{
		10002,
		2000028,
		0,
		"",
		""
	},
	{
		10002,
		2000031,
		0,
		"",
		""
	},
	{
		10002,
		2000020,
		0,
		"",
		""
	},
	{
		10002,
		2000021,
		0,
		"",
		""
	},
	{
		10002,
		2000022,
		0,
		"",
		""
	},
	{
		10002,
		2000036,
		0,
		"",
		""
	},
	{
		10002,
		2000056,
		0,
		"",
		""
	},
	{
		10002,
		2000016,
		0,
		"",
		""
	},
	{
		10003,
		2000030,
		0,
		"",
		""
	},
	{
		10003,
		2000043,
		0,
		"",
		""
	},
	{
		10003,
		2000047,
		0,
		"",
		""
	},
	{
		10003,
		2000053,
		0,
		"",
		""
	},
	{
		10003,
		2000025,
		0,
		"",
		""
	},
	{
		10003,
		2000015,
		0,
		"",
		""
	},
	{
		10003,
		2000010,
		0,
		"",
		""
	},
	{
		10003,
		2000029,
		0,
		"",
		""
	},
	{
		10003,
		2000046,
		0,
		"",
		""
	},
	{
		10021,
		2000057,
		100,
		"2023-01-01 05:00:00#2033-05-10 23:59:00",
		""
	},
	{
		10031,
		2000051,
		100,
		"2023-01-01 05:00:00#2033-05-10 23:59:00",
		""
	},
	{
		10041,
		2000002,
		100,
		"2023-01-01 05:00:00#2033-05-10 23:59:00",
		""
	},
	{
		10401,
		2000019,
		0,
		"",
		""
	},
	{
		10401,
		2000008,
		0,
		"",
		""
	},
	{
		10401,
		2000041,
		0,
		"",
		""
	}
}
local t_lottery_hero_group = {}

t_lottery_hero_group.dataList = dataList

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
	local parent1 = t_lottery_hero_group[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_lottery_hero_group[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_lottery_hero_group
