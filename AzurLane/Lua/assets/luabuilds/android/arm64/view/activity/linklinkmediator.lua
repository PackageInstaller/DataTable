local var_0_0 = class("LinkLinkMediator", import("..base.ContextMediator"))

var_0_0.EVENT_OPERATION = "event operation"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	arg_1_0:SetActivityData()
	arg_1_0:SetPlayerData()

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:SetPlayer(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	elseif var_4_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		local var_4_2 = getProxy(ActivityProxy):getActivityById(var_4_1)

		if var_4_2:getConfig("type") == ActivityConst.ACTIVITY_TYPE_LINK_LINK then
			arg_4_0.viewComponent:DisplayResult(var_4_2)
		end
	end

	return
end

function var_0_0.SetPlayerData(arg_5_0)
	arg_5_0.viewComponent:SetPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function var_0_0.SetActivityData(arg_6_0)
	arg_6_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINK_LINK)))

	return
end

return var_0_0
