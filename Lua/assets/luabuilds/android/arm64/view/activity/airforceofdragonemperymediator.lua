local var_0_0 = class("AirForceOfDragonEmperyMediator", import("view.base.ContextMediator"))

var_0_0.ON_BATTLE = "AirForceOfDragonEmperyMediator ON_BATTLE"
var_0_0.ON_ACTIVITY_OPREATION = "AirForceOfDragonEmperyMediator ON_ACTIVITY_OPREATION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_BATTLE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_AIRFIGHT,
			stageId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_OPREATION, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE)

	var_1_0:RecordTip()
	arg_1_0.viewComponent:SetActivityData(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_AIRFIGHT_BATTLE then
			arg_5_0:getViewComponent():SetActivityData(var_5_1)
			arg_5_0:getViewComponent():UpdateView()
		end
	elseif var_5_0 == GAME.BEGIN_STAGE_DONE then
		arg_5_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, var_5_1.callback)
	end

	return
end

return var_0_0
