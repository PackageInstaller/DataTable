pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "crossroad_ship") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "crossroad_ship"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.crossroad_ship = var_0_2
pg = var_0

local var_0_3 = var_0.crossroad_ship

var_0_3.all = {
	101,
	102,
	103,
	104,
	105,
	106
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.crossroad_ship = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.crossroad_ship

	var_1_0[101] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 1,
		id = 101,
		move_type = 2,
		width = 100,
		resource = "daqinghuayu_tpl"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.crossroad_ship

	var_1_1[102] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 2,
		id = 102,
		move_type = 2,
		width = 100,
		resource = "xinzexi_tpl"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.crossroad_ship

	var_1_2[103] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 0,
		id = 103,
		move_type = 1,
		width = 100,
		resource = "zibao_tpl"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.crossroad_ship

	var_1_3[104] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 0,
		id = 104,
		move_type = 1,
		width = 100,
		resource = "jinbi_tpl"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.crossroad_ship

	var_1_4[105] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 0,
		id = 105,
		move_type = 1,
		width = 100,
		resource = "yulei_tpl"
	}
	pg = var_1_4
	var_1_4.base.crossroad_ship[106] = {
		speed = 60,
		weight = 10,
		length = 5,
		type = 0,
		id = 106,
		move_type = 1,
		width = 100,
		resource = "weixiu_tpl"
	}

	return
end)()

return
