class = var_0_10000

local var_0_0 = "MainActAprilFoolBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_aprilFool"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0:IsShowTip()

	setActive = var_1_10002

	var_1_10002(arg_2_0.tipTr.gameObject, var_2_0)

	return
end

function var_0_1.GetActivityID(arg_3_0)
	return arg_3_0:GetLinkConfig().time[2]
end

function var_0_1.IsShowTip(arg_4_0)
	if arg_4_0:GetActivityID() then
		::label_4_0::

		getProxy = var_1_10002
		ActivityProxy = var_1_10004

		local var_4_0 = var_1_10002(var_1_10004)

		var_1_10002 = var_1_10002.getActivityById(var_4_0, var_1)
	end

	return var_1_10002 and var_1_10002:readyToAchieve()
end

function var_0_1.CustomOnClick(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02
	local var_5_1 = var_1.sendNotification

	GAME = var_1_10004

	local var_5_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_5_1(var_5_0, var_5_2, var_1_10005.ACTIVITY, {
		id = arg_5_0:GetActivityID()
	})

	return
end

return var_0_1
