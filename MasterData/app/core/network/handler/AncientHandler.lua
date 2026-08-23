local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Ancient_Enter = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			dump(arg_1_2, "on_S2C_Ancient_Enter")
			g.core.model.User.ancientsData:onRecvEnter(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ENTER, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Ancient_CreateTeam = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.ancientsData:onRecvNotifyTeamChange(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CREATETEAM, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Ancient_ReqJoin = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			if arg_3_2.confirm then
				g.core.module.ModuleManager:tip(g.core.lang:get(433361))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(433362))
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_REQJOIN, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Ancient_QuickJoin = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_QUICKJOIN, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Ancient_Invite = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			dump(arg_5_2, "on_S2C_Ancient_Invite")
			g.core.model.User.ancientsData:onRecvInvite(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_INVITE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Ancient_ConfirmInvite = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CONFIRMINVITE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Ancient_GetInvitationList = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.ancientsData:onRcvInvitationList(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETINVITATIONLIST, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Ancient_QuitTeam = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			dump(arg_8_2, "on_S2C_Ancient_QuitTeam")
			g.core.model.User.ancientsData:onRecvQuitTeam(arg_8_2)
			g.core.model.User.ancientsData:setSelfDiceNum(0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_QUITTEAM, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Ancient_Kick = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			dump(arg_9_2, "on_S2C_Ancient_Kick")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_KICK, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Ancient_Setting = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_SETTING, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Ancient_NotifyTeamChange = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			dump(arg_11_2, "on_S2C_Ancient_NotifyTeamChange")
			g.core.model.User.ancientsData:onRecvNotifyTeamChange(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_Ancient_NotifyBeKick = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			dump(arg_12_2, "on_S2C_Ancient_NotifyBeKick")
			g.core.model.User.ancientsData:onRecvBeKick(arg_12_2)
			g.core.model.User.ancientsData:setSelfDiceNum(0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYBEKICK, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_Ancient_NotifyInvite = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYINVITE, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_Ancient_NotifyDisbandTeam = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYDISBANDTEAM, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_Ancient_GetApplyList = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.ancientsData:onRcvApplyList(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETAPPLYLIST, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_Ancient_ConfirmApply = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.ancientsData:onRcvConfirmApply(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CONFIRMAPPLY, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_Ancient_DeleteApply = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			-- block empty
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DELETEAPPLY, false, arg_17_1, arg_17_2)
	end,
	on_S2C_Ancient_GetApplyRecord = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.model.User.ancientsData:setApplyTeams(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETAPPLYRECORD, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_Ancient_RecommendTeam = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_RECOMMENDTEAM, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_Ancient_GetTeamInfo = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETTEAMINFO, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_Ancient_Search = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_SEARCH, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_Ancient_GetUserList = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			dump(arg_22_2, "on_S2C_Ancient_GetUserList")
			g.core.model.User.ancientsData:onRecvGetUserList(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETUSERLIST, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_Ancient_GetMessageBoard = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			dump(arg_23_2, "on_S2C_Ancient_GetMessageBoard")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETMESSAGEBOARD, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_Ancient_AddMessage = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			dump(arg_24_2, "on_S2C_Ancient_AddMessage")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ADDMESSAGE, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_Ancient_OperateMessage = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			dump(arg_25_2, "on_S2C_Ancient_OperateMessage")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_OPERATEMESSAGE, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_Ancient_OperateStart = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			dump(arg_26_2, "on_S2C_Ancient_OperateStart")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_OPERATESTART, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_Ancient_OperateEnd = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			dump(arg_27_2, "on_S2C_Ancient_OperateEnd")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_OPERATEEND, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_Ancient_OperateNotify = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			dump(arg_28_2, "on_S2C_Ancient_OperateNotify")
			g.core.model.User.ancientsData:onRecvOperateNotify(arg_28_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_OPERATENOTIFY, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_Ancient_Formation = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			dump(arg_29_2, "on_S2C_Ancient_Formation")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FORMATION, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_Ancient_FormationNotify = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			dump(arg_30_2, "on_S2C_Ancient_FormationNotify")
			g.core.model.User.ancientsData:onRecvFormationNotify(arg_30_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FORMATIONNOTIFY, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_Ancient_LootInfo = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			g.core.model.User.ancientsData:setSelfDiceNum(arg_31_2.dice_num)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_LOOTINFO, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_Ancient_DiceRoll = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.model.User.ancientsData:setSelfDiceNum(arg_32_2.dice_num)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICEROLL, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_Ancient_DiceGiveUp = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICEGIVEUP, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_Ancient_DiceNotify = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICENOTIFY, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_Ancient_GetRankList = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETRANKLIST, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_Ancient_Match = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			dump(arg_36_2, "on_S2C_Ancient_Match")
			g.core.model.User.ancientsData:onRecvMatch(arg_36_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_MATCH, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_Ancient_BattleStart = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			dump(arg_37_2, "on_S2C_Ancient_BattleStart")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLESTART, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_Ancient_BattleTurnNotify = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			dump(arg_38_2, "on_S2C_Ancient_BattleTurnNotify")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLETURNNOTIFY, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_Ancient_BattleEndNotify = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			dump(arg_39_2, "on_S2C_Ancient_BattleEndNotify")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLEENDNOTIFY, false, arg_39_1, arg_39_2)
		end
	end,
	on_S2C_Ancient_BattleSpectate = function(arg_40_0, arg_40_1, arg_40_2)
		if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
			dump(arg_40_2, "on_S2C_Ancient_BattleSpectate")
			g.core.model.User.ancientsData:onRecvBattleSpectate(arg_40_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLESPECTATE, false, arg_40_1, arg_40_2)
		end
	end,
	on_S2C_Ancient_BattleReports = function(arg_41_0, arg_41_1, arg_41_2)
		if ProtoHandler:onMsgProcess(arg_41_1, arg_41_2) then
			dump(arg_41_2, "on_S2C_Ancient_BattleReports")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLEREPORTS, false, arg_41_1, arg_41_2)
		end
	end,
	on_S2C_Ancient_PetSetKnight = function(arg_42_0, arg_42_1, arg_42_2)
		dump(arg_42_2, "on_S2C_Ancient_PetSetKnight")

		if ProtoHandler:onMsgProcess(arg_42_1, arg_42_2) then
			g.core.model.User.ancientsData:updatePetData(arg_42_2.pet)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_PETSETKNIGHT, false, arg_42_1, arg_42_2)
		end
	end,
	on_S2C_Ancient_TaskNtf = function(arg_43_0, arg_43_1, arg_43_2)
		dump(arg_43_2, "on_S2C_Ancient_TaskNtf")

		if ProtoHandler:onMsgProcess(arg_43_1, arg_43_2) then
			g.core.model.User.ancientsData:reqTaskNtf(arg_43_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKNTF, false, arg_43_1, arg_43_2)
		end
	end,
	on_S2C_Ancient_TaskAward = function(arg_44_0, arg_44_1, arg_44_2)
		if ProtoHandler:onMsgProcess(arg_44_1, arg_44_2) then
			g.core.model.User.ancientsData:reqGetTaskAwards(arg_44_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TASKAWARD, false, arg_44_1, arg_44_2)
		end
	end,
	on_S2C_Ancient_ActiveAward = function(arg_45_0, arg_45_1, arg_45_2)
		if ProtoHandler:onMsgProcess(arg_45_1, arg_45_2) then
			g.core.model.User.ancientsData:reqGetActiveAwards(arg_45_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ACTIVEAWARD, false, arg_45_1, arg_45_2)
		end
	end,
	on_S2C_Ancient_TeamTaskNtf = function(arg_46_0, arg_46_1, arg_46_2)
		dump(arg_46_2, "on_S2C_Ancient_TeamTaskNtf")

		if ProtoHandler:onMsgProcess(arg_46_1, arg_46_2) then
			g.core.model.User.ancientsData:reqTaskNtf(arg_46_2)
			g.core.model.User.ancientsData:updatePetData(arg_46_2.pet)
			g.core.model.User.ancientsData:updateActiveCount(arg_46_2.active_value)
			g.core.model.User.ancientsData:updateActiveAwardedIds(arg_46_2.active_awarded_ids or {})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_TEAMTASKNTF, false, arg_46_1, arg_46_2)
		end
	end,
	on_S2C_Ancient_BuyFightTimes = function(arg_47_0, arg_47_1, arg_47_2)
		dump(arg_47_2, "on_S2C_Ancient_BuyFightTimes")

		if ProtoHandler:onMsgProcess(arg_47_1, arg_47_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BUYFIGHTTIMES, false, arg_47_1, arg_47_2)
		end
	end,
	on_S2C_Ancient_FightTimesNtf = function(arg_48_0, arg_48_1, arg_48_2)
		dump(arg_48_2, "on_S2C_Ancient_FightTimesNtf")

		if ProtoHandler:onMsgProcess(arg_48_1, arg_48_2) then
			g.core.model.User.ancientsData:onRecvFightTimesNtf(arg_48_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FIGHTTIMESNTF, false, arg_48_1, arg_48_2)
		end
	end,
	on_S2C_Ancient_FinalMatch = function(arg_49_0, arg_49_1, arg_49_2)
		dump(arg_49_2, "on_S2C_Ancient_FinalMatch")

		if ProtoHandler:onMsgProcess(arg_49_1, arg_49_2) then
			g.core.model.User.ancientsData:onRecvFinalMatch(arg_49_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALMATCH, false, arg_49_1, arg_49_2)
		end
	end,
	on_S2C_Ancient_FinalFormation = function(arg_50_0, arg_50_1, arg_50_2)
		if ProtoHandler:onMsgProcess(arg_50_1, arg_50_2) then
			dump(arg_50_2, "on_S2C_Ancient_FinalFormation")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALFORMATION, false, arg_50_1, arg_50_2)
		end
	end,
	on_S2C_Ancient_FinalFormationNotify = function(arg_51_0, arg_51_1, arg_51_2)
		if ProtoHandler:onMsgProcess(arg_51_1, arg_51_2) then
			dump(arg_51_2, "on_S2C_Ancient_FinalFormationNotify")
			g.core.model.User.ancientsData:onRecvFinalFormationNotify(arg_51_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALFORMATIONNOTIFY, false, arg_51_1, arg_51_2)
		end
	end,
	on_S2C_Ancient_FinalBattleReport = function(arg_52_0, arg_52_1, arg_52_2)
		if ProtoHandler:onMsgProcess(arg_52_1, arg_52_2) then
			dump(arg_52_2, "on_S2C_Ancient_FinalBattleReport")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_FINALBATTLEREPORT, false, arg_52_1, arg_52_2)
		end
	end,
	on_S2C_Ancient_GetFinalTeamList = function(arg_53_0, arg_53_1, arg_53_2)
		if ProtoHandler:onMsgProcess(arg_53_1, arg_53_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALTEAMLIST, false, arg_53_1, arg_53_2)
		end
	end,
	on_S2C_Ancient_GetFinalRankList = function(arg_54_0, arg_54_1, arg_54_2)
		if ProtoHandler:onMsgProcess(arg_54_1, arg_54_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALRANKLIST, false, arg_54_1, arg_54_2)
		end
	end,
	on_S2C_Ancient_GuessInfo = function(arg_55_0, arg_55_1, arg_55_2)
		if ProtoHandler:onMsgProcess(arg_55_1, arg_55_2) then
			g.core.model.User.ancientsData:initGuessData(arg_55_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSINFO, false, arg_55_1, arg_55_2)
		end
	end,
	on_S2C_Ancient_RoundNotify = function(arg_56_0, arg_56_1, arg_56_2)
		if ProtoHandler:onMsgProcess(arg_56_1, arg_56_2) then
			g.core.model.User.ancientsData:addGuessData(arg_56_2)
			g.core.model.User.ancientsData:InitRoundTeamsData(arg_56_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY, false, arg_56_1, arg_56_2)
		end
	end,
	on_S2C_Ancient_Guess = function(arg_57_0, arg_57_1, arg_57_2)
		if ProtoHandler:onMsgProcess(arg_57_1, arg_57_2) then
			g.core.model.User.ancientsData:updateGuessData(arg_57_2.guess)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESS, false, arg_57_1, arg_57_2)
		end
	end,
	on_S2C_Ancient_GuessAward = function(arg_58_0, arg_58_1, arg_58_2)
		if ProtoHandler:onMsgProcess(arg_58_1, arg_58_2) then
			g.core.model.User.ancientsData:updateGuessData(arg_58_2.guess)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSAWARD, false, arg_58_1, arg_58_2)
		end
	end,
	on_S2C_Ancient_GetFinalUserList = function(arg_59_0, arg_59_1, arg_59_2)
		if ProtoHandler:onMsgProcess(arg_59_1, arg_59_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALUSERLIST, false, arg_59_1, arg_59_2)
		end
	end,
	on_S2C_Ancient_NotifyMaxMessageId = function(arg_60_0, arg_60_1, arg_60_2)
		if ProtoHandler:onMsgProcess(arg_60_1, arg_60_2) then
			dump(arg_60_2, "on_S2C_Ancient_NotifyMaxMessageId")
			g.core.model.User.ancientsData:onRecvNotifyMaxMessageId(arg_60_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYMAXMESSAGEID, false, arg_60_1, arg_60_2)
		end
	end
}
