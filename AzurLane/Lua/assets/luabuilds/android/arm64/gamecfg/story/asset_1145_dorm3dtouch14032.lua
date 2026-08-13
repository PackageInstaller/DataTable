local var_0_0 = {
	fadeOut = 1.5,
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTOUCH14032",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	actorName = 49905,
	side = 2,
	dir = 1,
	voice = "event:/dorm/drom3d_aegir_ik_furniture1_tone7/drom3d_aegir_ik_furniture1_tone7",
	nameColor = "#FFFFFF",
	hidePaintObj = true,
	say = "总在边缘游走……通常都没什么好下场哦？",
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
			name = "IK_living02_idle01_fb01",
			time = 0,
			type = "action",
			skip = true
		},
		{
			id = 2024,
			name = "IK_living02_idle01_fb01_SF",
			type = "item_action"
		},
		{
			id = 2025,
			name = "IK_living02_idle01_SF_2_fb01",
			type = "item_action"
		},
		{
			id = 2026,
			name = "IK_living02_idle01_SF_3_fb01",
			type = "item_action"
		},
		{
			param = "IK_living02_idle01_fb01_shu",
			name = "furniture/Item/Book_01/pre_db_book_01_IK600610",
			time = 0,
			type = "extra_item_action",
			skip = true
		},
		{
			skip = true,
			name = "Face_shame_start",
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
var_0_0.scripts = var_0_1

return var_0_0
