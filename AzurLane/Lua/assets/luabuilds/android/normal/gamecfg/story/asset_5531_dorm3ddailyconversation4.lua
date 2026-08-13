local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION4",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actor = 0,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		say = "（这段时间天狼星都没提过什么要求……还是问问她吧。）",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		},
		options = {
			{
				content = "要不要添置一些家具？",
				flag = 1
			},
			{
				content = "有没有想要的东西？",
				flag = 2
			}
		}
	}
}
local var_0_2 = {
	actorName = 20220,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "感谢您的关怀和慷慨，不过天狼星目前还不需要这些，我的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "biaoda",
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
	say = "只要能够留在这里，并且还能够这样侍奉您，天狼星就满足了。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
