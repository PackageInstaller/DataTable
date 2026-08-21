local var_0_0 = class("IslandSubmitTaskOneStepCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21041, {
		task_ids = var_1_0.taskIds
	}, 21042, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()
			local var_2_1 = 0

			for iter_2_0, iter_2_1 in ipairs(var_0) do
				local var_2_2 = var_2_0:GetTask(iter_2_1)

				var_2_1 = var_2_1 + var_2_2:GetExp()

				local var_2_3 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

				for iter_2_2, iter_2_3 in ipairs(var_2_2:GetRecycleItemInfos()) do
					var_2_3:RemoveItem(iter_2_3.id, iter_2_3.count)
				end

				var_2_0:RemoveTask(iter_2_1)
				var_2_0:AddFinishId(iter_2_1)
			end

			IslandTaskHelper.OnSubmitTask(var_0)
			var_2_0:TryAcceptAutoTasks()
			arg_1_0:sendNotification(GAME.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0, var_2_1),
				callback = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
