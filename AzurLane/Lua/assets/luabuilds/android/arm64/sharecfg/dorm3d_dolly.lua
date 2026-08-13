pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3D_dolly") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3D_dolly"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3D_dolly = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3D_dolly

var_0_3.all = {
	1001,
	1002
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3D_dolly

var_0_4.get_id_list_by_char_id = {
	[20220] = {
		1001,
		1002
	}
}
pg = var_0_4
pg = var_1

local var_0_5

if not var_1.base then
	var_0_5 = {}
end

var_0_4.base = var_0_5
pg = var_0_4
var_0_4.base.dorm3D_dolly = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3D_dolly

	var_1_0[1001] = {
		char_id = 20220,
		name = "Dolly1_2",
		id = 1001,
		move_time = 0,
		wait_time = 0
	}
	pg = var_1_0
	var_1_0.base.dorm3D_dolly[1002] = {
		char_id = 20220,
		name = "Dolly2_3",
		id = 1002,
		move_time = 3,
		wait_time = -1
	}

	return
end)()

return
