local var_0_0 = g.core.common.ServerTime
local RedCliffBuildConfig = require("app.view.module.redCliff.const.RedCliffBuildConfig")
local var_0_2 = g.core.config.chibi_pool_info
local var_0_3 = g.core.config.chibi_map_info
local var_0_4 = g.core.config.chibi_component_info
local var_0_5 = g.core.config.chibi_turn_info
local var_0_6 = g.core.config.chibi_achievement_info
local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local var_0_9 = g.core.const.ConstMgr.RedCliffConst
local RedCliffEditorStruct = require("app.view.module.redCliff.model.RedCliffEditorStruct")
local RedCliffPlayerStruct = require("app.view.module.redCliff.model.RedCliffPlayerStruct")
local RedCliffData = class("RedCliffData")

function RedCliffData:ctor()
	self:initData()
end

function RedCliffData:initData()
	self._actId = 0
	self._actSubId = 0
	self._actStartTime = 0
	self._actEndTime = 0
	self._actExpireTime = 0
	self._openDays = 0
	self._signEndTime = 0
	self._crossOpenTime = 0
	self._allSvrOpenTime = 0
	self._semiFinalOpenTime = 0
	self._grandFinalOpenTime = 0
	self._poolTimeListMap = {}
	self._isApply = false
	self._myPoolId = 0
	self._myScore = 0
	self._myPoolRank = 0
	self._halfRoomId = 0
	self._dailyMatchMaxScore = 0
	self._crossRank = 0
	self._allSvrRank = 0
	self._hasAchievementIds = {}
	self._maxSeasonScore = 0
	self._challengeNum = 0
	self._winNum = 0
	self._turnAtkNum = 0
	self._joinTurnNUm = 0
	self._occupyChibiNum = 0
	self._occupyMiddleNum = 0
	self._occupyNum = 0
	self._rankMap = {}
	self._rewardMap = {}
	self._myMapId = 1
	self._mapInfo = nil
	self._myPlayerStruct = nil
	self._myEditorStruct = nil
	self._selfResult = nil
	self._myMatchRank = 0
	self._myMatchScore = 0
	self._localRankLength = 0
	self._crossRankLength = 0
	self._successListMap = {}
	self._failListMap = {}
	self._hasNotifyPromotion = false
	self._roomUserList = {}
	self._robotMaxNum = 0
	self._robotTarget = {}
	self._isPromote = false
	self._ladderStartTime = 0
	self._ladderEndTime = 0
	self._finalStartTime = 0
	self._finalEndTime = 0
	self._playerStructMap = {}
	self._matchRankList = {}
	self._recordList = {}
	self._matchEndRankList = {}
	self._finalRoomMap = {}
	self._targetEditor = nil
	self._targetCoord = nil
	self._taskTypeProgressDict = {}
	self._taskGotIdDict = {}

	self:_initCfg()
end

function RedCliffData:_initCfg()
	self:_initTurnInfo()
	self:_initComponentInfo()
	self:_initRobotMaxNum()

	self._editorMap = {}
	self._editorIdMap = {}
	self._zOrderTag = {}

	self:_initMapEditorCfg()
end

function RedCliffData:_initRankRewardInfo()
	local RankAward = require("app.core.common.RankAward")

	self._rewardMap[var_0_9.REWARD_TYPE.ALL_SERVER] = RankAward:getRankAwardArray(var_0_9.REWARD_TYPE.ALL_SERVER, 1)
	self._rewardMap[var_0_9.REWARD_TYPE.CROSS] = RankAward:getRankAwardArray(var_0_9.REWARD_TYPE.CROSS, 1)
end

function RedCliffData:_initTurnInfo()
	self._turnInfoMap = {}

	for iter_5_0, iter_5_1 in var_0_5.ipairs() do
		self._turnInfoMap[iter_5_1.pool] = self._turnInfoMap[iter_5_1.pool] or {}

		table.insert(self._turnInfoMap[iter_5_1.pool], iter_5_1)
	end
end

function RedCliffData:_initComponentInfo()
	self._rebornCompIdList = {}
	self._componentInfoEditorIdMap = {}
	self._componentInfoIdMap = {}

	for iter_6_0, iter_6_1 in var_0_4.ipairs() do
		self._componentInfoEditorIdMap[iter_6_1.map_id] = self._componentInfoEditorIdMap[iter_6_1.map_id] or {}
		self._componentInfoEditorIdMap[iter_6_1.map_id][iter_6_1.editor_id] = iter_6_1
		self._componentInfoIdMap[iter_6_1.id] = iter_6_1

		if iter_6_1.type == var_0_9.EDITOR_TYPE.REBORN then
			table.insert(self._rebornCompIdList, iter_6_1.id)
		end
	end
