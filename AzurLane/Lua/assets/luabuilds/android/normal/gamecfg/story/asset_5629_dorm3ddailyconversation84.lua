local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION84",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，您的黑眼圈好像又加重了。要处理的工作很多所以很辛苦吧。",
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
			name = "danyou",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 2,
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
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "如果天狼星能帮上您的忙就好了……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "对了，就用一杯果蔬汁让{dorm3d}您恢复精神吧，也能够补充营养。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_6 = {}

STORY_EVENT = var_0_4
var_0_6.name = var_0_4.TEST
var_0_6.data = {
	op_list = {
		{
			param = "Play",
			name = "rentong",
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
var_0_5.options = {
	{
		content = "不用麻烦了",
		flag = 1
	},
	{
		content = "有你在我身边就可以恢复精神",
		flag = 2
	}
}
var_0_1[3] = var_0_5

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "虽然您这么说了……",
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

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[4] = var_0_8
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "但是为了您的健康着想的话，天狼星还是为您……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "有没有除了果蔬汁以外的方法？",
			flag = 1
		}
	}
}

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "那、那么，就请用天狼星的身体来……!",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_12 = {}

STORY_EVENT = var_4
var_0_12.name = var_4.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "ganjin",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 1,
			type = "wait"
		},
		{
			param = "Play",
			name = "Face_jingxi",
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[6] = var_0_11
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}？您为什么突然后退了呢……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
