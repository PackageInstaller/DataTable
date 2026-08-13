local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION90",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，您的脸有些红呢……是因为工作方面的应酬导致的吗？",
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
			name = "biaoda",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_jingya",
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
		content = "是啊",
		flag = 1
	},
	{
		content = "只是有些热",
		flag = 2
	}
}
var_0_1[1] = var_0_2
var_0_1[2] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 1,
	say = "摸上去也很烫……要不要天狼星帮您降降温呢？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "你要怎么做？",
			flag = 1
		}
	}
}
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 2,
	say = "那，要不要天狼星帮您降降温呢？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "你要怎么做？",
			flag = 1
		}
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，请您放松一些，天狼星要解开您的制服……",
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
			name = "beishang",
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
	say = "您的制服系得很规整，布料又厚实，这也是导致您体温上升的原因之一呢。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "接下来天狼星会用毛巾包裹住冰块，为您擦拭身体。",
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
			name = "shy",
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
var_0_8.options = {
	{
		content = "会感冒的吧？",
		flag = 1
	},
	{
		content = "是不是有点太刺激了",
		flag = 2
	}
}
var_0_1[6] = var_0_8

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "完全不会哦！",
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[7] = var_0_11

local var_0_14 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "如果{dorm3d}担心着凉的话，天狼星会用自己的体温给{dorm3d}保暖的！",
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
			name = "jinzhang",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_shiluo",
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
var_0_1[8] = var_0_14
var_0_1[9] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "您只要安心接受天狼星的侍奉就好了，我骄傲的{dorm3d}。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
