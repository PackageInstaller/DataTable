local PeakArenaBaseData = class("PeakArenaBaseData")
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst

function PeakArenaBaseData:ctor()
	self:initData()
end

function PeakArenaBaseData:initData()
	if self._peakArenaData then
		self._peakArenaData:initData()
	end

	self._peakArenaData = nil
end

function PeakArenaBaseData:sendCrossRedPoint()
	return self._peakArenaData:sendCrossRedPoint()
end

function PeakArenaBaseData:onS2CUpdateRedPoint(arg_4_1)
	if self._peakArenaData then
		self._peakArenaData:onS2CUpdateRedPoint(arg_4_1)
	end
end

function PeakArenaBaseData:onS2CGetInfo(arg_5_1)
	if self._peakArenaData then
		self._peakArenaData:onS2CGetInfo(arg_5_1)
	else
		if arg_5_1.match_mode and arg_5_1.match_mode == var_0_2.PeakArenaMatchMode.ALLIANCE then
			g.core.model.User:delayLoadData("peakArena2Data", "app.view.module.peakArena.model.PeakArena2Data")

			self._peakArenaData = g.core.model.User.peakArena2Data
		else
			g.core.model.User:delayLoadData("peakArena1Data", "app.view.module.peakArena.model.PeakArenaData")

			self._peakArenaData = g.core.model.User.peakArena1Data
		end

		self._peakArenaData:onS2CGetInfo(arg_5_1)
	end

	self._peakArenaData:sendCrossRedPoint()
end

function PeakArenaBaseData:onS2CGetServerInfo(arg_6_1)
	self._peakArenaData:onS2CGetServerInfo(arg_6_1)
end

function PeakArenaBaseData:onS2CGetUserInfo(arg_7_1)
	self._peakArenaData:onS2CGetUserInfo(arg_7_1)
end

function PeakArenaBaseData:onS2CGetFinalInfo(arg_8_1)
	self._peakArenaData:onS2CGetFinalInfo(arg_8_1)
end

function PeakArenaBaseData:onS2CGetRecords(arg_9_1)
	self._peakArenaData:onS2CGetRecords(arg_9_1)
end

function PeakArenaBaseData:onS2CMatch(arg_10_1)
	self._peakArenaData:onS2CMatch(arg_10_1)
end

function PeakArenaBaseData:onS2CChallengeBegin(arg_11_1)
	self._peakArenaData:onS2CChallengeBegin(arg_11_1)
end

function PeakArenaBaseData:onS2CChallengeFinish(arg_12_1)
	self._peakArenaData:onS2CChallengeFinish(arg_12_1)
end

function PeakArenaBaseData:onS2CPeakArenaHistory(arg_13_1)
	self._peakArenaData:onS2CPeakArenaHistory(arg_13_1)
end

function PeakArenaBaseData:onS2CGetCommonRankList(arg_14_1)
	self._peakArenaData:onS2CGetCommonRankList(arg_14_1)
end

function PeakArenaBaseData:onS2CPlayBets(arg_15_1)
	self._peakArenaData:onS2CPlayBets(arg_15_1)
end

function PeakArenaBaseData:onS2CCheer(arg_16_1)
	self._peakArenaData:onS2CCheer(arg_16_1)
end

function PeakArenaBaseData:onS2CAllianceRankAward(arg_17_1)
	self._peakArenaData:onS2CAllianceRankAward(arg_17_1)
end

function PeakArenaBaseData:getCrossActivityId()
	return self._peakArenaData:getCrossActivityId()
end

function PeakArenaBaseData:getName(arg_19_1)
	return self._peakArenaData:getName(arg_19_1)
end

function PeakArenaBaseData:getBuffDesc(arg_20_1)
	return self._peakArenaData:getBuffDesc(arg_20_1)
end

function PeakArenaBaseData:getGroupStruct(arg_21_1)
	return self._peakArenaData:getGroupStruct(arg_21_1)
end

function PeakArenaBaseData:getMyselfInfo()
	return self._peakArenaData:getMyselfInfo()
end

function PeakArenaBaseData:resetOldScore()
	self._peakArenaData:resetOldScore()
end

function PeakArenaBaseData:getServerSidArr()
	return self._peakArenaData:getServerSidArr()
end

function PeakArenaBaseData:getPercentageOdds()
	return self._peakArenaData:getPercentageOdds()
end

function PeakArenaBaseData:isExistDailyTaskAward()
	return self._peakArenaData:isExistDailyTaskAward()
end

function PeakArenaBaseData:getStartTime()
	return self._peakArenaData:getStartTime()
end

function PeakArenaBaseData:getIntegralStageEndTime()
	return self._peakArenaData:getIntegralStageEndTime()
end

function PeakArenaBaseData:getGroupStageEndTime()
	return self._peakArenaData:getGroupStageEndTime()
