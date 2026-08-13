pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "shake_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "shake_template"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.shake_template = var_0_2
pg = var_0

local var_0_3 = var_0.shake_template

var_0_3.all = {
	0,
	103,
	109,
	203,
	209,
	301,
	302,
	303,
	999,
	1001,
	1002,
	1010,
	1011,
	1020,
	1021
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.shake_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.shake_template

	var_1_0[0] = {
		description = "无震动",
		priority = 0,
		time = 0,
		vibration_H = 0,
		bounce = false,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 0,
		id = 0,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.shake_template

	var_1_1[103] = {
		description = "水平微弱震动",
		priority = 0,
		time = 2.5,
		vibration_H = 30,
		bounce = false,
		loop = 3,
		friction_const_H = 0,
		friction_coefficient_H = 0.93,
		id = 103,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.shake_template

	var_1_2[109] = {
		description = "水平强烈震动",
		priority = 0,
		time = 3,
		vibration_H = 100,
		bounce = false,
		loop = 2,
		friction_const_H = 0,
		friction_coefficient_H = 0.98,
		id = 109,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.shake_template

	var_1_3[203] = {
		description = "垂直微弱震动",
		priority = 0,
		time = 2.5,
		vibration_H = 0,
		bounce = false,
		loop = 3,
		friction_const_H = 0,
		friction_coefficient_H = 0,
		id = 203,
		vibration_V = 30,
		friction_const_V = 0,
		friction_coefficient_V = 0.93
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.shake_template

	var_1_4[209] = {
		description = "垂直剧烈震动",
		priority = 0,
		time = 3,
		vibration_H = 0,
		bounce = false,
		loop = 2,
		friction_const_H = 0,
		friction_coefficient_H = 0,
		id = 209,
		vibration_V = 100,
		friction_const_V = 0,
		friction_coefficient_V = 0.98
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.shake_template

	var_1_5[301] = {
		description = "玩家被击中",
		priority = 0,
		time = 2,
		vibration_H = 0.5,
		bounce = false,
		loop = 2,
		friction_const_H = 0,
		friction_coefficient_H = 0.7,
		id = 301,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.shake_template

	var_1_6[302] = {
		description = "大炮后坐力",
		priority = 0,
		time = 2,
		vibration_H = -1,
		bounce = false,
		loop = 3,
		friction_const_H = 0,
		friction_coefficient_H = 0.6,
		id = 302,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.shake_template

	var_1_7[303] = {
		description = "机枪后坐力",
		priority = 0,
		time = 10,
		vibration_H = 20,
		bounce = false,
		loop = 7,
		friction_const_H = 0,
		friction_coefficient_H = -1,
		id = 303,
		vibration_V = 0,
		friction_const_V = 0,
		friction_coefficient_V = 0
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.shake_template

	var_1_8[999] = {
		description = "测试地震效果",
		priority = 9,
		time = 3,
		vibration_H = 0.04,
		bounce = true,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 999,
		vibration_V = 0.007,
		friction_const_V = 0.0005,
		friction_coefficient_V = 1
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.shake_template

	var_1_9[1001] = {
		description = "大世界_仲裁者天帕岚斯武器_微弱震动",
		priority = 12,
		time = 3.5,
		vibration_H = 0.04,
		bounce = true,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1001,
		vibration_V = 0.005,
		friction_const_V = 0.00018,
		friction_coefficient_V = 1
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.shake_template

	var_1_10[1002] = {
		description = "大世界_仲裁者天帕岚斯武器_召唤前强震动",
		priority = 13,
		time = 12,
		vibration_H = 0.07,
		bounce = true,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1002,
		vibration_V = 0.006,
		friction_const_V = 0.0002,
		friction_coefficient_V = 1
	}
	pg = var_1_10

	local var_1_11 = var_1_10.base.shake_template

	var_1_11[1010] = {
		description = "大世界_仲裁者司特莲库斯武器_锤地大招震动",
		priority = 13,
		time = 1.5,
		vibration_H = 0.03,
		bounce = false,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1010,
		vibration_V = 6,
		friction_const_V = 0.00018,
		friction_coefficient_V = 0.93
	}
	pg = var_1_11

	local var_1_12 = var_1_11.base.shake_template

	var_1_12[1011] = {
		description = "大世界_仲裁者司特莲库斯武器_锤地小技能震动",
		priority = 12,
		time = 1.5,
		vibration_H = 0.03,
		bounce = false,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1011,
		vibration_V = 5,
		friction_const_V = 0.00018,
		friction_coefficient_V = 0.91
	}
	pg = var_1_12

	local var_1_13 = var_1_12.base.shake_template

	var_1_13[1020] = {
		description = "大世界_深渊Boss战列",
		priority = 9,
		time = 6,
		vibration_H = 0.04,
		bounce = true,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1020,
		vibration_V = 0.007,
		friction_const_V = 0.0005,
		friction_coefficient_V = 1
	}
	pg = var_1_13
	var_1_13.base.shake_template[1021] = {
		description = "大世界_深渊Boss战列",
		priority = 12,
		time = 3,
		vibration_H = 0.03,
		bounce = false,
		loop = 0,
		friction_const_H = 0,
		friction_coefficient_H = 1,
		id = 1021,
		vibration_V = 3.5,
		friction_const_V = 0.00018,
		friction_coefficient_V = 0.92
	}

	return
end)()

return