end

function RedCliffData:_initMapEditorCfg()
	if self._editorMap[self._myMapId] and self._editorIdMap[self._myMapId] then
		return
	end

	self._editorMap[self._myMapId] = {}
	self._editorIdMap[self._myMapId] = {}
	self._zOrderTag[self._myMapId] = {}

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(RedCliffBuildConfig) do
		local var_7_1 = string.split(iter_7_0, "_")

		if iter_7_1 == var_0_9.ZORDER_TAG then
			self._zOrderTag[self._myMapId][iter_7_0] = true
		else
			local var_7_2 = self._componentInfoEditorIdMap[self._myMapId][iter_7_1]
			local var_7_3 = RedCliffEditorStruct.new({
				cfg = self._componentInfoEditorIdMap[self._myMapId][iter_7_1],
				pos = cc.p(tonumber(var_7_1[1]), tonumber(var_7_1[2])),
				editorId = iter_7_1
			})

			for iter_7_2, iter_7_3 in ipairs((var_7_3:getOccupyCoord())) do
				var_7_0[self:_getCoordKey(iter_7_3)] = var_7_3
			end

			if var_7_2 then
				self._editorIdMap[self._myMapId][var_7_2.id] = var_7_3
			elseif var_0_9.NOT_BARRIER_ID[iter_7_1] then
				self._zOrderTag[self._myMapId][iter_7_0] = true
			end
		end
	end

	self._editorMap[self._myMapId] = var_7_0
end

function RedCliffData:_initRobotMaxNum()
	self._robotMaxNum = g.core.common.DeviceCheck.CUR_LEVEL == require("app.core.common.DeviceCheckConst").LEVEL_SIGN.HIGH and g.core.config.chibi_parameter_info.get(7).value or g.core.config.chibi_parameter_info.get(6).value
end

function RedCliffData:getRobotMaxNum()
	return self._robotMaxNum
end

function RedCliffData:getMyRankAndScore()
	return self._myPoolRank, self._myScore
end

function RedCliffData:getUpgradeStateByPoolId(arg_11_1)
	if arg_11_1 < self._myPoolId then
		return var_0_9.UPGRADE_STATE.UPGRADE
	elseif self._myPoolId == arg_11_1 then
		return var_0_9.UPGRADE_STATE.CURRENT
	else
		return var_0_9.UPGRADE_STATE.NEED_UPGRADE
	end
end

function RedCliffData:isInPoolTimeDuration(arg_12_1)
	local var_12_0, var_12_1 = self:getDurationByPoolId(arg_12_1)
	local var_12_2 = var_0_0:getTime()

	return var_12_0 <= var_12_2 and var_12_2 < var_12_1
end

function RedCliffData:isOpenDaysSatisfy()
	return var_0_0:getOpenDays() >= self._openDays
end

function RedCliffData:getGameStage()
	local var_14_0 = var_0_0:getTime()

	if var_14_0 < self._actStartTime then
		return var_0_9.GAME_STAGE.NONE
	elseif var_14_0 < self._crossOpenTime then
		return var_0_9.GAME_STAGE.APPLY
	elseif var_14_0 < self._semiFinalOpenTime then
		return var_0_9.GAME_STAGE.LADDER
	elseif var_14_0 < self._actEndTime then
		return var_0_9.GAME_STAGE.FINAL
	elseif var_14_0 < self._actExpireTime then
		return var_0_9.GAME_STAGE.RESULT
	end

	return var_0_9.GAME_STAGE.NONE
end

function RedCliffData:getApplyEndTime()
	return self._signEndTime
end

function RedCliffData:getActExpireTime()
	return self._actExpireTime
end

function RedCliffData:getGameStageDuration(arg_17_1)
	if arg_17_1 == var_0_9.GAME_STAGE.APPLY then
		return self._actStartTime, self._signEndTime
	elseif arg_17_1 == var_0_9.GAME_STAGE.LADDER then
		return self._crossOpenTime, self._semiFinalOpenTime
	elseif arg_17_1 == var_0_9.GAME_STAGE.FINAL then
		return self._semiFinalOpenTime, self._actEndTime
	end

	return 0, 0
end

function RedCliffData:getDurationByPoolId(arg_18_1)
	if arg_18_1 == var_0_9.POOL_ID.CROSS then
		return self._crossOpenTime, self._semiFinalOpenTime
	elseif arg_18_1 == var_0_9.POOL_ID.ALL then
		return self._allSvrOpenTime, self._semiFinalOpenTime
	elseif arg_18_1 == var_0_9.POOL_ID.SEMI then
		return self._semiFinalOpenTime, self._grandFinalOpenTime
	elseif arg_18_1 == var_0_9.POOL_ID.GRAND then
		return self._grandFinalOpenTime, self._actEndTime
	end

	return 0, 0
