class = var_0_10000

local var_0_0 = "MainActMedalCollectionBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_medal"
end

function var_0_1.GetActivityID(arg_2_0)
	checkExist = var_1_10001

	if not var_1_10001(arg_2_0.config, {
		"time"
	}) then
		return nil
	end

	local var_2_0

	if var_1[1] ~= "default" or not var_1[2] then
		var_2_0 = nil
	end

	return var_2_0
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetActivityID(var_3_0)

	getProxy = var_3_0
	ActivityProxy = var_1_10003

	local var_3_2 = var_3_0(var_1_10003)
	local var_3_3 = var_2.getActivityById(var_3_2, var_3_1)

	Activity = var_3_2

	local var_3_4 = var_3_2.IsActivityReady(var_3_3)

	setActive = var_4

	var_4(arg_3_0.tipTr.gameObject, var_3_4)

	return
end

function var_0_1.CustomOnClick(arg_4_0)
	errorMsg = var_1_10001

	var_1_10001("Set activity_link_button param using View's name")

	return
end

return var_0_1
