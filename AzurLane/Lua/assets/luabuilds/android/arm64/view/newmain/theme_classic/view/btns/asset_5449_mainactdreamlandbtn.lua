class = var_0_10000

local var_0_0 = "MainActDreamlandBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.InShowTime(arg_1_0)
	local var_1_0 = var_0_1.super.InShowTime(arg_1_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_1_1 = var_1_10002(var_1_10004)
	local var_1_2 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_1_3 = var_1_2(var_1_1, var_1_10005.ACTIVITY_TYPE_HOTSPRING_2)

	return var_1_0 and var_1_3 and not var_1_3:isEnd()
end

function var_0_1.GetEventName(arg_2_0)
	return "event_dreamland"
end

function var_0_1.OnInit(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_3_2 = var_3_1(var_3_0, var_1_10004.ACTIVITY_TYPE_DREAMLAND)

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_3_3 = var_1_10002(var_4)
	local var_3_4 = var_2.getActivityByType

	ActivityConst = var_1_10005

	local var_3_5 = var_3_4(var_3_3, var_1_10005.ACTIVITY_TYPE_HOTSPRING_2)

	DreamlandData = var_3_0

	local var_3_6 = var_3_0.New(var_3_2, var_3_5)
	local var_3_7 = var_3.ExistAnyMapOrExploreAward(var_3_6)

	setActive = var_5

	var_5(arg_3_0.tipTr.gameObject, var_3_7)

	return
end

return var_0_1
