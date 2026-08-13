class = var_0_10000

local var_0_0 = "MergeTaskOneStepAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

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

		local function var_1_3(arg_2_0)
			ipairs = var_2_10001

			for iter_2_0, iter_2_1 in var_2_10001(arg_2_0) do
				table = var_2_10006

				var_2_10006.insert(var_1_2, iter_2_1)
			end

			return
		end

		seriesAsync = var_8

		var_8({
			function(arg_3_0)
				if #var_1_0 <= 0 then
					arg_3_0()

					return
				end

				local var_3_0 = arg_1_0
				local var_3_1 = var_1.sendNotification

				GAME = var_2_10003

				var_3_1(var_3_0, var_2_10003.SUBMIT_TASK_ONESTEP, {
					dontSendMsg = true,
					resultList = var_1_0,
					callback = function(arg_4_0)
						var_1_3(arg_4_0)
						arg_3_0()

						return
					end
				})

				return
			end,
			function(arg_5_0)
				if #var_1_1 <= 0 then
					arg_5_0()

					return
				end

				local var_5_0 = arg_1_0
				local var_5_1 = var_1.sendNotification

				GAME = var_2_10003

				var_5_1(var_5_0, var_2_10003.BATCH_SUBMIT_WEEK_TASK, {
					dontSendMsg = true,
					ids = var_1_1,
					callback = function(arg_6_0)
						var_1_3(arg_6_0)
						arg_5_0()

						return
					end
				})

				return
			end
		}, function()
			_ = var_2_10000

			local var_7_0 = var_2_10000.map(var_1_0, function(arg_8_0)
				return arg_8_0.id
			end)
			local var_7_1 = arg_1_0
			local var_7_2 = var_1.sendNotification

			GAME = var_2_10003

			var_7_2(var_7_1, var_2_10003.MERGE_TASK_ONE_STEP_AWARD_DONE, {
				awards = var_1_2,
				taskIds = var_7_0
			})

			return
		end)
	end

	return
end

return var_0_1
