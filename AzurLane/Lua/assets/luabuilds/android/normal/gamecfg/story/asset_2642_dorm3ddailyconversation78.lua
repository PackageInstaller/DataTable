local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION78",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		say = "（虽然最近天气渐渐热起来了，但总觉得天狼星这里格外热啊……）",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		},
		options = {
			{
				content = "天狼星怕热吗？",
				flag = 1
			},
			{
				content = "天狼星不觉得热吗？",
				flag = 2
			}
		}
	}
}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "欸？是{dorm3d}您比较怕热吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			param = "Play",
			name = "surprise1",
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

local var_0_5 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "抱歉！是天狼星的疏忽……还请您原谅我的冒失。",
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
			name = "jinzhang",
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
var_0_1[3] = var_0_5
var_0_1[4] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "不过，天狼星之前从其他人那里听来了一个降温的技巧。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "说来听听",
			flag = 1
		}
	}
}

local var_0_8 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "就是——如果觉得热的话，就立刻去洗热水澡。",
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
var_0_1[5] = var_0_8
var_0_1[6] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "洗完的瞬间就会觉得十分凉爽哦！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[7] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "那么，就由天狼星来伺候{dorm3d}沐浴吧。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_11 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "还请您不要乱动，天狼星要来为您脱下身上的制服了哦~",
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
var_0_1[8] = var_0_11
var_0_0.scripts = var_0_1

return var_0_0
