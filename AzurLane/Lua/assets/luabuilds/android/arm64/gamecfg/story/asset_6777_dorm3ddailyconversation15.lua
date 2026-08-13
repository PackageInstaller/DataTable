local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION15",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 20220,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "{dorm3d}看起来好像有点疲惫，没什么精神呢？一定是工作太累了吧……",
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
			name = "shy",
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
var_0_1[1] = var_0_2
var_0_1[2] = {
	actorName = 20220,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "不过，天狼星这里有一个能让{dorm3d}快速恢复精神的技巧哦！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "什么技巧？",
			flag = 1
		}
	}
}
var_0_1[3] = {
	actorName = 20220,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "就是——在感到疲惫的时候，立刻洗个热水澡！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	actorName = 20220,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "天狼星现在就来侍奉{dorm3d}沐浴吧！……就从帮您脱掉衣服开始！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
