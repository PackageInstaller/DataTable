local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION89",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		nameColor = "#FFFFFF",
		actorName = "指挥官",
		say = "你会不会觉得现在的房间布置太单调了？",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "并不会哦，我的{dorm3d}。",
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[2] = var_0_2
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不过，天狼星之前提过，希望让{dorm3d}把路上看到的花送给我。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "要不要干脆借这个机会，尝试一下插花呢？这样{dorm3d}也不会觉得房间布置单调了。",
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
var_0_5.options = {
	{
		content = "天狼星会插花？",
		flag = 1
	},
	{
		content = "女仆还要学插花吗？",
		flag = 2
	}
}
var_0_1[4] = var_0_5
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 1,
	say = "嗯……不算会，只是勉强了解一点点。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[6] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 2,
	say = "为{dorm3d}提供舒适和赏心悦目的居家环境，是女仆的分内之事。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "虽然是天狼星提出的插花，但我其实并不擅长呢……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不过提出这种自己并不擅长的事，也是因为天狼星实在太想和{dorm3d}一起做了……！",
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
			name = "ganjin",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 3,
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
var_0_1[8] = var_0_8

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "果然……还请您惩罚天狼星这个厚脸皮的女仆吧，我的{dorm3d}。",
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

local var_0_13 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_13.name = var_5.TEST_DONE
var_0_12.callbackData = var_0_13
var_0_11.dispatcher = var_0_12
var_0_1[9] = var_0_11
var_0_1[10] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星已经做好了接受惩罚的准备……！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
