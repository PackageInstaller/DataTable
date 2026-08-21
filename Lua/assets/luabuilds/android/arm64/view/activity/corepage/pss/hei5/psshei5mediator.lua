local var_0_0 = class("PSSHei5Mediator", import("view.base.ContextMediator"))

var_0_0.EVENT_GET_AWARD_ALL = "PSSHei5Mediator.EVENT_GET_AWARD_ALL"
var_0_0.EVENT_OPEN_BIRTHDAY = "PSSHei5Mediator.EVENT_OPEN_BIRTHDAY"
var_0_0.ON_TASK_GO = "PSSHei5Mediator.ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "PSSHei5Mediator.ON_TASK_SUBMIT"
var_0_0.ON_TASK_QUICK_SUBMIT = "PSSHei5Mediator.ON_TASK_QUICK_SUBMIT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD_ALL, function(arg_2_0)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 1,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_OPEN_BIRTHDAY, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_5_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_QUICK_SUBMIT, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.QUICK_TASK, arg_6_1.id)

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)))

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.CRUSING_CMD_DONE,
		GAME.CHARGE_SUCCESS,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_8_1.id == arg_8_0.viewComponent.activity.id then
			arg_8_0.viewComponent:setActivity(var_8_1)
			arg_8_0.viewComponent:UpdatePhase()
			arg_8_0.viewComponent:UpdateAwardPage()
			arg_8_0.viewComponent:UpdateTaskPage()
			arg_8_0.viewComponent:UpdateView()
		end
	elseif var_8_0 == GAME.CRUSING_CMD_DONE then
		arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1.awards)
		arg_8_0.viewComponent:UpdateAwardPage()
		arg_8_0.viewComponent:UpdateView()
	elseif var_8_0 == GAME.CHARGE_SUCCESS then
		arg_8_0.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_8_1.shopId
		}, Goods.TYPE_CHARGE)))
	elseif var_8_0 == GAME.SUBMIT_TASK_DONE or var_8_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_8_0.viewComponent:UpdateTaskPage()
		arg_8_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
