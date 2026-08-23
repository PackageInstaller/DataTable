local var_0_0 = g.core.model.User.gveDataMgr
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GVExxxx = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			-- block empty
		end
	end,
	on_S2C_GVE_TaskGetInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:getGveTaskData():updateTaskInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_TASKGETINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GVE_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:getGveTaskData():updateTaskStatus(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GVE_ChapterAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:getGveTaskData():updateChapterStatus(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_CHAPTERAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GVE_WorldEnter = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:getGveData():updateWorldPointInfo(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDENTER, false, arg_5_1, arg_5_2)
		end

		if arg_5_2.is_first then
			var_0_0:getGveData():getIdleReward()
		end
	end,
	on_S2C_GVE_WorldMove = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_0:getGveData():onGveWorldMove(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDMOVE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GVE_WorldDataNotify = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_0:getGveData():onWorldDataNotify(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDDATANOTIFY, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GVE_WorldKeepAlive = function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_2.ret == g.core.network.proto.RET_GVE_KEEP_ALIVE_FAIL then
			g.core.network.GameNetProxy:send_C2S_GVE_WorldEnter({})

			return
		end

		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			-- block empty
		end
	end,
	on_S2C_GVE_WorldCellDetail = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_0:onWorldCellDetail(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCELLDETAIL, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_GVE_WorldChallengeBegin = function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_2.ret == g.core.network.proto.RET_GVE_CELL_CANNOT_CHALLENGE then
			g.core.network.GameNetProxy:send_C2S_GVE_WorldEnter({})
		end

		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_0:getGveFormationData():onS2CBattleBegin(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCHALLENGEBEGIN, false, arg_10_1, arg_10_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_CHALLENGE_BEGIN_ERROR, false, arg_10_1, {})
		end
	end,
	on_S2C_GVE_WorldGiveupCell = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_0:getGveData():onGiveUpGrid(arg_11_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDGIVEUPCELL, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_GVE_WorldCancalGiveupCell = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			var_0_0:getGveData():onCancelGiveUpGrid(arg_12_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCANCALGIVEUPCELL, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_GVE_WorldSetCellKnight = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			var_0_0:getGveData():onSetCellKnight(arg_13_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSETCELLKNIGHT, false, arg_13_1, arg_13_2)
		end
	end,
	on_S2C_GVE_WorldTimeAward = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDTIMEAWARD, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_GVE_GetInfo = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_0:onS2CGVEGetInfo(arg_15_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETINFO, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_GVE_NoticeActivity = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_0:onS2CGVEGetInfo(arg_16_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_NOTICEACTIVITY, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_GVE_SignUp = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_0:onS2CGVESignUpSuccess()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_SIGNUP, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_GVE_TeamModify = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_0:onS2CGVETeamModify(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_TEAMMODIFY, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_GVE_TeamInfo = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			var_0_0:onS2CGetGVETeamInfo(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_TEAMINFO, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_GVE_UserList = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			var_0_0:onS2CGetGVEUserList(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_USERLIST, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_GVE_GuildList = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			var_0_0:onS2CGetGVEGuildList(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GUILDLIST, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_GVE_TeamRankList = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			var_0_0:onS2CGVETeamRankList(arg_22_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETWORLDGUILD, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_GVE_GetBossAward = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			var_0_0:getAwardHonor(arg_23_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSAWARD, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_GVE_WorldUserDataFlush = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			var_0_0:onS2CGVEUserDataFlush(arg_24_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_GVE_WorldSelectKnight = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			var_0_0:onS2CGVESelectedKnight(arg_25_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSELECTKNIGHT, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_GVE_WorldActionNotify = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			var_0_0:getGveFormationData():onS2CKnightActionNotify(arg_26_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDACTIONNOTIFY, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_GVE_BossGetInfo = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			var_0_0:getGveData():onS2CGetBossInfo(arg_27_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSGETINFO, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_GVE_ChallengeBossBegin = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			var_0_0:getGveData():onS2CChallengeBossEnd(arg_28_2)
			var_0_0:getGveFormationData():updateKnightAction(arg_28_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_CHALLENGEBOSSBEGIN, false, arg_28_1, arg_28_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_CHALLENGE_BEGIN_ERROR, false, arg_28_1, {})
		end
	end,
	on_S2C_GVE_GetAllBossIsDead = function(arg_29_0, arg_29_1, arg_29_2)
		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			var_0_0:getGveData():onS2CAllBossIsDead(arg_29_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLBOSSISDEAD, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_GVE_BossNotifyDead = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			var_0_0:getGveData():onS2CBossNotify(arg_30_2)
			var_0_0:onUpdateBossDeadState(arg_30_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_BOSSNOTIFYDEAD, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_GVE_GetBossRank = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			if arg_31_2.rank_type == g.core.const.ConstMgr.GveConst.GVE_RANK_TYPE.BOSS9_ALLIANCE_TOTAL_DAMAGE then
				var_0_0:setLastBossDamageDataList(arg_31_2)
			elseif arg_31_2.rank_type == g.core.const.ConstMgr.GveConst.GVE_RANK_TYPE.ALLIANCE_TOTAL_DAMAGE then
				var_0_0:onSeasonRankDataBack(arg_31_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSRANK, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_GVE_GetAllRandomBossInfo = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLRANDOMBOSSINFO, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_GVE_Halidom_GetInfo = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			var_0_0:getGveBagData():updateInfo(arg_33_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_GETINFO, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_GVE_Halidom_Merge = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			var_0_0:getGveBagData():onS2CHalidomMergeSuccess(arg_34_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_GVE_Halidom_FastDecomposition = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			var_0_0:getGveBagData():onS2CFastDecompose(arg_35_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_GVE_Halidom_LevelUp = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			var_0_0:getGveBagData():onS2CLevelUp(arg_36_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_GVE_Halidom_SwitchJob = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			var_0_0:getGveBagData():onS2CSwitchJob(arg_37_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_SWITCHJOB, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_GVE_Halidom_Equip = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			var_0_0:getGveBagData():onS2CEquip(arg_38_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_GVE_Halidom_Decomposition = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			var_0_0:getGveBagData():onS2CDecompose(arg_39_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION, false, arg_39_1, arg_39_2)
		end
	end,
	on_S2C_GVE_Halidom_UserList = function(arg_40_0, arg_40_1, arg_40_2)
		if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
			var_0_0:onAllUserData(arg_40_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_USERLIST, false, arg_40_1, arg_40_2)
		end
	end,
	on_S2C_GVE_GetBossFirstKill = function(arg_41_0, arg_41_1, arg_41_2)
		if ProtoHandler:onMsgProcess(arg_41_1, arg_41_2) then
			var_0_0:onS2CGVEHonorRankList(arg_41_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSFIRSTKILL, false, arg_41_1, arg_41_2)
		end
	end,
	on_S2C_GVE_SyncRandomBossInfo = function(arg_42_0, arg_42_1, arg_42_2)
		if ProtoHandler:onMsgProcess(arg_42_1, arg_42_2) then
			var_0_0:getGveData():onRandBossInfoSync(arg_42_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_SYNCRANDOMBOSSINFO, false, arg_42_1, arg_42_2)
		end
	end,
	on_S2C_GVE_GetResearchInfo = function(arg_43_0, arg_43_1, arg_43_2)
		if ProtoHandler:onMsgProcess(arg_43_1, arg_43_2) then
			var_0_0:getGveInstituteData():onGetResearchData(arg_43_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETRESEARCHINFO, false, arg_43_1, arg_43_2)
		end
	end,
	on_S2C_GVE_ResearchMission = function(arg_44_0, arg_44_1, arg_44_2)
		if ProtoHandler:onMsgProcess(arg_44_1, arg_44_2) then
			var_0_0:getGveInstituteData():onResearchMission(arg_44_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHMISSION, false, arg_44_1, arg_44_2)
		end
	end,
	on_S2C_GVE_ResearchAward = function(arg_45_0, arg_45_1, arg_45_2)
		if ProtoHandler:onMsgProcess(arg_45_1, arg_45_2) then
			var_0_0:getGveInstituteData():onResearchAward(arg_45_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHAWARD, false, arg_45_1, arg_45_2)
		end
	end,
	on_S2C_GVE_ResearchRankList = function(arg_46_0, arg_46_1, arg_46_2)
		if ProtoHandler:onMsgProcess(arg_46_1, arg_46_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHRANKLIST, false, arg_46_1, arg_46_2)
		end
	end,
	on_S2C_GVE_GetLastBossDamage = function(arg_47_0, arg_47_1, arg_47_2)
		if ProtoHandler:onMsgProcess(arg_47_1, arg_47_2) then
			var_0_0:setLastBossDamageDataList(arg_47_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_G_VE_GETLASTBOSSDAMAGE, false, arg_47_1, arg_47_2)
		end
	end
}
