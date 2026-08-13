local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH1605",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/Tianlangxing_dorm3d_tone/touch21",
	actorName = 20220,
	nameColor = "#FFFFFF",
	say = "这样的姿势，会适合天狼星吗？",
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
			name = "zuo_FF_2_hudong_jiao_2_start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_haixiu",
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