end

function RedCliffData:getPoolStateByPoolId(arg_19_1)
	local var_19_0 = var_0_0:getTime()
	local var_19_1, var_19_2 = self:getDurationByPoolId(arg_19_1)

	if var_19_0 < var_19_1 then
		return var_0_9.POOL_STATE.ALL_NOT_START
	else
		local var_19_3 = self:getCurrentPoolFightTime(arg_19_1)

		if var_19_3 then
			if var_19_0 < var_19_3.startTime then
				return var_0_9.POOL_STATE.CUR_NOT_START
			else
				return var_0_9.POOL_STATE.CUR_START
			end
		else
			return var_0_9.POOL_STATE.ALL_END
		end
	end
end

function RedCliffData:checkCanFightByPoolId(arg_20_1)
	local var_20_0 = self._poolTimeListMap[arg_20_1] or {}
	local var_20_1 = var_0_0:getTime()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if var_20_1 >= iter_20_1.startTime and var_20_1 < iter_20_1.endTime then
			return true
		end
	end

	return false
end

function RedCliffData:getCurrentPoolFightTime(arg_21_1)
	local var_21_0 = self._poolTimeListMap[arg_21_1] or {}
	local var_21_1 = var_0_0:getTime()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if var_21_1 < iter_21_1.startTime or var_21_1 < iter_21_1.endTime then
			return iter_21_1
		end
	end

	return nil
end

