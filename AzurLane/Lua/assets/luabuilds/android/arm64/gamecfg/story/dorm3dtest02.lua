local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3DTEST02",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	say = "对话2",
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
			name = "surprise2",
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
	say = "对话1",
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
			skip = false,
			name = "Tianlangxing02_Zoulangdengdai",
			time = 0,
			type = "timeline",
			touchs = {
				{
					{
						pos = {
							10,
							10
						}
					},
					{
						pos = {
							-100,
							-10
						}
					},
					{
						pos = {
							200,
							-100
						}
					},
					{
						pos = {
							-300,
							200
						}
					}
				}
			},
			options = {
				{
					{
						content = "查看《跛脚巨人》"
					},
					{
						content = "查看《值得警戒》"
					}
				}
			}
		}
	}
}

local var_0_7 = {
	hideUI = true
}

STORY_EVENT = var_5
var_0_7.name = var_5.TEST_DONE
var_0_6.callbackData = var_0_7
var_0_5.dispatcher = var_0_6
var_0_1[2] = var_0_5
var_0_0.scripts = var_0_1

return var_0_0
