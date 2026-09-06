-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/controller/BattleRecordRankController.lua

module("logic.extensions.battlerecord.controller.BattleRecordRankController", package.seeall)

local BattleRecordRankController = class("BattleRecordRankController", BaseController)

BattleRecordRankController.ChllengePrefix = "challenge_"
BattleRecordRankController.WTowerPrefix = "wt_"
BattleRecordRankController.PetTrainningPrefix = "kl_"
BattleRecordRankController.BFPrefix = "bf_"
BattleRecordRankController.StoryPrefix = "pf_"
BattleRecordRankController.PvePrefix = "pve_"
BattleRecordRankController.LegendPrefix = "lc_"
BattleRecordRankController.TechingPrefix = "bc_"
BattleRecordRankController.EndlessPrefix = "inf_"
BattleRecordRankController.ChuangkongUnion = "cku_"
BattleRecordRankController.TeachPrefix = "bc_"
BattleRecordRankController.HonourTowerPrefix = "ht_"

function BattleRecordRankController:onInit()
	BattleRecordRankController.super.onInit(self)

	self._lastRequestRanksTimes = nil
	self._lastRankKey = nil
	self._requestBattleRecordRanksLimit = 30
	self._lastRecordKey = nil
	self._lastRequestLatestRecordsTimes = nil
	self._requestLatestRecordsLimit = 5
	self._requestBattleRecordsLimit = 30
	self._requestBattleDetailsLimit = 30
end

function BattleRecordRankController:onReset()
	BattleRecordRankController.super.onReset(self)

	self._lastRequestRanksTimes = nil
	self._requestBattleRecordRanksLimit = 30
	self._lastRequestLatestRecordsTimes = nil
	self._requestLatestRecordsLimit = 30
	self._requestBattleRecordsLimit = 30
	self._requestBattleDetailsLimit = 30
	self._lastRankKey = nil
	self._lastRecordKey = nil
	self._lastRank = nil
	self._saveCurStack = false
end

function BattleRecordRankController:isChallengeWithBattleRecord(cId)
	local cfg = ChallengeConfig.instance:getChallengeCfg(cId)

	if cfg then
		return cfg.video
	end
end

function BattleRecordRankController:isWTowerWithBattleRecord(towerIndex, towerId)
	local levelCfg = WTowerConfig.instance:getCfgById(towerIndex, towerId)

	if levelCfg then
		return levelCfg.video
	end
end

function BattleRecordRankController:isPetTrainningWithBattleRecord(stageId)
	local stageCfg = PetTrialConfig.instance:getStageCfgById(stageId)

	if stageCfg then
		return stageCfg.needSaveVideo
	end
end

function BattleRecordRankController:isPveWithBattleRecord(pveId)
	local configCo = WuShenConfig.instance:getMasterCoById(pveId)

	if configCo then
		return configCo.video
	end

	return false
end

function BattleRecordRankController:getChallengeRankKey(cId, pId, bId, levelId)
	return BattleRecordRankController.ChllengePrefix .. cId .. "_" .. pId .. "_" .. bId .. "_" .. levelId
end

function BattleRecordRankController:getTeachRankKey(stageId)
	return BattleRecordRankController.TeachPrefix .. stageId
end

function BattleRecordRankController:getWTowerRankKey(towerId, towerIndex)
	return BattleRecordRankController.WTowerPrefix .. towerId .. "_" .. towerIndex
end

function BattleRecordRankController:getStoryKey(chapter, stage)
	return BattleRecordRankController.StoryPrefix .. chapter .. "_" .. stage
end

function BattleRecordRankController:getPetTrainningRankKey(stageId)
	return BattleRecordRankController.PetTrainningPrefix .. stageId
end

function BattleRecordRankController:getEndlessRankKey(stageId)
	return BattleRecordRankController.EndlessPrefix .. stageId
end

function BattleRecordRankController:getBfRankKey(teamId, monsterId)
	return BattleRecordRankController.BFPrefix .. teamId .. "_" .. monsterId
end

function BattleRecordRankController:getPveRankKey(pveId)
	return BattleRecordRankController.PvePrefix .. pveId
end

function BattleRecordRankController:getLegendKey(challengeId, stageId)
	return BattleRecordRankController.LegendPrefix .. challengeId .. "_" .. stageId
end

function BattleRecordRankController:enterChallengeRanksView(cId, pId, bId, levelId)
	self:enterBattleRanksView(self:getChallengeRankKey(cId, pId, bId, levelId))
end

function BattleRecordRankController:enterChallengeRecoresView(cId, pId, bId)
	self:enterBattleRecoresView(self:getChallengeRankKey(cId, pId, bId, levelId))
