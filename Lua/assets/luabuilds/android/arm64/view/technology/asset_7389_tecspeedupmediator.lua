local TecSpeedUpMediator = class("TecSpeedUpMediator", import("..base.ContextMediator"))

function TecSpeedUpMediator:register()
	return
end

function TecSpeedUpMediator:listNotificationInterests()
	return {
		GAME.USE_TEC_SPEEDUP_ITEM_DONE
	}
end

function TecSpeedUpMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.USE_TEC_SPEEDUP_ITEM_DONE then
		self.viewComponent:closeView()
	end

	return
end

return TecSpeedUpMediator
