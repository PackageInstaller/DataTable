local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_MysteryBoss_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_MysteryBoss_EnterRoom = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossEnterRoom(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_ENTERROOM, false, arg_2_1, arg_2_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_BOSS_ENTERROOM_ERROR, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_MysteryBoss_LeaveRoom = function(arg_3_0, arg_3_1, arg_3_2)
		g.core.model.User.mysteryBossData:onS2CMysteryBossLeaveRoom()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_LEAVEROOM, false, arg_3_1, arg_3_2)
	end,
	on_S2C_MysteryBoss_GetRankList = function(arg_4_0, arg_4_1, arg_4_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GETRANKLIST, false, arg_4_1, arg_4_2)
	end,
	on_S2C_MysteryBoss_PosChallengeBegin = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_POSCHALLENGEBEGIN, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_MysteryBoss_PosChallengeFinish = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossPosChallengeFinish(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_POSCHALLENGEFINISH, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_MysteryBoss_BossChallengeBegin = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_BOSSCHALLENGEBEGIN, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_MysteryBoss_BossChallengeFinish = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.mysteryBossData:onS2CBossChallengeFinish(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_BOSSCHALLENGEFINISH, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyPosChallenge = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyPosChallenge(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYPOSCHALLENGE, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyBossChallenge = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyBossChallenge(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYBOSSCHALLENGE, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyBossDead = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyBossDead(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYBOSSDEAD, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyLeave = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyLeave(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYLEAVE, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyAwards = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyAwards(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYAWARDS, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_MysteryBoss_RecvAward = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.mysteryBossData:cleanResultAwards()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_RECVAWARD, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_MysteryBoss_GiveAward = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.mysteryBossData:cleanResultAwards()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_GIVEAWARD, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_MysteryBoss_NotifyDisband = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.mysteryBossData:onS2CMysteryBossNotifyDisband()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MYSTERY_BOSS_NOTIFYDISBAND, false, arg_16_1, arg_16_2)
		end
	end
}
