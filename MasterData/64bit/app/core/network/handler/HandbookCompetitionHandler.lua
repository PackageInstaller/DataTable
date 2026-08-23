local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.competitionData

return {
	on_S2C_HandbookCompetition_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CHandbookCompetitionGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_HandbookCompetition_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CHandbookCompetitionGetAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_HandbookCompetition_SyncTask = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CHandbookCompetitionSyncTask(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_COMPETITION_SYNCTASK, false, arg_3_1, arg_3_2)
		end
	end
}
