local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WeeklyCompetition_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.weeklyCompetitionMgrData:onS2CWeeklyCompetitionInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WeeklyCompetition_Enter = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.weeklyCompetitionMgrData:onS2CWeeklyCompetitionEnter(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_ENTER, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_WeeklyCompetition_ScoreAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.weeklyCompetitionMgrData:onS2CWeeklyCompetitionScoreAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_SCOREAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_WeeklyCompetition_GetServerInfos = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_GETSERVERINFOS, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_WeeklyCompetition_GetRankList = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_GETRANKLIST, false, arg_5_1, arg_5_2)
		end
	end
}
