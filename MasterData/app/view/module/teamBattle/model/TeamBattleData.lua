local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleGameData = require("app.view.module.teamBattle.model.TeamBattleGameData")
local TeamBattleMapData = require("app.view.module.teamBattle.model.TeamBattleMapData")
local TeamBattleFormationData = require("app.view.module.teamBattle.model.TeamBattleFormationData")
local TeamBattleShopData = require("app.view.module.teamBattle.model.TeamBattleShopData")
local TeamBattleTeamUpData = require("app.view.module.teamBattle.model.TeamBattleTeamUpData")
local TeamBattleData = class("TeamBattleData")

function TeamBattleData:ctor()
	self:initData()
end

function TeamBattleData:initData()
	self._activityId = 0
	self._actPrepareTime = 0
	self._actStartTime = 0
	self._actEndTime = 0
	self._actExpireTime = 0
	self._openDayLimit = 0
	self._tempPlayerList = {}
	self._isGetBulletInfo = false
	self._mapData = TeamBattleMapData.new()
	self._gameData = TeamBattleGameData.new()
	self._formationData = nil
	self._teamUpData = TeamBattleTeamUpData.new()
	self._curEnteredMap = -1
end

function TeamBattleData:_updateActivity(arg_3_1)
	self._activityId = arg_3_1.sub_id
	self._actPrepareTime = arg_3_1.prepare_time
	self._actStartTime = arg_3_1.start_time
	self._actEndTime = arg_3_1.end_time
	self._actExpireTime = arg_3_1.expire_time
	self._openDayLimit = arg_3_1.open_day

	if self._activityId > 0 then
		self._mapData:setCurMapId(g.core.config.team_battle_info.get(self._activityId).map_group)
	end
end

function TeamBattleData:getTimeStr()
	local var_4_0 = self:getCurStage()

	if var_4_0 == TeamBattleConst.ACTIVITY_STATE.PREPARE then
		return g.core.lang:get(427002)
	elseif var_4_0 == TeamBattleConst.ACTIVITY_STATE.OPEN then
		return g.core.lang:get(427003)
	elseif var_4_0 == TeamBattleConst.ACTIVITY_STATE.RESULT then
		return g.core.lang:get(427004)
	elseif var_4_0 == TeamBattleConst.ACTIVITY_STATE.NOT_OPEN then
		return g.core.lang:get(427001)
	end
end

function TeamBattleData:getFinishTime()
	local var_5_0 = self:getCurStage()

	if var_5_0 == TeamBattleConst.ACTIVITY_STATE.PREPARE then
		return self._actStartTime
	elseif var_5_0 == TeamBattleConst.ACTIVITY_STATE.OPEN then
		return self._actEndTime
	elseif var_5_0 == TeamBattleConst.ACTIVITY_STATE.RESULT then
		return self._actExpireTime
	end

	return 0
end

function TeamBattleData:isActivityResultStage()
	return checkbool(self:getCurStage() == TeamBattleConst.ACTIVITY_STATE.RESULT)
end

function TeamBattleData:isActivityOpen(arg_7_1)
	if self._actStartTime == 0 or g.core.common.ServerTime:getOpenDays() < self._openDayLimit then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE) then
		return false
	end

	if arg_7_1 and arg_7_1 ~= self._activityId then
		return false
	end

	return self:isInActiveTime()
end

function TeamBattleData:needRequireBulletInfo()
	if not self:isActivityOpen() then
		return false
	end

	return not self._isGetBulletInfo
end

function TeamBattleData:setGetBulletInfo(arg_9_1)
	self._isGetBulletInfo = arg_9_1 == true
end

function TeamBattleData:isInActiveTime()
	local var_10_0 = g.core.common.ServerTime:getTime()

	return var_10_0 >= self._actPrepareTime and var_10_0 <= self._actExpireTime
end

function TeamBattleData:getActivityExpireTime()
	return self._actExpireTime
end

function TeamBattleData:getCurStage()
	local var_12_0 = g.core.common.ServerTime:getTime()

	if var_12_0 >= self._actPrepareTime and var_12_0 < self._actStartTime then
		return TeamBattleConst.ACTIVITY_STATE.PREPARE
	elseif var_12_0 >= self._actStartTime and var_12_0 < self._actEndTime then
		return TeamBattleConst.ACTIVITY_STATE.OPEN
	elseif var_12_0 > self._actEndTime and var_12_0 <= self._actExpireTime then
		return TeamBattleConst.ACTIVITY_STATE.RESULT
	end

	return TeamBattleConst.ACTIVITY_STATE.NOT_OPEN
end

function TeamBattleData:getActivityTimeInfo()
	return {
		prepareTime = self._actPrepareTime,
		startTime = self._actStartTime,
		endTime = self._actEndTime,
		expireTime = self._actExpireTime
	}
