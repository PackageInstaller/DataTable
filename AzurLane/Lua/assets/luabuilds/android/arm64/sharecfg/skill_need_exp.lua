pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "skill_need_exp") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "skill_need_exp"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.skill_need_exp = var_0_2
pg = var_0

local var_0_3 = var_0.skill_need_exp

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
var_0_3.base.skill_need_exp = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.skill_need_exp

	var_1_0[1] = {
		exp = 100,
		level = 1
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.skill_need_exp

	var_1_1[2] = {
		exp = 200,
		level = 2
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.skill_need_exp

	var_1_2[3] = {
		exp = 400,
		level = 3
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.skill_need_exp

	var_1_3[4] = {
		exp = 800,
		level = 4
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.skill_need_exp

	var_1_4[5] = {
		exp = 1400,
		level = 5
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.skill_need_exp

	var_1_5[6] = {
		exp = 2200,
		level = 6
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.skill_need_exp

	var_1_6[7] = {
		exp = 3200,
		level = 7
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.skill_need_exp

	var_1_7[8] = {
		exp = 4400,
		level = 8
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.skill_need_exp

	var_1_8[9] = {
		exp = 5800,
		level = 9
	}
	pg = var_1_8
	var_1_8.base.skill_need_exp[10] = {
		exp = 0,
		level = 10
	}

	return
end)()

return
