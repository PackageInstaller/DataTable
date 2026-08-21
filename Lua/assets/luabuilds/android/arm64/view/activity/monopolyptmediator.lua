local var_0_0 = class("MonopolyPtMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_ADDED,
		GAME.ACT_NEW_PT_DONE,
		GAME.BEGIN_STAGE_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()
	local var_3_2 = arg_3_1:getType()

	if var_3_0 == ActivityProxy.ACTIVITY_UPDATED or var_3_0 == ActivityProxy.ACTIVITY_ADDED then
		arg_3_0:updateGameUI(var_3_1)
	elseif var_3_0 == GAME.ACT_NEW_PT_DONE then
		arg_3_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_3_1.awards, var_3_1.callback)
	elseif var_3_0 == GAME.BEGIN_STAGE_DONE then
		arg_3_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_3_1)
	end

	return
end

function var_0_0.updateGameUI(arg_4_0, arg_4_1)
	arg_4_0.viewComponent:updataActivity(arg_4_1)

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
