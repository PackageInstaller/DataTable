class = var_0_10000

local var_0_0 = "IslandSubmitTaskOneStepCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskIds
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21041, {
		task_ids = var_1_0
	}, 21042, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetTaskAgency(var_2_1)

			local var_2_3 = 0

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(var_1_0) do
				local var_2_4 = var_2_2:GetTask(iter_2_1)

				var_2_3 = var_2_3 + var_8.GetExp(var_2_4)
				getProxy = var_9
				IslandProxy = var_2_4

				local var_2_5 = var_9(var_2_4)
				local var_2_6 = var_9.GetIsland(var_2_5)
				local var_2_7 = var_9.GetInventoryAgency(var_2_6)

				ipairs = var_2_6

				for iter_2_2, iter_2_3 in var_2_6(var_8:GetRecycleItemInfos()) do
					var_2_7:RemoveItem(iter_2_3.id, iter_2_3.count)
				end

				var_2_2:RemoveTask(iter_2_1)
				var_2_2:AddFinishId(iter_2_1)
			end

			IslandTaskHelper = var_2_10003

			var_2_10003.OnSubmitTask(var_1_0)
			var_2_2:TryAcceptAutoTasks()

			IslandDropHelper = var_2_10003
			var_2_10003 = var_2_10003.AddItems(arg_2_0, var_2_3)

			local var_2_8 = arg_1_0
			local var_2_9 = var_4.sendNotification

			GAME = iter_2_0

			var_2_9(var_2_8, iter_2_0.ISLAND_SUBMIT_TASK_ONE_STEP_DONE, {
				dropData = var_2_10003,
				callback = var_1_1
			})
		else
			pg = var_2_2

			local var_2_10 = var_2_2.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_11(var_2_10, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
