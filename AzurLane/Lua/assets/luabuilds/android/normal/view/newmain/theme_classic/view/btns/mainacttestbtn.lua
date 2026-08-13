class = var_0_10000

local var_0_0 = "MainActTestBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))
local var_0_2 = true

function var_0_1.InShowTime(arg_1_0)
	arg_1_0.config = {
		param = "0",
		name = "event_all",
		time = "always",
		text_pic = "text_event_all",
		type = 0,
		pic = "event_all_default",
		id = 9,
		group_id = 1,
		order = 99
	}

	return var_0_2
end

function var_0_1.CustomOnClick(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.m02
	local var_2_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_2_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_2_1(var_2_0, var_2_2, var_1_10004.DREAMLAND)

	return
end

return var_0_1
