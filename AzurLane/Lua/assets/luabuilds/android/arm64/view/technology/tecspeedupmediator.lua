local var_0_0 = class("TecSpeedUpMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.USE_TEC_SPEEDUP_ITEM_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.USE_TEC_SPEEDUP_ITEM_DONE then
		arg_3_0.viewComponent:closeView()
	end

	return
end

return var_0_0