end

function BattleRecordRankController:enterChallenge(cId, pId, bId, levelId)
	self:enterView2(self:getChallengeRankKey(cId, pId, bId, levelId))
end

function BattleRecordRankController:enterBattleRanksView(rankKey)
	UIStateManager.instance:push(ViewName.ChallengeRank, rankKey, 1)
end

function BattleRecordRankController:enterBattleRecoresView(rankKey)
	UIStateManager.instance:push(ViewName.ChallengeRank, rankKey, 2)
end

function BattleRecordRankController:enterView(rankKey)
	UIStateManager.instance:push(ViewName.ChallengeRank, rankKey)
end

function BattleRecordRankController:enterView2(rankKey)
	UIStateManager.instance:push(ViewName.ChallengeRank2, rankKey)
end

function BattleRecordRankController:enterStoryRecord(chapterId, stageId)
	local key = self:getStoryKey(chapterId, stageId)

	self:enterView2(key)
end

function BattleRecordRankController:enterLegendRecord(challengeId, stageId)
	local key = self:getLegendKey(challengeId, stageId)

	self:enterView2(key)
end

function BattleRecordRankController:requestBattleRanks(rankKey, startRank, endRank)
	if not self:_isRankRequestTimeLimit(rankKey) then
		self._lastRankKey = rankKey
		startRank = startRank or 1
		endRank = endRank or 100

		BattleRecordRankAgent.instance:sendPM_BattleRecordGetRankReq(rankKey, startRank, endRank)
	end
end

function BattleRecordRankController:onBattleRanks(respond)
	local rankKey = self._lastRankKey

	self._lastRankKey = nil

	self:_updateLastRankRequestTime(rankKey)
	BattleRecordRankModel.instance:onBattleRecordRanks(rankKey, respond)
	GlobalDispatcher:dispatch(GlobalNotify.ChallengeRanks, rankKey)
end

function BattleRecordRankController:requestBattleLatestRecords(rankKey)
	if not self:_isLastRecordsRequestLimit(rankKey) then
		self._lastRecordKey = rankKey

		if string.find(rankKey, BattleRecordRankController.BFPrefix) then
			local key = string.gsub(rankKey, BattleRecordRankController.BFPrefix, "")
			local ids = string.split(key, "_")
			local teamId = tonumber(ids[1])
			local monsterId = tonumber(ids[2])

			BreachFormationAgent.instance:sendPM_BreachFormationGetLatestRecordsReq(monsterId, function(msg)
				local temp = {}

				temp.recordList = msg.latestRecords

				self:onBattleLatestRecords(temp)
			end)
		else
			BattleRecordRankAgent.instance:sendPM_BattleRecordGetLatestRecordsReq(rankKey)
		end
	end
end

function BattleRecordRankController:onBattleLatestRecords(respond)
	local rankKey = self._lastRecordKey

	self._lastRecordKey = nil

	self:_updateLastRecordsRequestTime(rankKey)
	BattleRecordRankModel.instance:onBattleLatestRecords(rankKey, respond)
	GlobalDispatcher:dispatch(GlobalNotify.ChallengeLatestRecords, rankKey)
end

function BattleRecordRankController:requestBattleRecordDetails(rankKey, rank)
	if self:_isBattleDetailsRequestLimit(rankKey, rank) then
		local detailsResult = BattleRecordRankModel.instance:getRankDetails(rankKey, rank)

		self:viewRankDetails(rankKey, detailsResult.details)
	else
		self._lastRankKey = rankKey
		self._lastRank = rank

		BattleRecordRankAgent.instance:sendPM_BattleRecordGetBattleDetailReq(rankKey, rank)
	end
end

function BattleRecordRankController:_isBattleDetailsRequestLimit(rankKey, rank)
	local resultData = BattleRecordRankModel.instance:getRankDetails(rankKey, rank)

	if not resultData or not resultData.details then
		return
	end

	local ranks = BattleRecordRankModel.instance:getBattleRecordRanks(rankKey)
	local rankData = BattleRecordRankModel.instance:getRank(rankKey, rank)

	for i = 1, #ranks.rankDetails do
		local detailData = ranks.rankDetails[i]

		if checknumber(detailData.rank) == rank and detailData.userId == rankData.userId then
			if UnityEngine.Time.realtimeSinceStartup - detailData.detailsTime >= self._requestBattleDetailsLimit then
				table.remove(ranks.rankDetails, i)

				return
			else
				return true
			end
		end
	end
end

