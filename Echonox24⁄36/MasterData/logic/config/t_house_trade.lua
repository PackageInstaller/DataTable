-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_trade.lua

module("logic.config.t_house_trade", package.seeall)

local title = {
	cost = 2,
	name = 7,
	jobCount = 4,
	mood = 5,
	unlockOrder = 12,
	upgradeDesc = 11,
	maxWeeklyOrder = 10,
	desc = 8,
	productivity = 3,
	maxDailyOrder = 9,
	icon = 6,
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
		1,
		0,
		"10005",
		"贸易站.Lv1",
		"从商品到货币，从消费到投资，从订单到订单。",
		6,
		3,
		"",
		1
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
		1,
		0,
		"10005",
		"贸易站.Lv2",
		"从商品到货币，从消费到投资，从订单到订单。",
		7,
		3,
		"可概率刷出<color=#eebb69>2级订单</color>；每日订单队列上限<color=#eebb69>+1</color>",
		2
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
		2,
		0,
		"10005",
		"贸易站.Lv3",
		"从商品到货币，从消费到投资，从订单到订单。",
		7,
		3,
		"工作职位<color=#eebb69>+1</color>",
		2
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
		2,
		0,
		"10005",
		"贸易站.Lv4",
		"从商品到货币，从消费到投资，从订单到订单。",
		7,
		3,
		"解锁<color=#eebb69>校时器经验</color>订单",
		2
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
		2,
		0,
		"10005",
		"贸易站.Lv5",
		"从商品到货币，从消费到投资，从订单到订单。",
		9,
		3,
		"每日订单队列上限<color=#eebb69>+2</color>",
		2
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
		2,
		0,
		"10005",
		"贸易站.Lv6",
		"从商品到货币，从消费到投资，从订单到订单。",
		9,
		3,
		"可概率刷出<color=#eebb69>3级订单</color>",
		3
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
		3,
		0,
		"10005",
		"贸易站.Lv7",
		"从商品到货币，从消费到投资，从订单到订单。",
		9,
		3,
		"工作职位<color=#eebb69>+1</color>",
		3
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
		3,
		0,
		"10005",
		"贸易站.Lv8",
		"从商品到货币，从消费到投资，从订单到订单。",
		9,
		4,
		"每周订单数量<color=#eebb69>+1</color>",
		3
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
		110,
		3,
		0,
		"10005",
		"贸易站.Lv9",
		"从商品到货币，从消费到投资，从订单到订单。",
		9,
		4,
		"贸易站基础生产力<color=#eebb69>+10%</color>",
		3
	},
	{
		10,
		nil,
		110,
		3,
		0,
		"10005",
		"贸易站.Lv10",
		"从商品到货币，从消费到投资，从订单到订单。",
		11,
		4,
		"每日订单队列上限<color=#eebb69>+2</color>",
		3
	}
}
local t_house_trade = {}

t_house_trade.dataList = dataList

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
	t_house_trade[v[1]] = v

	setmetatable(v, mt)
end

return t_house_trade
