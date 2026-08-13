local var_0_0 = {
	dialogbox = 2,
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	hideRecord = true,
	mode = 2,
	id = "DORM3TIMELINE11005",
	placeholder = {
		"dorm3d"
	}
}
local var_0_1 = {}
local var_0_2 = {
	stopbgm = true,
	bgm = "Story-room-newjersey"
}
local var_0_3 = {
	nextOne = true
}

STORY_EVENT = var_0_10004
var_0_3.name = var_0_10004.TEST
var_0_3.data = {
	op_list = {
		{
			sceneRoot = "Xinzexi_DB/Newjerseyhostel",
			name = "FFliwu_10517_02",
			scene = "map_newjerseyhostel_01",
			type = "timeline",
			skip = false,
			options = {
				{
					{
						content = "不错，真的是一款很有趣的游戏……策略性很强"
					}
				},
				{
					{
						content = "好啊，我可是更了解你的战术了，要当心了"
					}
				},
				{
					{
						content = "似乎是不公平的对战"
					}
				},
				{
					{
						content = "或许能争取一个平局"
					}
				}
			},
			touchs = {
				{
					{
						pos = {
							0,
							0
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
