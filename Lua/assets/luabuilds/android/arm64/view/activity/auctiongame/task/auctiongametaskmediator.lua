local var_0_0 = class("AuctionGameTaskMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_GO = "AuctionGameTaskMediator::ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "AuctionGameTaskMediator::ON_TASK_SUBMIT"
var_0_0.ON_ACTIVITY_TASK_SUBMIT_ONESTEP = "AuctionGameTaskMediator::ON_ACTIVITY_TASK_SUBMIT_ONESTEP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2
		})

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {
		[GAME.SUBMIT_TASK_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = getProxy(ContextProxy)

			if var_6_0:GetPrevContext(0).mediator ~= ActivityMediator and #arg_6_1:getBody().awards > 0 then
				arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards)
			end

			arg_6_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_7_0, arg_7_1)
			local var_7_0 = getProxy(ContextProxy)

			if var_7_0:GetPrevContext(0).mediator ~= CoreActivityMainMediator and #arg_7_1:getBody().awards > 0 then
				arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_7_1:getBody().awards)
			end

			arg_7_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.TOTAL_TASK_UPDATED] = function(arg_8_0, arg_8_1)
			arg_8_0.viewComponent:RefreshUI()

			return
		end
	}

	return
end

function var_0_0.remove(arg_9_0)
	return
end

return var_0_0
