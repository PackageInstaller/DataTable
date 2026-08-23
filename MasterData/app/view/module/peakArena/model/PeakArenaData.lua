local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst.HonorTitleType
local var_0_3 = g.core.const.ConstMgr.PeakArenaConst.StageType
local var_0_4 = g.core.config.peakarena_level_info
local var_0_5 = g.core.config.parameter_info
local var_0_6 = g.core.config.peakarena_activity_info
local var_0_7 = g.core.common.ServerTime
local var_0_8 = g.core.model.User
local var_0_9 = g.core.model.User.taskData
local var_0_10 = g.core.model.User.guideData
local var_0_11 = g.core.common.Drops
local PeakArenaGroupStruct = import(".PeakArenaGroupStruct")
local PeakStageUserStruct = import(".PeakStageUserStruct")
local PeakArenaData = class("PeakArenaData")

function PeakArenaData:ctor()
	self:initData()
end

function PeakArenaData:initData()
	self._crossActivityId = 1
	self._startTime = 0
	self._integralStageEndTime = 0
	self._groupStageEndTime = 0
	self._finalStageEndTime = 0
	self._finishTime = 0
	self._battleId = 0
	self._myselfEnterPeak = false
	self._myGroupIdInPeak = 1
	self._openSvrTimeLimit = 0
	self._lastSelectMatchTime = 0
	self._formationLimitTime = var_0_5.get(20055).parameter
	self._peakStageSvrRoundInfoArr = {}
	self._roundStartTimeArr = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1.ID_ROUND_START_TIME) do
		table.insert(self._roundStartTimeArr, var_0_5.get(iter_2_1).parameter)
	end

	self._svrSidArr = {}
	self._myselfInfo = {
		score = 0,
		rank = 0,
		old_score = 0,
		win_count = 0,
		match_count = 0,
		old_rank = 0,
		final_lv = var_0_2.NONE,
		awards = {}
	}
	self._groupStructDict = {}
	self._recordArr = {}
	self._matchedOpponentInfo = nil
	self._rankArrDict = {}
	self._myRankingDict = {}
	self._seasonArr = {}
	self._peakStageUserStructDict = {}
	self._playbackDict = {}
	self._peakStageRound2Dict = {}
	self._betDict = {}
	self._matchMode = var_0_1.PeakArenaMatchMode.GUILD
	self._hasCheerIds = {}
	self._recvUserRankAward = {}
	self._hasAward = false
	self._hasCheer = false
end

function PeakArenaData:sendCrossRedPoint()
	return
end

function PeakArenaData:_logActivityInfo()
	g.core.log:info("---------      当前时间：", var_0_7:getDate())
	g.core.log:info("---------      开服限制时间：", var_0_7:getDate(self._openSvrTimeLimit))
	g.core.log:info("---------      活动开始时间：", var_0_7:getDate(self._startTime))
	g.core.log:info("---------      积分赛结束时间：", var_0_7:getDate(self._integralStageEndTime))
	g.core.log:info("---------      小组赛结束时间：", var_0_7:getDate(self._groupStageEndTime))
	g.core.log:info("---------      巅峰赛赛结束时间：", var_0_7:getDate(self._finalStageEndTime))
	g.core.log:info("---------      活动结束时间：", var_0_7:getDate(self._finishTime))
end

function PeakArenaData:onS2CUpdateRedPoint(arg_5_1)
	self._hasAward = checkbool(arg_5_1.has_award)
	self._hasCheer = checkbool(arg_5_1.has_cheer)
end

function PeakArenaData:onS2CGetInfo(arg_6_1)
	self._myselfEnterPeak = checkbool(arg_6_1.is_final_player)

	if self._myselfEnterPeak then
		self._myGroupIdInPeak = self:toClientGroupId(arg_6_1.room_id or 0)
	end

	local var_6_1 = arg_6_1.info or {}

	self._startTime = var_6_1.start_time or 0
	self._integralStageEndTime = var_6_1.advance_end_time or 0
	self._groupStageEndTime = var_6_1.group_end_time or 0
	self._finalStageEndTime = var_6_1.final_end_time or 0
	self._finishTime = var_6_1.finish_time or 0
	self._crossActivityId = var_6_1.sub_id or 1
	self._openSvrTimeLimit = var_0_7:getTimeByOpenDay(var_6_1.open_days or 1)
	self._matchMode = arg_6_1.match_mode or var_0_1.PeakArenaMatchMode.NONE
