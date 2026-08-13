local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3023",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actorName = 19903,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		dir = 1,
		say = "点心，安克雷奇，之前不会做……但，安克雷奇偷偷学习了！",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "做给{dorm3d}吃！{dorm3d}，喜欢什么？",
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
			name = "ab_shuohua_deyi_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_weixiao",
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
var_0_1[2] = var_0_2
var_0_1[3] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "马卡龙、蒙布朗……还有，柠檬塔、拿破仑……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "种类好丰盛！",
			flag = 1
		},
		{
			content = "安克雷奇好厉害！",
			flag = 1
		}
	}
}

local var_0_5 = {
	actorName = 19903,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "唔……那些……安克雷奇都不会……！食谱很难……曲奇，安克雷奇，可以！",
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
			name = "ab_shuohua_gandong_01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_kaixin",
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
var_0_1[4] = var_0_5
var_0_1[5] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "硬邦邦，曲奇！{dorm3d}，尝一尝！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
