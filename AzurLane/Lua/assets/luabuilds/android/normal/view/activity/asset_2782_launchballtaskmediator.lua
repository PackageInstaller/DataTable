class = var_0_10000

local var_0_0 = "LaunchBallTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SUBMIT_ALL = "SUBMIT_ALL"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	LaunchBallTaskMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.SUBMIT_ALL, function(arg_2_0, arg_2_1)
		arg_1_0.submit = #arg_2_1
		arg_1_0.awards = {}

		for iter_2_0 = 1, #arg_2_1 do
			local var_2_0 = arg_1_0
			local var_2_1 = var_6.sendNotification

			GAME = var_2_10008

			var_2_1(var_2_0, var_2_10008.SUBMIT_TASK, arg_2_1[iter_2_0].id)
		end

		return
	end)

	return
end

function var_0_1.onUIAvalible(arg_3_0)
	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.SUBMIT_TASK_DONE

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	GAME = var_5_1

	local var_5_4

	if var_5_0 == var_5_1.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_5_2.awards > 0 then
			local var_5_3 = arg_5_0.viewComponent

			var_5_4 = var_5_4.emit
			BaseUI = var_1_10006

			var_5_4(var_5_3, var_1_10006.ON_ACHIEVE, var_5_2.awards)
		end

		if var_5_2.callback then
			-- block empty
		end

		local var_5_5 = arg_5_0.viewComponent

		var_5_4.updateTask(var_5_5, true)
	else
		GAME = var_5_4

		if var_5_0 == var_5_4.SUBMIT_TASK_DONE then
			if arg_5_0.submit and arg_5_0.submit > 0 then
				for iter_5_0 = 1, #var_5_2 do
					table = var_1_10008

					var_1_10008.insert(arg_5_0.awards, var_5_2[iter_5_0])
				end

				arg_5_0.submit = arg_5_0.submit - 1

				if arg_5_0.submit == 0 then
					local var_5_6 = arg_5_0.viewComponent
					local var_5_7 = var_4.emit

					BaseUI = var_1_10006

					var_5_7(var_5_6, var_1_10006.ON_ACHIEVE, arg_5_0.awards, function()
						local var_6_0 = arg_5_0.viewComponent

						var_0.updateTasks(var_6_0)

						return
					end)
				end
			else
				local var_5_8 = arg_5_0.viewComponent
				local var_5_9 = var_4.emit

				BaseUI = var_1_10006

				var_5_9(var_5_8, var_1_10006.ON_ACHIEVE, var_5_2, function()
					local var_7_0 = arg_5_0.viewComponent

					var_0.updateTasks(var_7_0)

					return
				end)
			end
		end
	end

	return
end

return var_0_1
