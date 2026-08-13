local var_0_0 = {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DPAIDGIFTFEEDBACK2",
	alpha = 0,
	hideSkip = true,
	hideAuto = true
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
			name = "FFliwu_cadiban",
			time = 0,
			type = "timeline",
			scene = "map_siriushostel_01",
			skip = false,
			options = {},
			touchs = {
				[0] = {
					{
						pos = {
							0,
							-350
						}
					}
				},
				{
					{
						pos = {
							150,
							-50
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
