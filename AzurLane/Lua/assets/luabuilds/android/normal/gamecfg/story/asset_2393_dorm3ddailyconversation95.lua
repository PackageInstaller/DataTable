local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION95",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "因为{dorm3d}您总是加班处理工作文件，所以很少有机会能看到夕阳吧。",
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
			name = "sikao1",
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
		content = "所以多少觉得有些可惜",
		flag = 1
	}
}
var_0_1[1] = var_0_2
var_0_1[2] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "可惜……？是因为错失了景色的可惜吗？天狼星不太明白。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "欸？您说夕阳是白天与晚上的重要分界线，错过了就觉得一天过得很混沌？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "那，天狼星可以之后去帮您处理工作，或者接您下班吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_6 = {}

STORY_EVENT = var_4
var_0_6.name = var_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "dianshouzhi",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_haixiu",
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

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[4] = var_0_5
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星想让您看到夕阳，我的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[6] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "哪怕只是工作途中片刻的休息，天狼星也想实现您的愿望。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星，想为您做些什么……我骄傲的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
