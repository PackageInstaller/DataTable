local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION92",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}，您是怎么看待“下雨天”的呢？",
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_2.options = {
	{
		content = "没什么感觉",
		flag = 1
	},
	{
		content = "不太喜欢",
		flag = 2
	},
	{
		content = "我很喜欢",
		flag = 3
	}
}
var_0_1[1] = var_0_2
var_0_1[2] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 1,
	say = "也是呢，毕竟只是普通的天气变化。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 2,
	say = "就算战斗方面不会造成影响，也会对生活上造成影响，对吧。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	optionFlag = 3,
	say = "是因为下雨天会让人很放松吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不过……皇家的雾都倒是常年处于阴雨之中，经常被雾气包围，能有阳光就算是特别幸运的事了。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[6] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "像那样阴郁的氛围一直持续下去，久而久之就会影响到身心呢。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "相比之下{dorm3d}您这里就要好的多了",
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
			name = "toukan",
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

local var_0_7 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[7] = var_0_5
var_0_1[8] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不光是说天气……您就像驱散阴霾的阳光一样，能够侍奉您，是一件再幸运不过的事。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
