local var_0_0 = class("WorldTriggerTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.taskId
	local var_1_2 = var_1_0.portId
	local var_1_3 = nowWorld()
	local var_1_4 = nowWorld():GetTaskProxy()
	local var_1_5, var_1_6 = WorldTask.canTrigger(var_1_0.taskId)

	if not var_1_5 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_6)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(33205, {
		taskId = var_1_0.taskId
	}, 33206, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 then
				local var_2_0 = var_1_3:GetActiveMap():GetPort()
				local var_2_1 = underscore.rest(var_2_0.taskIds, 1)

				table.removebyvalue(var_2_1, var_1_1)
				var_2_0:UpdateTaskIds(var_2_1)
			end

			local var_2_2 = WorldTask.New(arg_2_0.task)

			var_2_2.new = 1

			var_1_4:addTask(var_2_2)

			if #var_2_2.config.task_op > 0 then
				pg.NewStoryMgr.GetInstance():Play(var_2_2.config.task_op, nil, true)
			end

			arg_1_0:sendNotification(GAME.WORLD_TRIGGER_TASK_DONE, {
				task = var_2_2
			})
		elseif arg_2_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_task_refuse1"))
		else
			pg.TipsMgr.GetInstance():ShowTips("trigger task fail:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
