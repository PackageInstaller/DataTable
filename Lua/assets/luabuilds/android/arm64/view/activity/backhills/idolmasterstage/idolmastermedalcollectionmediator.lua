local var_0_0 = class("IdolMasterMedalCollectionMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		arg_4_0.viewComponent:updateAfterSubmit(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		-- block empty
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

return var_0_0
