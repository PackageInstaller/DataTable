local var_0_0 = class("IslandUpdateTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	;({}).task_id = 0
	;({}).target_id = var_1_0.targetId
	;({}).target_count = var_1_0.progress

	pg.ConnectionMgr.GetInstance():Send(21036, {}, 21037, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.task_list) do
				var_2_0:UpdateTask((IslandTask.New(iter_2_1)))
			end

			arg_1_0:sendNotification(GAME.ISLAND_UPDATE_TASK_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
