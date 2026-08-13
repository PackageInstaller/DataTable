pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "equip_data_by_quality") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "equip_data_by_quality"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.equip_data_by_quality = var_0_2
pg = var_0

local var_0_3 = var_0.equip_data_by_quality

var_0_3.all = {
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
var_0_3.base.equip_data_by_quality = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.equip_data_by_quality

	var_1_0[1] = {
		gear_score = 30,
		gear_score_addition = 5,
		equip_quality = 1,
		destory_resource_ratio = 1
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.equip_data_by_quality

	var_1_1[2] = {
		gear_score = 50,
		gear_score_addition = 8,
		equip_quality = 2,
		destory_resource_ratio = 2
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.equip_data_by_quality

	var_1_2[3] = {
		gear_score = 80,
		gear_score_addition = 10,
		equip_quality = 3,
		destory_resource_ratio = 3
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.equip_data_by_quality

	var_1_3[4] = {
		gear_score = 120,
		gear_score_addition = 12,
		equip_quality = 4,
		destory_resource_ratio = 4
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.equip_data_by_quality

	var_1_4[5] = {
		gear_score = 180,
		gear_score_addition = 15,
		equip_quality = 5,
		destory_resource_ratio = 5
	}
	pg = var_1_4
	var_1_4.base.equip_data_by_quality[6] = {
		gear_score = 300,
		gear_score_addition = 20,
		equip_quality = 6,
		destory_resource_ratio = 6
	}

	return
end)()

return
