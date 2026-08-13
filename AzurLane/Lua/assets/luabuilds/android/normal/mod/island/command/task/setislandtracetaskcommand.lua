class = var_0_10000

local var_0_0 = "SetIslandTraceTaskCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().traceId then
		var_1_0 = 0
	end

	local var_1_1 = var_2.type

	IslandTaskTrackCard = var_1_10005

	local var_1_6

	if var_1_1 == var_1_10005.TYPES.MAIN then
		getProxy = var_1_6
		IslandProxy = var_1_10006

		local var_1_2 = var_1_6(var_1_10006)
		local var_1_3 = var_1_6.GetIsland(var_1_2)
		local var_1_4 = var_1_6.GetTaskAgency(var_1_3)

		var_1_6.SetMainTraceId(var_1_4, var_1_0)

		local var_1_5 = arg_1_0

		var_1_6 = arg_1_0.sendNotification
		GAME = var_7

		var_1_6(var_1_5, var_7.ISLAND_SET_TRACE_TASK_DONE, {
			traceId = var_1_0,
			type = var_1_1
		})

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_5.Send(var_1_7, 21034, {
		task_id = var_1_0
	}, 21035, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			getProxy = var_2_4
			IslandProxy = var_2_10002

			local var_2_0 = var_2_4(var_2_10002)
			local var_2_1 = var_2_4.GetIsland(var_2_0)
			local var_2_2 = var_2_4.GetTaskAgency(var_2_1)

			var_2_4.SetTraceId(var_2_2, var_1_0)

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10003

			var_2_4(var_2_3, var_2_10003.ISLAND_SET_TRACE_TASK_DONE, {
				traceId = var_1_0,
				type = var_1_1
			})
		else
			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
