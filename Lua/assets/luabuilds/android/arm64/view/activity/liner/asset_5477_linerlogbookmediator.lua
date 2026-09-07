local LinerLogBookMediator = class("LinerLogBookMediator", import("view.base.ContextMediator"))

LinerLogBookMediator.GET_SCHEDULE_AWARD = "LinerLogBookMediator.GET_SCHEDULE_AWARD"
LinerLogBookMediator.GET_ROOM_AWARD = "LinerLogBookMediator.GET_ROOM_AWARD"
LinerLogBookMediator.ON_START_REASONING = "LinerLogBookMediator.ON_START_REASONING"
LinerLogBookMediator.GET_EVENT_AWARD = "LinerLogBookMediator.GET_EVENT_AWARD"
LinerLogBookMediator.ON_CLOSE = "LinerLogBookMediator.ON_CLOSE"

function LinerLogBookMediator:register()
	self:bind(LinerLogBookMediator.GET_SCHEDULE_AWARD, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 2,
			activity_id = arg_2_1,
			arg1 = arg_2_2,
			drop = arg_2_3
		})

		return
	end)
	self:bind(LinerLogBookMediator.GET_ROOM_AWARD, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 3,
			activity_id = arg_3_1,
			arg1 = arg_3_2,
			drop = arg_3_3
		})

		return
	end)
	self:bind(LinerLogBookMediator.ON_START_REASONING, function(arg_4_0, arg_4_1, arg_4_2)
		self.viewComponent:OnStartReasoning(arg_4_1, arg_4_2)

		return
	end)
	self:bind(LinerLogBookMediator.GET_EVENT_AWARD, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		self:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 4,
			activity_id = arg_5_1,
			arg1 = arg_5_2,
			arg2 = arg_5_3,
			drop = arg_5_4
		})

		return
	end)
	self:bind(LinerLogBookMediator.ON_CLOSE, function()
		self.viewComponent:onBackPressed()

		return
	end)

	return
end

function LinerLogBookMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_LINER_OP_DONE
	}
end

function LinerLogBookMediator:handleNotification(arg_8_1)
	if arg_8_1:getName() == GAME.ACTIVITY_LINER_OP_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_8_1:getBody().awards)
		self.viewComponent:UpdateView()
	end

	return
end

return LinerLogBookMediator
