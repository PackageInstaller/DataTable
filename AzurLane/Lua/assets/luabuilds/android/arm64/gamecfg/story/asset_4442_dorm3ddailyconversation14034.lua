local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION14034",
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
	say = "{dorm3d}，工作怎么样了？",
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
			name = "talk_01-start",
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
	say = "是吗，还剩下一些……这样啊……",
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
			name = "think_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
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
	say = "没什么，不过是觉得……你走出这里以后……那道目光……就不能只为我停留。",
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
			name = "Idle",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_helpless_start",
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
	say = "真讨厌，我怎么也开始说起孩子话来了？你有你的工作，我有我的职责……我明白的……",
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
			name = "shake_01",
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
	say = "……让我再抱一会儿吧，就一小会儿。不会耽误太久的……现在暂且，就这样吧？",
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
			name = "doubt_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shy_start",
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
