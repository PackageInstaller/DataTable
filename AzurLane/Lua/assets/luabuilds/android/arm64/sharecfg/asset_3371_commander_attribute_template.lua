pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "commander_attribute_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "commander_attribute_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.commander_attribute_template = var_0_2
pg = var_0

local var_0_3 = var_0.commander_attribute_template

var_0_3.all = {
	101,
	102,
	103
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.commander_attribute_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.commander_attribute_template

	var_1_0[101] = {
		rate_durability = 0,
		name = "指挥",
		rate_torpedo = 3000,
		rate_antiaircraft = 0,
		id = 101,
		rate_antisub = 9000,
		rate_cannon = 6000,
		rate_air = 0
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.commander_attribute_template

	var_1_1[102] = {
		rate_durability = 0,
		name = "战术",
		rate_torpedo = 6000,
		rate_antiaircraft = 9000,
		id = 102,
		rate_antisub = 0,
		rate_cannon = 0,
		rate_air = 3000
	}
	pg = var_1_1
	var_1_1.base.commander_attribute_template[103] = {
		rate_durability = 9000,
		name = "后勤",
		rate_torpedo = 0,
		rate_antiaircraft = 0,
		id = 103,
		rate_antisub = 0,
		rate_cannon = 3000,
		rate_air = 6000
	}

	return
end)()

return
