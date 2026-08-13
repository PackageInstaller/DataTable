local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3TIMELINE01",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	typewriter = {
		speed = 0.05,
		speedUp = 0.01
	}
}
local var_0_3 = {
	nextOne = true
}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			skip = false,
			name = "Qihe_Jinmenjieshao",
			time = 21.7,
			type = "timeline",
			options = {
				[4] = {
					{
						content = "先好好休息一下吧"
					}
				},
				[5] = {
					{
						content = "不是那个意思……"
					},
					{
						content = "你误会了……"
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
				},
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
