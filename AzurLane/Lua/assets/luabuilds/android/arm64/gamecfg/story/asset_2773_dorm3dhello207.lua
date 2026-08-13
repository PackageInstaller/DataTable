local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DHELLO207",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello7",
	actorName = 30221,
	hidePaintObj = true,
	side = 2,
	nameColor = "#FFFFFF",
	say = "刚刚你不在的时候，我稍微整理了一下房间，怎么样，是不是感觉整洁有序了很多？呵呵……没错，我就是想让{dorm3d}夸我一下呢。",
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
			name = "shuohua_chayao",
			type = "action"
		},
		{
			skip = true,
			name = "Face_kaixing",
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
var_0_0.scripts = var_0_1

return var_0_0