end

function PeakArenaData:onS2CGetServerInfo(arg_7_1)
	self._svrSidArr = arg_7_1.server_infos or {}
end

function PeakArenaData:onS2CGetUserInfo(arg_8_1)
	if arg_8_1.info then
		table.merge(self._myselfInfo, arg_8_1.info)
	end

	self._myselfInfo.final_lv = arg_8_1.final_lv

	local var_8_0 = arg_8_1.user_data

	if arg_8_1.user_data then
		self._myselfInfo.old_score = var_8_0.old_score or 0
	end

	local var_8_1 = arg_8_1.rank or 0

	self._myselfInfo.rank = var_8_1
	self._myselfInfo.old_rank = var_8_1

	if not table.keyof(var_0_2, self._myselfInfo.final_lv) then
		self._myselfInfo.final_lv = var_0_2.NONE
	end

	self._hasCheerIds = var_8_0.cheer_user_ids or {}
	self._recvUserRankAward = var_8_0.alliance_rank_award_user_ids or {}
end

function PeakArenaData:onS2CGetFinalInfo(arg_9_1)
	local var_9_0 = arg_9_1.rounds or {}

	if checkbool(var_9_0[1]) then
		self._peakStageUserStructDict = {}
		self._peakStageSvrRoundInfoArr = var_9_0
		self._playbackDict = {}
		self._betDict = {}
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.user_data or {}) do
		local var_9_1 = PeakStageUserStruct.new(iter_9_1)
		local var_9_2 = var_9_1:getUserId()

		if var_9_2 > 0 then
			self._peakStageUserStructDict[var_9_2] = var_9_1
		end
	end

	local var_9_3 = {}

	for iter_9_2, iter_9_3 in ipairs(self._peakStageSvrRoundInfoArr or {}) do
		var_9_3[iter_9_3.round] = iter_9_3.uids or {}
	end

	self:_updateUsersHonorTitleType(var_9_3)

	for iter_9_4 = 1, var_0_1.FINAL_GROUP_ID do
		self:getGroupStruct(iter_9_4):updateData(var_9_3)
	end

	for iter_9_5, iter_9_6 in ipairs(arg_9_1.battle_ids or {}) do
		self._playbackDict[self:getPlaybackKey(iter_9_6.round, iter_9_6.uid)] = iter_9_6.battle_id
	end

	for iter_9_7, iter_9_8 in ipairs(arg_9_1.bet_data or {}) do
		self._betDict[iter_9_8.uid] = iter_9_8.num
	end
end

function PeakArenaData:onS2CGetRecords(arg_10_1)
	local var_10_0 = arg_10_1.records or {}

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		return arg_11_0.timestamp > arg_11_1.timestamp
	end)

	self._recordArr[var_0_1.MatchRecordType.PERSONAL] = var_10_0
end

function PeakArenaData:onS2CMatch(arg_12_1)
	local var_12_0 = arg_12_1.robot_id and arg_12_1.robot_id > 0
	local var_12_1 = {}

	if var_12_0 then
		var_12_1.targetId = arg_12_1.robot_id or arg_12_1.target_id
	end

	var_12_1.isRobot = var_12_0
	var_12_1.score = arg_12_1.target_score or 0
	var_12_1.myScore = arg_12_1.self_score or 0
	self._matchedOpponentInfo = var_12_1
end

function PeakArenaData:onS2CChallengeBegin(arg_13_1)
	self._battleId = arg_13_1.battle_id or 0
end

