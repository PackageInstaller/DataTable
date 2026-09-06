-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/model/AnnualFubenModel.lua

module("logic.extensions.annualfuben.model.AnnualFubenModel", package.seeall)

local AnnualFubenModel = class("AnnualFubenModel", BaseModel)

AnnualFubenModel.ReadFlag = "AnnualFubenModel.ReadFlag"

function AnnualFubenModel:ctor()
	return
end

function AnnualFubenModel:onInit()
	AnnualFubenModel.super.onInit(self)
	self:onReset()
end

function AnnualFubenModel:onReset()
	self._info = {}
	self._holdFmtMo = nil
	self._brokenFmtMo = nil
	self._bossFmtMo = nil
	self._gainClue = {}
	self._gainCluePrize = {}
	self._lockRace = {}
	self._gainedBossPrize = {}
end

function AnnualFubenModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local gainClue = {}

	if data.clueIds then
		for i, v in ipairs(data.clueIds) do
			gainClue[v] = true
		end
	end

	local gainCluePrizeId = {}

	if data.gainedCluePrizeIds then
		for i, v in ipairs(data.gainedCluePrizeIds) do
			gainCluePrizeId[v] = true
		end
	end

	local lockRaceInfo = {}

	if data.lockRaces then
		for i, v in ipairs(data.lockRaces) do
			if v.raceId > 0 then
				lockRaceInfo[v.raceId] = v.posId
			end
		end
	end

	local gainedBossPrize = {}

	if data.gainedBossPrizeIds then
		for i, v in ipairs(data.gainedBossPrizeIds) do
			gainedBossPrize[v] = true
		end
	end

	data.totalBossDamage = math.abs(checknumber(data.totalBossDamage))
	self._lockRace[data.activityId] = lockRaceInfo
	self._gainCluePrize[data.activityId] = gainCluePrizeId
	self._gainClue[data.activityId] = gainClue
	self._gainedBossPrize[data.activityId] = gainedBossPrize
	self._info[data.activityId] = data
end

function AnnualFubenModel:saveGainClue(activityId, clueId)
	if self._gainClue[activityId] then
		self._gainClue[activityId][clueId] = true
	end
end

function AnnualFubenModel:saveGainClueTime(activityId)
	if self._info[activityId] then
		self._info[activityId].dailyClueTimes = self._info[activityId].dailyClueTimes or 0
		self._info[activityId].dailyClueTimes = self._info[activityId].dailyClueTimes + 1
	end
end

function AnnualFubenModel:isGainClue(activityId, clueId)
	if self._gainClue[activityId] then
		return self._gainClue[activityId][clueId] or false
	end

	return false
end

function AnnualFubenModel:getSearchClueTime(activityId)
	if self._info[activityId] then
		return self._info[activityId].dailyClueTimes
	end

	return 0
end

function AnnualFubenModel:isGainCluePrize(activityId, prizeId)
	if self._gainCluePrize[activityId] then
		return self._gainCluePrize[activityId][prizeId] or false
	end

	return false
end

function AnnualFubenModel:getHoldFmtMo()
	self._holdFmtMo = self._holdFmtMo or AnnualFubenHoldClgFmtMo.New()

	return self._holdFmtMo
end

function AnnualFubenModel:getBrokenFmtMo()
	self._brokenFmtMo = self._brokenFmtMo or AnnualFubenBrokenClgFmtMo.New()

	return self._brokenFmtMo
end

function AnnualFubenModel:getBossFmtMo()
	self._bossFmtMo = self._bossFmtMo or AnnualFubenBossClgFmtMo.New()

	return self._bossFmtMo
end

function AnnualFubenModel:getBossDamage(activityId)
	if self._info[activityId] then
		return self._info[activityId].totalBossDamage
	end

	return 0
end

function AnnualFubenModel:getTodayBossDamage(activityId)
	if self._info[activityId] then
		return checknumber(self._info[activityId].todayBossDamage)
	end

	return 0
end

function AnnualFubenModel:isGainBossDamagePrize(activityId, prizeId)
	if self._gainedBossPrize[activityId] then
		return self._gainedBossPrize[activityId][prizeId]
	end

	return false
end

