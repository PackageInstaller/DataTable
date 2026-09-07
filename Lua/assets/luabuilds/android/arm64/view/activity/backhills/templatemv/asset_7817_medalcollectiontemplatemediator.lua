local MedalCollectionTemplateMediator = class("MedalCollectionTemplateMediator", import("view.base.ContextMediator"))

MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK = "MEMORYBOOK_UNLOCK"
MedalCollectionTemplateMediator.MEMORYBOOK_GO = "MEMORYBOOK_GO"

function MedalCollectionTemplateMediator:register()
	self:BindEvent()
	self.viewComponent:UpdateActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))

	return
end

function MedalCollectionTemplateMediator:BindEvent()
	self:bind(MedalCollectionTemplateMediator.MEMORYBOOK_UNLOCK, function(arg_3_0, ...)
		self:sendNotification(GAME.MEMORYBOOK_UNLOCK, ...)

		return
	end)
	self:bind(MedalCollectionTemplateMediator.MEMORYBOOK_GO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function MedalCollectionTemplateMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function MedalCollectionTemplateMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_ADDED or var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			self.viewComponent:UpdateActivity(var_6_1)
		end
	elseif var_6_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		self.viewComponent:UpdateActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
		self.viewComponent:UpdateAfterSubmit(var_6_1)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		local var_6_2 = getProxy(ActivityProxy):getActivityById(var_6_1)

		if var_6_2:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PUZZLA then
			self.viewComponent:UpdateActivity(var_6_2)
			self.viewComponent:UpdateAfterFinalMedal()
		end
	elseif var_6_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getContextByMediator(ActivityMediator) then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, var_6_1.callback)
	end

	return
end

return MedalCollectionTemplateMediator
