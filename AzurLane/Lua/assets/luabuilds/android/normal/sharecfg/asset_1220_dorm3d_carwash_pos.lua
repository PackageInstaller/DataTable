pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_carwash_pos") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_carwash_pos"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_carwash_pos = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_carwash_pos

var_0_3.all = {
	1,
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
var_0_3.base.dorm3d_carwash_pos = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_carwash_pos

	var_1_0[1] = {
		mood_value = 0,
		idle_anim = "XC1_idle",
		id = 1,
		hit_reaction_layer = "idle1",
		pos = "nxmf_1",
		fury_anim = {
			1,
			2,
			3,
			4
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.dorm3d_carwash_pos

	var_1_1[2] = {
		mood_value = 30,
		idle_anim = "XC2_idle",
		id = 2,
		hit_reaction_layer = "idle1",
		pos = "nxmf_2",
		fury_anim = {
			5,
			6,
			7,
			8,
			99
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.dorm3d_carwash_pos

	var_1_2[3] = {
		mood_value = 60,
		idle_anim = "XC3_idle-CW",
		id = 3,
		hit_reaction_layer = "idle1",
		pos = "nxmf_3",
		fury_anim = {
			9,
			12,
			4
		}
	}
	pg = var_1_2
	var_1_2.base.dorm3d_carwash_pos[4] = {
		mood_value = 100,
		idle_anim = "XC3_idle-CN",
		id = 4,
		hit_reaction_layer = "",
		pos = "nxmf_3",
		fury_anim = {
			10,
			11
		}
	}

	return
end)()

return
