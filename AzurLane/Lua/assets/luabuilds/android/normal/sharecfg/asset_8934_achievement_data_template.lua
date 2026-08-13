pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "achievement_data_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "achievement_data_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.achievement_data_template = var_0_2
pg = var_0

local var_0_3 = var_0.achievement_data_template

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.achievement_data_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.achievement_data_template

	var_1_0[1] = {
		award = "[]",
		condition = "杀怪数量达到30只",
		action = 1,
		type = 1,
		id = 1,
		target_num = 30,
		limit = "[]",
		target_id = "0"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.achievement_data_template

	var_1_1[2] = {
		award = "[]",
		condition = "收集10艘不同的驱逐舰",
		action = 2,
		type = 2,
		id = 2,
		target_num = 10,
		limit = "[]",
		target_id = "1"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.achievement_data_template

	var_1_2[3] = {
		award = "[]",
		condition = "收集20艘不同的驱逐舰",
		action = 2,
		type = 2,
		id = 3,
		target_num = 20,
		limit = "[]",
		target_id = "1"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.achievement_data_template

	var_1_3[4] = {
		award = "[]",
		condition = "收集30艘不同的驱逐舰",
		action = 2,
		type = 2,
		id = 4,
		target_num = 30,
		limit = "[]",
		target_id = "1"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.achievement_data_template

	var_1_4[5] = {
		award = "[]",
		condition = "任意舰船升级到30级",
		action = 2,
		type = 4,
		id = 5,
		target_num = 30,
		limit = "[]",
		target_id = "0"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.achievement_data_template

	var_1_5[6] = {
		award = "[]",
		condition = "任意驱逐舰升级到30级",
		action = 2,
		type = 4,
		id = 6,
		target_num = 30,
		limit = "[]",
		target_id = "1"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.achievement_data_template

	var_1_6[7] = {
		award = "[]",
		condition = "拉菲升级到30级",
		action = 2,
		type = 5,
		id = 7,
		target_num = 30,
		limit = "[]",
		target_id = "[101,102,103,104]"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.achievement_data_template

	var_1_7[8] = {
		award = "[]",
		condition = "收集10种不同的主炮装备",
		action = 2,
		type = 6,
		id = 8,
		target_num = 10,
		limit = "[]",
		target_id = "1"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.achievement_data_template

	var_1_8[9] = {
		award = "[]",
		condition = "竞技场连胜10场",
		action = 3,
		type = 7,
		id = 9,
		target_num = 10,
		limit = "[]",
		target_id = "0"
	}
	pg = var_1_8
	var_1_8.base.achievement_data_template[10] = {
		award = "[]",
		condition = "获得声望，反击图鉴",
		action = 4,
		type = 3,
		id = 10,
		target_num = 1,
		limit = "[]",
		target_id = "[1,2]"
	}

	return
end)()

return
