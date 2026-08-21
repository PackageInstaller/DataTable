local var_0_0 = class("JiuJiuExpeditionGameMediator", import("...base.ContextMediator"))

var_0_0.OPEN_LAYER = "OPEN_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_LAYER, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(arg_2_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	table.insertto({
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}, var_0_0.super.listNotificationInterests(arg_3_0))

	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.BEGIN_STAGE_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	var_0_0.super.handleNotification(arg_4_0, arg_4_1)

	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED and var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_EXPEDITION then
		arg_4_0.viewComponent:activityUpdate()
	elseif var_4_0 == GAME.BEGIN_STAGE_DONE then
		arg_4_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

return var_0_0
