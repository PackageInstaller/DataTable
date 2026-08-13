local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH11043",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 10517,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_NewJersey_other/drom3d_NewJersey_ik_gfit3_tone7",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "明明和honey已经是这种关系了……但还是会紧张呢……",
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
			name = "IK_dining02_idle01_fb02",
			time = 0,
			type = "action",
			skip = true
		},
		{
			id = 2018,
			name = "IK_dining02_idle01_fb02_BX",
			type = "item_action"
		},
		{
			skip = true,
			name = "face_happy_start",
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
