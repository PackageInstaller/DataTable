class = var_0_10000

local var_0_0 = "MainActFeastBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.InShowTime(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_2 = var_1_1(var_1_0, var_1_10003.ACTIVITY_TYPE_FEAST)

	arg_1_0.config = {
		param = "0",
		name = "event_minigame",
		text_pic = "text_event_minigame",
		type = 0,
		pic = "event_minigame",
		id = 20,
		group_id = 5,
		order = 1,
		time = {
			"default"
		}
	}

	return var_1_2 and not var_1_2:isEnd()
end

function var_0_1.CustomOnClick(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.emit

	NewMainMediator = var_1_10003

	local var_2_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_2_1(var_2_0, var_2_2, var_1_10004.FEAST)

	return
end

return var_0_1
