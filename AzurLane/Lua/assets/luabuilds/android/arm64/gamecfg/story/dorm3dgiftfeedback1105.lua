local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DGIFTFEEDBACK1105",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_Newjersey_other/drom3d_NewJersey_gift2_voice1",
	actorName = 10517,
	nameColor = "#FFFFFF",
	say = "双人游戏手柄！Honey是在邀请我一起玩吗？",
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
			name = "encourage_01-start",
			type = "action"
		},
		{
			skip = true,
			name = "face_happy_start",
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

local var_0_5 = {
	voice = "event:/dorm/drom3d_Newjersey_other/drom3d_NewJersey_gift2_voice2",
	actorName = 10517,
	nameColor = "#FFFFFF",
	say = "正好我最近练习了很多新招式~嘿嘿~要试试看吗？",
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
			name = "excited_01-start",
			type = "action"
		},
		{
			skip = true,
			name = "face_happy_start",
			type = "action"
		},
		{
			skip = false,
			time = 2,
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
var_0_0.scripts = var_0_1

return var_0_0
