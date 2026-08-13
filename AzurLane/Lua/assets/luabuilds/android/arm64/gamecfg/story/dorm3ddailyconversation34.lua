local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION34",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actor = 0,
		side = 0,
		hidePaintObj = true,
		say = "要出去走走吗？"
	}
}
local var_0_2 = {
	actorName = 20220,
	side = 2,
	dir = 1,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "我很乐意，我的{dorm3d}。不过，您是觉得天狼星这里有些乏味……吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "单纯只是想和天狼星出门。",
			flag = 1
		},
		{
			content = "想要两个人一起去外面做些什么",
			flag = 2
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
			name = "dianshouzhi",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 1,
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
var_0_1[2] = var_0_2
var_0_1[3] = {
	actorName = 20220,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "您的意思，难道是约、约会？！天狼星明白了，一定会好好侍奉{dorm3d}，直到您彻底尽兴为止❤",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
