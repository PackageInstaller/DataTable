local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3047",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "{dorm3d}！明天……安克雷奇，也能看到……{dorm3d}吗？",
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
			name = "ab_shuohua_idle_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_yihuo",
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
var_0_1[2] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "明天的明天……也可以？还有，很多个……明天，都能吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "{dorm3d}，能和安克雷奇，约定吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	actorName = 19903,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "不……不是每天都见面的约定……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "ab_shuohua_jujue_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_weixiao",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
			type = "wait"
		}
	}
}

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[4] = var_0_5
var_0_1[5] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "是……{dorm3d}……没来，安克雷奇……也会等着{dorm3d}……的约定！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
