pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "commander_home_style") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "commander_home_style"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.commander_home_style = var_0_2
pg = var_0

local var_0_3 = var_0.commander_home_style

var_0_3.all = {
	1,
	2,
	3
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.commander_home_style = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.commander_home_style

	var_1_0[1] = {
		id = 1,
		name = "1"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.commander_home_style

	var_1_1[2] = {
		id = 2,
		name = "2"
	}
	pg = var_1_1
	var_1_1.base.commander_home_style[3] = {
		id = 3,
		name = "3"
	}

	return
end)()

return
