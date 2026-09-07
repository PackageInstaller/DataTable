local RivalInfoMediator = class("RivalInfoMediator", import("..base.ContextMediator"))

RivalInfoMediator.START_BATTLE = "RivalInfoMediator:START_BATTLE"

function RivalInfoMediator:register()
	assert(self.contextData.rival, "rival should exist")
	assert(self.contextData.type, "type should exist")
	self.viewComponent:setRival(self.contextData.rival)
	self:bind(RivalInfoMediator.START_BATTLE, function(arg_2_0)
		self:sendNotification(GAME.MILITARY_STARTED, {
			rivalId = self.contextData.rival.id,
			system = (self.contextData.type == RivalInfoLayer.TYPE_BATTLE or nil) and SYSTEM_DUEL
		})
		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)

	return
end

function RivalInfoMediator:listNotificationInterests()
	return {}
end

function RivalInfoMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return RivalInfoMediator
