class = var_0_10000

local var_0_0 = "MainActLayerBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_layer"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetActivityID(var_2_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_2 = var_1_10002(var_1_10004)
	local var_2_3 = var_2.getActivityById(var_2_2, var_2_1)

	Activity = var_2_0

	local var_2_4 = var_2_0.IsActivityReady(var_2_3)

	setActive = var_2_2

	var_2_2(arg_2_0.tipTr.gameObject, var_2_4)

	return
end

function var_0_1.GetActivityID(arg_3_0)
	checkExist = var_1_10001

	if not var_1_10001(arg_3_0.config, {
		"time"
	}) then
		return nil
	end

	local var_3_0

	if var_1[1] ~= "default" or not var_1[2] then
		var_3_0 = nil
	end

	return var_3_0
end

return var_0_1
