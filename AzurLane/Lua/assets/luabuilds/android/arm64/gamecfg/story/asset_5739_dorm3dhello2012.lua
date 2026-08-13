local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO2012",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello12",
	actorName = 30221,
	hidePaintObj = true,
	side = 2,
	nameColor = "#FFFFFF",
	say = "太好了，今天的期待也被{dorm3d}满足了呢。嗯？好奇我在期待什么吗？就是……每次分开以后，我都会想你下一次会什么时候来而已啦……",
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
			skip = true,
			name = "shuohua_chuaishou",
			type = "action"
		},
		{
			skip = true,
			name = "Face_weixiao",
			type = "action"
		},
		{
			time = 2.5,
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
