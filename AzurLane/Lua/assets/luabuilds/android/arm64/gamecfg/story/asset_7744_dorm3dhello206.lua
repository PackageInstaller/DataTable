local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO206",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello6",
	actorName = 30221,
	hidePaintObj = true,
	side = 2,
	nameColor = "#FFFFFF",
	say = "嗯……感觉最近{dorm3d}做事越来越有条理了呢，也许……会是我帮上忙了吗？如果有什么工作方面的事需要帮忙，也可以不用客气地告诉我哦。",
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
			name = "shuohua_wenhou",
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