end

function PeakArenaBaseData:getFinalStageEndTime()
	return self._peakArenaData:getFinalStageEndTime()
end

function PeakArenaBaseData:getFinishTime()
	return self._peakArenaData:getFinishTime()
end

function PeakArenaBaseData:getStageType()
	return self._peakArenaData and self._peakArenaData:getStageType()
end

function PeakArenaBaseData:isShowEntrance()
	return self._peakArenaData and self._peakArenaData:isShowEntrance()
end

function PeakArenaBaseData:isGrading()
	return self._peakArenaData:isGrading()
end

function PeakArenaBaseData:getPALevelInfo(arg_35_1)
	return self._peakArenaData:getPALevelInfo(arg_35_1)
end

function PeakArenaBaseData:getMaxStarNum(arg_36_1)
	return self._peakArenaData:getMaxStarNum(arg_36_1)
end

function PeakArenaBaseData:getMaxStarNumWithScore(arg_37_1)
	return self._peakArenaData:getMaxStarNumWithScore(arg_37_1)
end

function PeakArenaBaseData:getRecordArrWithType(arg_38_1)
	return self._peakArenaData:getRecordArrWithType(arg_38_1)
end

function PeakArenaBaseData:getMatchedOpponentInfo()
	return self._peakArenaData:getMatchedOpponentInfo()
end

function PeakArenaBaseData:clearMatchedOpponentInfo()
	self._peakArenaData:clearMatchedOpponentInfo()
end

function PeakArenaBaseData:getBattleId()
	return self._peakArenaData:getBattleId()
end

function PeakArenaBaseData:clearBattleId()
	self._peakArenaData:clearBattleId()
end

function PeakArenaBaseData:getPeakStageUserNumWithRound(arg_43_1)
	return self:getGroupStruct(1):getUserNumWithRound(arg_43_1)
end

function PeakArenaBaseData:getPeakStageGroupType()
	return self._peakArenaData:getPeakStageGroupType()
end

function PeakArenaBaseData:getDefaultShowGroupId()
	return self._peakArenaData:getDefaultShowGroupId()
end

function PeakArenaBaseData:toSvrGroupId(arg_46_1)
	return self._peakArenaData:toSvrGroupId(arg_46_1)
end

function PeakArenaBaseData:toClientGroupId(arg_47_1)
	return self._peakArenaData:toClientGroupId(arg_47_1)
end

function PeakArenaBaseData:getDanGradingChangeType()
	return self._peakArenaData:getDanGradingChangeType()
end

function PeakArenaBaseData:isFirstEntrySeason()
	return self._peakArenaData:isFirstEntrySeason()
end

function PeakArenaBaseData:setEnteredSeason(arg_50_1)
	self._peakArenaData:setEnteredSeason(arg_50_1)
end

function PeakArenaBaseData:getMaxMatchingDuration()
	return self._peakArenaData:getMaxMatchingDuration()
end

function PeakArenaBaseData:getRankList(arg_52_1)
	return self._peakArenaData:getRankList(arg_52_1)
end

function PeakArenaBaseData:getMyRankingForRankingList(arg_53_1)
	return self._peakArenaData:getMyRankingForRankingList(arg_53_1)
end

function PeakArenaBaseData:getLevelInfoList()
	return self._peakArenaData:getLevelInfoList()
end

function PeakArenaBaseData:resetRecordList()
	self._peakArenaData:resetRecordList()
end

function PeakArenaBaseData:getTaskCfgArr()
	return self._peakArenaData:getTaskCfgArr()
end

function PeakArenaBaseData:getPeakArenaHistory()
	return self._peakArenaData:getPeakArenaHistory()
end

function PeakArenaBaseData:isGroupDataExpired(arg_58_1)
	return self._peakArenaData:isGroupDataExpired(arg_58_1)
end

function PeakArenaBaseData:getPlaybackKey(arg_59_1, arg_59_2)
	return arg_59_1 .. "_" .. arg_59_2
end

function PeakArenaBaseData:getPlaybackId(arg_60_1, arg_60_2, arg_60_3)
	return self._peakArenaData:getPlaybackId(arg_60_1, arg_60_2, arg_60_3)
end

function PeakArenaBaseData:getPlaybackIdWithUserIdx(arg_61_1, arg_61_2, arg_61_3)
	return self._peakArenaData:getPlaybackIdWithUserIdx(arg_61_1, arg_61_2, arg_61_3)
end

function PeakArenaBaseData:getRoundStartTime(arg_62_1, arg_62_2)
	return self._peakArenaData:getRoundStartTime(arg_62_1, arg_62_2)
end

function PeakArenaBaseData:getNextRoundWithTime(arg_63_1, arg_63_2)
	return self._peakArenaData:getNextRoundWithTime(arg_63_1, arg_63_2)
