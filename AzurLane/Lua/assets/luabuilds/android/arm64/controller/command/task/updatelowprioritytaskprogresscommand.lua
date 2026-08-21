local var_0_0 = class("UpdateLowPriorityTaskProgressCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.taskId
	local var_1_2
	local var_1_3
	local var_1_4 = getProxy(TaskProxy)
	local var_1_5 = getProxy(TaskProxy):getTaskById(var_1_0.taskId)

	if not var_1_5 then
		return
	end

	local var_1_6 = var_1_5:getActId()
	local var_1_7 = var_1_5:getConfig("sub_type")
	local var_1_8 = false

	if var_1_7 == 2001 then
		var_1_2 = Task.TASK_PROGRESS_UPDATE

		for iter_1_0, iter_1_1 in pairs((getProxy(FleetProxy):getData())) do
			if (table.contains(pg.task_data_template[var_1_0.taskId].target_id, iter_1_1.id) or #pg.task_data_template[var_1_0.taskId].target_id == 0) and iter_1_1:getShipCount() == pg.task_data_template[var_1_0.taskId].target_num then
				var_1_8 = true

				break
			end
		end

		var_1_3 = pg.task_data_template[var_1_0.taskId].target_num
	elseif var_1_7 == 2002 then
		var_1_2 = Task.TASK_PROGRESS_UPDATE

		local var_1_10 = 0

		for iter_1_2, iter_1_3 in pairs((getProxy(FleetProxy):getData())) do
			if iter_1_3:getShipCount() == pg.task_data_template[var_1_0.taskId].target_id[2] and pg.task_data_template[var_1_0.taskId].target_id[1] <= iter_1_3:avgLevel() then
				var_1_10 = var_1_10 + 1
			end
		end

		if not var_1_5:isFinish() and var_1_10 > var_1_5.progress then
			var_1_8 = true
			var_1_3 = var_1_10
		end
	elseif var_1_7 == 2003 then
		var_1_2 = Task.TASK_PROGRESS_UPDATE
		var_1_8 = true
		var_1_3 = 1
	elseif var_1_7 == 2010 or var_1_7 == 2011 then
		var_1_2 = Task.TASK_PROGRESS_APPEND
		var_1_8 = true
		var_1_3 = 1
	elseif var_1_7 == 2012 then
		var_1_2 = Task.TASK_PROGRESS_UPDATE
		var_1_3 = var_1_0.progress
		var_1_8 = true
	elseif var_1_7 == 2025 then
		var_1_2 = Task.TASK_PROGRESS_UPDATE
		var_1_3 = 1
		var_1_8 = true
	end

	if not var_1_8 then
		return
	end

	;({})[1] = {
		task_id = var_1_1,
		mode = var_1_2,
		progress = var_1_3,
		act_id = var_1_6
	}
	;({}).progressinfo = {}

	pg.ConnectionMgr.GetInstance():Send(20209, {}, 20210, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 == Task.TASK_PROGRESS_UPDATE then
				var_1_5:updateProgress(var_1_3)
			elseif var_1_2 == Task.TASK_PROGRESS_APPEND then
				var_1_5:updateProgress(var_1_5.progress + var_1_3)
			end

			var_1_4:updateTask(var_1_5)
			arg_1_0:sendNotification(GAME.SHARE_TASK_FINISHED)
		end

		return
	end)

	return
end

return var_0_0