end

function TeamBattleData:getActivityId()
	return self._activityId
end

function TeamBattleData:getMapData()
	return self._mapData
end

function TeamBattleData:getGameData()
	return self._gameData
end

function TeamBattleData:getFormationData()
	self._formationData = self._formationData or TeamBattleFormationData.new()

	return self._formationData
end

function TeamBattleData:getTeamUpData()
	return self._teamUpData
end

function TeamBattleData:checkIsNeedGetTeamInfo()
	return self._needGetTeamInfo
end

function TeamBattleData:setNetBroken(arg_20_1)
	self._netBroken = arg_20_1
end

function TeamBattleData:isNetBroKen()
	return self._netBroken
end

function TeamBattleData:onS2CFlushRedPoint(arg_22_1)
	self:_updateActivity(arg_22_1.activity)

	self._enterRed = arg_22_1.is_hint

	local var_22_0 = self:getCurStage()

	self._needGetTeamInfo = false

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE) and (var_22_0 == TeamBattleConst.ACTIVITY_STATE.OPEN or var_22_0 == TeamBattleConst.ACTIVITY_STATE.PREPARE) then
		self._needGetTeamInfo = true
	end
end

function TeamBattleData:onS2CTeamBattleEnter(arg_23_1)
	self._mapData:getMapInfo(self._mapData:getCurMapId(), true)
	self._mapData:updateMapData(arg_23_1)
	self:getFormationData():updateKnightHP(arg_23_1.knights)
end

function TeamBattleData:onS2CTeamBattleExit(arg_24_1)
	return
end

function TeamBattleData:onS2CTeamBattleEnterRoom(arg_25_1)
	if arg_25_1.room then
		self._mapData:updateRoomData(arg_25_1.room)
	end

	if arg_25_1.user then
		self._mapData:updatePlayer(arg_25_1.user)
	end
end

function TeamBattleData:onS2CTeamBattleSetBattleKnights(arg_26_1)
	self:getFormationData():clearTempGuardMap()
end

function TeamBattleData:onS2CTeamBattleSetWork(arg_27_1)
	self._mapData:updatePlayerHasInfo({
		work = arg_27_1.work
	})
end

function TeamBattleData:onS2CTeamBattleSetVisibleArea(arg_28_1)
	self._mapData:updateVisibleArea(arg_28_1.visible_area)
end

function TeamBattleData:onS2CTeamBattleChallengeMonsterFinish(arg_29_1)
	return
end

function TeamBattleData:onS2CTeamBattleMove(arg_30_1)
	self._mapData:updateMoviePath(arg_30_1)
end

function TeamBattleData:onS2CTeamBattleHelp(arg_31_1)
	return
end

function TeamBattleData:onS2CTeamBattleUseItem(arg_32_1)
	return
end

function TeamBattleData:onS2CTeamBattleGetLog(arg_33_1)
	return
end

function TeamBattleData:onS2CTeamBattleChallengeMonsterBegin(arg_34_1)
	return
end

function TeamBattleData:onS2CTeamBattleChallengeBossBegin(arg_35_1)
	return
end

function TeamBattleData:onS2CTeamBattleChallengeResult(arg_36_1)
	self._mapData:setBattleResult(arg_36_1.challenge_result)

	if g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.DAILY_RESET_MONSTER_ID).parameter - g.core.model.User.teamBattleData:getMapData():getPlayerStruct():getExtData().daily_give_up_times < 1 then
		local var_36_0 = self._mapData:clearMapResult(false)

		if var_36_0 then
			for iter_36_0, iter_36_1 in ipairs(var_36_0) do
				self:getFormationData():getGuardById(iter_36_1.id):updateHpRatio(iter_36_1.num)
			end
		end
	end
end

function TeamBattleData:onS2CTeamBattleOpChallengeResult(arg_37_1)
	local var_37_0 = self._mapData:clearMapResult(arg_37_1.is_give_up)

	if var_37_0 then
		for iter_37_0, iter_37_1 in ipairs(var_37_0) do
			self:getFormationData():getGuardById(iter_37_1.id):updateHpRatio(iter_37_1.num)
		end
	end
end

function TeamBattleData:onS2CTeamBattleKnightShopBuy(arg_38_1)
	self:getFormationData():addPoolMemberKnight({
		arg_38_1.knight
	})
	self._mapData:updateShopBuyPos(arg_38_1.grid_id, arg_38_1.pos, arg_38_1.knight.id)
end

function TeamBattleData:onS2CTeamBattleBuffShopBuy(arg_39_1)
	self._mapData:updateShopBuyPos(arg_39_1.grid_id, arg_39_1.pos, arg_39_1.buff_id)
