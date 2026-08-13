pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_stocking_trigger") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_stocking_trigger"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_stocking_trigger = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_stocking_trigger

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
var_0_3.base.dorm3d_stocking_trigger = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_stocking_trigger

	var_1_0[1] = {
		exit = 1,
		trigger_pos = 0.2,
		id = 1,
		compare_type = 1,
		trigger_type = 1,
		trigger_param = {
			120231
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_stocking_trigger

	var_1_1[2] = {
		exit = 0,
		trigger_pos = 0.2,
		id = 2,
		compare_type = 1,
		trigger_type = 1,
		trigger_param = {
			120232
		}
	}
	pg = var_1_1
	var_1_1.base.dorm3d_stocking_trigger[3] = {
		exit = 0,
		trigger_pos = 0.2,
		id = 3,
		compare_type = 1,
		trigger_type = 1,
		trigger_param = {
			120225
		}
	}

	return
end)()

return
