local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DGIFTFEEDBACK1",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "这是您送给我的茶具……？天狼星真是受宠若惊……我慷慨的主人！",
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
			skip = true,
			name = "ganjin",
			type = "action"
		},
		{
			skip = true,
			name = "Face_gaoxing",
			type = "action"
		},
		{
			skip = false,
			time = 2,
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
var_0_1[2] = {
	nameColor = "#FFFFFF",
	actorName = 20220,
	say = "天狼星一定会好好爱惜它，然后用它冲泡美味的红茶来招待主人！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
