pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "enemy_data_skill") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "enemy_data_skill"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.enemy_data_skill = var_0_2
pg = var_0

local var_0_3 = var_0.enemy_data_skill

var_0_3.all = {
	1,
	3,
	5,
	6,
	7,
	8
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.enemy_data_skill = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.enemy_data_skill

	var_1_0[1] = {
		id = 1,
		is_repeat = 0,
		type = "白鹰弹幕类",
		skill_list = {
			31101,
			31102,
			31103
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.enemy_data_skill

	var_1_1[3] = {
		id = 3,
		is_repeat = 0,
		type = "重樱弹幕类",
		skill_list = {
			31301,
			31302,
			31303
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.enemy_data_skill

	var_1_2[5] = {
		id = 5,
		is_repeat = 0,
		type = "鱼雷弹幕",
		skill_list = {
			31501,
			31502
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.enemy_data_skill

	var_1_3[6] = {
		id = 6,
		is_repeat = 0,
		type = "防御类",
		skill_list = {
			32001,
			32002
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.enemy_data_skill

	var_1_4[7] = {
		id = 7,
		is_repeat = 0,
		type = "回复类",
		skill_list = {
			33001,
			33002
		}
	}
	pg = var_1_4
	var_1_4.base.enemy_data_skill[8] = {
		id = 8,
		is_repeat = 1,
		type = "状态类",
		skill_list = {
			35000
		}
	}

	return
end)()

return
