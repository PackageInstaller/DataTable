local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DGIFTAVG12041",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {
	{
		actorName = 30707,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		say = "{dorm3d}~{namecode:97}为您准备了一个小惊喜哦~",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		},
		options = {
			{
				content = "似乎已经从{namecode:97}这里得到了太多惊喜……今天能提前透露一下吗？",
				flag = 1
			}
		}
	}
}
local var_0_2 = {
	actorName = 30707,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "{dorm3d}的要求，{namecode:97}一定会全力满足的~",
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
			name = "excited_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "Face_happy_start",
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
	actorName = 30707,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "现在能说的就是……呵呵~{namecode:97}想要{dorm3d}一直在身边呢~",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "只有……这样？",
			flag = 1
		}
	}
}
var_0_1[4] = {
	actorName = 30707,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "呵呵呵呵~{dorm3d}好像并不满足于此嘛。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}

local var_0_5 = {
	actorName = 30707,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "但如果我说肯定会让{dorm3d}耳目一新的话~您是不是会超级期待呢？",
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
			name = "talk_01-start",
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
var_0_1[5] = var_0_5
var_0_1[6] = {
	actorName = 30707,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "我去准备一下，呵呵，{dorm3d}等下再来看哦~",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
