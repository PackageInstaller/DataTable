local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ElderBoss_Enter = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.elderBossData:onS2CElderBossEnter(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_ENTER, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ElderBoss_ChallengeBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEBEGIN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ElderBoss_ChallengeFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.elderBossData:onS2CElderBossChallengeFinish(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_ElderBoss_GetReport = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.elderBossData:onS2CElderBossGetReport(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_GETREPORT, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_ElderBoss_ChooseBuff = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.elderBossData:onS2CElderBossChooseBuff(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHOOSEBUFF, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_ElderBoss_JoinExit = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.elderBossData:onS2CElderBossJoinExit(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_JOINEXIT, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_ElderBoss_ChallengeNotify = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.elderBossData:onS2CElderBossChallengeNotify(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGENOTIFY, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_ElderBoss_TaskAward = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.elderBossData:onS2CElderBossTaskAward(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_TASKAWARD, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_ElderBoss_ServerInfos = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.elderBossData:onS2CServerInfos(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_SERVERINFOS, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_ElderBoss_Exit = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_EXIT, false, arg_10_1, arg_10_2)
		end
	end
}
