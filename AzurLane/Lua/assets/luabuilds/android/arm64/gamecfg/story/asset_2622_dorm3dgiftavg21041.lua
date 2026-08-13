local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DGIFTAVG21041",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	wait = 1,
	side = 2,
	actorName = 79902,
	voice = "event:/dorm/drom3d_nakhimov_gift_timeline01_voice1/drom3d_nakhimov_gift_timeline01_voice1",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "{dorm3d}，你送给我的这个本能训练器……很可能会干扰工作间运行的设备。"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "anger_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_think_start",
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
var_0_2.typewriter = {
	speed = 0.05,
	speedUp = 0.01
}
var_0_1[1] = var_0_2
var_0_1[2] = {
	actorName = 79902,
	side = 2,
	wait = 1,
	dir = 1,
	voice = "event:/dorm/drom3d_nakhimov_gift_timeline01_voice2/drom3d_nakhimov_gift_timeline01_voice2",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "所以安全起见，想请指挥官来配合我进行仪器的稳定性分析。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
