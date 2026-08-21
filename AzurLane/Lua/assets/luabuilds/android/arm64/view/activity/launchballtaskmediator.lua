local var_0_0 = class("LaunchBallTaskMediator", import("..base.ContextMediator"))

var_0_0.SUBMIT_ALL = "SUBMIT_ALL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(LaunchBallTaskMediator.SUBMIT_ALL, function(arg_2_0, arg_2_1)
		arg_1_0.submit = #arg_2_1
		arg_1_0.awards = {}

		for iter_2_0 = 1, #arg_2_1 do
			arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_2_1[iter_2_0].id)
		end

		return
	end)

	return
end

function var_0_0.onUIAvalible(arg_3_0)
	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.SUBMIT_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_5_1.awards > 0 then
			arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1.awards)
		end

		if var_5_1.callback then
			-- block empty
		end

		arg_5_0.viewComponent:updateTask(true)
	elseif var_5_0 == GAME.SUBMIT_TASK_DONE then
		if arg_5_0.submit and arg_5_0.submit > 0 then
			for iter_5_0 = 1, #var_5_1 do
				table.insert(arg_5_0.awards, var_5_1[iter_5_0])
			end

			arg_5_0.submit = arg_5_0.submit - 1

			if arg_5_0.submit == 0 then
				arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_5_0.awards, function()
					arg_5_0.viewComponent:updateTasks()

					return
				end)
			end
		else
			arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_5_1, function()
				arg_5_0.viewComponent:updateTasks()

				return
			end)
		end
	end

	return
end

return var_0_0
