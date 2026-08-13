local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH21022",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 79902,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_nakhimov_ik_furniture1_tone5/drom3d_nakhimov_ik_furniture1_tone5",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "欸，红灯警报，这是出什么故障了……",
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
			name = "IK_desk02_idle01_fb01-2",
			time = 0,
			type = "action",
			skip = true
		},
		{
			id = 3004,
			name = "IK_desk02_idle01_fb01-2_MFJC",
			type = "item_action"
		},
		{
			id = 3005,
			name = "vfx_desk02_idle01_fb01_2",
			type = "item_action"
		},
		{
			skip = true,
			name = "Face_amazed_start",
			type = "action"
		},
		{
			skip = false,
			time = 4,
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
