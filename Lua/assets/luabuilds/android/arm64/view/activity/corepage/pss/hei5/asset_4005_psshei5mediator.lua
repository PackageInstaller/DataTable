local PSSHei5Mediator = class("PSSHei5Mediator", import("view.base.ContextMediator"))

PSSHei5Mediator.EVENT_GET_AWARD_ALL = "PSSHei5Mediator.EVENT_GET_AWARD_ALL"
PSSHei5Mediator.EVENT_OPEN_BIRTHDAY = "PSSHei5Mediator.EVENT_OPEN_BIRTHDAY"
PSSHei5Mediator.ON_TASK_GO = "PSSHei5Mediator.ON_TASK_GO"
PSSHei5Mediator.ON_TASK_SUBMIT = "PSSHei5Mediator.ON_TASK_SUBMIT"
PSSHei5Mediator.ON_TASK_QUICK_SUBMIT = "PSSHei5Mediator.ON_TASK_QUICK_SUBMIT"

function PSSHei5Mediator:register()
	self:bind(PSSHei5Mediator.EVENT_GET_AWARD_ALL, function(arg_2_0)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 1,
			activity_id = self.viewComponent.activity.id
		})

		return
	end)
	self:bind(PSSHei5Mediator.EVENT_OPEN_BIRTHDAY, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self:bind(PSSHei5Mediator.ON_TASK_GO, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)
	self:bind(PSSHei5Mediator.ON_TASK_SUBMIT, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_5_1.id)

		return
	end)
	self:bind(PSSHei5Mediator.ON_TASK_QUICK_SUBMIT, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.QUICK_TASK, arg_6_1.id)

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)))

	return
end

function PSSHei5Mediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.CRUSING_CMD_DONE,
		GAME.CHARGE_SUCCESS,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function PSSHei5Mediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_8_1.id == self.viewComponent.activity.id then
			self.viewComponent:setActivity(var_8_1)
			self.viewComponent:UpdatePhase()
			self.viewComponent:UpdateAwardPage()
			self.viewComponent:UpdateTaskPage()
			self.viewComponent:UpdateView()
		end
	elseif var_8_0 == GAME.CRUSING_CMD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		self.viewComponent:UpdateAwardPage()
		self.viewComponent:UpdateView()
	elseif var_8_0 == GAME.CHARGE_SUCCESS then
		self.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_8_1.shopId
		}, Goods.TYPE_CHARGE)))
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE or var_8_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateTaskPage()
		self.viewComponent:UpdateView()
	end

	return
end

return PSSHei5Mediator