function AnnualFubenModel:getHoldStageId(activityId)
	if self._info[activityId] then
		return self._info[activityId].simpleStageId
	end

	return 0
end

function AnnualFubenModel:getBrokenStageId(activityId)
	if self._info[activityId] then
		return self._info[activityId].stageId
	end

	return 0
end

function AnnualFubenModel:saveTempRankInfo(msg)
	self._tempRankInfo = GameUtil.pbToTable(msg)
end

function AnnualFubenModel:getTempRankInfo()
	return self._tempRankInfo
end

function AnnualFubenModel:saveCluePrize(msg)
	if self._gainCluePrize[msg.activityId] then
		self._gainCluePrize[msg.activityId][msg.prizeId] = true
	end
end

function AnnualFubenModel:getLockRaces(activityId)
	if self._lockRace[activityId] then
		return self._lockRace[activityId]
	end
end

function AnnualFubenModel:isRaceLock(activityId, raceId)
	if self._lockRace[activityId] then
		return self._lockRace[activityId][raceId]
	end

	return false
end

function AnnualFubenModel:saveResetBrokenStage(msg)
	self._lockRace[msg.activityId] = {}
end

function AnnualFubenModel:saveBossPrize(msg)
	if self._gainedBossPrize[msg.activityId] then
		self._gainedBossPrize[msg.activityId][msg.prizeId] = true
	end
end

function AnnualFubenModel:saveBrokenStageBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local lockRace = {}

	if data.lockRaces then
		for i, v in ipairs(data.lockRaces) do
			lockRace[v.raceId] = v.posId
		end
	end

	self._lockRace[msg.activityId] = lockRace

	if self._info[msg.activityId] and not data.lockRaces then
		self._info[msg.activityId].stageId = msg.stageId
	end
end

function AnnualFubenModel:saveHoldStageBattleInfo(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].simpleStageId = msg.stageId
	end
end

function AnnualFubenModel:saveBossBattleInfo(msg)
	if self._info[msg.activityId] then
		local damage = checknumber(msg.damage)
		local todayDamage = checknumber(self._info[msg.activityId].todayBossDamage)

		if todayDamage < damage then
			self._info[msg.activityId].todayBossDamage = damage
			self._info[msg.activityId].totalBossDamage = self._info[msg.activityId].totalBossDamage - todayDamage + damage
		end

		local historyBossDamge = checknumber(self._info[msg.activityId].historyBossDamge)

		if historyBossDamge < damage then
			self._info[msg.activityId].historyBossDamge = damage
		end
	end
end

function AnnualFubenModel:getHistoryBossDamge(activityId)
	if self._info[activityId] then
		return self._info[activityId].historyBossDamge
	end

	return 0
end

function AnnualFubenModel:getFirstEnterMain(activityId)
	local key = string.format("%s#EnterMain#%d", AnnualFubenModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AnnualFubenModel:setFirstEnterMain(activityId)
	local key = string.format("%s#EnterMain#%d", AnnualFubenModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

function AnnualFubenModel:getFirstEnterChapterOne(activityId)
	local key = string.format("%s#EnterOne#%d", AnnualFubenModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AnnualFubenModel:setFirstEnterChapterOne(activityId)
	local key = string.format("%s#EnterOne#%d", AnnualFubenModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

function AnnualFubenModel:getFirstEnterChapterTwo(activityId)
	local key = string.format("%s#EnterTwo#%d", AnnualFubenModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AnnualFubenModel:setFirstEnterChapterTwo(activityId)
	local key = string.format("%s#EnterTwo#%d", AnnualFubenModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

function AnnualFubenModel:getFirstEnterChapterThree(activityId)
	local key = string.format("%s#EnterThree#%d", AnnualFubenModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AnnualFubenModel:setFirstEnterChapterThree(activityId)
	local key = string.format("%s#EnterThree#%d", AnnualFubenModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

function AnnualFubenModel:getReadChapterThreeStory(activityId)
	local key = string.format("%s#EndThree#%d", AnnualFubenModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AnnualFubenModel:setReadChapterThreeStory(activityId)
	local key = string.format("%s#EndThree#%d", AnnualFubenModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

AnnualFubenModel.instance = AnnualFubenModel.New()

return AnnualFubenModel
