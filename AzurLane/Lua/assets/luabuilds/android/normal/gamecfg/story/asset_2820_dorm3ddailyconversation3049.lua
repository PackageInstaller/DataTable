local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3049",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actorName = 19903,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		dir = 1,
		say = "{dorm3d}，以后……安克雷奇……帮{dorm3d}，工作！",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	},
	{
		actorName = 19903,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		dir = 1,
		say = "{dorm3d}教，安克雷奇，很清楚……！",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	dir = 1,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "首先，整理……然后，分类……{dorm3d}，安克雷奇，说的对吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "不错！",
			flag = 1
		},
		{
			content = "就是这样！",
			flag = 1
		}
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "ab_shuohua_jinzhang_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_jingya",
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
var_0_1[3] = var_0_2
var_0_1[4] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "嘿嘿，做到了！安克雷奇，真棒…！{dorm3d}夸……安克雷奇，进步！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
