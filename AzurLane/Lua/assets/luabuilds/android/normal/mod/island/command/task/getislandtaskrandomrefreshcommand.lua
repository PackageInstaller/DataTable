class = var_0_10000

local var_0_0 = "GetIslandTaskRandomRefreshCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 21030, {
		type = 0
	}, 21031, function(arg_2_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = var_1.GetIsland(var_2_0)
		local var_2_2 = var_1.GetTaskAgency(var_2_1)

		var_1.UpdateRandomRefreshTask(var_2_2, arg_2_0)

		local var_2_3 = arg_1_0
		local var_2_4 = var_2.sendNotification

		GAME = var_4

		var_2_4(var_2_3, var_4.ISLAND_GET_RANDOM_REFRESH_TASK_DONE)

		return
	end)

	return
end

return var_0_1
