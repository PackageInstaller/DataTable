pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "intimacy_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "intimacy_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.intimacy_template = var_0_2
pg = var_0

local var_0_3 = var_0.intimacy_template

var_0_3.all = {
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.intimacy_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.intimacy_template

	var_1_0[1] = {
		name = "失望",
		upper_bound = 3099,
		id = 1,
		attr_bonus = 0,
		lower_bound = 0,
		icon = "intimacy_1",
		desc = "intimacy_desc_1"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.intimacy_template

	var_1_1[2] = {
		name = "陌生",
		upper_bound = 6099,
		id = 2,
		attr_bonus = 0,
		lower_bound = 3100,
		icon = "intimacy_2",
		desc = "intimacy_desc_2"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.intimacy_template

	var_1_2[3] = {
		name = "友好",
		upper_bound = 8099,
		id = 3,
		attr_bonus = 100,
		lower_bound = 6100,
		icon = "intimacy_3",
		desc = "intimacy_desc_3"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.intimacy_template

	var_1_3[4] = {
		name = "喜欢",
		upper_bound = 9999,
		id = 4,
		attr_bonus = 300,
		lower_bound = 8100,
		icon = "intimacy_4",
		desc = "intimacy_desc_4"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.intimacy_template

	var_1_4[5] = {
		name = "爱",
		upper_bound = 10000,
		id = 5,
		attr_bonus = 600,
		lower_bound = 10000,
		icon = "intimacy_5",
		desc = "intimacy_desc_5"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.intimacy_template

	var_1_5[6] = {
		name = "婚",
		upper_bound = 19999,
		id = 6,
		attr_bonus = 900,
		lower_bound = 10001,
		icon = "Intimacy_6",
		desc = "intimacy_desc_6"
	}
	pg = var_1_5
	var_1_5.base.intimacy_template[7] = {
		name = "婚",
		upper_bound = 20000,
		id = 7,
		attr_bonus = 1200,
		lower_bound = 20000,
		icon = "Intimacy_6",
		desc = "intimacy_desc_7"
	}

	return
end)()

return
