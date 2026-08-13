local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH3089",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 19903,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_Anchorage_other/drom3d_Anchorage_ik_gift6_tone2",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "抱抱……{dorm3d}……！",
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
			name = "ab_TD_bed_idle03_fb02",
			time = 0,
			type = "action",
			skip = true
		},
		{
			id = 2020,
			name = "ab_TD_bed_idle03_fb02_1chuang",
			type = "item_action"
		},
		{
			id = 2021,
			name = "ab_TD_bed_idle03_fb02_2xiong",
			type = "item_action"
		},
		{
			id = 2022,
			name = "ab_TD_bed_idle03_fb02_3caiqiu",
			type = "item_action"
		},
		{
			skip = true,
			name = "Face_kaixin",
			type = "action"
		},
		{
			skip = false,
			time = 3,
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
var_0_0.scripts = var_0_1

return var_0_0
