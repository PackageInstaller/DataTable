pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_carwash") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_carwash"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_carwash = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_carwash

var_0_3.all = {
	79902
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm3d_carwash = {}

;(function()
	pg = var_1_10000
	var_1_10000.base.dorm3d_carwash[30] = {
		character_prefab = "dorm3d/character/naximofu_db/prefabs/naximofu_racing_carwash",
		pos_phase2 = 4,
		group_id = 79902,
		pos = {
			1,
			2,
			3
		},
		non_decal_colliders = {
			"Head Collider"
		},
		end_timeline = {
			hideUI = false,
			sceneName = "XiChe_79902_JSZS",
			exit = "black",
			enter = "white",
			sceneAB = "dorm3d/character/naximofu_db/timeline/xiche_79902_jszs/xiche_79902_jszs_scene"
		}
	}

	return
end)()

return
