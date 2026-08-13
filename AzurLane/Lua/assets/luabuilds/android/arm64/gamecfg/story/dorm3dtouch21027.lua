local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH21027",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 79902,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_nakhimov_ik_gfit1_tone3/drom3d_nakhimov_ik_gfit1_tone3",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "嗯……这是中档吗……感觉稍微有些刺激……",
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
			name = "IK_desk02_idle02_fb03",
			time = 0,
			type = "action",
			skip = true
		},
		{
			id = 3004,
			name = "IK_desk02_idle02_fb03_MFJC",
			type = "item_action"
		},
		{
			id = 3005,
			name = "vfx_desk02_idle02_fb03",
			type = "item_action"
		},
		{
			skip = true,
			name = "Face_amazed_start",
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
