pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "auction_session") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "auction_session"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.auction_session = var_0_2
pg = var_0

local var_0_3 = var_0.auction_session

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.auction_session = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.auction_session

	var_1_0[1] = {
		name = "B级拍卖场",
		id = 1,
		auction_value = "低",
		threshold = 5000,
		bottom_price = 0,
		ticket = 100,
		game_type = 105,
		value_range = {
			{
				{
					0,
					300000
				},
				1000
			},
			{
				{
					300000,
					550000
				},
				4500
			},
			{
				{
					550000,
					750000
				},
				4500
			},
			{
				{
					750000,
					1000000
				},
				200
			}
		},
		rarity_probability = {
			{
				1,
				3800
			},
			{
				2,
				3100
			},
			{
				3,
				2500
			},
			{
				4,
				500
			},
			{
				5,
				100
			}
		},
		rarity_limit = {
			{
				1,
				3
			},
			{
				2,
				2
			},
			{
				3,
				2
			}
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.auction_session

	var_1_1[2] = {
		name = "A级拍卖场",
		id = 2,
		auction_value = "中",
		threshold = 1000000,
		bottom_price = 0,
		ticket = 5000,
		game_type = 106,
		value_range = {
			{
				{
					0,
					700000
				},
				1600
			},
			{
				{
					700000,
					1700000
				},
				4100
			},
			{
				{
					1700000,
					2700000
				},
				4100
			},
			{
				{
					2700000,
					4500000
				},
				200
			}
		},
		rarity_probability = {
			{
				1,
				2500
			},
			{
				2,
				2800
			},
			{
				3,
				2700
			},
			{
				4,
				1500
			},
			{
				5,
				500
			}
		},
		rarity_limit = {
			{
				1,
				2
			},
			{
				2,
				2
			},
			{
				3,
				2
			},
			{
				4,
				1
			}
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.auction_session

	var_1_2[3] = {
		name = "S级拍卖场",
		id = 3,
		auction_value = "高",
		threshold = 3000000,
		bottom_price = 0,
		ticket = 20000,
		game_type = 107,
		value_range = {
			{
				{
					0,
					2000000
				},
				1400
			},
			{
				{
					2000000,
					4500000
				},
				4100
			},
			{
				{
					4500000,
					7000000
				},
				4200
			},
			{
				{
					7000000,
					12000000
				},
				300
			}
		},
		rarity_probability = {
			{
				1,
				1000
			},
			{
				2,
				2200
			},
			{
				3,
				3100
			},
			{
				4,
				3000
			},
			{
				5,
				700
			}
		},
		rarity_limit = {
			{
				1,
				1
			},
			{
				2,
				1
			},
			{
				3,
				3
			},
			{
				4,
				3
			}
		}
	}
	pg = var_1_2
	var_1_2.base.auction_session[4] = {
		name = "藏品预购",
		id = 4,
		auction_value = "",
		threshold = 0,
		bottom_price = 0,
		ticket = 0,
		game_type = 0,
		value_range = {
			{
				{
					0,
					100000
				},
				1600
			},
			{
				{
					100000,
					200000
				},
				4100
			},
			{
				{
					200000,
					300000
				},
				4100
			},
			{
				{
					300000,
					400000
				},
				200
			}
		},
		rarity_probability = {
			{
				1,
				4700
			},
			{
				2,
				4000
			},
			{
				3,
				900
			},
			{
				4,
				300
			},
			{
				5,
				100
			}
		},
		rarity_limit = {
			{
				1,
				3
			},
			{
				3,
				1
			}
		}
	}

	return
end)()

return
