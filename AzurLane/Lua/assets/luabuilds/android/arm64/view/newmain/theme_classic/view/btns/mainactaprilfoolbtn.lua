local var_0_0 = class("MainActAprilFoolBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_aprilFool"
end

function var_0_0.OnInit(arg_2_0)
	setActive(arg_2_0.tipTr.gameObject, (arg_2_0:IsShowTip()))

	return
end

function var_0_0.GetActivityID(arg_3_0)
	return arg_3_0:GetLinkConfig().time[2]
end

function var_0_0.IsShowTip(arg_4_0)
	local var_4_0 = arg_4_0:GetActivityID()
	local var_4_1 = var_4_0 and getProxy(ActivityProxy):getActivityById(var_4_0)

	return var_4_1 and var_4_1:readyToAchieve()
end

function var_0_0.CustomOnClick(arg_5_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
		id = arg_5_0:GetActivityID()
	})

	return
end

return var_0_0
