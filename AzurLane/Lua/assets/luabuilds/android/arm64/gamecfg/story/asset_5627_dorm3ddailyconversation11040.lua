local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION11040",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 10517,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "honey，给你的蜜桔汁热红酒。",
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
			name = "hello_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_smile_start",
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
	actor = 10517,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "Honey快尝尝呀~",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	actor = 10517,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "我也很想知道，这是什么味道呢。",
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
			name = "shy_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_think_start",
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
var_0_1[4] = {
	actorName = 10517,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "如果好喝的话，我也愿意尝尝哦~",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
