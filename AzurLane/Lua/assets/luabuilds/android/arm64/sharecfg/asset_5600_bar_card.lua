pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "bar_card") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "bar_card"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.bar_card = var_0_2
pg = var_0

local var_0_3 = var_0.bar_card

var_0_3.all = {
	1,
	2,
	3,
	99,
	0
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.bar_card = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.bar_card

	var_1_0[1] = {
		id = 1,
		unit_res = 101006,
		card_res = "card_1"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.bar_card

	var_1_1[2] = {
		id = 2,
		unit_res = 101007,
		card_res = "card_2"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.bar_card

	var_1_2[3] = {
		id = 3,
		unit_res = 101005,
		card_res = "card_3"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.bar_card

	var_1_3[99] = {
		id = 99,
		unit_res = 101008,
		card_res = "card_99"
	}
	pg = var_1_3
	var_1_3.base.bar_card[0] = {
		id = 0,
		unit_res = 101010,
		card_res = ""
	}

	return
end)()

return