end

function PeakArenaBaseData:cancelMatching()
	self._peakArenaData:cancelMatching()
end

function PeakArenaBaseData:isCanSelectMatchBtn()
	return self._peakArenaData:isCanSelectMatchBtn()
end

function PeakArenaBaseData:getUserSnapshotWithId(arg_66_1)
	return self._peakArenaData:getUserSnapshotWithId(arg_66_1)
end

function PeakArenaBaseData:getPeakStageUserStructWithId(arg_67_1)
	return self._peakArenaData:getPeakStageUserStructWithId(arg_67_1)
end

function PeakArenaBaseData:gotoBetListPopEnable()
	return self._peakArenaData:gotoBetListPopEnable()
end

function PeakArenaBaseData:getMyBetNum(arg_69_1)
	return self._peakArenaData:getMyBetNum(arg_69_1)
end

function PeakArenaBaseData:getTotalBetNum()
	return self._peakArenaData:getTotalBetNum()
end

function PeakArenaBaseData:getRemainBetNum()
	return self._peakArenaData:getRemainBetNum()
end

function PeakArenaBaseData:isIBetOnHim(arg_72_1)
	return self._peakArenaData:isIBetOnHim(arg_72_1)
end

function PeakArenaBaseData:getBetEndTime()
	return self._peakArenaData:getBetEndTime()
end

function PeakArenaBaseData:getBetStarTime()
	return self._peakArenaData:getBetStarTime()
end

function PeakArenaBaseData:isBetTime()
	return self._peakArenaData:isBetTime()
end

function PeakArenaBaseData:getChampionUserId()
	return self._peakArenaData:getChampionUserId()
end

function PeakArenaBaseData:isThereNoEditMulTeam()
	return self._peakArenaData:isThereNoEditMulTeam()
end

function PeakArenaBaseData:isShowMulTeamEditBtnNewPoint(arg_78_1)
	return self._peakArenaData:isShowMulTeamEditBtnNewPoint(arg_78_1)
end

function PeakArenaBaseData:saveMulTeamEditBtnNewPointShowedState()
	self._peakArenaData:saveMulTeamEditBtnNewPointShowedState()
end

function PeakArenaBaseData:isMulTeamEditTime()
	return self._peakArenaData:isMulTeamEditTime()
end

function PeakArenaBaseData:isReqMulTeamDataAfterInfoRes()
	return self._peakArenaData:isReqMulTeamDataAfterInfoRes()
end

function PeakArenaBaseData:getMyRank()
	return self._peakArenaData:getMyRank()
end

function PeakArenaBaseData:getFormationCD()
	return self._peakArenaData:getFormationCD()
end

function PeakArenaBaseData:getMatchMode()
	return self._peakArenaData:getMatchMode()
end

function PeakArenaBaseData:isCheerActive()
	return self._peakArenaData:getMatchMode() == var_0_2.PeakArenaMatchMode.ALLIANCE
end

function PeakArenaBaseData:isUserCheer(arg_86_1)
	return self._peakArenaData:isUserCheer(arg_86_1)
end

function PeakArenaBaseData:isChestActive()
	return self._peakArenaData:getMatchMode() == var_0_2.PeakArenaMatchMode.ALLIANCE
end

function PeakArenaBaseData:isShowAlliance()
	return self._peakArenaData:getMatchMode() == var_0_2.PeakArenaMatchMode.ALLIANCE
end

function PeakArenaBaseData:getCheerCount(arg_89_1)
	return self._peakArenaData:getCheerCount(arg_89_1)
end

function PeakArenaBaseData:getOwnCheerCount()
	return self._peakArenaData:getOwnCheerCount()
end

function PeakArenaBaseData:isRankAwardRecv(arg_91_1)
	return self._peakArenaData:isRankAwardRecv(arg_91_1)
end

function PeakArenaBaseData:hasCanCheerCount()
	return self._peakArenaData and self._peakArenaData:hasCanCheerCount()
end

function PeakArenaBaseData:hasRankAwardCanRecv()
	return self._peakArenaData and self._peakArenaData:hasRankAwardCanRecv()
end

function PeakArenaBaseData:resetHasCheer()
	self._peakArenaData:resetHasCheer()
end

function PeakArenaBaseData:resetHasAward()
	self._peakArenaData:resetHasAward()
end

function PeakArenaBaseData:getRecordByBattleId(arg_96_1)
	return self._peakArenaData:getRecordByBattleId(arg_96_1)
end

function PeakArenaBaseData:cacheRecordBattleId(arg_97_1)
	self._peakArenaData:cacheRecordBattleId(arg_97_1)
end

function PeakArenaBaseData:getCacheBattleId()
	return self._peakArenaData:getCacheBattleId()
end

return PeakArenaBaseData
