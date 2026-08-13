class = var_0_10000

local var_0_0 = "TriggerTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)
	local var_1_2 = arg_1_1:getType()

	pg = var_1_0

	local var_1_3 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 20007, {
		id = var_1_1
	}, 20008, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			TaskProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.addTask

			Task = var_2_10004

			var_2_1(var_2_0, var_2_10004.New({
				id = var_1_1
			}))

			local var_2_2 = arg_1_0
			local var_2_3 = var_1.sendNotification

			GAME = var_4

			var_2_3(var_2_2, var_4.TRIGGER_TASK_DONE, {
				taskId = var_1_1
			})

			if var_1_2 then
				var_1_2(true)
			end
		elseif var_1_2 then
			var_1_2(false)
		end

		return
	end)

	return
end

return var_0_1
