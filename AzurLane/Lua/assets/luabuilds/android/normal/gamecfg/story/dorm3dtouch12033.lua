local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH12033",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 30707,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_Taiho_ik_gfit4_tone3/drom3d_Taiho_ik_gfit4_tone3",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "每次被{dorm3d}触碰的地方……都变得滚烫呢……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "IK_sp01_idle01_fb02",
			time = 5,
			type = "action",
			skip = true
		},
		{
			param = "IK_sp01_idle01_fb02_PP",
			name = "furniture/Prefabs/Pay_Dafenghostel/pre_db_df_pipa01",
			time = 5,
			type = "extra_item_action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2
var_0_0.scripts = var_0_1

return var_0_0
