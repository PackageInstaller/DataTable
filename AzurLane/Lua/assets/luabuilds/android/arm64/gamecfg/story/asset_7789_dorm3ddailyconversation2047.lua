local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION2047",
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
		say = "想知道我的秘密？我对{dorm3d}没有保留秘密。",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	},
	{
		actorName = 30221,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		say = "问我最喜欢的人……？",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	actorName = 30221,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "这个问题在你这里，不能算秘密吧？",
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
			name = "shuohua_gandong",
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
var_0_1[3] = var_0_2
var_0_1[4] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "不过如果你想确认的话，无论多少次，我都会说给你听。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "我最喜欢的人……是你。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
