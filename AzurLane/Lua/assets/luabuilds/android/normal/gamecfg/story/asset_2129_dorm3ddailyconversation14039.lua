local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION14039",
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
	say = "嗯，这件不行……这件也……",
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
			name = "shake_01",
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
var_0_1[2] = {
	actor = 0,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "这是在挑什么？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "呀？！吓死我了，不要突然凑过来！",
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
			name = "amazed_01-start",
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
var_0_1[3] = var_0_5

local var_0_8 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "那个，就是，泳、泳装……我有好几件中意的，不知道该怎么选……",
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
			name = "emotion_01-start",
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
var_0_1[4] = var_0_8
var_0_1[5] = {
	actor = 0,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "这种东西还是到店试穿比较好吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "这么说好像也对。好——决定了，明天就去挑吧，当然了，你得跟我一起去。",
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
			name = "excited_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_angry_start",
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
var_0_1[6] = var_0_11

local var_0_14 = {
	actorName = 49905,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "不许有反对意见，听明白了吗？",
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
			name = "nod_01",
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

local var_0_16 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_16.name = var_5.TEST_DONE
var_0_15.callbackData = var_0_16
var_0_14.dispatcher = var_0_15
var_0_1[7] = var_0_14
var_0_0.scripts = var_0_1

return var_0_0