end

function TeamBattleData:onS2CTeamBattleMine(arg_40_1)
	return
end

function TeamBattleData:onS2CTeamBattleReborn(arg_41_1)
	if arg_41_1.knights then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1.knights) do
			self:getFormationData():getGuardById(iter_41_1.id):updateHpRatio(iter_41_1.hp)
		end
	end
end

function TeamBattleData:onS2CTeamBattleRecoverHp(arg_42_1)
	self:getFormationData():updateKnightHP(arg_42_1.knights or {})
end

function TeamBattleData:onS2CTeamBattleSelectBuff(arg_43_1)
	if arg_43_1.grid_id then
		self._mapData:eventFinish({
			grid_id = arg_43_1.grid_id
		})
	end
end

function TeamBattleData:onS2CTeamBattleSelectGame(arg_44_1)
	self._mapData:onSelectGame(arg_44_1)
end

function TeamBattleData:onS2CTeamBattleSelectItem(arg_45_1)
	return
end

function TeamBattleData:onS2CTeamBattleNotifyEnterRoom(arg_46_1)
	self._mapData:updateRoomData(arg_46_1.room, true)
	self._mapData:updatePlayer({
		arg_46_1.user
	})
end

function TeamBattleData:onS2CTeamBattleNotifyExit(arg_47_1)
	self._mapData:updatePlayer({
		arg_47_1.user
	})
end

function TeamBattleData:onS2CTeamBattleNotifySetWork(arg_48_1)
	self._mapData:updatePlayer({
		arg_48_1.user
	})
end

function TeamBattleData:onS2CTeamBattleNotifySetVisibleArea(arg_49_1)
	self._mapData:updateVisibleArea(arg_49_1.visible_area, arg_49_1.user_id)
end

function TeamBattleData:onS2CTeamBattleNotifyMove(arg_50_1)
	self._mapData:updateMoviePathAndEvent(arg_50_1)
end

function TeamBattleData:onS2CTeamBattleNotifyHelp(arg_51_1)
	self._mapData:updatePlayer({
		arg_51_1.target
	})
end

function TeamBattleData:onS2CTeamBattleNotifyUseItem(arg_52_1)
	return
end

function TeamBattleData:onS2CTeamBattleNotifyChallengeMonsterBegin(arg_53_1)
	self._mapData:challengeMonster(arg_53_1)
end

function TeamBattleData:onS2CTeamBattleNotifyChallengeMonsterFinish(arg_54_1)
	self._mapData:updateMonster(arg_54_1)
	self._mapData:setScore(arg_54_1.score or 0)
end

function TeamBattleData:onS2CTeamBattleNotifyChallengeBossBegin(arg_55_1)
	return
end

function TeamBattleData:onS2CTeamBattleNotifyChallengeBossFinish(arg_56_1)
	self._mapData:updateBoss(arg_56_1)
	self._mapData:setScore(arg_56_1.score or 0)
end

function TeamBattleData:onS2CTeamBattleNotifyKnightShopBuy(arg_57_1)
	self._mapData:updateEvent(arg_57_1.shop, arg_57_1.user_id)
end

function TeamBattleData:onS2CTeamBattleBuffShopRefresh(arg_58_1)
	self._mapData:updateEvent(arg_58_1.shop, arg_58_1.user_id)
end

function TeamBattleData:onS2CTeamBattleNotifyBuffShopBuy(arg_59_1)
	if arg_59_1.user_id ~= g.core.model.User:getId() then
		self._mapData:onOtherBuyBuff(arg_59_1.shop)
	end

	self._mapData:updateEvent(arg_59_1.shop, arg_59_1.user_id)
end

function TeamBattleData:onS2CTeamBattleNotifyMine(arg_60_1)
	self._mapData:updateEvent(arg_60_1.mine)
end

function TeamBattleData:onS2CTeamBattleNotifyReborn(arg_61_1)
	self._mapData:eventFinish({
		grid_id = arg_61_1.grid_id
	})
end

function TeamBattleData:onS2CTeamBattleNotifyRecoverHp(arg_62_1)
	self._mapData:eventFinish({
		grid_id = arg_62_1.grid_id
	})
end

function TeamBattleData:onS2CTeamBattleNotifySelectBuff(arg_63_1)
	self._mapData:addBuff(arg_63_1.buff.buff_ids[arg_63_1.buff.pos])
	self._mapData:eventFinish({
		grid_id = arg_63_1.grid_id
	})
end

function TeamBattleData:onS2CTeamBattleNotifySelectGame(arg_64_1)
	return
end

function TeamBattleData:onS2CTeamBattleNotifySelectItem(arg_65_1)
	return
end

function TeamBattleData:onS2CTeamBattleNoticeActivity(arg_66_1)
	self:_updateActivity(arg_66_1.activity)
