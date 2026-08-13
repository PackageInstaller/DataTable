local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION75",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，您为什么一直在看着天狼星？",
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
			name = "toukan",
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
		content = "天狼星有喜欢的音乐吗？",
		flag = 1
	},
	{
		content = "想更了解天狼星的喜好，比如喜欢的音乐之类的",
		flag = 2
	}
}
var_0_1[1] = var_0_2

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星仔细回想了一下，过去似乎没有什么好好聆听音乐的机会……",
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
			name = "sikao1",
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
	say = "所以在音乐这方面，也没有什么可以称得上“喜欢”或是“不喜欢”的内容。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星感到很抱歉，我的{dorm3d}……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "为什么要道歉呢？",
			flag = 1
		}
	}
}
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "因为{dorm3d}想要更了解天狼星的喜好，但天狼星完全没有这方面的认知。所以……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "还没找到喜好也不要紧",
			flag = 1
		},
		{
			content = "我会陪着天狼星慢慢寻找",
			flag = 2
		}
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "其实……！",
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
	say = "天狼星最喜欢的永远是您，我骄傲的{dorm3d}啊。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
