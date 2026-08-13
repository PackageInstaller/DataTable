local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO2010",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello10",
	actorName = 30221,
	hidePaintObj = true,
	side = 2,
	nameColor = "#FFFFFF",
	say = "{dorm3d}来了啊，要不要试试按摩呢？嗯……等你的时候我学了些按摩的手法，说是能比较有效地缓解肩颈方面的疲劳。快来这边坐下，让我试试看吧？",
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
			name = "shuohua_zixin",
			type = "action"
		},
		{
			skip = true,
			name = "Face_kaixing",
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
