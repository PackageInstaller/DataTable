local var_0_0 = class("VoteFameHallMediator", import("..base.ContextMediator"))

var_0_0.ON_SUBMIT_TASK = "VoteFameHallMediator:ON_SUBMIT_TASK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)
	arg_1_0.viewComponent:SetPastVoteData(getProxy(VoteProxy):GetPastVoteData())

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.SUBMIT_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.SUBMIT_TASK_DONE then
		arg_4_0.viewComponent:UpdateTips(arg_4_0.viewComponent.year)
		arg_4_0.viewComponent:UpdateBtnsTip()
	end

	return
end

return var_0_0
