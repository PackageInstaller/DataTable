pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_order_list") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_order_list"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_order_list = var_0_2
pg = var_0

local var_0_3 = var_0.island_order_list

var_0_3.all = {
	101,
	102,
	103,
	104,
	105,
	201,
	301,
	302,
	303
}
pg = var_0_3

local var_0_4 = var_0_3.island_order_list

var_0_4.get_id_list_by_type = {
	{
		101,
		102,
		103,
		104,
		105
	},
	{
		201
	},
	{
		301,
		302,
		303
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.island_order_list = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_order_list

	var_1_0[101] = {
		type = 1,
		name = "普通订单1",
		unlock_level = 1,
		id = 101,
		unlock_cost = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_order_list

	var_1_1[102] = {
		type = 1,
		name = "普通订单2",
		unlock_level = 5,
		id = 102,
		unlock_cost = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_order_list

	var_1_2[103] = {
		type = 1,
		name = "普通订单3",
		unlock_level = 10,
		id = 103,
		unlock_cost = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_order_list

	var_1_3[104] = {
		type = 1,
		name = "普通订单4",
		unlock_level = 15,
		id = 104,
		unlock_cost = {}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_order_list

	var_1_4[105] = {
		type = 1,
		name = "普通订单5",
		unlock_level = 20,
		id = 105,
		unlock_cost = {}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_order_list

	var_1_5[201] = {
		type = 2,
		name = "加急订单1",
		unlock_level = 5,
		id = 201,
		unlock_cost = {}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_order_list

	var_1_6[301] = {
		type = 3,
		name = "船舶订单1",
		unlock_level = 10,
		id = 301,
		unlock_cost = {
			{
				1,
				0
			}
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_order_list

	var_1_7[302] = {
		type = 3,
		name = "船舶订单2",
		unlock_level = 20,
		id = 302,
		unlock_cost = {
			{
				1,
				0
			}
		}
	}
	pg = var_1_7
	var_1_7.base.island_order_list[303] = {
		type = 3,
		name = "船舶订单3",
		unlock_level = 30,
		id = 303,
		unlock_cost = {
			{
				1,
				0
			}
		}
	}

	return
end)()

return