function PeakArenaData:onS2CChallengeFinish(arg_14_1)
	if arg_14_1.is_win then
		self._myselfInfo.win_count = self._myselfInfo.win_count + 1
	end

	self._myselfInfo.old_score = self._myselfInfo.score
	self._myselfInfo.score = arg_14_1.score or 0
	self._myselfInfo.old_rank = self._myselfInfo.rank
	self._myselfInfo.rank = arg_14_1.rank
	self._myselfInfo.match_count = self._myselfInfo.match_count + 1
end

function PeakArenaData:onS2CPeakArenaHistory(arg_15_1)
	local var_15_0 = arg_15_1.historys or {}

	if #var_15_0 > 1 then
		table.sort(var_15_0, function(arg_16_0, arg_16_1)
			return arg_16_0.start_time > arg_16_1.start_time
		end)
	end

	self._seasonArr = var_15_0
end

function PeakArenaData:onS2CGetCommonRankList(arg_17_1)
	local var_17_0 = arg_17_1.self_rank or 0
	local var_17_1 = arg_17_1.rank_units or {}

	self._myRankingDict[arg_17_1.id] = var_17_0
	self._rankArrDict[arg_17_1.id] = var_17_1
	self._myselfInfo.rank = var_17_0

	local var_17_2 = var_0_8:getId()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if iter_17_1.id == var_17_2 then
			self._myselfInfo.score = iter_17_1.score or 0

			break
		end
	end
end

function PeakArenaData:onS2CPlayBets(arg_18_1)
	local var_18_0 = arg_18_1.target or 0

	if var_18_0 > 0 then
		local var_18_1 = self._betDict[var_18_0] or 0

		if var_18_1 == 0 then
			self:getPeakStageUserStructWithId(var_18_0):addSupportNum(1)
		end

		self._betDict[var_18_0] = var_18_1 + arg_18_1.bets
	end
end

function PeakArenaData:_updateUsersHonorTitleType(arg_19_1)
	local var_19_0 = {}

	for iter_19_0 = var_0_2.FIRST, var_0_2.TOP_64, -1 do
		for iter_19_1, iter_19_2 in ipairs(arg_19_1[iter_19_0 - 1] or {}) do
			if iter_19_2 > 0 and not var_19_0[iter_19_2] then
				local var_19_2 = self:getPeakStageUserStructWithId(iter_19_2)

				if var_19_2 then
					var_19_2:setHonorTitleType(iter_19_0)
				end

				var_19_0[iter_19_2] = 1
			end
		end
	end
end

function PeakArenaData:getCrossActivityId()
	return self._crossActivityId
end

function PeakArenaData:getName(arg_21_1)
	if not arg_21_1 or arg_21_1 < 1 then
		arg_21_1 = 1
	end

	return var_0_6.get(arg_21_1).activity_name
end

function PeakArenaData:getBuffDesc(arg_22_1)
	arg_22_1 = arg_22_1 or 1

	local var_22_0 = g.core.config.talent_skill_info.fetch(var_0_6.get(arg_22_1).talent_skill)

	var_22_0 = var_22_0 or {}

	return var_22_0.description or ""
end

function PeakArenaData:getGroupStruct(arg_23_1)
	self._groupStructDict[arg_23_1] = self._groupStructDict[arg_23_1] or PeakArenaGroupStruct.new(arg_23_1)

	return self._groupStructDict[arg_23_1]
end

function PeakArenaData:getMyselfInfo()
	return self._myselfInfo
end

function PeakArenaData:resetOldScore()
	self._myselfInfo.old_score = self._myselfInfo.score
end

function PeakArenaData:getServerSidArr()
	return self._svrSidArr
end

function PeakArenaData:getPercentageOdds()
	if self._myselfInfo.match_count < 1 then
		return 0
	else
		return math.ceil(self._myselfInfo.win_count / self._myselfInfo.match_count * 1000) / 10
	end
end

function PeakArenaData:isExistDailyTaskAward()
	local var_28_0 = self:getStageType()

	if var_28_0 ~= var_0_3.INTEGRAL then
		if var_28_0 == var_0_3.PEAK then
			local var_28_1, var_28_2 = next((self:getTaskCfgArr()))

			if var_28_2 then
				return var_0_9:getTaskState(var_28_2) == var_0_0.TaskConst.TASK_STATE.CAN_ACCEPT
			end
		end
	end

	return false
