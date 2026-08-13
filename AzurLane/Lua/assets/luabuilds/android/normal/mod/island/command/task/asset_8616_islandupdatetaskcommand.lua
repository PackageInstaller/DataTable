class = var_0_10000

local var_0_0 = "IslandUpdateTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskId
	local var_1_1 = var_2.targetId
	local var_1_2 = var_2.progress
	local var_1_3 = 0

	pg = var_1_10006

	local var_1_4 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 21036, {
		task_id = var_1_3,
		target_id = var_1_1,
		target_count = var_1_2
	}, 21037, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetTaskAgency(var_2_1)
			ipairs = var_2_1

			for iter_2_0, iter_2_1 in var_2_1(arg_2_0.task_list) do
				IslandTask = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)

				var_2_2:UpdateTask(var_2_10007)
			end

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.ISLAND_UPDATE_TASK_DONE)
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
