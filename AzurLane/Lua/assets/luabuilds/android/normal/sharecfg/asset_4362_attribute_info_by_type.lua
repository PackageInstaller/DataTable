pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "attribute_info_by_type") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "attribute_info_by_type"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.attribute_info_by_type = var_0_2
pg = var_0

local var_0_3 = var_0.attribute_info_by_type

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
	10,
	11,
	12
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.attribute_info_by_type = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.attribute_info_by_type

	var_1_0[1] = {
		id = 1,
		name = "durability",
		condition = "耐久"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.attribute_info_by_type

	var_1_1[2] = {
		id = 2,
		name = "cannon",
		condition = "炮击"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.attribute_info_by_type

	var_1_2[3] = {
		id = 3,
		name = "torpedo",
		condition = "雷击"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.attribute_info_by_type

	var_1_3[4] = {
		id = 4,
		name = "antiaircraft",
		condition = "防空"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.attribute_info_by_type

	var_1_4[5] = {
		id = 5,
		name = "air",
		condition = "航空"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.attribute_info_by_type

	var_1_5[6] = {
		id = 6,
		name = "reload",
		condition = "装填"
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.attribute_info_by_type

	var_1_6[7] = {
		id = 7,
		name = "armor",
		condition = "装甲"
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.attribute_info_by_type

	var_1_7[8] = {
		id = 8,
		name = "hit",
		condition = "命中"
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.attribute_info_by_type

	var_1_8[9] = {
		id = 9,
		name = "dodge",
		condition = "机动"
	}
	pg = var_1_8

	local var_1_9 = var_1_8.base.attribute_info_by_type

	var_1_9[10] = {
		id = 10,
		name = "speed",
		condition = "航速"
	}
	pg = var_1_9

	local var_1_10 = var_1_9.base.attribute_info_by_type

	var_1_10[11] = {
		id = 11,
		name = "luck",
		condition = "幸运"
	}
	pg = var_1_10
	var_1_10.base.attribute_info_by_type[12] = {
		id = 12,
		name = "antisub",
		condition = "反潜"
	}

	return
end)()

return
