pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_minigame") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_minigame"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_minigame = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_minigame

var_0_3.all = {
	67,
	70,
	75
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_minigame

var_0_4.get_id_list_by_room_id = {
	{
		67
	},
	{
		70
	},
	{
		75
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
var_0_4.base.dorm3d_minigame = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_minigame

	var_1_0[67] = {
		name = "打手",
		id = 67,
		room_id = 1,
		area = "Chair",
		ship_id = 20220,
		action = {
			"SitStart",
			"SitEnd"
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_minigame

	var_1_1[70] = {
		name = "日程",
		action = "",
		id = 70,
		room_id = 2,
		area = "",
		ship_id = 30221
	}
	pg = var_1_1
	var_1_1.base.dorm3d_minigame[75] = {
		name = "猜拳游戏",
		action = "",
		id = 75,
		room_id = 3,
		area = "",
		ship_id = 19903
	}

	return
end)()

return
