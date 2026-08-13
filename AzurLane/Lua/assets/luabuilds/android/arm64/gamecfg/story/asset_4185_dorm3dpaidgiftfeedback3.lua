local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DPAIDGIFTFEEDBACK3",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	stopbgm = true,
	bgm = "story-room-sirius"
}
local var_0_3 = {
	nextOne = true
}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			sceneRoot = "Tianlangxing_DB/SiriusHostel",
			name = "FFliwu_20220_03",
			scene = "map_siriushostel_01",
			type = "timeline",
			skip = false,
			options = {
				[2] = {
					{
						content = "感觉很不错，毕竟就连天狼星昨晚也很早就睡着了。"
					}
				}
			},
			touchs = {
				{
					{
						pos = {
							-50,
							-250
						}
					}
				}
			}
		}
	}
}

local var_0_4 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_4.name = var_5.TEST_DONE
var_0_3.callbackData = var_0_4
var_0_2.dispatcher = var_0_3
var_0_1[1] = var_0_2
var_0_0.scripts = var_0_1

return var_0_0