end

function PeakArenaData:getStartTime()
	return self._startTime
end

function PeakArenaData:getIntegralStageEndTime()
	return self._integralStageEndTime
end

function PeakArenaData:getGroupStageEndTime()
	return self._groupStageEndTime
end

function PeakArenaData:getFinalStageEndTime()
	return self._finalStageEndTime
end

function PeakArenaData:getFinishTime()
	return self._finishTime
end

function PeakArenaData:getStageType()
	if self._startTime < self._openSvrTimeLimit then
		return var_0_3.NONE
	end

	local var_34_0 = var_0_7:getTime()

	if var_34_0 < self._startTime then
		return var_0_3.NONE
	elseif var_34_0 < self._integralStageEndTime then
		return var_0_3.INTEGRAL
	elseif var_34_0 < self._finalStageEndTime then
		return var_0_3.PEAK
	elseif var_34_0 < self._finishTime then
		return var_0_3.TOP_SHOW
	else
		return var_0_3.NONE
	end
end

function PeakArenaData:isShowEntrance()
	return self:getStageType() ~= var_0_3.NONE and self:getMatchMode() ~= var_0_1.PeakArenaMatchMode.NONE
end

function PeakArenaData:isGrading()
	return self._myselfInfo.match_count > 0
end

function PeakArenaData:getPALevelInfo(arg_37_1)
	arg_37_1 = arg_37_1 or 0

	local var_37_0 = var_0_4.get(1)

	arg_37_1 = math.max(var_37_0.integral, arg_37_1)

	local var_37_1 = var_0_4.getLength()

	arg_37_1 = math.min(var_0_4.get(var_37_1).integral, arg_37_1)

	for iter_37_0 = var_37_1, 1, -1 do
		local var_37_2 = var_0_4.get(iter_37_0)

		if arg_37_1 >= var_37_2.integral then
			return var_37_2
		end
	end

	return var_37_0
end

function PeakArenaData:getMaxStarNum(arg_38_1)
	return (math.max(1, #var_0_4.match(function(arg_39_0)
		return arg_39_0.pic == arg_38_1
	end)))
end

function PeakArenaData:getMaxStarNumWithScore(arg_40_1)
	return self:getMaxStarNum(self:getPALevelInfo(arg_40_1).pic)
end

function PeakArenaData:getRecordArrWithType(arg_41_1)
	return self._recordArr[arg_41_1]
end

function PeakArenaData:getRecordByBattleId(arg_42_1)
	for iter_42_0, iter_42_1 in ipairs((self:getRecordArrWithType(var_0_1.MatchRecordType.PERSONAL))) do
		if iter_42_1.battle_id == arg_42_1 then
			return iter_42_1
		end
	end

	return nil
end

function PeakArenaData:cacheRecordBattleId(arg_43_1)
	self._cacheBattleId = arg_43_1
end

function PeakArenaData:getCacheBattleId()
	return self._cacheBattleId
end

function PeakArenaData:getMatchedOpponentInfo()
	return self._matchedOpponentInfo
end

function PeakArenaData:clearMatchedOpponentInfo()
	self._matchedOpponentInfo = nil
end

function PeakArenaData:getBattleId()
	return self._battleId
end

function PeakArenaData:clearBattleId()
	self._battleId = 0
end

function PeakArenaData:getPeakStageUserNumWithRound(arg_49_1)
	return self:getGroupStruct(1):getUserNumWithRound(arg_49_1)
end

function PeakArenaData:getPeakStageGroupType()
	if var_0_7:getTime() < self._groupStageEndTime then
		return var_0_1.GroupType.GROUP
	else
		return var_0_1.GroupType.FINAL
	end
end

function PeakArenaData:getDefaultShowGroupId()
	if self._myselfEnterPeak then
		return self._myGroupIdInPeak
	else
		return 1
	end
end

function PeakArenaData:_checkClientGroupId(arg_52_1)
	arg_52_1 = math.max(1, arg_52_1)
	arg_52_1 = math.min(var_0_1.FINAL_GROUP_ID, arg_52_1)

	return arg_52_1
