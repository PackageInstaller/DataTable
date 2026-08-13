local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION83",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "现在好像还不是泡温泉的季节呢……",
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
		content = "说的也是呢，有点可惜",
		flag = 1
	},
	{
		content = "季节不是问题",
		flag = 2
	}
}
var_0_1[1] = var_0_2
var_0_1[2] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 1,
	say = "{dorm3d}，您想去泡温泉吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 2,
	say = "确实呢，只要有一颗想泡温泉的心，季节也不是问题。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不过……现在去泡温泉的话，应该就体会不到在汤泉中欣赏红枫的惬意了吧。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "嗯？您说这样的话听起来不像是天狼星会说的……",
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
			name = "sikao2",
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
var_0_1[5] = var_0_5
var_0_1[6] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "因为这是天狼星偶然间从重樱的同伴们那里听来的，我敏锐的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "如果可以的话，请您允许天狼星的小小请求。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星想在最合适的季节中与您一同……并且侍奉在您左右。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_9 = {}

STORY_EVENT = var_0_7
var_0_9.name = var_0_7.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "toukan",
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

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[8] = var_0_8
var_0_0.scripts = var_0_1

return var_0_0
