pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10003

local var_0_2

if not var_0_10001(var_0_10003, "dorm3d_camera_volume_template") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_camera_volume_template"
	}

	confNEO = var_4
	var_0_2 = var_0_2(var_0_1, var_4)
end

var_0.dorm3d_camera_volume_template = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_camera_volume_template

var_0_3.all = {
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
var_0_3.base.dorm3d_camera_volume_template = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_camera_volume_template

	var_1_0[2] = {
		unlock_text = "契合度1级解锁",
		name = "反差",
		volume = "contrast_volume",
		id = 2,
		icon = "Props/drom3d_camera1001",
		rarity = 2,
		desc = "获得后可在相机功能中解锁反差滤镜",
		unlock = {}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_camera_volume_template

	var_1_1[3] = {
		unlock_text = "契合度9级解锁",
		name = "黄昏",
		volume = "dusk_volume",
		id = 3,
		icon = "Props/drom3d_camera1001",
		rarity = 2,
		desc = "获得后可在相机功能中解锁黄昏滤镜",
		unlock = {
			1,
			20220,
			9
		}
	}
	pg = var_1_1
	var_1_1.base.dorm3d_camera_volume_template[4] = {
		unlock_text = "契合度13级解锁",
		name = "柔光",
		volume = "soft_volume",
		id = 4,
		icon = "Props/drom3d_camera1001",
		rarity = 2,
		desc = "获得后可在相机功能中解锁柔光滤镜",
		unlock = {
			1,
			20220,
			13
		}
	}

	return
end)()

return
