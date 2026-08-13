local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION91",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		nameColor = "#FFFFFF",
		actorName = 20220,
		say = "……{dorm3d}？",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "就算天狼星的料理水平再怎么不尽如人意，也绝对不会用微波炉泡茶的！",
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
			name = "yaotou",
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
		content = "这算是皇家的坚持吗？",
		flag = 1
	}
}
var_0_1[2] = var_0_2

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "当然！要泡茶的话，一定要用水壶把水烧开。",
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
			name = "jidong",
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
var_0_1[3] = var_0_5
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "绝对不可以接一杯水然后放进微波炉加热哦！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "您该不会……想这么试试吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "不会",
			flag = 1
		},
		{
			content = "……被你发现了",
			flag = 2
		}
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "呼……那就好。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_9 = {}

STORY_EVENT = var_4
var_0_9.name = var_4.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "kuxiao",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_beishang",
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
var_0_1[6] = var_0_8
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "开个玩笑而已，不过没想到天狼星的反应意外地有趣……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 2,
	say = "其它任何事都可以，唯独在这件事上，请恕天狼星无法妥协。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "kuxiao",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_beishang",
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_11.options = {
	{
		content = "天狼星的反应好有趣",
		flag = 1
	}
}
var_0_1[8] = var_0_11
var_0_1[9] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "欸？原来您是在和天狼星开玩笑啊……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_14 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "差点就要做好毁掉厨房也不能让您这样做的觉悟了……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_15 = {}

STORY_EVENT = var_4
var_0_15.name = var_4.TEST
var_0_15.data = {
	op_list = {
		{
			param = "Play",
			name = "yaotou",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_beishang",
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

local var_0_16 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_16.name = var_5.TEST_DONE
var_0_15.callbackData = var_0_16
var_0_14.dispatcher = var_0_15
var_0_1[10] = var_0_14
var_0_1[11] = {
	nameColor = "#FFFFFF",
	actorName = "指挥官",
	say = "……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
