local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO3014",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_Anchorage_other/drom3d_Anchorage_hello14",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "{dorm3d}……来啦！{dorm3d}，不在……安克雷奇，好寂寞……抱抱……安克雷奇！",
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
			name = "ab_shuohua_chongbai_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_haixiu",
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
