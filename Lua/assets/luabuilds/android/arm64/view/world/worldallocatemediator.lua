local var_0_0 = class("WorldAllocateMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setItem(arg_1_0.contextData.itemVO)
	arg_1_0.viewComponent:setFleets(arg_1_0.contextData.fleetList)
	arg_1_0.viewComponent:setConfirmCallback(arg_1_0.contextData.confirmCallback)

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.WORLD_ITEM_USE_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	if arg_3_1:getName() == GAME.WORLD_ITEM_USE_DONE then
		arg_3_0.viewComponent:flush(arg_3_1:getBody().item)
	end

	return
end

return var_0_0
