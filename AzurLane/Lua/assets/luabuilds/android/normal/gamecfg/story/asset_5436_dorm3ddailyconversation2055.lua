local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION2055",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actorName = 30221,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		dir = 1,
		say = "这里的珊瑚礁也很美，有点想去浮潜……",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	actorName = 30221,
	side = 2,
	dir = 1,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "不过如果遇到水母的话……总感觉很危险。",
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
			name = "shuohua_yaotou",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_wunai",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
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
var_0_2.options = {
	{
		content = "别担心，我会保护{namecode:50:能代}的。",
		flag = 1
	}
}
var_0_1[2] = var_0_2
var_0_1[3] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "{dorm3d}真是可靠呢……不过如果真的遇到水母的话……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "应该是我来保护{dorm3d}会比较合适吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
