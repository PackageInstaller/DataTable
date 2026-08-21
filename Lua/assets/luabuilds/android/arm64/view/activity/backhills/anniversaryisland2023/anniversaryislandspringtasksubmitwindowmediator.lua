local var_0_0 = class("AnniversaryIslandSpringTaskSubmitWindowMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, function(arg_2_0)
		arg_1_0:sendNotification(AnniversaryIslandSpringTask2023Mediator.SUBMIT_TASK, arg_1_0.contextData.task)

		return
	end)
	arg_1_0:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_3_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_5_0.viewComponent:closeView()
	end

	return
end

function var_0_0.remove(arg_6_0)
	return
end

return var_0_0
