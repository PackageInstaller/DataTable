class = var_0_10000

local var_0_0 = "UpdateTaskProgressCommand"

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

	local var_1_5 = var_8:getConfig("sub_type")
	local var_1_6 = false
	local var_1_7

	if var_1_5 == 2001 then
		Task = var_1_7
		var_1_2 = var_1_7.TASK_PROGRESS_UPDATE
		var_1_7 = var_1_1.target_id
		var_1_10012 = var_1_1.target_num
		getProxy = var_1_10013
		FleetProxy = var_1_10014
		var_1_10015 = var_1_10013(var_1_10014)

		local var_1_8 = var_13.getData(var_1_10015)

		pairs = var_1_10015

		for iter_1_0, iter_1_1 in var_1_10015(var_1_8) do
			table = var_1_10020

			if (var_1_10020.contains(var_1_7, iter_1_1.id) or #var_1_7 == 0) and iter_1_1:getShipCount() == var_1_10012 then
				var_1_6 = true

				break
			end
		end

		var_1_3 = var_1_10012
	elseif var_1_5 == 2002 then
		Task = var_1_7
		var_1_2 = var_1_7.TASK_PROGRESS_UPDATE
		var_1_10012 = var_1_1.target_id[1]

		local var_1_9 = var_1_7[2]
		local var_1_10 = var_1_1.target_num

		getProxy = var_1_10015
		FleetProxy = var_1_10016

		local var_1_11 = var_1_10015(var_1_10016)
		local var_1_12 = var_15.getData(var_1_11)
		local var_1_13 = 0

		pairs = iter_1_0

		for iter_1_2, iter_1_3 in iter_1_0(var_1_12) do
			if iter_1_3:getShipCount() == var_1_9 and var_1_10012 <= iter_1_3:avgLevel() then
				var_1_13 = var_1_13 + 1
			end
		end

		if not var_8:isFinish() and var_1_13 > var_8.progress then
			var_1_6 = true
			var_1_3 = var_1_13
		end
	elseif var_1_5 == 2003 then
		Task = var_1_7
		var_1_2 = var_1_7.TASK_PROGRESS_UPDATE
		var_1_6 = true
		var_1_3 = 1
	elseif var_1_5 == 2010 or var_1_5 == 2011 then
		Task = var_1_7
		var_1_2 = var_1_7.TASK_PROGRESS_APPEND
		var_1_6 = true
		var_1_3 = 1
	elseif var_1_5 == 2012 then
		Task = var_1_7
		var_1_2 = var_1_7.TASK_PROGRESS_UPDATE
		var_1_3 = var_2.progress
		var_1_6 = true
	end

	if not var_1_6 then
		return
	end

	local var_1_14 = {
		id = var_1_0,
		mode = var_1_2,
		progress = var_1_3
	}

	pg = var_1_10012

	local var_1_15 = var_1_10012.ConnectionMgr.GetInstance()

	var_12.Send(var_1_15, 20009, {
		progressinfo = {
			var_1_14
		}
	}, 20010, function(arg_2_0)
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
