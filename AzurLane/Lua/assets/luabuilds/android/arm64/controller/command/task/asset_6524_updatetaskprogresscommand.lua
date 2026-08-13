class = var_0_10000

local var_0_0 = "UpdateTaskProgressCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).taskId

	pg = var_1_0

	local var_1_2 = var_1_0.task_data_template[var_1_1]
	local var_1_3
	local var_1_4

	getProxy = var_1_10007
	TaskProxy = var_1_10009

	local var_1_5 = var_1_10007(var_1_10009)

	if not var_7.getTaskById(var_1_5, var_1_1) then
		return
	end

	local var_1_6 = var_8
	local var_1_7 = var_8.getConfig(var_1_6, "sub_type")
	local var_1_8 = false
	local var_1_9

	if var_1_7 == 2001 then
		Task = var_1_6
		var_1_3 = var_1_6.TASK_PROGRESS_UPDATE
		var_1_6 = var_1_2.target_id
		var_1_9 = var_1_2.target_num
		getProxy = var_1_10013
		FleetProxy = var_1_10015

		local var_1_10 = var_1_10013(var_1_10015)
		local var_1_11 = var_13.getData(var_1_10)

		pairs = var_1_10015

		for iter_1_0, iter_1_1 in var_1_10015(var_1_11) do
			table = var_1_10020

			if (var_1_10020.contains(var_1_6, iter_1_1.id) or #var_1_6 == 0) and iter_1_1:getShipCount() == var_1_9 then
				var_1_8 = true

				break
			end
		end

		var_1_4 = var_1_9
	elseif var_1_7 == 2002 then
		Task = var_1_6
		var_1_3 = var_1_6.TASK_PROGRESS_UPDATE
		var_1_9 = var_1_2.target_id[1]

		local var_1_12 = var_1_6[2]
		local var_1_13 = var_1_2.target_num

		getProxy = var_1_10015
		FleetProxy = var_1_10017

		local var_1_14 = var_1_10015(var_1_10017)
		local var_1_15 = var_15.getData(var_1_14)
		local var_1_16 = 0

		pairs = var_1_14

		for iter_1_2, iter_1_3 in var_1_14(var_1_15) do
			if iter_1_3:getShipCount() == var_1_12 and var_1_9 <= iter_1_3:avgLevel() then
				var_1_16 = var_1_16 + 1
			end
		end

		if not var_8:isFinish() and var_1_16 > var_8.progress then
			var_1_8 = true
			var_1_4 = var_1_16
		end
	elseif var_1_7 == 2003 then
		Task = var_1_6
		var_1_3 = var_1_6.TASK_PROGRESS_UPDATE
		var_1_8 = true
		var_1_4 = 1
	elseif var_1_7 == 2010 or var_1_7 == 2011 then
		Task = var_1_6
		var_1_3 = var_1_6.TASK_PROGRESS_APPEND
		var_1_8 = true
		var_1_4 = 1
	elseif var_1_7 == 2012 then
		Task = var_1_6
		var_1_3 = var_1_6.TASK_PROGRESS_UPDATE
		var_1_4 = var_2.progress
		var_1_8 = true
	end

	if not var_1_8 then
		return
	end

	local var_1_17 = {
		id = var_1_1,
		mode = var_1_3,
		progress = var_1_4
	}

	pg = var_1_9

	local var_1_18 = var_1_9.ConnectionMgr.GetInstance()

	var_12.Send(var_1_18, 20009, {
		progressinfo = {
			var_1_17
		}
	}, 20010, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_3

			Task = var_2_10002

			if var_2_0 == var_2_10002.TASK_PROGRESS_UPDATE then
				local var_2_1 = var_0

				var_1.updateProgress(var_2_1, var_1_4)
			else
				local var_2_2 = var_1_3

				Task = var_2

				if var_2_2 == var_2.TASK_PROGRESS_APPEND then
					local var_2_3 = var_0.progress + var_1_4
					local var_2_4 = var_0

					var_2.updateProgress(var_2_4, var_2_3)
				end
			end

			local var_2_5 = var_0

			var_1.updateTask(var_2_5, var_0)

			local var_2_6 = arg_1_0
			local var_2_7 = var_1.sendNotification

			GAME = var_4

			var_2_7(var_2_6, var_4.SHARE_TASK_FINISHED)
		end

		return
	end)

	return
end

return var_0_1
