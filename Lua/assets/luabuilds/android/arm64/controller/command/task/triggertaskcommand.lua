local var_0_0 = class("TriggerTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getType()

	pg.ConnectionMgr.GetInstance():Send(20007, {
		id = arg_1_1:getBody()
	}, 20008, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(TaskProxy):addTask(Task.New({
				id = var_0
			}))
			arg_1_0:sendNotification(GAME.TRIGGER_TASK_DONE, {
				taskId = var_0
			})

			if var_1_0 then
				var_1_0(true)
			end
		elseif var_1_0 then
			var_1_0(false)
		end

		return
	end)

	return
end

return var_0_0
