local CollectionBookMediator = class("CollectionBookMediator", import("..base.ContextMediator"))

CollectionBookMediator.ACT_ID = ActivityConst.HOLIDAY_ACT_ID

function CollectionBookMediator:register()
	return
end

function CollectionBookMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function CollectionBookMediator:handleNotification(arg_3_1)
	if arg_3_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_3_1:getBody().awards, function()
			self.viewComponent:updateAwardPanel()
			self.viewComponent:updateTag()

			return
		end)
	end

	return
end

function CollectionBookMediator.GetCollectionBookTip()
	local var_5_0 = getProxy(ActivityProxy):getActivityById(CollectionBookMediator.ACT_ID):getConfig("config_client").collect_task

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = getProxy(TaskProxy):getTaskById(var_5_0[iter_5_0])

		if var_5_1 and var_5_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return CollectionBookMediator
