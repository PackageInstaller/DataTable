local var_0_0 = class("MallAwardMediator", import("view.base.ContextMediator"))

var_0_0.INPUT_GOLD = "MallAwardMediator.INPUT_GOLD"
var_0_0.GET_PT_AWARD = "MallAwardMediator.GET_PT_AWARD"
var_0_0.SUBMIT_TASK = "MallAwardMediator.SUBMIT_TASK"
var_0_0.TASK_GO = "MallAwardMediator.TASK_GO"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.INPUT_GOLD, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_2_1,
			cmd = ActivityMallOPCommand.CMD.INPUT_GOLD,
			arg1 = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_PT_AWARD, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACT_NEW_PT, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.ACT_NEW_PT_DONE,
		GAME.ACTIVITY_MALL_OP_DONE,
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1:getBody()

	if var_7_0 == GAME.ACT_NEW_PT_DONE then
		if arg_7_0:IsAwardHandledByParent() then
			arg_7_0.viewComponent:UpdateView()
		else
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
				arg_7_0.viewComponent:UpdateView()

				return
			end)
		end
	elseif var_7_0 == GAME.ACTIVITY_MALL_OP_DONE then
		if var_7_1.cmd == ActivityMallOPCommand.CMD.INPUT_GOLD then
			arg_7_0.viewComponent:UpdateView()
		end
	elseif var_7_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		if arg_7_0:IsAwardHandledByParent() then
			arg_7_0.viewComponent:UpdateView()
		else
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_1.awards, function()
				arg_7_0.viewComponent:UpdateView()

				return
			end)
		end
	end

	return
end

function var_0_0.IsAwardHandledByParent(arg_10_0)
	return arg_10_0.contextData and arg_10_0.contextData.awardHandledByParent
end

function var_0_0.remove(arg_11_0)
	return
end

return var_0_0
