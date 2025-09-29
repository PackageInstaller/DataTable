-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_skin_goods.lua

module("logic.config.t_skin_goods", package.seeall)

local title = {
	cost = 5,
	name = 3,
	isOnline = 4,
	skinId = 6,
	onlineEndTime = 11,
	discountCost = 7,
	discountEndTime = 10,
	goodsType = 2,
	discount = 8,
	bindActivityId = 12,
	goodsId = 1,
	discountStartTime = 9
}
local dataList = {
	{
		1500001,
		15,
		"皮肤1",
		true,
		"{1100001:60}",
		1500005,
		"{1100001:6}",
		1,
		"2022-08-01T05:00:00",
		"2023-08-12T05:00:00",
		nil,
		0
	},
	{
		1500002,
		15,
		"皮肤2",
		false,
		"{1100001:70}",
		1500011,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500003,
		15,
		"皮肤3",
		true,
		"{1100001:80}",
		1500012,
		"{1100001:40}",
		5,
		"2021-08-01T05:00:00",
		"2021-08-12T05:00:00",
		nil,
		0
	},
	{
		1500004,
		15,
		"皮肤4",
		true,
		"{1100001:90}",
		1500013,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500005,
		15,
		"皮肤5",
		true,
		"{1100001:100}",
		1500019,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500006,
		15,
		"皮肤6",
		true,
		"{1100001:110}",
		1500021,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500007,
		15,
		"皮肤7",
		true,
		"{1100001:120}",
		1505601,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500008,
		15,
		"皮肤8",
		true,
		"{1100001:130}",
		1505602,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500009,
		15,
		"皮肤9",
		true,
		"{1100001:140}",
		1505603,
		"{1100001:6}",
		1,
		"2022-08-01T05:00:00",
		"2023-08-12T05:00:00",
		nil,
		0
	},
	{
		1500010,
		15,
		"皮肤10",
		false,
		"{1100001:150}",
		1505604,
		"",
		0,
		nil,
		nil,
		nil,
		0
	},
	{
		1500011,
		15,
		"皮肤11",
		true,
		"{1100001:160}",
		1505605,
		"{1100001:40}",
		5,
		"2021-08-01T05:00:00",
		"2021-08-12T05:00:00",
		nil,
		0
	},
	{
		1500012,
		15,
		"皮肤12",
		true,
		"{1100001:170}",
		1505606,
		"",
		0,
		nil,
		nil,
		nil,
		0
	}
}
local t_skin_goods = {}

t_skin_goods.dataList = dataList

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
	t_skin_goods[v[1]] = v

	setmetatable(v, mt)
end

return t_skin_goods
