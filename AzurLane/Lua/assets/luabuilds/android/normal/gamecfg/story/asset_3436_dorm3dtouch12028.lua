local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH12028",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 30707,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_Taiho_ik_gfit2_tone5/drom3d_Taiho_ik_gfit2_tone5",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "能感受到{dorm3d}的温度……{namecode:97}真是太幸福了……",
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
			name = "IK_sp01_idle02_fb02",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "IK_sp01_idle02_fb02_PP",
			name = "furniture/Prefabs/Pay_Dafenghostel/pre_db_df_pipa01",
			time = 0,
			type = "extra_item_action",
			skip = true
		},
		{
			skip = true,
			name = "Face_smile_start",
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
