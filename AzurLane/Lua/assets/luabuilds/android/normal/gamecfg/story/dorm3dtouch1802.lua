local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH1802",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/Tianlangxing_dorm3d_tone1/drom3d_sirus_ik_gift6_tone13",
	actorName = 20220,
	nameColor = "#FFFFFF",
	say = "要这样动起来的话，比平时要困难呢……",
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
			name = "bunny_IK_cafe_idle01_fb02",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "bunny_IK_cafe_idle01_fb02_baozhen",
			name = "furniture/Item/Cafe_Pillow/pre_db_cafe_pillow",
			time = 0,
			type = "extra_item_action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_weixiao",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 2,
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
