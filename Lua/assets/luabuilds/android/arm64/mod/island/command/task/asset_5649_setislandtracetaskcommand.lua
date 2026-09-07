local SetIslandTraceTaskCommand = class("SetIslandTraceTaskCommand", pm.SimpleCommand)

function SetIslandTraceTaskCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.traceId or 0
	local var_1_2 = var_1_0.type

	if var_1_0.type == IslandTaskTrackCard.TYPES.MAIN then
		getProxy(IslandProxy):GetIsland():GetTaskAgency():SetMainTraceId(var_1_1)
		self:sendNotification(GAME.ISLAND_SET_TRACE_TASK_DONE, {
			traceId = var_1_1,
			type = var_1_2
		})

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21034, {
		task_id = var_1_1
	}, 21035, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetTaskAgency():SetTraceId(var_1_1)
			self:sendNotification(GAME.ISLAND_SET_TRACE_TASK_DONE, {
				traceId = var_1_1,
				type = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return SetIslandTraceTaskCommand
