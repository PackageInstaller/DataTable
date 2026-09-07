local MallAwardMediator = class("MallAwardMediator", import("view.base.ContextMediator"))

MallAwardMediator.INPUT_GOLD = "MallAwardMediator.INPUT_GOLD"
MallAwardMediator.GET_PT_AWARD = "MallAwardMediator.GET_PT_AWARD"
MallAwardMediator.SUBMIT_TASK = "MallAwardMediator.SUBMIT_TASK"
MallAwardMediator.TASK_GO = "MallAwardMediator.TASK_GO"

function MallAwardMediator:register()
	self:bind(MallAwardMediator.INPUT_GOLD, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_2_1,
			cmd = ActivityMallOPCommand.CMD.INPUT_GOLD,
			arg1 = arg_2_2
		})

		return
	end)
	self:bind(MallAwardMediator.GET_PT_AWARD, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACT_NEW_PT, arg_3_1)

		return
	end)
	self:bind(MallAwardMediator.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	self:bind(MallAwardMediator.TASK_GO, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)

	return
end

function MallAwardMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACT_NEW_PT_DONE,
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function MallAwardMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.ACT_NEW_PT_DONE then
		if self:IsAwardHandledByParent() then
			self.viewComponent:UpdateView()
		else
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
				self.viewComponent:UpdateView()

				return
			end)
		end
	elseif var_7_0 == GAME.ACTIVITY_MALL_OP_DONE then
		if var_7_1.cmd == ActivityMallOPCommand.CMD.INPUT_GOLD then
			self.viewComponent:UpdateView()
		end
	elseif var_7_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		if self:IsAwardHandledByParent() then
			self.viewComponent:UpdateView()
		else
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
				self.viewComponent:UpdateView()

				return
			end)
		end
	end

	return
end

function MallAwardMediator:IsAwardHandledByParent()
	return self.contextData and self.contextData.awardHandledByParent
end

function MallAwardMediator:remove()
	return
end

return MallAwardMediator
