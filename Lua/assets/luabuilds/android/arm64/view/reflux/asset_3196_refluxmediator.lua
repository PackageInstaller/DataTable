local RefluxMediator = class("RefluxMediator", import("..base.ContextMediator"))

RefluxMediator.OnTaskSubmit = "RefluxMediator.OnTaskSubmit"
RefluxMediator.OnTaskGo = "RefluxMediator.OnTaskGo"
RefluxMediator.OPEN_CHARGE_ITEM_PANEL = "RefluxMediator:OPEN_CHARGE_ITEM_PANEL"
RefluxMediator.OPEN_CHARGE_ITEM_BOX = "RefluxMediator:OPEN_CHARGE_ITEM_BOX"
RefluxMediator.OPEN_CHARGE_BIRTHDAY = "RefluxMediator:OPEN_CHARGE_BIRTHDAY"

function RefluxMediator:register()
	self:bind(RefluxMediator.OnTaskSubmit, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	self:bind(RefluxMediator.OnTaskGo, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	self:bind(RefluxMediator.OPEN_CHARGE_ITEM_PANEL, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_4_1
			}
		}))

		return
	end)
	self:bind(RefluxMediator.OPEN_CHARGE_ITEM_BOX, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_5_1
			}
		}))

		return
	end)
	self:bind(RefluxMediator.OPEN_CHARGE_BIRTHDAY, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)

	return
end

function RefluxMediator:listNotificationInterests()
	return {
		GAME.REFLUX_SIGN_DONE,
		GAME.SUBMIT_TASK_DONE,
		GAME.REFLUX_GET_PT_AWARD_DONE,
		TaskProxy.TASK_UPDATED,
		TaskProxy.TASK_REMOVED,
		TaskProxy.TASK_DELETE,
		GAME.SHOPPING_DONE,
		GAME.CHARGE_CONFIRM_FAILED,
		GAME.CHARGED_LIST_UPDATED,
		GAME.ZERO_HOUR_OP_DONE
	}
end

function RefluxMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.REFLUX_SIGN_DONE then
		if self:isCanUpdateView(self.viewComponent.signView) then
			self.viewComponent.signView:updateUI()
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end

		self.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
		if self:isCanUpdateView(self.viewComponent.taskView) and #var_8_1 > 0 then
			table.insert(var_8_1, (self.viewComponent.taskView:calcLastSubmitTaskPT()))
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		end

		if self:isCanUpdateView(self.viewComponent.ptView) then
			self.viewComponent.ptView:updateUI()
		end

		self.viewComponent:updateRedPotList()
	elseif var_8_0 == TaskProxy.TASK_UPDATED or var_8_0 == TaskProxy.TASK_REMOVED or var_8_0 == TaskProxy.TASK_DELETE then
		if self:isCanUpdateView(self.viewComponent.taskView) then
			self.viewComponent.taskView:updateUI()
		end

		self.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.REFLUX_GET_PT_AWARD_DONE then
		if self:isCanUpdateView(self.viewComponent.ptView) then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
			self.viewComponent.ptView:updateAfterServer()
		end

		self.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.SHOPPING_DONE then
		if self:isCanUpdateView(self.viewComponent.shopView) then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
			self.viewComponent.shopView:updateUI()
		end
	elseif var_8_0 == GAME.CHARGE_CONFIRM_FAILED then
		-- block empty
	elseif var_8_0 == GAME.CHARGED_LIST_UPDATED then
		if self:isCanUpdateView(self.viewComponent.shopView) then
			self.viewComponent.shopView:updateUI()
		end
	elseif var_8_0 == GAME.ZERO_HOUR_OP_DONE then
		self.viewComponent:closeView()
	end

	return
end

function RefluxMediator:isCanUpdateView(arg_9_1)
	if arg_9_1 and arg_9_1:GetLoaded() then
		return true
	else
		return false
	end

	return
end

return RefluxMediator
