pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "energy_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "energy_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.energy_template = var_0_2
pg = var_0

local var_0_3 = var_0.energy_template

var_0_3.all = {
	1,
	2,
	3,
	4
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.energy_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.energy_template

	var_1_0[1] = {
		name = "低落的心情",
		upper_bound = 0,
		id = 1,
		lower_bound = 0,
		icon = "express_1",
		desc = "energy_desc_1"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.energy_template

	var_1_1[2] = {
		name = "一般的心情",
		upper_bound = 30,
		id = 2,
		lower_bound = 1,
		icon = "express_2",
		desc = "energy_desc_2"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.energy_template

	var_1_2[3] = {
		name = "好心情",
		upper_bound = 120,
		id = 3,
		lower_bound = 31,
		icon = "express_3",
		desc = "energy_desc_3"
	}
	pg = var_1_2
	var_1_2.base.energy_template[4] = {
		name = "很好心情",
		upper_bound = 150,
		id = 4,
		lower_bound = 121,
		icon = "express_4",
		desc = "energy_desc_4"
	}

	return
end)()

return
