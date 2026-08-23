local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Exploration_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.explorationData:onS2CExplorationInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Exploration_EventProcess = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.explorationData:onS2CExplorationEventProcess(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, false, arg_2_1, arg_2_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_EXPLORATION_EVENTPROCESS_FAILED, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Exploration_UnlockCell = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.explorationData:onS2CExplorationUnlockCell(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_UNLOCKCELL, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Exploration_EventNotify = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			-- block empty
		end
	end,
	on_S2C_Exploration_GetServerInfos = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.explorationData:onS2CGetServerInfo(arg_5_2)
		end
	end,
	on_S2C_Exploration_ChallengeGuardBegin = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDBEGIN, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Exploration_ChallengeGuardFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.explorationData:getMapData():onGuardBattleFinish(arg_7_2.is_win)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDFINISH, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Exploration_ChallengeMonsterFinish = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.explorationData:getMapData():onRobberBattleFinish(arg_8_2.is_win)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEMONSTERFINISH, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Exploration_GetBossBattleTeam = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.explorationData:onS2CGetBossBattleTeam(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_GETBOSSBATTLETEAM, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Exploration_ChallengeBossBegin = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEGUARDBEGIN, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Exploration_ChallengeBossFinish = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.explorationData:updateBossChallengeCount(arg_11_2.boss_daily_challenge_count or 0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_CHALLENGEBOSSFINISH, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Exploration_Move = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.explorationData:onS2CExplorationMove(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_MOVE, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Exploration_GetGuildBuffDetail = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.explorationData:updateGuildBuff(arg_13_2.guild_buffs)
			g.core.model.User.explorationData:updateGuildPlayer(arg_13_2.snapshots)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_GETGUILDBUFFDETAIL, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Exploration_ShopRefresh = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.explorationData:getMapData():updateEventByUID(arg_14_2.shop_id, arg_14_2.event)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_SHOPREFRESH, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Exploration_Sell = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_SELL, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Exploration_FinishTask = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.explorationData:getTaskData():finishTaskInfo(arg_16_2.task_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_FINISHTASK, false, arg_16_1, arg_16_2)
		end
	end
}
