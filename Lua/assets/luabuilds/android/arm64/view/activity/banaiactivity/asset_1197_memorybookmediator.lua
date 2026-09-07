local MemoryBookMediator = class("MemoryBookMediator", import("...base.ContextMediator"))

MemoryBookMediator.ON_UNLOCK = "MemoryBookMediator:ON_UNLOCK"
MemoryBookMediator.EVENT_OPERATION = "MemoryBookMediator:EVENT_OPERATION"

function MemoryBookMediator:register()
	self:bind(MemoryBookMediator.ON_UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
			id = arg_2_1,
			actId = arg_2_2
		})

		return
	end)
	self:bind(MemoryBookMediator.EVENT_OPERATION, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))

	return
end

function MemoryBookMediator:listNotificationInterests()
	return {
		GAME.MEMORYBOOK_UNLOCK_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_SHOW_AWARDS
	}
end

function MemoryBookMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.MEMORYBOOK_UNLOCK_DONE then
		self.viewComponent:updateMemorys()
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1.id == self.viewComponent.activity.id then
			self.viewComponent:setActivity(var_5_1)
			self.viewComponent:updateProgress()
		end
	elseif var_5_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS then
		if getProxy(ContextProxy):getCurrentContext().mediator == ActivityMediator then
			return
		end

		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards, var_5_1.callback)
	end

	return
end

return MemoryBookMediator
