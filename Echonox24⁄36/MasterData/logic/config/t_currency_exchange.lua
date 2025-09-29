-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_currency_exchange.lua

module("logic.config.t_currency_exchange", package.seeall)

local title = {
	jumpId = 7,
	exchangeLimit = 6,
	rule = 4,
	targetLimit = 5,
	id = 1,
	goodsId = 8,
	targetId = 3,
	sourceId = 2
}
local dataList = {
	{
		1001,
		1100001,
		1100002,
		"10:100",
		5,
		nil,
		10801002,
		0
	},
	{
		1002,
		1100001,
		1100006,
		"10:50",
		4,
		nil,
		10801002,
		0
	},
	{
		1003,
		1100001,
		1100003,
		"10:5000",
		20,
		{
			2,
			100
		},
		10801002,
		0
	},
	{
		1101,
		1100002,
		1100006,
		"50:120|80:120|100:120|150:120|200:120",
		1,
		{
			1,
			5
		},
		10801003,
		0
	},
	{
		1102,
		1100002,
		1001001,
		"160:1",
		0,
		{
			3,
			1000000
		},
		10801003,
		13101001
	},
	{
		1103,
		1100002,
		1001002,
		"400:1",
		0,
		{
			3,
			1000000
		},
		10801003,
		0
	},
	{
		1104,
		1100002,
		1100017,
		"20:1",
		0,
		nil,
		0,
		0
	}
}
local t_currency_exchange = {}

t_currency_exchange.dataList = dataList

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
	t_currency_exchange[v[1]] = v

	setmetatable(v, mt)
end

return t_currency_exchange
