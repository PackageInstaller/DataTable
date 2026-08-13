local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DGIFTAVG12051",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	wait = 1,
	side = 2,
	actorName = 30707,
	voice = "event:/dorm/drom3d_Taiho_gift_timeline03_voice1/drom3d_Taiho_gift_timeline03_voice1",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "嗯？{dorm3d}！怎么走路没有声音呀~"
}
local var_0_3 = {}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_2.typewriter = {
	speed = 0.05,
	speedUp = 0.01
}
var_0_2.options = {
	{
		content = "你在收拾衣柜吗？",
		flag = 1
	}
}
var_0_1[1] = var_0_2

local var_0_5 = {
	actorName = 30707,
	side = 2,
	wait = 1,
	dir = 1,
	voice = "event:/dorm/drom3d_Taiho_gift_timeline03_voice2/drom3d_Taiho_gift_timeline03_voice2",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "嘿嘿~呵呵~当然不是，{namecode:97}在拿新睡衣呢~",
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

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[2] = var_0_5
var_0_1[3] = {
	actorName = 30707,
	side = 2,
	wait = 1,
	dir = 1,
	voice = "event:/dorm/drom3d_Taiho_gift_timeline03_voice3/drom3d_Taiho_gift_timeline03_voice3",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "是{dorm3d}从没见过的一身，呵呵~",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "？可以说……很期待？",
			flag = 1
		}
	}
}

local var_0_8 = {
	wait = 1,
	side = 2,
	actorName = 30707,
	dir = 1,
	voice = "event:/dorm/drom3d_Taiho_gift_timeline03_voice4/drom3d_Taiho_gift_timeline03_voice4",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "当然要期待！因为……大凤要带指挥官大人参与到睡衣的换新仪式中呢♡"
}
local var_0_9 = {}

STORY_EVENT = var_4
var_0_9.name = var_4.TEST
var_0_9.data = {
	op_list = {
		{
			param = "Play",
			name = "satisfied_01-start",
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

local var_0_10 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_10.name = var_5.TEST_DONE
var_0_9.callbackData = var_0_10
var_0_8.dispatcher = var_0_9
var_0_8.typewriter = {
	speed = 0.05,
	speedUp = 0.01
}
var_0_1[4] = var_0_8
var_0_0.scripts = var_0_1

return var_0_0
