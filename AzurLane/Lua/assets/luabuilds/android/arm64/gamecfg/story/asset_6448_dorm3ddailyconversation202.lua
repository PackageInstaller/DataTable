local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION202",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 30221,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "是不是该换个发卡了呢？",
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
			name = "shuohua_sikao",
			type = "action"
		},
		{
			skip = true,
			name = "Face_sikao",
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
var_0_1[1] = var_0_2
var_0_1[2] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "平时总在忙着训练和工作，很少有空闲思考这个。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "不如{dorm3d}陪我一起选一个新的款式吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "选你喜欢的款式就好",
			flag = 1
		}
	}
}
var_0_1[4] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	optionFlag = 1,
	say = "我还是更想让你来选。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "不怕我选的款式你不喜欢么？",
			flag = 1
		}
	}
}
var_0_1[5] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "……你喜欢的款式，我也一定会喜欢的。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
