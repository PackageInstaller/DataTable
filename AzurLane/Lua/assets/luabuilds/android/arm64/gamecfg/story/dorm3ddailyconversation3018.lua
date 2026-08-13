local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3018",
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
		say = "童话故事，安克雷奇，喜欢！最喜欢，公主的故事！",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	},
	{
		actorName = 19903,
		side = 2,
		nameColor = "#FFFFFF",
		hidePaintObj = true,
		dir = 1,
		say = "七个好朋友，头发长！长着鱼尾巴，被王子……吻……嘿嘿……",
		typewriter = {
			speed = 0.05,
			speedUp = 0.01
		}
	}
}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	dir = 1,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "然后，寻找丢掉的，7颗星星圆球！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "后面好像混进了奇怪的故事……",
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
			param = "Play",
			name = "ab_shuohua_jidong_01",
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

local var_0_4 = {
	hideUI = false
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[3] = var_0_2
var_0_1[4] = {
	actorName = 19903,
	side = 2,
	dir = 1,
	optionFlag = 1,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "欸……？安克雷奇……不明白！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	},
	options = {
		{
			content = "安克雷奇也想成为公主吗？",
			flag = 1
		}
	}
}
var_0_1[5] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "安克雷奇，想成为……公主！不过，安克雷奇，更喜欢{dorm3d}！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[6] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "安克雷奇……要找到7颗星星圆球，把{dorm3d}变成……童话王子！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
