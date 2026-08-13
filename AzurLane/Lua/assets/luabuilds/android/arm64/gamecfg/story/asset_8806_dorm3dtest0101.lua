local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTEST01",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		say = "对话1",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	say = "对话2",
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
			skip = false,
			name = "Bow",
			type = "action"
		},
		{
			param = "Play",
			name = "story_2202_01",
			time = 3,
			type = "timeline",
			skip = true
		}
	}
}

local var_0_4 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[2] = var_0_2

local var_0_5 = {
	say = "对话3",
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
			name = "story_2202_01",
			time = 0,
			type = "timeline"
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
	say = "选项",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "用力回握她的手",
			flag = 1
		},
		{
			content = "将{namecode:67}搂过来",
			flag = 2
		}
	}
}

local var_0_8 = {
	optionFlag = 2
}
local var_0_9 = {}

STORY_EVENT = var_4
var_0_9.name = var_4.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "story_2202_01",
			time = 7,
			type = "timeline"
		}
	}
}

local var_0_10 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_1[5] = var_0_8

local var_0_11 = {
	optionFlag = 1
}
local var_0_12 = {}

STORY_EVENT = var_0_10
var_0_12.name = var_0_10.TEST
var_0_12.data = {
	op_list = {
		{
			param = "Play",
			name = "story_2202_01",
			time = 5,
			type = "timeline"
		}
	}
}

local var_0_13 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[6] = var_0_11
var_0_1[7] = {
	say = "对话1",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
