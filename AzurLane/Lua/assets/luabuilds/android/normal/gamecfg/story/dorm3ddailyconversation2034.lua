local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION2034",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 30221,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "最近看到水上游乐园似乎新增加了一个无重力漂浮睡眠舱……",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "我记得是新开发的商品？",
			flag = 1
		}
	}
}
local var_0_3 = {}

STORY_EVENT = var_4
var_0_3.name = var_4.TEST
var_0_3.data = {
	op_list = {
		{
			skip = true,
			name = "shuohua_wenhou",
			type = "action"
		},
		{
			skip = true,
			name = "Face_weixiao",
			type = "action"
		},
		{
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
var_0_1[1] = var_0_2

local var_0_5 = {
	actorName = 30221,
	side = 2,
	hidePaintObj = true,
	nameColor = "#FFFFFF",
	say = "嗯。说是可以模拟无重力环境，能让人美美地睡上一觉。",
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
			skip = true,
			name = "shuohua_qidai",
			type = "action"
		},
		{
			skip = true,
			name = "Face_weixiao",
			type = "action"
		},
		{
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
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "铁血的{namecode:461:吕佐夫}小姐是这么说的。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "咳，那个，要去体验无重力环境吗？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	actorName = 30221,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "我确认过睡眠舱的大小，足够我们两个人躺进去了。",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
