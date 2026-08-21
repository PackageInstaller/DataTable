local var_0_0 = class("WorldTriggerDailyTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = nowWorld():GetTaskProxy()

	pg.ConnectionMgr.GetInstance():Send(7, {
		task_list = arg_1_1:getBody().taskIds
	}, 8, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_0:getDailyTaskIds()

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.task_list) do
				local var_2_1 = WorldTask.New(iter_2_1)

				var_2_1.new = 1

				table.removebyvalue(var_2_0, var_2_1.id)
				var_1_0:addTask(var_2_1)

				if #var_2_1.config.task_op > 0 then
					pg.NewStoryMgr.GetInstance():Play(var_2_1.config.task_op, nil, true)
				end

				arg_1_0:sendNotification(GAME.WORLD_TRIGGER_TASK_DONE, {
					task = var_2_1
				})
			end

			var_1_0:UpdateDailyTaskIds(var_2_0)
			arg_1_0:sendNotification(GAME.WORLD_TRIGGER_DAILY_TASK_DONE)
		elseif arg_2_0.result == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_task_refuse1"))
		elseif arg_2_0.result == 20 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_sametask_tip"))
		else
			pg.TipsMgr.GetInstance():ShowTips("trigger task fail:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
