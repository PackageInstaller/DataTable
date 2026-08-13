local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION3014",
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
		say = "今天{dorm3d}，工作，辛苦，很累……安克雷奇，要帮{dorm3d}！",
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
	say = "安克雷奇，帮{dorm3d}分担……{dorm3d}，多休息！",
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
			name = "ab_shuohua_qiaoqiaohua_01",
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
	say = "不过，太难的，不行……简单的，可以！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	actorName = 19903,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "嗯，总之，先把那个……邮件？仓库？全部……清空！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[5] = {
	actor = 0,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "等一下！！！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
