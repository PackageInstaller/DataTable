local MonthCardSetMediator = class("MonthCardSetMediator", import("..base.ContextMediator"))

function MonthCardSetMediator:register()
	return
end

function MonthCardSetMediator:listNotificationInterests()
	return {
		GAME.MONOPOLY_AWARD_DONE
	}
end

function MonthCardSetMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.MONOPOLY_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_3_0.awards, var_3_0.callback)
	end

	return
end

return MonthCardSetMediator
