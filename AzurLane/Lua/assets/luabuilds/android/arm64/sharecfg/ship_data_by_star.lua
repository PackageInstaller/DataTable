pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "ship_data_by_star") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "ship_data_by_star"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.ship_data_by_star = var_0_2
pg = var_0

local var_0_3 = var_0.ship_data_by_star

var_0_3.all = {
	0,
	1,
	2,
	3,
	4,
	5,
	6
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.ship_data_by_star = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.ship_data_by_star

	var_1_0[0] = {
		energy_recover_time_ratio = 0,
		energy_recover_food_ratio = 0,
		exchange_price = 1,
		level_restrictions = 0,
		ship_star = 0,
		destory_item = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.ship_data_by_star

	var_1_1[1] = {
		energy_recover_time_ratio = 1,
		energy_recover_food_ratio = 0.1,
		exchange_price = 1,
		level_restrictions = 1,
		ship_star = 1,
		destory_item = {}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.ship_data_by_star

	var_1_2[2] = {
		energy_recover_time_ratio = 1.1,
		energy_recover_food_ratio = 0.11,
		exchange_price = 1,
		level_restrictions = 10,
		ship_star = 2,
		destory_item = {}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.ship_data_by_star

	var_1_3[3] = {
		energy_recover_time_ratio = 1.3,
		energy_recover_food_ratio = 0.12,
		exchange_price = 5,
		level_restrictions = 30,
		ship_star = 3,
		destory_item = {
			{
				2,
				15001,
				1
			}
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.ship_data_by_star

	var_1_4[4] = {
		energy_recover_time_ratio = 1.6,
		energy_recover_food_ratio = 0.13,
		exchange_price = 30,
		level_restrictions = 50,
		ship_star = 4,
		destory_item = {
			{
				2,
				15001,
				4
			}
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.ship_data_by_star

	var_1_5[5] = {
		energy_recover_time_ratio = 2,
		energy_recover_food_ratio = 0.14,
		exchange_price = 80,
		level_restrictions = 70,
		ship_star = 5,
		destory_item = {
			{
				2,
				15001,
				10
			}
		}
	}
	pg = var_1_5
	var_1_5.base.ship_data_by_star[6] = {
		energy_recover_time_ratio = 2.5,
		energy_recover_food_ratio = 0.15,
		exchange_price = 200,
		level_restrictions = 90,
		ship_star = 6,
		destory_item = {
			{
				2,
				15001,
				30
			},
			{
				8,
				59011,
				500
			}
		}
	}

	return
end)()

return
