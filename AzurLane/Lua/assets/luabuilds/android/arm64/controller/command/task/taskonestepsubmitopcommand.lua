class = var_0_10000

local var_0_0 = "TaskOneStepSubmitOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if #arg_1_1:getBody().resultList > 0 then
		local var_1_0 = {}
		local var_1_1 = {}

		ipairs = var_1_10006

		for iter_1_0, iter_1_1 in var_1_10006(var_3) do
			if iter_1_1.isWeekTask then
				table = var_11

				var_11.insert(var_1_1, iter_1_1.id)
			else
				table = var_11

				var_11.insert(var_1_0, iter_1_1)
			end
		end

		local var_1_2 = {}

		seriesAsync = var_7

		var_7({
			function(arg_2_0)
				if #var_1_0 > 0 then
					pg = var_1

					local var_2_0 = var_1.m02
					local var_2_1 = var_1.sendNotification

					GAME = var_2_10004

					var_2_1(var_2_0, var_2_10004.SUBMIT_TASK_ONESTEP, {
						resultList = var_0,
						callback = arg_2_0
					})
				else
					arg_2_0()
				end

				return
			end,
			function(arg_3_0)
				if #var_1_1 > 0 then
					local var_3_0 = arg_1_0
					local var_3_1 = var_1.emit

					TaskMediator = var_2_10004

					var_3_1(var_3_0, var_2_10004.ON_BATCH_SUBMIT_WEEK_TASK, var_1_1, arg_3_0)
				else
					arg_3_0()
				end

				return
			end
		})
	end

	return
end

return var_0_1
