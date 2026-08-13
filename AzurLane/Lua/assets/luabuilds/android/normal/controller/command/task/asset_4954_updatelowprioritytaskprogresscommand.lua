class = var_0_10000

local var_0_0 = "UpdateLowPriorityTaskProgressCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId

	pg = var_1_10004

	local var_1_1 = var_1_10004.task_data_template[var_1_0]
	local var_1_2
	local var_1_3

	getProxy = var_1_10007
	TaskProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)

	if not var_7.getTaskById(var_1_4, var_1_0) then
		return
	end

	local var_1_5 = var_8:getActId()
	local var_1_6 = var_8:getConfig("sub_type")
	local var_1_7 = false
	local var_1_8

	if var_1_6 == 2001 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_UPDATE
		var_1_8 = var_1_1.target_id
		var_1_10013 = var_1_1.target_num
		getProxy = var_1_10014
		FleetProxy = var_1_10015
		var_1_10016 = var_1_10014(var_1_10015)

		local var_1_9 = var_14.getData(var_1_10016)

		pairs = var_1_10016

		for iter_1_0, iter_1_1 in var_1_10016(var_1_9) do
			table = var_1_10021

			if (var_1_10021.contains(var_1_8, iter_1_1.id) or #var_1_8 == 0) and iter_1_1:getShipCount() == var_1_10013 then
				var_1_7 = true

				break
			end
		end

		var_1_3 = var_1_10013
	elseif var_1_6 == 2002 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_UPDATE
		var_1_10013 = var_1_1.target_id[1]

		local var_1_10 = var_1_8[2]
		local var_1_11 = var_1_1.target_num

		getProxy = var_1_10016
		FleetProxy = var_1_10017

		local var_1_12 = var_1_10016(var_1_10017)
		local var_1_13 = var_16.getData(var_1_12)
		local var_1_14 = 0

		pairs = iter_1_0

		for iter_1_2, iter_1_3 in iter_1_0(var_1_13) do
			if iter_1_3:getShipCount() == var_1_10 and var_1_10013 <= iter_1_3:avgLevel() then
				var_1_14 = var_1_14 + 1
			end
		end

		if not var_8:isFinish() and var_1_14 > var_8.progress then
			var_1_7 = true
			var_1_3 = var_1_14
		end
	elseif var_1_6 == 2003 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_UPDATE
		var_1_7 = true
		var_1_3 = 1
	elseif var_1_6 == 2010 or var_1_6 == 2011 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_APPEND
		var_1_7 = true
		var_1_3 = 1
	elseif var_1_6 == 2012 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_UPDATE
		var_1_3 = var_2.progress
		var_1_7 = true
	elseif var_1_6 == 2025 then
		Task = var_1_8
		var_1_2 = var_1_8.TASK_PROGRESS_UPDATE
		var_1_3 = 1
		var_1_7 = true
	end

	if not var_1_7 then
		return
	end

	local var_1_15 = {
		task_id = var_1_0,
		mode = var_1_2,
		progress = var_1_3,
		act_id = var_1_5
	}

	pg = var_1_10013

	local var_1_16 = var_1_10013.ConnectionMgr.GetInstance()

	var_13.Send(var_1_16, 20209, {
		progressinfo = {
			var_1_15
		}
	}, 20210, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			Task = var_2_10002

			local var_2_1

			if var_2_0 == var_2_10002.TASK_PROGRESS_UPDATE then
				var_2_1 = var_0

				var_1.updateProgress(var_2_1, var_1_3)
			else
				local var_2_2 = var_1_2

				Task = var_2_1

				if var_2_2 == var_2_1.TASK_PROGRESS_APPEND then
					local var_2_3 = var_0.progress + var_1_3
					local var_2_4 = var_0

					var_2.updateProgress(var_2_4, var_2_3)
				end
			end

			local var_2_5 = var_0

			var_1.updateTask(var_2_5, var_0)

			local var_2_6 = arg_1_0
			local var_2_7 = var_1.sendNotification

			GAME = var_3

			var_2_7(var_2_6, var_3.SHARE_TASK_FINISHED)
		end

		return
	end)

	return
end

return var_0_1
