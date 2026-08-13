local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION82",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		nameColor = "#FFFFFF",
		actorName = "指挥官",
		say = "该说天狼星总是干劲满满吗……印象中从没见过你有疲惫的时候啊。",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "欸？",
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
var_0_1[2] = var_0_2
var_0_1[3] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "关于这点，之前是为了要适应战斗的节奏，天狼星可以利用碎片时间完成休息。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "这个习惯也一直保留了下来，所以现在在{dorm3d}面前也不会流露出疲态。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	nameColor = "#FFFFFF",
	actorName = "指挥官",
	say = "那岂不是丧失了赖床这种非常重要的乐趣吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "啊，原来如此，天狼星明白了。",
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
			name = "rentong",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 1,
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
		content = "？？？",
		flag = 1
	},
	{
		content = "天狼星明白的内容是指？",
		flag = 2
	}
}
var_0_1[6] = var_0_5

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "{dorm3d}认为赖床是非常重要的乐趣，那么，您应该有会赖床的时候。",
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
			name = "sikao2",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = false,
			time = 2,
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
var_0_1[7] = var_0_8
var_0_1[8] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "为了让天狼星也体会到这种乐趣……{dorm3d}今天应该就会留在这里，教会我这种体验。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星现在就去准备床铺，以便让您有足够舒适的赖床体验，我……骄傲的{dorm3d}。",
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
			time = 2,
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
var_0_0.scripts = var_0_1

return var_0_0
