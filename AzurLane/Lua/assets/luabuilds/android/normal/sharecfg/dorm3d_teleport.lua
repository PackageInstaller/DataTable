pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_teleport") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_teleport"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_teleport = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_teleport

var_0_3.all = {
	1401,
	1402
}
pg = var_0_3

local var_0_4 = var_0_3.dorm3d_teleport

var_0_4.get_id_list_by_room_id = {
	[14] = {
		1401,
		1402
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
var_0_4.base.dorm3d_teleport = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_teleport

	var_1_0[1401] = {
		id = 1401,
		room_id = 14,
		teleport_zone = 14002,
		item_path = "/[MainBlock]/[Model]/scene_root/fbx/litmap_02/pre_db_aijier01/door_collider"
	}
	pg = var_1_0
	var_1_0.base.dorm3d_teleport[1402] = {
		id = 1402,
		room_id = 14,
		teleport_zone = 14003,
		item_path = "/[MainBlock]/[Model]/scene_root/fbx/litmap_05/pre_db_aijier01_study01/door_collider"
	}

	return
end)()

return
