local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION99",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "如果有一天{dorm3d}要处理的工作不再那么多，您想去哪里放松一下呢？",
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
			name = "shy",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_weixiao",
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
var_0_3.options = {
	{
		content = "在这里就挺好",
		flag = 1
	},
	{
		content = "在你身边就好",
		flag = 2
	}
}
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "主、{dorm3d}！这样不算是真正回答了天狼星的问题。",
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
			name = "surprise1",
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

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[2] = var_0_5
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星是真的很想知道，您在有足够的时间以后想去哪里。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "因为……天狼星想为那一天的到来做些准备（小声）。",
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
			name = "dianshouzhi",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_haixiu",
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
		content = "我的回答也是真的",
		flag = 1
	},
	{
		content = "只想去有天狼星的地方",
		flag = 2
	}
}
var_0_1[4] = var_0_8
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，您……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星明白了，等到那一天到来，就与您随便去哪里兜风吧。",
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
			name = "beishang",
			time = 0,
			type = "action",
			skip = true
		},
		{
			param = "Play",
			name = "Face_haixiu",
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
var_0_1[6] = var_0_11
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "只要能与您度过足够亲密的时光，天狼星就满足了。我骄傲的{dorm3d}……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
