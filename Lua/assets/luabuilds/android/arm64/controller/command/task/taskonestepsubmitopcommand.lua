local var_0_0 = class("TaskOneStepSubmitOPCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().resultList

	if #var_1_0 > 0 then
		local var_1_1 = {}
		local var_1_2 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			if iter_1_1.isWeekTask then
				table.insert({}, iter_1_1.id)
			else
				table.insert({}, iter_1_1)
			end
		end

		seriesAsync({
			function(arg_2_0)
				if #var_1_1 > 0 then
					pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
						resultList = var_1_0,
						callback = arg_2_0
					})
				else
					arg_2_0()
				end

				return
			end,
			function(arg_3_0)
				if #var_1_2 > 0 then
					arg_1_0:emit(TaskMediator.ON_BATCH_SUBMIT_WEEK_TASK, var_1_2, arg_3_0)
				else
					arg_3_0()
				end

				return
			end
		})
	end

	return
end

return var_0_0
