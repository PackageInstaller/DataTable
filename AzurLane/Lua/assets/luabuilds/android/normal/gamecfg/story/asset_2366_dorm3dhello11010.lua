local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO11010",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 10517,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_NewJersey_other/drom3d_NewJersey_hello10",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "房间OK，灯光OK，香薰OK~！再加上honey~！让我们开始房间约会吧！我可是很期待呢！",
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
			name = "shy_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_shy_start",
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