end

function PeakArenaData:toSvrGroupId(arg_53_1)
	arg_53_1 = self:_checkClientGroupId(arg_53_1)

	return arg_53_1 - 1
end

function PeakArenaData:toClientGroupId(arg_54_1)
	return (self:_checkClientGroupId(arg_54_1 + 1))
end

function PeakArenaData:getDanGradingChangeType()
	if self:isFirstEntrySeason() then
		if g.core.guide.GuideProxy:isGuideRunning() then
			return var_0_1.DanGradingChangeType.NONE
		elseif not var_0_10:getServerDataById(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.PEAK_ARENA_TICK_GUIDE_ID) then
			return var_0_1.DanGradingChangeType.NONE
		else
			return var_0_1.DanGradingChangeType.INHERIT
		end
	else
		local var_55_0 = self:getPALevelInfo(self._myselfInfo.score)
		local var_55_1 = self:getPALevelInfo(self._myselfInfo.old_score)

		if var_55_0.pic * 100 + var_55_0.star == var_55_1.pic * 100 + var_55_1.star then
			return var_0_1.DanGradingChangeType.NONE
		elseif var_55_1.pic * 100 + var_55_1.star < var_55_0.pic * 100 + var_55_0.star then
			if var_55_1.pic < var_55_0.pic then
				return var_0_1.DanGradingChangeType.LARGE_UP
			else
				return var_0_1.DanGradingChangeType.SMALL_UP
			end
		else
			return var_0_1.DanGradingChangeType.DOWN
		end
	end
end

function PeakArenaData:isFirstEntrySeason()
	if self._myselfInfo.match_count > 0 then
		return false
	else
		return self:_getJsonDict()[self:_getEnteredSeasonKey()] ~= 1
	end
end

function PeakArenaData:setEnteredSeason(arg_57_1)
	local var_57_0 = arg_57_1 and 1 or 0
	local var_57_1 = self:_getJsonDict()
	local var_57_2 = self:_getEnteredSeasonKey()

	if var_57_1[var_57_2] ~= (arg_57_1 and 1 or 0) then
		var_57_1[var_57_2] = var_57_0

		g.core.common.Storage:save(var_0_1.JSON_NAME, var_57_1)
	end
end

function PeakArenaData:_getEnteredSeasonKey()
	return "entrySeason_" .. tostring(self._startTime)
end

function PeakArenaData:_getJsonDict()
	return g.core.common.Storage:load(var_0_1.JSON_NAME) or {}
end

function PeakArenaData:getMaxMatchingDuration()
	return var_0_5.get(var_0_1.ID_MAX_MATCHING_DURATION).parameter
end

function PeakArenaData:getRankList(arg_61_1)
	return self._rankArrDict[arg_61_1] or {}
end

function PeakArenaData:getMyRankingForRankingList(arg_62_1)
	return self._myRankingDict[arg_62_1] or 0
end

function PeakArenaData:getLevelInfoList()
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in var_0_4.ipairs() do
		local var_63_1 = var_0_4.fetch(iter_63_0 + 1)

		table.insert(var_63_0, {
			cfg = iter_63_1,
			minScore = iter_63_1.integral,
			maxScore = (var_63_1 or nil) and var_63_1.integral - 1,
			awardData = (iter_63_1.drop > 0 or nil) and var_0_11:getGoodsArray(iter_63_1.drop)
		})
	end

	table.sort(var_63_0, function(arg_64_0, arg_64_1)
		return arg_64_1.minScore < arg_64_0.minScore
	end)

	return var_63_0
end

function PeakArenaData:resetRecordList()
	self._recordArr = {}
end

