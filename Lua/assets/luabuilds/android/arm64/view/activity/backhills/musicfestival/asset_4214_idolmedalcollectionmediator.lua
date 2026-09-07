local IdolMedalCollectionMediator = class("IdolMedalCollectionMediator", import("view.base.ContextMediator"))

function IdolMedalCollectionMediator:register()
	self:BindEvent()

	return
end

function IdolMedalCollectionMediator:BindEvent()
	return
end

function IdolMedalCollectionMediator:listNotificationInterests()
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function IdolMedalCollectionMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		self.viewComponent:updateAfterSubmit(var_4_1)
	elseif var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			self.viewComponent:UpdateActivity()
		end
	elseif var_4_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		local var_4_2 = getProxy(ContextProxy):getContextByMediator(ActivityMediator)

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards, var_4_1.callback)
	end

	return
end

return IdolMedalCollectionMediator
