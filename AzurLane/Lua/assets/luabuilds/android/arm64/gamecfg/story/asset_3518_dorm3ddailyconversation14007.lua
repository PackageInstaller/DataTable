local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION14007",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "从刚才起你就一直往身后藏着什么……该不会是在准备什么幼稚的惊喜吧？",
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
			name = "stare_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_think_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
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

local var_0_5 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "让我看看，到底是什么让你这么神秘——嗯？是个布偶？",
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
			name = "anger_01-end",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_amazed_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
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
var_0_1[2] = var_0_5

local var_0_8 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "……你说它像我？这对角又软又短，头也比身子还大……原来在指挥官心里我是这样的形象啊？",
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
			name = "sad_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shame_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
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
var_0_1[3] = var_0_8

local var_0_11 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "这个我没收了，可不能让它出现在你的办公室里影响我的威严。",
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
			name = "yandere_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_smile_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
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
var_0_1[4] = var_0_11

local var_0_14 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "想要回去？除非……你也做一个你自己的来交换。这样才算公平，不是吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_15 = {}

STORY_EVENT = var_0_13
var_0_15.name = var_0_13.TEST
var_0_15.data = {
	op_list = {
		{
			param = "Play",
			name = "Idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shame_start",
			type = "action"
		},
		{
			skip = false,
			time = 1.5,
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
var_0_1[5] = var_0_14
var_0_0.scripts = var_0_1

return var_0_0