function PeakArenaData:getTaskCfgArr()
	local var_66_0 = {}
	local var_66_1 = self:getStageType()
	local var_66_2 = self:getPeakStageGroupType()

	for iter_66_0, iter_66_1 in ipairs((var_0_9:getTaskCfgArrByModuleId(var_0_0.TaskConst.MODULE_ID.PEAK_ARENA))) do
		if iter_66_1.tab == var_0_1.DailyTaskTabType.PUBLIC then
			table.insert(var_66_0, iter_66_1)
		elseif iter_66_1.tab == var_0_1.DailyTaskTabType.INTEGRAL then
			if var_66_1 == var_0_3.INTEGRAL then
				table.insert(var_66_0, iter_66_1)
			end
		elseif iter_66_1.tab == var_0_1.DailyTaskTabType.PEAK then
			if var_66_1 == var_0_3.PEAK then
				table.insert(var_66_0, iter_66_1)
			end
		elseif iter_66_1.tab == var_0_1.DailyTaskTabType.PEAK_GROUP and var_66_1 == var_0_3.PEAK and var_66_2 == var_0_1.GroupType.GROUP then
			table.insert(var_66_0, iter_66_1)
		end
	end

	if #var_66_0 > 1 then
		table.sort(var_66_0, function(arg_67_0, arg_67_1)
			local var_67_0 = var_0_9:getTaskState(arg_67_0)
			local var_67_1 = var_0_9:getTaskState(arg_67_1)

			if var_67_0 == var_67_1 then
				return arg_67_0.id < arg_67_1.id
			else
				return var_67_0 < var_67_1
			end
		end)
	end

	return var_66_0
end

function PeakArenaData:getPeakArenaHistory()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs(self._seasonArr or {}) do
		if iter_68_1.top_user_ids then
			table.insert(var_68_0, iter_68_1)
		end
	end

	return var_68_0
end

function PeakArenaData:isGroupDataExpired(arg_69_1)
	if self:getGroupStruct(arg_69_1):isEmpty() then
		return true
	end

	return self:getStageType() ~= var_0_3.TOP_SHOW
end

function PeakArenaData:getPlaybackKey(arg_70_1, arg_70_2)
	return arg_70_1 .. "_" .. arg_70_2
end

function PeakArenaData:getPlaybackId(arg_71_1, arg_71_2, arg_71_3)
	if arg_71_1 == var_0_1.FINAL_GROUP_ID then
		arg_71_2 = arg_71_2 + 3
	end

	return self._playbackDict[self:getPlaybackKey(arg_71_2, arg_71_3)]
end

function PeakArenaData:getPlaybackIdWithUserIdx(arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = self:getGroupStruct(arg_72_1):getWinnerUserId(arg_72_2, arg_72_3)

	if var_72_0 > 0 then
		return self:getPlaybackId(arg_72_1, arg_72_2, var_72_0)
	end
end

function PeakArenaData:getRoundStartTime(arg_73_1, arg_73_2)
	if not self._roundStartTimeArr[arg_73_2] then
		return 0
	end

	if arg_73_1 == var_0_1.FINAL_GROUP_ID then
		return self._groupStageEndTime + self._roundStartTimeArr[arg_73_2]
	else
		return self._integralStageEndTime + self._roundStartTimeArr[arg_73_2]
	end
end

function PeakArenaData:getNextRoundWithTime(arg_74_1, arg_74_2)
	for iter_74_0 = 1, var_0_1.PEAK_STAGE_ROUND do
		if arg_74_2 <= self:getRoundStartTime(arg_74_1, iter_74_0) then
			return iter_74_0
		end
	end

	return 0
end

function PeakArenaData:cancelMatching()
	self._lastSelectMatchTime = var_0_7:getTime()
end

function PeakArenaData:isCanSelectMatchBtn()
	local var_76_0 = var_0_7:getTime()

	if var_76_0 - self._lastSelectMatchTime > var_0_1.SELECT_MATCH_INTERVAL_TIME then
		self._lastSelectMatchTime = var_76_0

		return true
	end

	return false
end

function PeakArenaData:getUserSnapshotWithId(arg_77_1)
	return g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_77_1)
end

function PeakArenaData:getPeakStageUserStructWithId(arg_78_1)
	if arg_78_1 and arg_78_1 > 0 then
		return self._peakStageUserStructDict[arg_78_1]
	end
end

function PeakArenaData:gotoBetListPopEnable()
	return checkbool(next(self._peakStageUserStructDict))
