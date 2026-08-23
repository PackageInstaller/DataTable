local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_NewSlg_Enter = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.newSlgData:enterSlg(arg_1_2)
			g.core.model.User.newSlgSkillTreeData:updateWithServerData(arg_1_2.technology)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_NewSlg_NotifyActInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.act_info and arg_2_2.act_info.sub_id and arg_2_2.act_info.sub_id > 0 then
				g.core.model.User.newSlgData:setActInfo(arg_2_2.act_info.sub_id)
			end

			g.core.model.User.newSlgData:updateRedData(arg_2_2)
		end
	end,
	on_S2C_NewSlg_GetMonsterInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.newSlgData:setMonsterData(arg_3_2.monster)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETMONSTERINFO, false, arg_3_1, arg_3_2.monster)
		end
	end,
	on_S2C_NewSlg_MonsterMarch = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.newSlgData:onRecvMonsterMarch(arg_4_2.move)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERMARCH, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_NewSlg_MonsterMarchCancel = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			-- block empty
		end
	end,
	on_S2C_NewSlg_GetMapShowData = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			if arg_6_2.user_show then
				g.core.model.User.newSlgData:updateUsersData(arg_6_2.user_show)
			end

			g.core.model.User.newSlgData:updateCitySerData(arg_6_2.city_show)
			g.core.model.User.newSlgData:updateFarmSerData(arg_6_2.farm_map_shows)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETMAPSHOWDATA, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_NewSlg_NotifyMapShow = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) and arg_7_2.user_show then
			g.core.model.User.newSlgData:notifyUsersData(arg_7_2.user_show)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYMAPSHOW, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_NewSlg_MoveHome = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.model.User.newSlgData:onRecvMoveHome(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVEHOME, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_NewSlg_MoveHomeAllianceProvince = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.model.User.newSlgData:onRecvMoveHomeToBornProvince(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVEHOME, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_NewSlg_NotifyMoveUnit = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) and arg_10_2.move then
			g.core.model.User.newSlgData:notifyMarchRoute(arg_10_2.move)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYMOVEUNIT, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_NewSlg_SyncUserScore = function(arg_11_0, arg_11_1, arg_11_2)
		return
	end,
	on_S2C_NewSlg_SyncUserBase = function(arg_12_0, arg_12_1, arg_12_2)
		if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
			g.core.model.User.newSlgData:updateBaseData(arg_12_2.user_base)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERBASE, false, arg_12_1, arg_12_2)
		end
	end,
	on_S2C_NewSlg_Leave = function(arg_13_0, arg_13_1, arg_13_2)
		if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
			-- block empty
		end
	end,
	on_S2C_NewSlg_EditUserTeam = function(arg_14_0, arg_14_1, arg_14_2)
		if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_EDITUSERTEAM, false, arg_14_1, arg_14_2)
		end
	end,
	on_S2C_NewSlg_SyncUserTeam = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			g.core.model.User.newSlgData:updateMyTeamData(arg_15_2.teams)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERTEAM, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_NewSlg_MonsterBattleReport = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			g.core.model.User.newSlgData:updateBattleMonsterReport(arg_16_2)
			g.core.model.User.newSlgData:recordBattleReport(g.core.common.ServerTime:getTime())
			g.core.model.User.newSlgData:oneNewBattleEnd()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MONSTERBATTLEREPORT, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_NewSlg_NotifyMonsterBattleResult = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			g.core.model.User.newSlgData:setMonsterData(arg_17_2.monster)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYMONSTERBATTLERESULT, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_NewSlg_UpgradeMainCity = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			g.core.model.User.newSlgDevelopData:updateUpgradeMainCityData(arg_18_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEMAINCITY, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_NewSlg_StationMainCity = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			g.core.model.User.newSlgDevelopData:updateEmbryoLineUpData(arg_19_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_STATIONMAINCITY, false, arg_19_1, arg_19_2)

			local var_19_0 = g.core.model.User.newSlgData:getFightValueChange()

			if var_19_0 > 0 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
					slgFightValueChange = var_19_0
				})
			end
		end
	end,
	on_S2C_NewSlg_UpgradeBarrack = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			g.core.model.User.newSlgDevelopData:updateUpgradeBarrackData(arg_20_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADEBARRACK, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_NewSlg_UpgradeSupply = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			g.core.model.User.newSlgDevelopData:updateUpgradeSupplyData(arg_21_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_UPGRADESUPPLY, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_NewSlg_ObtainSupplyAward = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			g.core.model.User.newSlgDevelopData:updateUpgradeSupplyData({
				supply = arg_22_2.supply
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINSUPPLYAWARD, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_NewSlg_UseSupplyToken = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USESUPPLYTOKEN, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_NewSlg_CityMarch = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			g.core.model.User.newSlgData.gatherCityRedPoint = true

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYMARCH, false, arg_24_1, arg_24_2)
		end
	end,
	on_S2C_NewSlg_CityCancelMove = function(arg_25_0, arg_25_1, arg_25_2)
		if ProtoHandler:onMsgProcess(arg_25_1, arg_25_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYCANCELMOVE, false, arg_25_1, arg_25_2)
		end
	end,
	on_S2C_NewSlg_GetCityGather = function(arg_26_0, arg_26_1, arg_26_2)
		if ProtoHandler:onMsgProcess(arg_26_1, arg_26_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYGATHER, false, arg_26_1, arg_26_2)
		end
	end,
	on_S2C_NewSlg_GetCityDefInfo = function(arg_27_0, arg_27_1, arg_27_2)
		if ProtoHandler:onMsgProcess(arg_27_1, arg_27_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYDEFINFO, false, arg_27_1, arg_27_2)
		end
	end,
	on_S2C_NewSlg_GetPreDayInfo = function(arg_28_0, arg_28_1, arg_28_2)
		if ProtoHandler:onMsgProcess(arg_28_1, arg_28_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETPREDAYINFO, false, arg_28_1, arg_28_2)
		end
	end,
	on_S2C_NewSlg_CityNtf = function(arg_29_0, arg_29_1, arg_29_2)
		dump(arg_29_2, "on_S2C_NewSlg_CityNtf")

		if ProtoHandler:onMsgProcess(arg_29_1, arg_29_2) then
			g.core.model.User.newSlgData:updateCitySerData(arg_29_2.city_show)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYNTF, false, arg_29_1, arg_29_2)
		end
	end,
	on_S2C_NewSlg_CityBattleEnd = function(arg_30_0, arg_30_1, arg_30_2)
		if ProtoHandler:onMsgProcess(arg_30_1, arg_30_2) then
			g.core.model.User.newSlgData:reqCityBattleEnd(arg_30_2)
			g.core.model.User.newSlgData:_deleteDeclareCity(arg_30_2.city_show)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYBATTLEEND, false, arg_30_1, arg_30_2)
		end
	end,
	on_S2C_NewSlg_GetRank = function(arg_31_0, arg_31_1, arg_31_2)
		if ProtoHandler:onMsgProcess(arg_31_1, arg_31_2) then
			g.core.model.User.newSlgData:setRankData(arg_31_2.id, arg_31_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, false, arg_31_1, arg_31_2)
		end
	end,
	on_S2C_NewSlg_BossCreateTeam = function(arg_32_0, arg_32_1, arg_32_2)
		if ProtoHandler:onMsgProcess(arg_32_1, arg_32_2) then
			g.core.model.User.newSlgData:updateBossTeamsInfoSerData({
				arg_32_2.team
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSCREATETEAM, false, arg_32_1, arg_32_2)
		end
	end,
	on_S2C_NewSlg_BossJoinTeam = function(arg_33_0, arg_33_1, arg_33_2)
		if ProtoHandler:onMsgProcess(arg_33_1, arg_33_2) then
			g.core.model.User.newSlgData:updateBossTeamsInfoSerData({
				arg_33_2.team
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSJOINTEAM, false, arg_33_1, arg_33_2)
		end
	end,
	on_S2C_NewSlg_BossTeamKickOut = function(arg_34_0, arg_34_1, arg_34_2)
		if ProtoHandler:onMsgProcess(arg_34_1, arg_34_2) then
			g.core.model.User.newSlgData:reqBossTeamKickOut(arg_34_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMKICKOUT, false, arg_34_1, arg_34_2)
		end
	end,
	on_S2C_NewSlg_BossTransferLeader = function(arg_35_0, arg_35_1, arg_35_2)
		if ProtoHandler:onMsgProcess(arg_35_1, arg_35_2) then
			g.core.model.User.newSlgData:reqBossTeamTransferLeader(arg_35_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTRANSFERLEADER, false, arg_35_1, arg_35_2)
		end
	end,
	on_S2C_NewSlg_BossLeave = function(arg_36_0, arg_36_1, arg_36_2)
		if ProtoHandler:onMsgProcess(arg_36_1, arg_36_2) then
			g.core.model.User.newSlgData:reqBossTeamLeave(arg_36_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSLEAVE, false, arg_36_1, arg_36_2)
		end
	end,
	on_S2C_NewSlg_BossTeamList = function(arg_37_0, arg_37_1, arg_37_2)
		if ProtoHandler:onMsgProcess(arg_37_1, arg_37_2) then
			g.core.model.User.newSlgData:updateBossTeamsInfoSerData(arg_37_2.teams)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMLIST, false, arg_37_1, arg_37_2)
		end
	end,
	on_S2C_NewSlg_BossTeamInfo = function(arg_38_0, arg_38_1, arg_38_2)
		if ProtoHandler:onMsgProcess(arg_38_1, arg_38_2) then
			g.core.model.User.newSlgData:reqBossTeamInfoDeal(arg_38_2.teams)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMINFO, false, arg_38_1, arg_38_2)
		end
	end,
	on_S2C_NewSlg_BossUserStateNotify = function(arg_39_0, arg_39_1, arg_39_2)
		if ProtoHandler:onMsgProcess(arg_39_1, arg_39_2) then
			g.core.model.User.newSlgData:reqBossUserStateNotify(arg_39_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSUSERSTATENOTIFY, false, arg_39_1, arg_39_2)
		end
	end,
	on_S2C_NewSlg_BossTeamJoinNotify = function(arg_40_0, arg_40_1, arg_40_2)
		if ProtoHandler:onMsgProcess(arg_40_1, arg_40_2) then
			g.core.model.User.newSlgData:reqBossTeamJoinNotify(arg_40_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMJOINNOTIFY, false, arg_40_1, arg_40_2)
		end
	end,
	on_S2C_NewSlg_BossDismissTeam = function(arg_41_0, arg_41_1, arg_41_2)
		if ProtoHandler:onMsgProcess(arg_41_1, arg_41_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSDISMISSTEAM, false, arg_41_1, arg_41_2)
		end
	end,
	on_S2C_NewSlg_BossBattleStartNotify = function(arg_42_0, arg_42_1, arg_42_2)
		if ProtoHandler:onMsgProcess(arg_42_1, arg_42_2) then
			g.core.model.User.newSlgData:reqBossBattleStartNotify(arg_42_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLESTARTNOTIFY, false, arg_42_1, arg_42_2)
		end
	end,
	on_S2C_NewSlg_BossBattleFinishNotify = function(arg_43_0, arg_43_1, arg_43_2)
		if ProtoHandler:onMsgProcess(arg_43_1, arg_43_2) then
			g.core.model.User.newSlgData:reqBossBattleFinishNotify(arg_43_2)
			g.core.model.User.newSlgData:recordBattleReport(g.core.common.ServerTime:getTime())
			g.core.model.User.newSlgData:oneNewBattleEnd()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLEFINISHNOTIFY, false, arg_43_1, arg_43_2)
		end
	end,
	on_S2C_NewSlg_BossQuickJoinTeam = function(arg_44_0, arg_44_1, arg_44_2)
		if ProtoHandler:onMsgProcess(arg_44_1, arg_44_2) then
			g.core.model.User.newSlgData:updateBossTeamsInfoSerData({
				arg_44_2.team
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSQUICKJOINTEAM, false, arg_44_1, arg_44_2)
		end
	end,
	on_S2C_NewSlg_BossMonsterTeam = function(arg_45_0, arg_45_1, arg_45_2)
		if ProtoHandler:onMsgProcess(arg_45_1, arg_45_2) then
			g.core.model.User.newSlgData:reqBossAuthority(arg_45_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSMONSTERTEAM, false, arg_45_1, arg_45_2)
		end
	end,
	on_S2C_NewSlg_NotifyCheckpointQuest = function(arg_46_0, arg_46_1, arg_46_2)
		if ProtoHandler:onMsgProcess(arg_46_1, arg_46_2) then
			g.core.model.User.newSlgData:updateCheckPointTask(arg_46_2.checkpoint_quests or {})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYCHECKPOINTQUEST, false, arg_46_1, arg_46_2)
		end
	end,
	on_S2C_NewSlg_SyncCityQuestProgress = function(arg_47_0, arg_47_1, arg_47_2)
		if ProtoHandler:onMsgProcess(arg_47_1, arg_47_2) then
			g.core.model.User.newSlgData:updateCityQuestProgressSerData(arg_47_2.city_progress or {})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS, false, arg_47_1, arg_47_2)
		end
	end,
	on_S2C_NewSlg_SyncMainQuestProgress = function(arg_48_0, arg_48_1, arg_48_2)
		if ProtoHandler:onMsgProcess(arg_48_1, arg_48_2) then
			g.core.model.User.newSlgData:updateUnitMainQuest(arg_48_2.main_quest)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCMAINQUESTPROGRESS, false, arg_48_1, arg_48_2)
		end
	end,
	on_S2C_NewSlg_CityQuestAward = function(arg_49_0, arg_49_1, arg_49_2)
		if ProtoHandler:onMsgProcess(arg_49_1, arg_49_2) then
			g.core.model.User.newSlgData:updateCityQuestAwarded(arg_49_2.ids or {})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYQUESTAWARD, false, arg_49_1, arg_49_2)
		end
	end,
	on_S2C_NewSlg_MainQuestAward = function(arg_50_0, arg_50_1, arg_50_2)
		if ProtoHandler:onMsgProcess(arg_50_1, arg_50_2) then
			g.core.model.User.newSlgData:updateMainQuestDataById(arg_50_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MAINQUESTAWARD, false, arg_50_1, arg_50_2)
		end
	end,
	on_S2C_NewSlg_ObtainBattleReward = function(arg_51_0, arg_51_1, arg_51_2)
		if ProtoHandler:onMsgProcess(arg_51_1, arg_51_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINBATTLEREWARD, false, arg_51_1, arg_51_2)
		end
	end,
	on_S2C_NewSlg_FlushBattleResults = function(arg_52_0, arg_52_1, arg_52_2)
		if ProtoHandler:onMsgProcess(arg_52_1, arg_52_2) then
			if arg_52_2.cities and #arg_52_2.cities > 0 then
				local var_52_0 = {
					cities = arg_52_2.cities
				}

				var_52_0.score = arg_52_2.score or 0

				g.core.model.User.newSlgData:setCityResultServerData(var_52_0)
			else
				g.core.model.User.newSlgData:setCityResultServerData(nil)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FLUSHBATTLERESULTS, false, arg_52_1, arg_52_2)
		end
	end,
	on_S2C_NewSlg_GetUserDetail = function(arg_53_0, arg_53_1, arg_53_2)
		if ProtoHandler:onMsgProcess(arg_53_1, arg_53_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERDETAIL, false, arg_53_1, arg_53_2)
		end
	end,
	on_S2C_NewSlg_GetMatchServer = function(arg_54_0, arg_54_1, arg_54_2)
		if ProtoHandler:onMsgProcess(arg_54_1, arg_54_2) then
			g.core.model.User.newSlgData:onS2CGetServerInfo(arg_54_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETMATCHSERVER, false, arg_54_1, arg_54_2)
		end
	end,
	on_S2C_NewSlg_GetReport = function(arg_55_0, arg_55_1, arg_55_2)
		if ProtoHandler:onMsgProcess(arg_55_1, arg_55_2) then
			g.core.model.User.newSlgData:onS2CNewSlgGetReport(arg_55_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETREPORT, false, arg_55_1, arg_55_2)
		end
	end,
	on_S2C_NewSlg_GetReportList = function(arg_56_0, arg_56_1, arg_56_2)
		if ProtoHandler:onMsgProcess(arg_56_1, arg_56_2) then
			g.core.model.User.newSlgData:onS2CNewSlgGetReportList(arg_56_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETREPORTLIST, false, arg_56_1, arg_56_2)
		end
	end,
	on_S2C_NewSlg_ObtainPreviewRewards = function(arg_57_0, arg_57_1, arg_57_2)
		if ProtoHandler:onMsgProcess(arg_57_1, arg_57_2) then
			g.core.model.User.newSlgData:setIsGotPreviewReward(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINPREVIEWREWARDS, false, arg_57_1, arg_57_2)
		end
	end,
	on_S2C_NewSlg_GetUserShowRankStatistic = function(arg_58_0, arg_58_1, arg_58_2)
		if ProtoHandler:onMsgProcess(arg_58_1, arg_58_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWRANKSTATISTIC, false, arg_58_1, arg_58_2)
		end
	end,
	on_S2C_NewSlg_GetMainCityInfo = function(arg_59_0, arg_59_1, arg_59_2)
		if ProtoHandler:onMsgProcess(arg_59_1, arg_59_2) then
			g.core.model.User.newSlgDevelopData:updateMainCityData(arg_59_2.main_city)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETMAINCITYINFO, false, arg_59_1, arg_59_2)
		end
	end,
	on_S2C_NewSlg_GetUserShowStatistic = function(arg_60_0, arg_60_1, arg_60_2)
		if ProtoHandler:onMsgProcess(arg_60_1, arg_60_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERSHOWSTATISTIC, false, arg_60_1, arg_60_2)
		end
	end,
	on_S2C_NewSlg_MoveTargetRightNow = function(arg_61_0, arg_61_1, arg_61_2)
		if ProtoHandler:onMsgProcess(arg_61_1, arg_61_2) then
			g.core.model.User.newSlgData:updateMoveTargetRightNow(arg_61_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVETARGETRIGHTNOW, false, arg_61_1, arg_61_2)
		end
	end,
	on_S2C_NewSlg_CityDeclare = function(arg_62_0, arg_62_1, arg_62_2)
		if ProtoHandler:onMsgProcess(arg_62_1, arg_62_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYDECLARE, false, arg_62_1, arg_62_2)
		end
	end,
	on_S2C_NewSlg_CityDeclareNtf = function(arg_63_0, arg_63_1, arg_63_2)
		if ProtoHandler:onMsgProcess(arg_63_1, arg_63_2) then
			if arg_63_2.alli_id == g.core.model.User.allianceData:getAllianceId() then
				g.core.model.User.newSlgData:updateSelfDeclareCities(arg_63_2.cities)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, false, arg_63_1, arg_63_2)
		end
	end,
	on_S2C_NewSlg_CityBeDeclaredNtf = function(arg_64_0, arg_64_1, arg_64_2)
		if ProtoHandler:onMsgProcess(arg_64_1, arg_64_2) then
			g.core.model.User.newSlgData:updateCityDeclaredAlliance(arg_64_2.city_be_declared)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF, false, arg_64_1, arg_64_2)
		end
	end,
	on_S2C_NewSlg_CityMarchNtf = function(arg_65_0, arg_65_1, arg_65_2)
		if ProtoHandler:onMsgProcess(arg_65_1, arg_65_2) then
			g.core.model.User.newSlgData:updateCityGatherNum({
				{
					id = arg_65_2.city_id,
					num = arg_65_2.num
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYMARCHNTF, false, arg_65_1, arg_65_2)
		end
	end,
	on_S2C_NewSlg_BuildCity = function(arg_66_0, arg_66_1, arg_66_2)
		if ProtoHandler:onMsgProcess(arg_66_1, arg_66_2) then
			g.core.model.User.newSlgData:updateBuildData(arg_66_2.build, arg_66_2.city_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BUILDCITY, false, arg_66_1, arg_66_2)
		end
	end,
	on_S2C_NewSlg_GetCityBuildInfo = function(arg_67_0, arg_67_1, arg_67_2)
		if ProtoHandler:onMsgProcess(arg_67_1, arg_67_2) then
			g.core.model.User.newSlgData:updateBuildData(arg_67_2.build, arg_67_2.city_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYBUILDINFO, false, arg_67_1, arg_67_2)
		end
	end,
	on_S2C_NewSlg_CityBattleAlliSummaryNtf = function(arg_68_0, arg_68_1, arg_68_2)
		if ProtoHandler:onMsgProcess(arg_68_1, arg_68_2) then
			g.core.model.User.newSlgData:setCityResultServerData(arg_68_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYBATTLEALLISUMMARYNTF, false, arg_68_1, arg_68_2)
		end
	end,
	on_S2C_NewSlg_GetInfoOnCityBattleEnd = function(arg_69_0, arg_69_1, arg_69_2)
		dump(arg_69_2, "on_S2C_NewSlg_GetInfoOnCityBattleEnd")

		if ProtoHandler:onMsgProcess(arg_69_1, arg_69_2) then
			g.core.model.User.newSlgData:updateCityOccupierId(arg_69_2.city_occupier, true)
			g.core.model.User.newSlgData:setScoreAddition(arg_69_2.score_addition)
			g.core.model.User.newSlgData:updateResAddition(arg_69_2.res_addition, true)
			g.core.model.User.newSlgData:setGiveUpCities(arg_69_2.give_up_city_ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETINFOONCITYBATTLEEND, false, arg_69_1, arg_69_2)
		end
	end,
	on_S2C_NewSlg_SetCityDeclaration = function(arg_70_0, arg_70_1, arg_70_2)
		if ProtoHandler:onMsgProcess(arg_70_1, arg_70_2) then
			g.core.model.User.newSlgData:setCityDeclaration(arg_70_2.city_id, arg_70_2.declaration)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SETCITYDECLARATION, false, arg_70_1, arg_70_2)
		end
	end,
	on_S2C_NewSlg_GetCityShowData = function(arg_71_0, arg_71_1, arg_71_2)
		if ProtoHandler:onMsgProcess(arg_71_1, arg_71_2) then
			g.core.model.User.newSlgData:updateCitySimpleData(arg_71_2.shows)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYSHOWDATA, false, arg_71_1, arg_71_2)
		end
	end,
	on_S2C_NewSlg_ObtainQuestReward = function(arg_72_0, arg_72_1, arg_72_2)
		if ProtoHandler:onMsgProcess(arg_72_1, arg_72_2) then
			g.core.model.User.newSlgData:reqObtainAchievementReward({
				arg_72_2.id
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINQUESTREWARD, false, arg_72_1, arg_72_2)
		end
	end,
	on_S2C_NewSlg_OnekeyObtainRewards = function(arg_73_0, arg_73_1, arg_73_2)
		if ProtoHandler:onMsgProcess(arg_73_1, arg_73_2) then
			g.core.model.User.newSlgData:reqObtainAchievementReward(arg_73_2.ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ONEKEYOBTAINREWARDS, false, arg_73_1, arg_73_2)
		end
	end,
	on_S2C_NewSlg_UserAchievementNtf = function(arg_74_0, arg_74_1, arg_74_2)
		if ProtoHandler:onMsgProcess(arg_74_1, arg_74_2) then
			g.core.model.User.newSlgData:updateAchievementSelfTaskData(arg_74_2.achievements)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USERACHIEVEMENTNTF, false, arg_74_1, arg_74_2)
		end
	end,
	on_S2C_NewSlg_AssistCity = function(arg_75_0, arg_75_1, arg_75_2)
		if ProtoHandler:onMsgProcess(arg_75_1, arg_75_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ASSISTCITY, false, arg_75_1, arg_75_2)
		end
	end,
	on_S2C_NewSlg_AssistCityNtf = function(arg_76_0, arg_76_1, arg_76_2)
		if ProtoHandler:onMsgProcess(arg_76_1, arg_76_2) then
			g.core.model.User.newSlgData:setAssistCities(arg_76_2.assist_city_authority)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ASSISTCITYNTF, false, arg_76_1, arg_76_2)
		end
	end,
	on_S2C_NewSlg_CityOccupierNtf = function(arg_77_0, arg_77_1, arg_77_2)
		if ProtoHandler:onMsgProcess(arg_77_1, arg_77_2) then
			g.core.model.User.newSlgData:updateCityOccupierId(arg_77_2.city_occupier, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYOCCUPIERNTF, false, arg_77_1, arg_77_2)
		end
	end,
	on_S2C_NewSlg_DeleteMoveUnit = function(arg_78_0, arg_78_1, arg_78_2)
		if ProtoHandler:onMsgProcess(arg_78_1, arg_78_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_DELETEMOVEUNIT, false, arg_78_1, arg_78_2)
		end
	end,
	on_S2C_NewSlg_GetSmallMapInfo = function(arg_79_0, arg_79_1, arg_79_2)
		if ProtoHandler:onMsgProcess(arg_79_1, arg_79_2) then
			g.core.model.User.newSlgData:setCityDeclarations(arg_79_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETSMALLMAPINFO, false, arg_79_1, arg_79_2)
		end
	end,
	on_S2C_NewSlg_FarmMarch = function(arg_80_0, arg_80_1, arg_80_2)
		if ProtoHandler:onMsgProcess(arg_80_1, arg_80_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMMARCH, false, arg_80_1, arg_80_2)
		end
	end,
	on_S2C_NewSlg_FarmCancelMove = function(arg_81_0, arg_81_1, arg_81_2)
		if ProtoHandler:onMsgProcess(arg_81_1, arg_81_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMCANCELMOVE, false, arg_81_1, arg_81_2)
		end
	end,
	on_S2C_NewSlg_FarmMapShowNtf = function(arg_82_0, arg_82_1, arg_82_2)
		dump(arg_82_2, "on_S2C_NewSlg_FarmMapShowNtf")

		if ProtoHandler:onMsgProcess(arg_82_1, arg_82_2) then
			g.core.model.User.newSlgData:updateFarmUnitSerData(arg_82_2.farm_map_shows)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMMAPSHOWNTF, false, arg_82_1, arg_82_2)
		end
	end,
	on_S2C_NewSlg_FarmBattleReport = function(arg_83_0, arg_83_1, arg_83_2)
		if ProtoHandler:onMsgProcess(arg_83_1, arg_83_2) then
			g.core.model.User.newSlgData:updateBattleFarmReport(arg_83_2)
			g.core.model.User.newSlgData:recordBattleReport(g.core.common.ServerTime:getTime())
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMBATTLEREPORT, false, arg_83_1, arg_83_2)
		end
	end,
	on_S2C_NewSlg_FarmGiveUp = function(arg_84_0, arg_84_1, arg_84_2)
		if ProtoHandler:onMsgProcess(arg_84_1, arg_84_2) then
			g.core.model.User.newSlgData:updateFarmUnitQuit(arg_84_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMGIVEUP, false, arg_84_1, arg_84_2)
		end
	end,
	on_S2C_NewSlg_GetFarmDefInfo = function(arg_85_0, arg_85_1, arg_85_2)
		if ProtoHandler:onMsgProcess(arg_85_1, arg_85_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMDEFINFO, false, arg_85_1, arg_85_2)
		end
	end,
	on_S2C_NewSlg_GetFarmBattleInfo = function(arg_86_0, arg_86_1, arg_86_2)
		if ProtoHandler:onMsgProcess(arg_86_1, arg_86_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMBATTLEINFO, false, arg_86_1, arg_86_2)
		end
	end,
	on_S2C_NewSlg_FarmAward = function(arg_87_0, arg_87_1, arg_87_2)
		if ProtoHandler:onMsgProcess(arg_87_1, arg_87_2) then
			g.core.model.User.newSlgData:updateFarmAward(arg_87_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMAWARD, false, arg_87_1, arg_87_2)
		end
	end,
	on_S2C_NewSlg_GetUserFarmInfo = function(arg_88_0, arg_88_1, arg_88_2)
		if ProtoHandler:onMsgProcess(arg_88_1, arg_88_2) then
			g.core.model.User.newSlgData:updateFarmAward(arg_88_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETUSERFARMINFO, false, arg_88_1, arg_88_2)
		end
	end,
	on_S2C_NewSlg_GetUserFarmAward = function(arg_89_0, arg_89_1, arg_89_2)
		if ProtoHandler:onMsgProcess(arg_89_1, arg_89_2) then
			g.core.model.User.newSlgData:updateFarmAward(arg_89_2)
		end
	end,
	on_S2C_NewSlg_BountyInfo = function(arg_90_0, arg_90_1, arg_90_2)
		if ProtoHandler:onMsgProcess(arg_90_1, arg_90_2) then
			dump(arg_90_2, "on_S2C_NewSlg_BountyInfo")
			g.core.model.User.newSlgData:updateBountyInfo(arg_90_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYINFO, false, arg_90_1, arg_90_2)
		end
	end,
	on_S2C_NewSlg_BountyRefreshTask = function(arg_91_0, arg_91_1, arg_91_2)
		if ProtoHandler:onMsgProcess(arg_91_1, arg_91_2) then
			g.core.model.User.newSlgData:updateBountyTask(arg_91_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYREFRESHTASK, false, arg_91_1, arg_91_2)
		end
	end,
	on_S2C_NewSlg_BountyTaskAward = function(arg_92_0, arg_92_1, arg_92_2)
		if ProtoHandler:onMsgProcess(arg_92_1, arg_92_2) then
			g.core.model.User.newSlgData:updateBountyTask(arg_92_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOUNTYTASKAWARD, false, arg_92_1, arg_92_2)
		end
	end,
	on_S2C_NewSlg_FirstKillInfo = function(arg_93_0, arg_93_1, arg_93_2)
		if ProtoHandler:onMsgProcess(arg_93_1, arg_93_2) then
			g.core.model.User.newSlgData:updateFirstKillInfo(arg_93_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLINFO, false, arg_93_1, arg_93_2)
		end
	end,
	on_S2C_NewSlg_FirstKillAward = function(arg_94_0, arg_94_1, arg_94_2)
		if ProtoHandler:onMsgProcess(arg_94_1, arg_94_2) then
			g.core.model.User.newSlgData:updateFirstKillAward(arg_94_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLAWARD, false, arg_94_1, arg_94_2)
		end
	end,
	on_S2C_NewSlg_UseFarmToken = function(arg_95_0, arg_95_1, arg_95_2)
		if ProtoHandler:onMsgProcess(arg_95_1, arg_95_2) then
			g.core.model.User.newSlgData:useFarmToken(arg_95_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USEFARMTOKEN, false, arg_95_1, arg_95_2)
		end
	end,
	on_S2C_NewSlg_GetAllianceInfo = function(arg_96_0, arg_96_1, arg_96_2)
		if ProtoHandler:onMsgProcess(arg_96_1, arg_96_2) then
			g.core.model.User.newSlgData:cacheAllianceCities(arg_96_2)

			if arg_96_2.user_id == g.core.model.User:getId() then
				g.core.model.User.newSlgData:updateAllianceSerData(arg_96_2.info)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETALLIANCEINFO, false, arg_96_1, arg_96_2)
		end
	end,
	on_S2C_NewSlg_FirstKillNotify = function(arg_97_0, arg_97_1, arg_97_2)
		if ProtoHandler:onMsgProcess(arg_97_1, arg_97_2) then
			g.core.model.User.newSlgData:updateFirstKillInfo({
				first_kills = {
					arg_97_2.info
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FIRSTKILLNOTIFY, false, arg_97_1, arg_97_2)
		end
	end,
	on_S2C_NewSlg_SeasonTaskSyncProgress = function(arg_98_0, arg_98_1, arg_98_2)
		if ProtoHandler:onMsgProcess(arg_98_1, arg_98_2) then
			g.core.model.User.newSlgData:updateTaskSeasonData(arg_98_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SEASONTASKSYNCPROGRESS, false, arg_98_1, arg_98_2)
		end
	end,
	on_S2C_NewSlg_SeasonTaskAward = function(arg_99_0, arg_99_1, arg_99_2)
		if ProtoHandler:onMsgProcess(arg_99_1, arg_99_2) then
			g.core.model.User.newSlgData:rewardTaskSeasonData(arg_99_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SEASONTASKAWARD, false, arg_99_1, arg_99_2)
		end
	end,
	on_S2C_NewSlg_TechnologyActivate = function(arg_100_0, arg_100_1, arg_100_2)
		if ProtoHandler:onMsgProcess(arg_100_1, arg_100_2) then
			g.core.model.User.newSlgSkillTreeData:updateActive(arg_100_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATE, false, arg_100_1, arg_100_2)
		end
	end,
	on_S2C_NewSlg_TechnologyUpdate = function(arg_101_0, arg_101_1, arg_101_2)
		if ProtoHandler:onMsgProcess(arg_101_1, arg_101_2) then
			g.core.model.User.newSlgSkillTreeData:updateExPoint(arg_101_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYUPDATE, false, arg_101_1, arg_101_2)
		end
	end,
	on_S2C_NewSlg_TechnologyActivateOneKey = function(arg_102_0, arg_102_1, arg_102_2)
		if ProtoHandler:onMsgProcess(arg_102_1, arg_102_2) then
			arg_102_2.activeIds = arg_102_2.activate_ids

			g.core.model.User.newSlgSkillTreeData:updateActiveOneKey(arg_102_2.activate_ids)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATEONEKEY, false, arg_102_1, arg_102_2)
		end
	end,
	on_S2C_NewSlg_TechnologyReset = function(arg_103_0, arg_103_1, arg_103_2)
		if ProtoHandler:onMsgProcess(arg_103_1, arg_103_2) then
			g.core.model.User.newSlgSkillTreeData:onTechnologyReset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYRESET, false, arg_103_1, arg_103_2)
		end
	end,
	on_S2C_NewSlg_SetAllianceStrategy = function(arg_104_0, arg_104_1, arg_104_2)
		if ProtoHandler:onMsgProcess(arg_104_1, arg_104_2) then
			g.core.model.User.newSlgData:onUpdateAllianceStrategy(arg_104_2.alli_strategy_base_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SETALLIANCESTRATEGY, false, arg_104_1, arg_104_2)
		end
	end,
	on_S2C_NewSlg_NotifyAllianceStrategy = function(arg_105_0, arg_105_1, arg_105_2)
		if ProtoHandler:onMsgProcess(arg_105_1, arg_105_2) then
			g.core.model.User.newSlgData:onUpdateAllianceStrategy(arg_105_2.alli_strategy_base_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYALLIANCESTRATEGY, false, arg_105_1, arg_105_2)
		end
	end,
	on_S2C_NewSlg_CityElementNtf = function(arg_106_0, arg_106_1, arg_106_2)
		if ProtoHandler:onMsgProcess(arg_106_1, arg_106_2) then
			g.core.model.User.newSlgData:updateCityElement(arg_106_2.city_elements)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYALLIANCESTRATEGY, false, arg_106_1, arg_106_2)
		end
	end
}
