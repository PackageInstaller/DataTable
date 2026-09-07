local NewCommanderMediator = class("NewCommanderMediator", import("..base.ContextMediator"))

NewCommanderMediator.ON_LOCK = "NewCommanderMediator:ON_LOCK"

function NewCommanderMediator:register()
	self:bind(NewCommanderMediator.ON_LOCK, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.COMMANDER_LOCK, {
			commanderId = arg_2_1,
			flag = arg_2_2
		})

		return
	end)
	assert(self.contextData.commander, "commander can not be nil")

	return
end

function NewCommanderMediator:listNotificationInterests()
	return {
		GAME.COMMANDER_LOCK_DONE
	}
end

function NewCommanderMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.COMMANDER_LOCK_DONE then
		self.viewComponent:updateLockState()
	end

	return
end

return NewCommanderMediator