end

function PeakArenaData:getMyBetNum(arg_80_1)
	local var_80_0 = 0

	if arg_80_1 and arg_80_1 > 0 then
		var_80_0 = self._betDict[arg_80_1]
	end

	var_80_0 = var_80_0 or 0

	return var_80_0
end

function PeakArenaData:getTotalBetNum()
	local var_81_0 = 0

	for iter_81_0, iter_81_1 in pairs(self._betDict) do
		var_81_0 = var_81_0 + iter_81_1
	end

	return var_81_0
end

function PeakArenaData:getRemainBetNum()
	return (math.max(var_0_5.get(var_0_1.ID_MAX_BET_NUM).parameter - self:getTotalBetNum(), 0))
end

function PeakArenaData:isIBetOnHim(arg_83_1)
	return (self._betDict[arg_83_1] or 0) > 0
end

function PeakArenaData:getBetEndTime()
	return self:getRoundStartTime(1, 1)
end

function PeakArenaData:getBetStarTime()
	return self._integralStageEndTime
end

function PeakArenaData:isBetTime()
	local var_86_0 = self:getBetEndTime()
	local var_86_1 = var_0_7:getTime()

	return self:getBetStarTime() < var_86_1 and var_86_1 < var_86_0
end

function PeakArenaData:getChampionUserId()
	return (self:getGroupStruct(var_0_1.FINAL_GROUP_ID):getUserIdWithRoundUserIdx(var_0_1.PEAK_STAGE_ROUND, 1))
end

function PeakArenaData:isThereNoEditMulTeam()
	if not self:isMulTeamEditTime() then
		return false
	end

	local var_88_0 = var_0_0.LineUpConst.MulTeamType.PEAK_ARENA

	if not g.core.model.User.mulFormationData:getFormationStruct(var_0_0.LineUpConst.MulTeamType.PEAK_ARENA, 1):isThereKnightLineup() then
		return true
	end

	if not g.core.model.User.mulFormationData:getFormationStruct(var_88_0, 2):isThereKnightLineup() then
		return true
	end

	if not g.core.model.User.mulFormationData:getFormationStruct(var_88_0, 3):isThereKnightLineup() then
		return true
	end

	return false
end

function PeakArenaData:isShowMulTeamEditBtnNewPoint(arg_89_1)
	if self:isMulTeamEditTime() then
		return self:_getJsonDict().mulTeamEditBtnNewPointShowed ~= 1
	end

	return false
end

function PeakArenaData:saveMulTeamEditBtnNewPointShowedState()
	local var_90_0 = self:_getJsonDict()

	if var_90_0.mulTeamEditBtnNewPointShowed ~= 1 then
		var_90_0.mulTeamEditBtnNewPointShowed = 1

		g.core.common.Storage:save(var_0_1.JSON_NAME, var_90_0)
	end
end

function PeakArenaData:isMulTeamEditTime()
	if self:getStageType() == var_0_3.PEAK then
		return self:getFormationCD() > 0
	else
		return false
	end
end

function PeakArenaData:isReqMulTeamDataAfterInfoRes()
	if self:isMulTeamEditTime() then
		return not g.core.model.User.mulFormationData:isInitWithSvrData(var_0_0.LineUpConst.MulTeamType.PEAK_ARENA)
	end

	return false
end

function PeakArenaData:getMyRank()
	return self._myselfInfo.rank
end

function PeakArenaData:getFormationCD()
	return self:getBetEndTime() - self._formationLimitTime - var_0_7:getTime()
end

function PeakArenaData:getCheerCount()
	return 0
end

function PeakArenaData:getOwnCheerCount()
	return 0
end

function PeakArenaData:isChestRcv()
	return false
end

function PeakArenaData:getMatchMode()
	return self._matchMode
end

function PeakArenaData:hasCanCheerCount()
	return false
end

function PeakArenaData:hasRankAwardCanRecv()
	return false
end

function PeakArenaData:resetHasCheer()
	self._hasCheer = false
end

function PeakArenaData:resetHasAward()
	self._hasAward = false
end

return PeakArenaData
