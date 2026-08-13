local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION2019",
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
		say = "问我这周的安排么？",
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
		say = "我想先把借来的几本书看完，还有一些额外的自主训练安排……",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		},
		options = {
			{
				content = "看来约你出门是没机会了？",
				flag = 1
			}
		}
	}
}
local var_0_2 = {
	actorName = 30221,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "……约、约我？那……其他事情都可以搁置的。",
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
			skip = true,
			name = "shuohua_chuaishou",
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
	say = "你一直都是……最优先事项。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
