pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "mode_room") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "mode_room"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.mode_room = var_0_2
pg = var_0

local var_0_3 = var_0.mode_room

var_0_3.all = {
	0,
	101,
	105,
	106,
	107
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.mode_room = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.mode_room

	var_1_0[0] = {
		viewer_count = 5,
		key = "test_room",
		id = 0,
		activity_type = 0,
		count = {
			1,
			1
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.mode_room

	var_1_1[101] = {
		viewer_count = 5,
		key = "scammer_tavern",
		id = 101,
		activity_type = 801,
		count = {
			1,
			1,
			1,
			1
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.mode_room

	var_1_2[105] = {
		viewer_count = 0,
		key = "竞拍低级场",
		id = 105,
		activity_type = 0,
		count = {
			1,
			1,
			1,
			1
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.mode_room

	var_1_3[106] = {
		viewer_count = 0,
		key = "竞拍中级场",
		id = 106,
		activity_type = 0,
		count = {
			1,
			1,
			1,
			1
		}
	}
	pg = var_1_3
	var_1_3.base.mode_room[107] = {
		viewer_count = 0,
		key = "竞拍高级场",
		id = 107,
		activity_type = 0,
		count = {
			1,
			1,
			1,
			1
		}
	}

	return
end)()

return
