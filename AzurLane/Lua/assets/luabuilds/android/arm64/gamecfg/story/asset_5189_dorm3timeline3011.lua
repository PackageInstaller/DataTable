local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3TIMELINE3011",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	stopbgm = true,
	bgm = "Story-room-anchorage"
}
local var_0_3 = {
	nextOne = true
}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			sceneRoot = "Ankeleiqi_DB/Anchoragehostel",
			name = "FFliwu_paint",
			scene = "map_anchoragehostel_01",
			type = "timeline",
			skip = false,
			options = {
				{
					{
						content = "想好要画什么了？"
					}
				},
				{
					{
						content = "没关系，我来收拾"
					},
					{
						content = "安克雷奇不用担心"
					}
				}
			},
			touchs = {
				{
					{
						pos = {
							0,
							50
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
