local var_0_0 = class("RefluxMediator", import("..base.ContextMediator"))

var_0_0.OnTaskSubmit = "RefluxMediator.OnTaskSubmit"
var_0_0.OnTaskGo = "RefluxMediator.OnTaskGo"
var_0_0.OPEN_CHARGE_ITEM_PANEL = "RefluxMediator:OPEN_CHARGE_ITEM_PANEL"
var_0_0.OPEN_CHARGE_ITEM_BOX = "RefluxMediator:OPEN_CHARGE_ITEM_BOX"
var_0_0.OPEN_CHARGE_BIRTHDAY = "RefluxMediator:OPEN_CHARGE_BIRTHDAY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnTaskSubmit, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.OnTaskGo, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_PANEL, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_4_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_ITEM_BOX, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemBoxMediator,
			viewComponent = ChargeItemBoxLayer,
			data = {
				panelConfig = arg_5_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
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

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.REFLUX_SIGN_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.signView) then
			arg_8_0.viewComponent.signView:updateUI()
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		end

		arg_8_0.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.taskView) and #var_8_1 > 0 then
			table.insert(var_8_1, (arg_8_0.viewComponent.taskView:calcLastSubmitTaskPT()))
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
		end

		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.ptView) then
			arg_8_0.viewComponent.ptView:updateUI()
		end

		arg_8_0.viewComponent:updateRedPotList()
	elseif var_8_0 == TaskProxy.TASK_UPDATED or var_8_0 == TaskProxy.TASK_REMOVED or var_8_0 == TaskProxy.TASK_DELETE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.taskView) then
			arg_8_0.viewComponent.taskView:updateUI()
		end

		arg_8_0.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.REFLUX_GET_PT_AWARD_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.ptView) then
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
			arg_8_0.viewComponent.ptView:updateAfterServer()
		end

		arg_8_0.viewComponent:updateRedPotList()
	elseif var_8_0 == GAME.SHOPPING_DONE then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.shopView) then
			arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
			arg_8_0.viewComponent.shopView:updateUI()
		end
	elseif var_8_0 == GAME.CHARGE_CONFIRM_FAILED then
		-- block empty
	elseif var_8_0 == GAME.CHARGED_LIST_UPDATED then
		if arg_8_0:isCanUpdateView(arg_8_0.viewComponent.shopView) then
			arg_8_0.viewComponent.shopView:updateUI()
		end
	elseif var_8_0 == GAME.ZERO_HOUR_OP_DONE then
		arg_8_0.viewComponent:closeView()
	end

	return
end

function var_0_0.isCanUpdateView(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1:GetLoaded() then
		return true
	else
		return false
	end

	return
end

return var_0_0