end

function TeamBattleData:onS2CTeamBattleTeamInfo(arg_67_1)
	self._teamUpData:setMyTeam(arg_67_1.team)

	self._needGetTeamInfo = false
end

function TeamBattleData:onS2CTeamBattleTeamList(arg_68_1)
	self._teamUpData:setTeamList(arg_68_1.teams)
end

function TeamBattleData:onS2CTeamBattleFindTeam(arg_69_1)
	self._teamUpData:setSearchTeam(arg_69_1.team)
end

function TeamBattleData:onS2CTeamBattleCreateTeam(arg_70_1)
	self._teamUpData:setMyTeam(arg_70_1.team)
end

function TeamBattleData:onS2CTeamBattleSetTeam(arg_71_1)
	self._teamUpData:setMyTeamOpen(arg_71_1.open)
end

function TeamBattleData:onS2CTeamBattleJoinTeam(arg_72_1)
	self._teamUpData:setMyTeam(arg_72_1.team)
end

function TeamBattleData:onS2CTeamBattleLeaveTeam(arg_73_1)
	self._teamUpData:setMyTeam(nil)
end

function TeamBattleData:onS2CTeamBattleKickOut(arg_74_1)
	self._teamUpData:changeMyTeamMember(arg_74_1.member_id, true)
end

function TeamBattleData:onS2CTeamBattleKickNotice(arg_75_1)
	self._teamUpData:setMyTeam(nil)
end

function TeamBattleData:onS2CTeamBattleUpdateTeam(arg_76_1)
	self._teamUpData:setMyTeam(arg_76_1.team)
end

function TeamBattleData:onS2CTeamBattleTeamRank(arg_77_1)
	local var_77_0 = {
		myScore = arg_77_1.own_score,
		myRank = arg_77_1.own_rank
	}

	var_77_0.list = arg_77_1.list or {}
	self._rankInfo = var_77_0
end

function TeamBattleData:getRankInfo()
	return self._rankInfo
end

function TeamBattleData:onS2CTeamBattleServerInfos(arg_79_1)
	self._teamUpData:setServerInfos(arg_79_1.server_infos)
end

function TeamBattleData:onS2CTeamBattlePlayGame(arg_80_1)
	self._mapData:eventFinish(arg_80_1.event)
end

function TeamBattleData:onS2CTeamBattleKnightShopRefresh(arg_81_1)
	self._mapData:updateEvent(arg_81_1.shop, arg_81_1.user_id)
end

function TeamBattleData:onS2CTeamBattleNotifyShareAwards(arg_82_1)
	self._mapData:updatePlayerExtData({
		awards = arg_82_1.awards
	})
end

function TeamBattleData:onS2CTeamBattleGetActionAwards(arg_83_1)
	self._mapData:updatePlayerExtData({
		award_action_time = g.core.common.ServerTime:getTime()
	})
	self._mapData:updatePlayerActionPointAwards(nil)
end

function TeamBattleData:onS2CTeamBattleGetShareAwards(arg_84_1)
	self._mapData:removePlayerExtDataItem({
		awards = true
	})
end

function TeamBattleData:onS2CTeamBattleGetAbleAwardInfo(arg_85_1)
	self._mapData:updatePlayerActionPointAwards(arg_85_1.action_awards)
	self._mapData:updatePlayerExtData({
		award_action_time = 0
	})
end

function TeamBattleData:isEnteredMap()
	if self._curEnteredMap == -1 then
		local var_86_0 = g.core.common.Storage:load("TeamBattle_enter_map", true)

		if var_86_0 then
			self._curEnteredMap = var_86_0.enterMapActId or 0
		end
	end

	return self._curEnteredMap == self._activityId
end

function TeamBattleData:saveEnteredMap()
	if self._curEnteredMap ~= self._activityId then
		g.core.common.Storage:save("TeamBattle_enter_map", {
			enterMapActId = self._activityId
		}, true)

		self._curEnteredMap = self._activityId
	end
end

function TeamBattleData:isEnoughPoint()
	return self._mapData:getLeftPoint() > 0
end

function TeamBattleData:hasGameCount()
	if self._mapData:getEventNumByType(TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD) > 0 then
		return true
	end

	if self._mapData:getEventNumByType(TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER) > 0 then
		return true
	end

	if self._mapData:getEventNumByType(TeamBattleConst.EVENT_TYPE.GAME_DART) > 0 then
		return true
	end

	return false
end

function TeamBattleData:isRedLog()
	if self:isActivityOpen() then
		return g.core.model.User.dayNotifyTool:isTodayHasRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_TEAM_BATTLE_LOG_RED_TIP)
	end

	return false
end

return TeamBattleData
