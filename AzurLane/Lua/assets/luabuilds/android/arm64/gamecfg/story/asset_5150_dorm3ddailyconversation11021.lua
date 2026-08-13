local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION11021",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 10517,
	side = 2,
	hidePaintObj = true,
	dir = 1,
	nameColor = "#FFFFFF",
	say = "呼~累了累了~！",
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
			name = "sad_01-start",
			time = 0,
			type = "action",
			skip = true
		},
		{
			skip = true,
			name = "face_think_start",
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
var_0_1[1] = var_0_2
var_0_1[2] = {
	actorName = 10517,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "honey，是时候差不多给我一些奖励了吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[3] = {
	actorName = 10517,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "不如……我们去港区外面约会吧？",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_1[4] = {
	actorName = 10517,
	side = 2,
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	dir = 1,
	say = "嘿嘿……我早就物色好地点了，你一定会喜欢的，Honey！",
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
var_0_0.scripts = var_0_1

return var_0_0