function BattleRecordRankController:onBattleRecordDetails(respond)
	local rankKey = self._lastRankKey
	local rank = self._lastRank

	self._lastRank = nil
	self._lastRankKey = nil

	local rankData = BattleRecordRankModel.instance:saveRankDetails(rankKey, rank, respond.playerView, UnityEngine.Time.realtimeSinceStartup)

	self:viewRankDetails(rankKey, respond.playerView)
end

function BattleRecordRankController:viewRankDetails(key, playerView)
	UIStateManager.instance:push(ViewName.missionviewerview, playerView)
end

function BattleRecordRankController:getChallengeInfo(key)
	local key = string.gsub(key, BattleRecordRankController.ChllengePrefix, "")
	local ids = string.split(key, "_")

	return tonumber(ids[1]), tonumber(ids[2]), tonumber(ids[3]), tonumber(ids[4])
end

function BattleRecordRankController:requestBattleRecordVideo(rankKey, rank)
	if self:_isBattleRecordsRequestLimit(rankKey, rank) then
		local btnResult = self:getRankBtlResule(rankKey, rank)

		self:viewBattleRecordVideo(btnResult.result)
	else
		self._lastRankKey = rankKey
		self._lastRank = rank

		BattleRecordRankAgent.instance:sendPM_BattleRecordGetBattleVideoReq(rankKey, rank)
	end
end

function BattleRecordRankController:_isBattleRecordsRequestLimit(rankKey, rank)
	local resultData = BattleRecordRankModel.instance:getRankBtlResult(rankKey, rank)

	if not resultData or not resultData.btlResults then
		return
	end

	local ranks = BattleRecordRankModel.instance:getBattleRecordRanks(rankKey)
	local rankData = BattleRecordRankModel.instance:getRank(rankKey, rank)

	for i = 1, #ranks.btlResults do
		local btlData = ranks.btlResults[i]

		if checknumber(btlData.rank) == rank and btlData.userId == rankData.userId then
			if UnityEngine.Time.realtimeSinceStartup - btlData.btlTime >= self._requestBattleRecordsLimit then
				table.remove(ranks.btlResults, i)

				return
			else
				return true
			end
		end
	end
end

function BattleRecordRankController:onBattleRecordVideo(status, respond)
	if status == 0 then
		if self._saveCurStack then
			UIJumper.instance:saveCurStack()
		end

		local rankKey = self._lastRankKey
		local rank = self._lastRank

		self._lastRank = nil
		self._lastRankKey = nil

		local rankData = BattleRecordRankModel.instance:saveRankBtlResule(rankKey, rank, respond.btlResult, UnityEngine.Time.realtimeSinceStartup)

		self:viewBattleRecordVideo(respond.btlResult)
	end

	self._saveCurStack = false
end

function BattleRecordRankController:viewBattleRecordVideo(btlResult)
	UIJumper.instance:saveCurStack()
	BattleFacade.instance:onViewUserFightMonsterBtlResult(btlResult)
end

function BattleRecordRankController:_isRankRequestTimeLimit(rankKey)
	local lastRequestRanksTimes

	if self._lastRequestRanksTimes then
		lastRequestRanksTimes = self._lastRequestRanksTimes[rankKey]
	end

	if not lastRequestRanksTimes or UnityEngine.Time.realtimeSinceStartup - lastRequestRanksTimes >= self._requestBattleRecordRanksLimit then
		return
	end

	return true
end

function BattleRecordRankController:_updateLastRankRequestTime(rankKey)
	self._lastRequestRanksTimes = self._lastRequestRanksTimes or {}
	self._lastRequestRanksTimes[rankKey] = UnityEngine.Time.realtimeSinceStartup
end

function BattleRecordRankController:_isLastRecordsRequestLimit(rankKey)
	local lastRequestLatestRecordsTimes

	if self._lastRequestLatestRecordsTimes then
		lastRequestLatestRecordsTimes = self._lastRequestLatestRecordsTimes[rankKey]
	end

	if not lastRequestLatestRecordsTimes or UnityEngine.Time.realtimeSinceStartup - lastRequestLatestRecordsTimes >= self._requestLatestRecordsLimit then
		return
	end

	return true
end

function BattleRecordRankController:_updateLastRecordsRequestTime(rankKey)
	self._lastRequestLatestRecordsTimes = self._lastRequestLatestRecordsTimes or {}
	self._lastRequestLatestRecordsTimes[rankKey] = UnityEngine.Time.realtimeSinceStartup
end

function BattleRecordRankController:sendPM_BattleRecordGetBattleVideoReq2(key, battleId, saveCurStack)
	self._saveCurStack = saveCurStack

	BattleRecordRankAgent.instance:sendPM_BattleRecordGetBattleVideoReq2(key, battleId)
end

BattleRecordRankController.instance = BattleRecordRankController.New()

return BattleRecordRankController
