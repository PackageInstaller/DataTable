local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_TeamBattle_Exit = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleExit(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_EXIT, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_TeamBattle_EnterRoom = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleEnterRoom(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_ENTERROOM, false, arg_2_1, arg_2_2)
		end

		if arg_2_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_SetBattleKnights = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSetBattleKnights(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETBATTLEKNIGHTS, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_TeamBattle_SetWork = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSetWork(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETWORK, false, arg_4_1, arg_4_2)
		end

		if arg_4_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_SetVisibleArea = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSetVisibleArea(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETVISIBLEAREA, false, arg_5_1, arg_5_2)
		end

		if arg_5_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_ChallengeMonsterFinish = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleChallengeMonsterFinish(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEMONSTERFINISH, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_TeamBattle_Move = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleMove(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_MOVE, false, arg_7_1, arg_7_2)
		end

		if arg_7_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_Help = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleHelp(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_HELP, false, arg_8_1, arg_8_2)
		end

		if arg_8_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_UseItem = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleUseItem(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_USEITEM, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_TeamBattle_GetLog = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleGetLog(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_GETLOG, false, arg_10_1, arg_10_2)
		end

		if arg_10_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_ChallengeMonsterBegin = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleChallengeMonsterBegin(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEMONSTERBEGIN, false, arg_11_1, arg_11_2)
		end

		if arg_11_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_ChallengeBossBegin = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleChallengeBossBegin(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CHALLENGEBOSSBEGIN, false, arg_12_1, arg_12_2)
		end

		if arg_12_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_OpChallengeResult = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleOpChallengeResult(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_OPCHALLENGERESULT, false, arg_13_1, arg_13_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_OP_RESULT_ERROR)
		end

		if arg_13_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_KnightShopBuy = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleKnightShopBuy(arg_14_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KNIGHTSHOPBUY, false, arg_14_1, arg_14_2)
		end

		if arg_14_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_BuffShopBuy = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleBuffShopBuy(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_BUFFSHOPBUY, false, arg_15_1, arg_15_2)
		end

		if arg_15_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_KnightShopRefresh = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KNIGHTSHOPREFRESH, false, arg_16_1, arg_16_2)
		end

		if arg_16_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_NotifyKnightShopRefresh = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleKnightShopRefresh(arg_17_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYKNIGHTSHOPREFRESH, false, arg_17_1, arg_17_2)
		end

		if arg_17_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_BuffShopRefresh = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_BUFFSHOPREFRESH, false, arg_18_1, arg_18_2)
		end

		if arg_18_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_NotifyBuffShopRefresh = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleBuffShopRefresh(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYBUFFSHOPREFRESH, false, arg_19_1, arg_19_2)
		end

		if arg_19_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_Mine = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleMine(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_MINE, false, arg_20_1, arg_20_2)
		end

		if arg_20_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_Reborn = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleReborn(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_REBORN, false, arg_21_1, arg_21_2)
		end

		if arg_21_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_RecoverHp = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleRecoverHp(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_RECOVERHP, false, arg_22_1, arg_22_2)
		end

		if arg_22_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_SelectBuff = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSelectBuff(arg_23_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTBUFF, false, arg_23_1, arg_23_2)
		end

		if arg_23_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_SelectGame = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSelectGame(arg_24_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTGAME, false, arg_24_1, arg_24_2)
		end

		if arg_24_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_SelectItem = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSelectItem(arg_25_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SELECTITEM, false, arg_25_1, arg_25_2)
		end

		if arg_25_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_NotifyEnterRoom = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyEnterRoom(arg_26_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYENTERROOM, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_TeamBattle_NotifyExit = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyExit(arg_27_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYEXIT, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_TeamBattle_NotifySetWork = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifySetWork(arg_28_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSETWORK, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_TeamBattle_NotifySetVisibleArea = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifySetVisibleArea(arg_29_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSETVISIBLEAREA, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_TeamBattle_NotifyMove = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyMove(arg_30_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMOVE, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_TeamBattle_NotifyHelp = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyHelp(arg_31_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYHELP, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_TeamBattle_NotifyUseItem = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyUseItem(arg_32_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYUSEITEM, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_TeamBattle_NotifyChallengeMonsterBegin = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyChallengeMonsterBegin(arg_33_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEMONSTERBEGIN, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_TeamBattle_NotifyChallengeMonsterFinish = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyChallengeMonsterFinish(arg_34_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEMONSTERFINISH, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_TeamBattle_NotifyChallengeBossBegin = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyChallengeBossBegin(arg_35_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEBOSSBEGIN, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_TeamBattle_NotifyChallengeBossFinish = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyChallengeBossFinish(arg_36_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYCHALLENGEBOSSFINISH, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_TeamBattle_NotifyKnightShopBuy = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyKnightShopBuy(arg_37_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYKNIGHTSHOPBUY, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_TeamBattle_NotifyBuffShopBuy = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyBuffShopBuy(arg_38_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYBUFFSHOPBUY, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_TeamBattle_NotifyMine = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyMine(arg_39_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYMINE, false, arg_39_1, arg_39_2)
		end
	end,
	on_S2C_TeamBattle_NotifyReborn = function(arg_40_0, arg_40_1, arg_40_2)
		if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyReborn(arg_40_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYREBORN, false, arg_40_1, arg_40_2)
		end
	end,
	on_S2C_TeamBattle_NotifyRecoverHp = function(arg_41_0, arg_41_1, arg_41_2)
		if ProtoHandler:onMsgProcess(arg_41_1, arg_41_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyRecoverHp(arg_41_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYRECOVERHP, false, arg_41_1, arg_41_2)
		end
	end,
	on_S2C_TeamBattle_NotifySelectBuff = function(arg_42_0, arg_42_1, arg_42_2)
		if ProtoHandler:onMsgProcess(arg_42_1, arg_42_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifySelectBuff(arg_42_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSELECTBUFF, false, arg_42_1, arg_42_2)
		end
	end,
	on_S2C_TeamBattle_NotifySelectGame = function(arg_43_0, arg_43_1, arg_43_2)
		if ProtoHandler:onMsgProcess(arg_43_1, arg_43_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifySelectGame(arg_43_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSELECTGAME, false, arg_43_1, arg_43_2)
		end
	end,
	on_S2C_TeamBattle_NotifySelectItem = function(arg_44_0, arg_44_1, arg_44_2)
		if ProtoHandler:onMsgProcess(arg_44_1, arg_44_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifySelectItem(arg_44_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSELECTITEM, false, arg_44_1, arg_44_2)
		end
	end,
	on_S2C_TeamBattle_NoticeActivity = function(arg_45_0, arg_45_1, arg_45_2)
		if ProtoHandler:onMsgProcess(arg_45_1, arg_45_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNoticeActivity(arg_45_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTICEACTIVITY, false, arg_45_1, arg_45_2)
		end
	end,
	on_S2C_TeamBattle_TeamInfo = function(arg_46_0, arg_46_1, arg_46_2)
		if ProtoHandler:onMsgProcess(arg_46_1, arg_46_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleTeamInfo(arg_46_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMINFO, false, arg_46_1, arg_46_2)
		end
	end,
	on_S2C_TeamBattle_TeamList = function(arg_47_0, arg_47_1, arg_47_2)
		if ProtoHandler:onMsgProcess(arg_47_1, arg_47_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleTeamList(arg_47_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMLIST, false, arg_47_1, arg_47_2)
		end
	end,
	on_S2C_TeamBattle_FindTeam = function(arg_48_0, arg_48_1, arg_48_2)
		if ProtoHandler:onMsgProcess(arg_48_1, arg_48_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleFindTeam(arg_48_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_FINDTEAM, false, arg_48_1, arg_48_2)
		end
	end,
	on_S2C_TeamBattle_CreateTeam = function(arg_49_0, arg_49_1, arg_49_2)
		if ProtoHandler:onMsgProcess(arg_49_1, arg_49_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleCreateTeam(arg_49_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_CREATETEAM, false, arg_49_1, arg_49_2)
		end
	end,
	on_S2C_TeamBattle_SetTeam = function(arg_50_0, arg_50_1, arg_50_2)
		if ProtoHandler:onMsgProcess(arg_50_1, arg_50_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleSetTeam(arg_50_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SETTEAM, false, arg_50_1, arg_50_2)
		end
	end,
	on_S2C_TeamBattle_JoinTeam = function(arg_51_0, arg_51_1, arg_51_2)
		if ProtoHandler:onMsgProcess(arg_51_1, arg_51_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleJoinTeam(arg_51_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_JOINTEAM, false, arg_51_1, arg_51_2)
		end
	end,
	on_S2C_TeamBattle_LeaveTeam = function(arg_52_0, arg_52_1, arg_52_2)
		if ProtoHandler:onMsgProcess(arg_52_1, arg_52_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleLeaveTeam(arg_52_2)
			g.core.model.User.chatData:clearChatByChannel(g.core.const.ConstMgr.ChatConst.TEAM_BATTLE)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_LEAVETEAM, false, arg_52_1, arg_52_2)
		end
	end,
	on_S2C_TeamBattle_KickOut = function(arg_53_0, arg_53_1, arg_53_2)
		if ProtoHandler:onMsgProcess(arg_53_1, arg_53_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleKickOut(arg_53_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KICKOUT, false, arg_53_1, arg_53_2)
		end
	end,
	on_S2C_TeamBattle_KickNotice = function(arg_54_0, arg_54_1, arg_54_2)
		if ProtoHandler:onMsgProcess(arg_54_1, arg_54_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleKickNotice(arg_54_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_KICKNOTICE, false, arg_54_1, arg_54_2)
		end
	end,
	on_S2C_TeamBattle_UpdateTeam = function(arg_55_0, arg_55_1, arg_55_2)
		if ProtoHandler:onMsgProcess(arg_55_1, arg_55_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleUpdateTeam(arg_55_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_UPDATETEAM, false, arg_55_1, arg_55_2)
		end
	end,
	on_S2C_TeamBattle_TeamRank = function(arg_56_0, arg_56_1, arg_56_2)
		if ProtoHandler:onMsgProcess(arg_56_1, arg_56_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleTeamRank(arg_56_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMRANK, false, arg_56_1, arg_56_2)
		end
	end,
	on_S2C_TeamBattle_ServerInfos = function(arg_57_0, arg_57_1, arg_57_2)
		if ProtoHandler:onMsgProcess(arg_57_1, arg_57_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleServerInfos(arg_57_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_SERVERINFOS, false, arg_57_1, arg_57_2)
		end
	end,
	on_S2C_TeamBattle_PlayGame = function(arg_58_0, arg_58_1, arg_58_2)
		if ProtoHandler:onMsgProcess(arg_58_1, arg_58_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattlePlayGame(arg_58_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_PLAYGAME, false, arg_58_1, arg_58_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_PLAY_GAME_FAILED, false, arg_58_1, arg_58_2)
		end

		if arg_58_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_NotifyShareAwards = function(arg_59_0, arg_59_1, arg_59_2)
		if ProtoHandler:onMsgProcess(arg_59_1, arg_59_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleNotifyShareAwards(arg_59_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_NOTIFYSHAREAWARDS, false, arg_59_1, arg_59_2)
		end
	end,
	on_S2C_TeamBattle_GetActionAwards = function(arg_60_0, arg_60_1, arg_60_2)
		if ProtoHandler:onMsgProcess(arg_60_1, arg_60_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleGetActionAwards(arg_60_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_GETACTIONAWARDS, false, arg_60_1, arg_60_2)
		end
	end,
	on_S2C_TeamBattle_GetShareAwards = function(arg_61_0, arg_61_1, arg_61_2)
		if ProtoHandler:onMsgProcess(arg_61_1, arg_61_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleGetShareAwards(arg_61_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_GETSHAREAWARDS, false, arg_61_1, arg_61_2)
		end

		if arg_61_2.ret == g.core.network.proto.RET_TEAM_BATTLE_USER_NOT_ENTER then
			g.core.model.User.teamBattleData:setNetBroken(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_NET_ERROR)
		end
	end,
	on_S2C_TeamBattle_GetAbleAwardInfo = function(arg_62_0, arg_62_1, arg_62_2)
		if ProtoHandler:onMsgProcess(arg_62_1, arg_62_2) then
			g.core.model.User.teamBattleData:onS2CTeamBattleGetAbleAwardInfo(arg_62_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_GETABLEAWARDINFO, false, arg_62_1, arg_62_2)
		end
	end
}
