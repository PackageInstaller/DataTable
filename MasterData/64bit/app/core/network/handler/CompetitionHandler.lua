local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.commonCompetitionDataManager

return {
	on_S2C_Competition_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMPETITION_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Competition_TaskAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CGetTaskAwardInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMPETITION_TASKAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Competition_ScoreAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CGetScoreAwardInfo(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_COMPETITION_SCOREAWARD, false, arg_3_1, arg_3_2)
		end
	end
}
