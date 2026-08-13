class = var_0_10000

local var_0_0 = "IslandAcceptTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().taskIds
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21032, {
		task_id_list = var_1_0
	}, 21033, function(arg_2_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = var_1.GetIsland(var_2_0)
		local var_2_2 = var_1.GetTaskAgency(var_2_1)
		local var_2_3 = {}

		ipairs = var_2_10003

		local var_2_4

		if not arg_2_0.task_list then
			var_2_4 = {}
		end

		for iter_2_0, iter_2_1 in var_2_10003(var_2_4) do
			IslandTask = var_2_10008
			var_2_10008 = var_2_10008.New(iter_2_1)

			var_2_2:AddTask(var_2_10008)

			table = var_9

			var_9.insert(var_2_3, iter_2_1.id)
		end

		if #var_2_3 > 0 then
			var_2_2:TryAutoTrackTask()
		end

		local var_2_5 = arg_1_0
		local var_2_6 = var_3.sendNotification

		GAME = var_5

		var_2_6(var_2_5, var_5.ISLAND_ACCEPT_TASK_DONE, {
			taskIds = var_2_3,
			callback = var_1_1
		})

		return
	end)

	return
end

return var_0_1