function RedCliffData:isLastMatchEndByPoolId(arg_22_1)
	local var_22_0 = self._poolTimeListMap[arg_22_1]

	if not self._poolTimeListMap[arg_22_1] or not next(var_22_0) then
		return true
	end

	return var_0_0:getTime() >= var_22_0[#var_22_0].endTime
end

function RedCliffData:getSemiFinalTime()
	return self._poolTimeListMap[var_0_9.POOL_ID.SEMI]
end

function RedCliffData:getFirstMatchTimeByPoolId(arg_24_1, arg_24_2)
	if not arg_24_2 then
		return self._poolTimeListMap[arg_24_1] and self._poolTimeListMap[arg_24_1][1]
	end

	for iter_24_0, iter_24_1 in ipairs(self._poolTimeListMap[arg_24_1]) do
		if arg_24_2 < iter_24_1.endTime then
			return iter_24_1
		end
	end
end

function RedCliffData:getApplyState()
	if self:isApply() then
		return var_0_9.APPLY_STATE.APPLIED
	end

	if var_0_0:getTime() < self._signEndTime then
		return var_0_9.APPLY_STATE.APPLY_ABLE
	else
		return var_0_9.APPLY_STATE.APPLY_END
	end
end

function RedCliffData:getPoolInfoByPoolId(arg_26_1)
	return var_0_2.fetch(arg_26_1)
end

function RedCliffData:getMyPoolId()
	return self._myPoolId
end

function RedCliffData:isApply()
	return self._isApply
end

function RedCliffData:getMyMapId()
	return self._myMapId
end

function RedCliffData:getMyMapInfo()
	return self._mapInfo
end

function RedCliffData:getMyPlayerStruct()
	return self._myPlayerStruct
end

function RedCliffData:getMyEditorStruct()
	return self:getEditorStructByComponentId((self._myPlayerStruct:getComponentId()))
end

function RedCliffData:getEditorStructByCoord(arg_33_1)
	return self:getEditorStructMap()[self:_getCoordKey(arg_33_1)]
end

function RedCliffData:getEditorStructByComponentId(arg_34_1)
	return self:getEditorStructIdMap()[arg_34_1]
end

function RedCliffData:saveTargetCoordAndEditor(arg_35_1, arg_35_2)
	self._targetCoord = arg_35_1
	self._targetEditor = arg_35_2
end

function RedCliffData:getTargetCoordAndEditor()
	return self._targetCoord, self._targetEditor
end

function RedCliffData:getMatchRankList()
	return self._matchRankList
end

function RedCliffData:getRecordList()
	return self._recordList
end

function RedCliffData:getMatchEndRankList()
	return self._matchEndRankList or {}
end

function RedCliffData:getFinalRoomListByRoomId(arg_40_1)
	return self._finalRoomMap[arg_40_1] or {}
end

function RedCliffData:getRandomRebornId()
	return self._rebornCompIdList[math.random(1, #self._rebornCompIdList)]
end

function RedCliffData:getPlayerStructByUserId(arg_42_1)
	local var_42_0 = self._playerStructMap[arg_42_1]

	if not self._playerStructMap[arg_42_1] then
		var_42_0 = RedCliffPlayerStruct.new()
		self._playerStructMap[arg_42_1] = var_42_0
	end

	return var_42_0
end

function RedCliffData:hasNotifyPromotion()
	self._hasNotifyPromotion = false

	return self._hasNotifyPromotion
end

function RedCliffData:isPromote()
	self._isPromote = false

	return self._isPromote
end

function RedCliffData:isUpgradeByPoolIdAndScore(arg_45_1, arg_45_2)
	local var_45_0 = self:getPoolInfoByPoolId(arg_45_1)
	local var_45_1 = var_45_0.upgrade_value

	if var_45_0.upgrade_type == var_0_9.UPGRADE_TYPE.PERMILLAGE then
		return arg_45_2 <= var_45_0.player_num_limit * var_45_1 / 100
	else
		return arg_45_2 <= var_45_1
	end
end

function RedCliffData:getEditorStructMap()
	return self._editorMap[self._myMapId]
end

function RedCliffData:getEditorStructIdMap()
	return self._editorIdMap[self._myMapId]
end

function RedCliffData:getRankListByRankType(arg_48_1)
	return self._rankMap[arg_48_1] or {}
end

function RedCliffData:getRewardByRewardType(arg_49_1)
	return self._rewardMap[arg_49_1] or {}
end

function RedCliffData:calDeltaScoreAfterMatch(arg_50_1, arg_50_2)
	local var_50_1 = 0

	for iter_50_0, iter_50_1 in g.core.config.chibi_rank_point_info.ipairs() do
		if arg_50_1 >= iter_50_1.rank_min and arg_50_1 <= iter_50_1.rank_max then
			var_50_1 = iter_50_1.point

			break
		end
	end

	return math.floor(arg_50_2 * (g.core.config.chibi_parameter_info.get(2).value / 1000) + var_50_1)
end

function RedCliffData:isActivityOpen()
	return self:getGameStage() ~= var_0_9.GAME_STAGE.NONE
end

function RedCliffData:getRouteArray(arg_52_1, arg_52_2)
	return (KsAStar.searchPath(arg_52_1, arg_52_2, self))
end

function RedCliffData:decomposePathArr(arg_53_1, arg_53_2)
	local var_53_0 = {}
	local var_53_1 = arg_53_2 or var_0_9.MOVE_SPEED
	local var_53_2 = arg_53_1[1]

	while 2 <= #arg_53_1 do
		local var_53_3 = KsMath.calculateDistance(var_53_2, arg_53_1[2]) / var_53_1
		local var_53_4 = cc.pMul(cc.pSub(arg_53_1[2], var_53_2), 1 / var_53_3)

		for iter_53_0 = 1, var_53_3 - 1 do
			local var_53_5 = cc.pAdd(var_53_2, var_53_4)

			table.insert(var_53_0, var_53_5)

			var_53_2 = var_53_5
		end

		var_53_0[#var_53_0 + 1] = arg_53_1[2]
		var_53_2 = arg_53_1[2]
	end

	return var_53_0
end

function RedCliffData:doCanMoveAStar(arg_54_1, arg_54_2)
	local var_54_0 = self:getEditorStructByCoord(arg_54_2)

	if not var_54_0 then
		return true
	end

	return checkbool(var_0_9.NOT_BARRIER_ID[var_54_0:getEditorId()])
end

function RedCliffData:isMainRoleZOrderHigh(arg_55_1)
	return checkbool(self._zOrderTag[self._myMapId][self:_getCoordKey((cc.p(math.floor(arg_55_1.x), math.floor(arg_55_1.y))))])
end

function RedCliffData:isEditorHasRobot(arg_56_1)
	return checkbool(self._robotTarget[self:_getCoordKey(arg_56_1)])
end

function RedCliffData:saveEditorRobot(arg_57_1, arg_57_2)
	if arg_57_1 then
		self._robotTarget[self:_getCoordKey(arg_57_1)] = arg_57_2
	end
end

function RedCliffData:_getCoordKey(arg_58_1)
	return arg_58_1.x .. "_" .. arg_58_1.y
end

function RedCliffData:_updateActivityInfo(arg_59_1)
	if not arg_59_1 then
		return
	end

	self._actId = arg_59_1.id or 0
	self._actSubId = arg_59_1.sub_id or 0
	self._actStartTime = arg_59_1.start_time or 0
	self._actEndTime = arg_59_1.end_time or 0
	self._actExpireTime = arg_59_1.expire_time or 0
	self._openDays = arg_59_1.open_day or 0
	self._signEndTime = arg_59_1.signup_end_time or 0
	self._crossOpenTime = arg_59_1.cross_open_time or 0
	self._allSvrOpenTime = arg_59_1.all_server_open_time or 0
	self._semiFinalOpenTime = arg_59_1.half_final_open_time or 0
	self._grandFinalOpenTime = arg_59_1.final_open_time or 0

	self:_calcStageEndTime()
end

function RedCliffData:_calcStageEndTime()
	self._poolTimeListMap = {}

	for iter_60_0, iter_60_1 in pairs(var_0_9.POOL_ID) do
		self._poolTimeListMap[iter_60_1] = {}

		local var_60_0 = var_0_3.get(self:getPoolInfoByPoolId(iter_60_1).map).length
		local var_60_1 = self._turnInfoMap[iter_60_1]
		local var_60_2

		if iter_60_1 == var_0_9.POOL_ID.CROSS then
			var_60_2 = var_0_0:getDateObject(self._crossOpenTime)
		elseif iter_60_1 == var_0_9.POOL_ID.ALL then
			var_60_2 = var_0_0:getDateObject(self._allSvrOpenTime)
		elseif iter_60_1 == var_0_9.POOL_ID.SEMI then
			var_60_2 = var_0_0:getDateObject(self._semiFinalOpenTime)
		elseif iter_60_1 == var_0_9.POOL_ID.GRAND then
			var_60_2 = var_0_0:getDateObject(self._grandFinalOpenTime)
		end

		for iter_60_2, iter_60_3 in ipairs(var_60_1) do
			var_60_2.hour = iter_60_3.start_hour
			var_60_2.minute = iter_60_3.start_minute
			var_60_2.second = iter_60_3.start_second

			local var_60_3 = var_0_0:getEndTimeStamp(var_0_0:getTimeStampByParams(var_60_2), iter_60_3.start_day)

			table.insert(self._poolTimeListMap[iter_60_1], {
				startTime = var_60_3,
				endTime = var_60_3 + var_60_0
			})
		end
	end
end

function RedCliffData:_getRecordType(arg_61_1, arg_61_2)
	local var_61_0 = g.core.model.User:getId()

	if var_61_0 == arg_61_1 then
		return var_0_9.RECORD_TYPE.DEFEND_LOSE
	elseif var_61_0 == arg_61_2 then
		return var_0_9.RECORD_TYPE.ATK_WIN
	end

	return var_0_9.RECORD_TYPE.ATK_LOSE
end

function RedCliffData:_getOccupyChangeType(arg_62_1, arg_62_2)
	if arg_62_1 and arg_62_2 then
		return var_0_9.OCCUPY_CHANGE_TYPE.ATK_OCCUPY
	elseif arg_62_1 then
		return var_0_9.OCCUPY_CHANGE_TYPE.DISCARD
	elseif arg_62_2 then
		return var_0_9.OCCUPY_CHANGE_TYPE.DIRECT_OCCUPY
	end
end

function RedCliffData:getSelfResult()
	return self._selfResult
end

function RedCliffData:getRoomUserList()
	return self._roomUserList
end

function RedCliffData:getMyMatchRankAndScore()
	return self._myMatchRank, self._myMatchScore
end

function RedCliffData:getSuccessList(arg_66_1)
	return self._successListMap[arg_66_1] or {}
end

function RedCliffData:getFailList(arg_67_1)
	return self._failListMap[arg_67_1] or {}
end

function RedCliffData:getMyRankByRankType(arg_68_1)
	if arg_68_1 == var_0_9.RANK_TYPE.ALL_SERVER then
		return self._allSvrRank
	end

	return self._crossRank
end

function RedCliffData:onS2CRedPoint(arg_69_1)
	self:_updateActivityInfo(arg_69_1.act_info)

	self._isApply = checkbool(arg_69_1.is_apply)
	self._myPoolId = arg_69_1.pool_id or 0
	self._myScore = arg_69_1.score or 0
	self._myPoolRank = arg_69_1.pool_rank or 0
	self._dailyMatchMaxScore = arg_69_1.daily_match_max_score or 0
	self._hasAchievementIds = arg_69_1.has_achievement_ids or {}

	self:updateTaskByStatus(arg_69_1)
end

function RedCliffData:onS2CChibiGetInfo(arg_70_1)
	self:_updateActivityInfo(arg_70_1.act_info)

	self._isApply = checkbool(arg_70_1.is_apply)
	self._actStartTime = arg_70_1.start_time or 0
	self._myPoolId = arg_70_1.pool_id or 0
	self._myScore = arg_70_1.score or 0
	self._myPoolRank = arg_70_1.pool_rank or 0
	self._halfRoomId = arg_70_1.half_final_room_id or 0
	self._dailyMatchMaxScore = arg_70_1.daily_match_max_score or 0
	self._hasAchievementIds = arg_70_1.has_achievement_ids or {}
	self._crossRank = arg_70_1.cross_achievement_rank or 0
	self._allSvrRank = arg_70_1.allserver_achievement_rank or 0
	self._maxSeasonScore = arg_70_1.max_season_score or 0
	self._challengeNum = arg_70_1.challenge_num or 0
	self._winNum = arg_70_1.win_challenge_num or 0
	self._turnAtkNum = arg_70_1.turn_challenge_num or 0
	self._joinTurnNUm = arg_70_1.join_turn_num or 0
	self._occupyChibiNum = arg_70_1.occupy_chibi_num or 0
	self._occupyMiddleNum = arg_70_1.occupy_medium_num or 0
	self._occupyNum = arg_70_1.occupy_component_num or 0

	if self._myPoolId > 0 then
		self._myMapId = var_0_2.get(self._myPoolId).map
		self._mapInfo = var_0_3.get(self._myMapId)
	end

	self:updateTaskByStatus(arg_70_1)
	self:_initRankRewardInfo()
end

function RedCliffData:onS2CChibiApply(arg_71_1)
	self._isApply = checkbool(arg_71_1.is_apply)
	self._myPoolId = arg_71_1.pool_id

	if self._myPoolId > 0 then
		self._myMapId = var_0_2.get(self._myPoolId).map
		self._mapInfo = var_0_3.get(self._myMapId)
		self._taskTypeProgressDict[1] = self._myPoolId
	end
end

function RedCliffData:onS2CGetFinalRoom(arg_72_1)
	if arg_72_1 and arg_72_1.room_id then
		self._finalRoomMap[arg_72_1.room_id] = arg_72_1.user_final
	end
end

function RedCliffData:onS2CChibiEnterRoom(arg_73_1)
	self._robotTarget = {}
	self._matchRankList = {}
	self._recordList = {}
	self._playerStructMap = {}
	self._myPlayerStruct = self._myPlayerStruct or RedCliffPlayerStruct.new()

	self._myPlayerStruct:resInfo(arg_73_1.self)

	self._playerStructMap[self._myPlayerStruct:getUserId()] = self._myPlayerStruct

	for iter_73_0, iter_73_1 in ipairs(arg_73_1.users or {}) do
		local var_73_0 = RedCliffPlayerStruct.new()

		var_73_0:resInfo(iter_73_1)

		self._playerStructMap[var_73_0:getUserId()] = var_73_0
	end

	for iter_73_2, iter_73_3 in ipairs(arg_73_1.cs or {}) do
		local var_73_1 = self:getEditorStructByComponentId(iter_73_3.id)

		if var_73_1 then
			var_73_1:setFertile(iter_73_3.is_fertility == 1)

			if iter_73_3.occupy_user > 0 then
				if var_73_1:getEditorType() ~= var_0_9.EDITOR_TYPE.REBORN then
					var_73_1:setPlayer(self._playerStructMap[iter_73_3.occupy_user])
				end
			end
		end
	end
end

function RedCliffData:onS2CLeaveComponent(arg_74_1)
	self._myPlayerStruct:resInfo(arg_74_1.user)

	local var_74_0 = self:getEditorStructByComponentId(arg_74_1.component_id)

	if var_74_0 then
		var_74_0:setPlayer(nil)
	end
end

function RedCliffData:onS2CChibiGetRankInfo(arg_75_1)
	self._myScore = arg_75_1.my_score or self._myScore
	self._myPoolRank = arg_75_1.my_rank or self._myPoolRank
	self._matchRankList = arg_75_1.users or {}

	if not self._myPlayerStruct then
		self._myPlayerStruct = RedCliffPlayerStruct.new()
		self._playerStructMap[g.core.model.User:getId()] = self._myPlayerStruct
	end

	self._myPlayerStruct:resInfo(arg_75_1.user)
end

function RedCliffData:onS2COccupyChange(arg_76_1)
	local var_76_0 = self:getEditorStructByComponentId(arg_76_1.component_id)
	local var_76_1 = arg_76_1.before_user
	local var_76_2 = arg_76_1.user
	local var_76_3 = arg_76_1.before_user and self:getPlayerStructByUserId(var_76_1.user_id) or nil
	local var_76_4 = arg_76_1.user and self:getPlayerStructByUserId(var_76_2.user_id) or nil
	local var_76_5 = self:_getOccupyChangeType(arg_76_1.before_user, arg_76_1.user)

	var_76_0:setPlayer(var_76_4)

	if var_76_5 == var_0_9.OCCUPY_CHANGE_TYPE.ATK_OCCUPY then
		var_76_4:resInfo(var_76_2)
		var_76_3:resInfo(var_76_1)

		if var_76_3:isSelf() or var_76_4:isSelf() then
			table.insert(self._recordList, {
				pre = var_76_3,
				occupy = var_76_4,
				componentId = arg_76_1.component_id,
				recordType = self:_getRecordType(var_76_1.user_id, var_76_2.user_id)
			})
		end
	elseif var_76_5 == var_0_9.OCCUPY_CHANGE_TYPE.DIRECT_OCCUPY then
		var_76_4:resInfo(var_76_2)

		if var_76_4:isSelf() then
			table.insert(self._recordList, {
				occupy = var_76_4,
				componentId = arg_76_1.component_id,
				recordType = var_0_9.RECORD_TYPE.ATK_NONE
			})
		end
	elseif var_76_5 == var_0_9.OCCUPY_CHANGE_TYPE.DISCARD then
		var_76_3:resInfo(var_76_1)
	end
end

function RedCliffData:onS2CNotifyFertility(arg_77_1)
	for iter_77_0, iter_77_1 in pairs((self:getEditorStructIdMap())) do
		iter_77_1:setFertile(false)
	end

	for iter_77_2, iter_77_3 in ipairs(arg_77_1.fertility or {}) do
		local var_77_0 = iter_77_3.is_fertility == 1
		local var_77_1 = self:getEditorStructByComponentId(iter_77_3.id)

		if var_77_1 then
			var_77_1:setFertile(var_77_0)
		end
	end
end

function RedCliffData:onS2CNotifyUserRevive(arg_78_1)
	local var_78_0 = self:getMyPlayerStruct()

	var_78_0:setDeadTime(arg_78_1.revive_time)
	var_78_0:resetRestHp()
	var_78_0:setComponentId(0)
end

function RedCliffData:onS2CMatchEnd(arg_79_1)
	self._matchEndRankList = {}
	self._matchEndRankList = arg_79_1.users or {}

	table.sort(self._matchEndRankList, function(arg_80_0, arg_80_1)
		if arg_80_0.score ~= arg_80_1.score then
			return arg_80_0.score > arg_80_1.score
		end

		if arg_80_0.fight_value ~= arg_80_1.fight_value then
			return arg_80_0.fight_value > arg_80_1.fight_value
		end

		return false
	end)

	for iter_79_0, iter_79_1 in ipairs(self._matchEndRankList) do
		if iter_79_1.id == g.core.model.User:getId() then
			self._selfResult = iter_79_1
			self._myMatchRank = iter_79_0
			self._myMatchScore = iter_79_1.score
		end
	end
end

function RedCliffData:onS2CCheckBattle(arg_81_1)
	if not arg_81_1 then
		return
	end

	if self._myPlayerStruct then
		self._myPlayerStruct:setCoolTime(self._mapInfo.cooling_time)

		if arg_81_1.check_status == var_0_9.CHECK_STATUS.LOSE then
			table.insert(self._recordList, {
				pre = self:getPlayerStructByUserId(arg_81_1.user_id),
				componentId = arg_81_1.component_id,
				recordType = var_0_9.RECORD_TYPE.ATK_LOSE
			})
		end
	end
end

function RedCliffData:onS2cNotifyUserInfo(arg_82_1)
	self._myPoolId = arg_82_1.pool_id or self._myPoolId

	if self._myPoolId then
		self._myMapId = self:getPoolInfoByPoolId(self._myPoolId).map
		self._mapInfo = var_0_3.get(self._myMapId)
	end

	self._myScore = arg_82_1.score or self._myScore
	self._myPoolRank = arg_82_1.pool_rank or self._myPoolRank
	self._localRankLength = arg_82_1.local_rank_length or self._localRankLength
	self._crossRankLength = arg_82_1.cross_rank_length or self._crossRankLength
	self._crossRank = arg_82_1.cross_achievement_rank or self._crossRank
	self._allSvrRank = arg_82_1.allserver_achievement_rank or self._allSvrRank
	self._halfRoomId = arg_82_1.half_final_room_id or self._halfRoomId
end

function RedCliffData:onS2CNotifyPromotionList(arg_83_1, arg_83_2)
	if arg_83_2 then
		self._hasNotifyPromotion = true
	end

	local var_83_0 = g.core.model.User:getId()

	self._successListMap[arg_83_1.pool_id] = {}
	self._failListMap[arg_83_1.pool_id] = {}

	for iter_83_0, iter_83_1 in ipairs(arg_83_1.users or {}) do
		if iter_83_1.is_promotion then
			table.insert(self._successListMap[arg_83_1.pool_id], iter_83_1)
		else
			table.insert(self._failListMap[arg_83_1.pool_id], iter_83_1)
		end

		if iter_83_1.id == var_83_0 then
			self._isPromote = checkbool(iter_83_1.is_promotion)
		end
	end
end

function RedCliffData:onS2CGetPromotionList(arg_84_1)
	self._successListMap[arg_84_1.pool_id] = {}
	self._failListMap[arg_84_1.pool_id] = {}

	for iter_84_0, iter_84_1 in ipairs(arg_84_1.users or {}) do
		if iter_84_1.is_promotion then
			table.insert(self._successListMap[arg_84_1.pool_id], iter_84_1)
		else
			table.insert(self._failListMap[arg_84_1.pool_id], iter_84_1)
		end
	end
end

function RedCliffData:onS2cGetRoomUser(arg_85_1)
	self._roomUserList = arg_85_1.users or {}
end

function RedCliffData:onS2CCommonRankList(arg_86_1)
	self._rankMap[arg_86_1.id] = arg_86_1.rank_units
end

function RedCliffData:recvAchievementData(arg_87_1)
	self._taskGotIdDict[arg_87_1.award_id] = true
end

function RedCliffData:saveSkipBattleState(arg_88_1)
	local var_88_0 = g.core.common.Storage:load("red_cliff_skip_battle.json", true) or {}

	var_88_0.is_skip = arg_88_1

	g.core.common.Storage:save("red_cliff_skip_battle.json", var_88_0, true)
end

function RedCliffData:isSkipBattle()
	local var_89_0 = g.core.common.Storage:load("red_cliff_skip_battle.json", true) or {}

	return var_89_0.is_skip == true or var_89_0.is_skip == nil
end

function RedCliffData:updateTaskByStatus(arg_90_1)
	self._taskTypeProgressDict = {}

	for iter_90_0, iter_90_1 in pairs(var_0_9.TASK_TYPE) do
		self._taskTypeProgressDict[iter_90_0] = arg_90_1[iter_90_1] or 0
	end

	self._taskGotIdDict = {}

	for iter_90_2, iter_90_3 in ipairs(arg_90_1.has_achievement_ids or {}) do
		self._taskGotIdDict[iter_90_3] = true
	end
end

function RedCliffData:isGotTaskById(arg_91_1, arg_91_2)
	arg_91_2 = arg_91_2 or var_0_6.get(arg_91_1)

	if self:isExpireTask(arg_91_2.type) then
		return false
	end

	return self._taskGotIdDict[arg_91_2.id] == true
end

function RedCliffData:isTaskCanGet(arg_92_1)
	local var_92_0 = var_0_6.get(arg_92_1)

	if self:isGotTaskById(nil, var_92_0) then
		return false
	end

	return self:getTaskProgress(var_92_0.type) >= var_92_0.value
end

function RedCliffData:getTaskProgress(arg_93_1)
	if self:isExpireTask(arg_93_1) then
		return 0
	end

	return self._taskTypeProgressDict[arg_93_1] or 0
end

function RedCliffData:isExpireTask(arg_94_1)
	if not self:isActivityOpen() then
		return true
	end

	return false
end

function RedCliffData:getCampaignStr()
	local var_95_0 = self:getGameStage()

	if var_95_0 == var_0_9.GAME_STAGE.APPLY then
		return g.core.lang:get(421107)
	elseif var_95_0 == var_0_9.GAME_STAGE.LADDER then
		if self:checkCanFightByPoolId(var_0_9.POOL_ID.CROSS) then
			return g.core.lang:get(421109)
		end

		return g.core.lang:get(421108)
	elseif var_95_0 == var_0_9.GAME_STAGE.FINAL then
		if self:isInPoolTimeDuration(var_0_9.POOL_ID.SEMI) then
			return (self:checkCanFightByPoolId(var_0_9.POOL_ID.SEMI) or nil) and (g.core.lang:get(421111) or g.core.lang:get(421110))
		else
			return (self:checkCanFightByPoolId(var_0_9.POOL_ID.GRAND) or nil) and (g.core.lang:get(421113) or g.core.lang:get(421112))
		end
	elseif var_95_0 == var_0_9.GAME_STAGE.RESULT then
		return g.core.lang:get(421115)
	end

	return g.core.lang:get(421013)
end

function RedCliffData:hasTaskCanReceive()
	local var_96_0 = self:getGameStage()

	if var_96_0 ~= var_0_9.GAME_STAGE.LADDER and var_96_0 ~= var_0_9.GAME_STAGE.FINAL then
		return false
	end

	for iter_96_0, iter_96_1 in var_0_6.ipairs() do
		if self:isTaskCanGet(iter_96_1.id) then
			return true
		end
	end

	return false
end

function RedCliffData:hasMatchCanFight()
	return self:checkCanFightByPoolId(self._myPoolId)
end

function RedCliffData:isCanApply()
	return self:getApplyState() == var_0_9.APPLY_STATE.APPLY_ABLE
end

return RedCliffData
