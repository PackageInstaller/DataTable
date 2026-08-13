pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_ik_touch_move") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_ik_touch_move"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_ik_touch_move = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_ik_touch_move

var_0_3.all = {
	1003101,
	1990311,
	1990312,
	1990313,
	1990314,
	1990315
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm3d_ik_touch_move = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_ik_touch_move

	var_1_0[1003101] = {
		target_ik = 10013001,
		trigger_dialogue = 0,
		back_time = 0.5,
		id = 1003101,
		move_time = 2.2,
		touch_step = {
			0.2,
			0.4,
			0.6,
			0.8,
			1
		},
		ik_point = {
			1,
			1
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_ik_touch_move

	var_1_1[1990311] = {
		target_ik = 30031200,
		trigger_dialogue = 0,
		back_time = 0.1,
		id = 1990311,
		move_time = 0.2,
		touch_step = {
			0.9,
			0.9,
			0.9,
			0.9,
			0.9,
			1
		},
		ik_point = {
			0,
			0
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_ik_touch_move

	var_1_2[1990312] = {
		target_ik = 31031200,
		trigger_dialogue = 0,
		back_time = 0.1,
		id = 1990312,
		move_time = 0.2,
		touch_step = {
			0.9,
			0.9,
			0.9,
			0.9,
			0.9,
			1
		},
		ik_point = {
			0,
			0
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.dorm3d_ik_touch_move

	var_1_3[1990313] = {
		target_ik = 30031000,
		trigger_dialogue = 0,
		back_time = 0.15,
		id = 1990313,
		move_time = 0.15,
		touch_step = {
			1,
			1,
			1,
			1
		},
		ik_point = {
			0,
			0
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.dorm3d_ik_touch_move

	var_1_4[1990314] = {
		target_ik = 30031000,
		trigger_dialogue = 0,
		back_time = 0.15,
		id = 1990314,
		move_time = 0.15,
		touch_step = {
			1,
			1,
			1,
			1
		},
		ik_point = {
			0,
			0
		}
	}
	pg = var_1_4
	var_1_4.base.dorm3d_ik_touch_move[1990315] = {
		target_ik = 30051201,
		trigger_dialogue = 0,
		back_time = 0.15,
		id = 1990315,
		move_time = 0.15,
		touch_step = {
			1,
			1,
			1,
			1
		},
		ik_point = {
			1,
			0
		}
	}

	return
end)()

return
