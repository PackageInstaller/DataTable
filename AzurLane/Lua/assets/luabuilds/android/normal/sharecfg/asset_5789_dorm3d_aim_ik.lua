pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "dorm3d_aim_ik") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "dorm3d_aim_ik"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.dorm3d_aim_ik = var_0_2
pg = var_0

local var_0_3 = var_0.dorm3d_aim_ik

var_0_3.all = {
	7990201,
	7990202
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.dorm3d_aim_ik = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.dorm3d_aim_ik

	var_1_0[7990201] = {
		fade_out = 0.3,
		layer_config = "config114514",
		id = 7990201,
		group_id = 79902,
		fade_in = 0.3,
		item_path = "/all_con/[camera]/Vcam1/ZHG_shou_R/pre_char_zhihuiguan_handR_mod/all/Bip001/ZHGArm_Bip001 Pelvis/Bip001 Spine/Bip001 R Clavicle/Bip001 R UpperArm"
	}
	pg = var_1_0
	var_1_0.base.dorm3d_aim_ik[7990202] = {
		fade_out = 0.3,
		layer_config = "config7990202",
		id = 7990202,
		group_id = 79902,
		fade_in = 0.3,
		item_path = "/all_con/[camera]/Vcam1/ZHG_shou_R/pre_char_zhihuiguan_handR_mod/all/Bip001/ZHGArm_Bip001 Pelvis/Bip001 Spine/Bip001 R Clavicle/Bip001 R UpperArm"
	}

	return
end)()

return
