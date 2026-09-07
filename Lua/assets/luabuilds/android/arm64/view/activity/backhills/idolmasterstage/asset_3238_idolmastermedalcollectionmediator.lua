local IdolMasterMedalCollectionMediator = class("IdolMasterMedalCollectionMediator", import("view.base.ContextMediator"))

function IdolMasterMedalCollectionMediator:register()
	self:BindEvent()

	return
end

function IdolMasterMedalCollectionMediator:BindEvent()
	return
end

function IdolMasterMedalCollectionMediator:listNotificationInterests()
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function IdolMasterMedalCollectionMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		self.viewComponent:updateAfterSubmit(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		-- block empty
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

return IdolMasterMedalCollectionMediator
