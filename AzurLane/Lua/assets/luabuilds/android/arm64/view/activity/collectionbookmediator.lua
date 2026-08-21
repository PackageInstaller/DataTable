local var_0_0 = class("CollectionBookMediator", import("..base.ContextMediator"))

var_0_0.ACT_ID = ActivityConst.HOLIDAY_ACT_ID

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	if arg_3_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN then
		arg_3_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_3_1:getBody().awards, function()
			arg_3_0.viewComponent:updateAwardPanel()
			arg_3_0.viewComponent:updateTag()

			return
		end)
	end

	return
end

function var_0_0.GetCollectionBookTip()
	local var_5_0 = getProxy(ActivityProxy):getActivityById(CollectionBookMediator.ACT_ID):getConfig("config_client").collect_task

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = getProxy(TaskProxy):getTaskById(var_5_0[iter_5_0])

		if var_5_1 and var_5_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return var_0_0
