-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/AoQiHeroModel.lua

module("logic.extensions.aoqihero.model.AoQiHeroModel", package.seeall)

local AoQiHeroModel = class("AoQiHeroModel", BaseModel)

AoQiHeroModel.ReadFlag = "AoQiHeroModel.ReadFlag"

function AoQiHeroModel:ctor()
	return
end

function AoQiHeroModel:onInit()
	self:onReset()
end

function AoQiHeroModel:onReset()
	self._info = {}
	self._recordInfo = {}
	self._curPetTeam = {}
	self._curPet = {}
	self._gainedEndlessPrizeMap = {}
	self._pvpMapInfo = {}
	self._cardUnlockNum = {}
end

function AoQiHeroModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._info[info.activityId] = info

	self:checkUnlockPet(info.activityId, info)

	self._curPetTeam[msg.activityId] = {}

	for i = 1, self._cardUnlockNum[msg.activityId] do
		self._curPetTeam[msg.activityId][i] = {
			petId = 0,
			lv = 1
		}
	end

	if info.positions then
		for i, v in ipairs(info.positions) do
			self._curPetTeam[msg.activityId][v.posId].lv = v.level
		end
	end

	self._curPet[msg.activityId] = {}

	local usePetCfgs = AoQiHeroConfig.instance:getUsePetCfgs(info.activityId)

	for i, v in ipairs(usePetCfgs) do
		if string.nilorempty(v.unlockCost) then
			self._curPet[msg.activityId][v.raceId] = true
		end
	end

	if info.raceIds then
		for i, v in ipairs(info.raceIds) do
			self._curPet[msg.activityId][v] = true
		end
	end

	self._gainedEndlessPrizeMap[msg.activityId] = {}

	if info.gainedEndlessPrizeIds then
		for i, v in ipairs(info.gainedEndlessPrizeIds) do
			self._gainedEndlessPrizeMap[msg.activityId][v] = true
		end
	end

	local mapInfo = {}

	mapInfo.mapId = info.pvpDefCreepMasterId
	mapInfo.pets = {}

	local mapCfg = AoQiHeroConfig.instance:getTeamCfg(info.activityId, mapInfo.mapId)

	if mapCfg then
		for i, v in ipairs(info.pvpDef) do
			mapInfo.pets[v.raceId] = v.posId
		end
	end

	self._pvpMapInfo[msg.activityId] = mapInfo
end

function AoQiHeroModel:unLockPet(msg)
	if self._curPet[msg.activityId] then
		self._curPet[msg.activityId][msg.raceId] = true
	end
end

function AoQiHeroModel:upgradePosition(msg)
	if self._curPetTeam[msg.activityId] and self._curPetTeam[msg.activityId][msg.posId] then
		self._curPetTeam[msg.activityId][msg.posId].lv = msg.curLevel
	end
end

function AoQiHeroModel:saveTeamInfo(msg)
	if self._curPetTeam[msg.activityId] and msg.raceIds then
		for i, v in ipairs(msg.raceIds) do
			if self._curPetTeam[msg.activityId][i] then
				self._curPetTeam[msg.activityId][i].petId = v
			end
		end
	end
end

function AoQiHeroModel:checkUnlockPet(activityId, changeInfo)
	local info = changeInfo or self._info[activityId]
	local isChange = false

	if info then
		local activityCfg = AoQiHeroConfig.instance:getActivityCfg(activityId)
		local normalStageCfgs = AoQiHeroConfig.instance:getNormalStageCfgs(activityId)
		local cardUnlock = activityCfg.initCardUnlock

		for i, v in ipairs(normalStageCfgs) do
			if v.stageId > info.normalStageId then
				break
			end

			if v.unlock == true then
				cardUnlock = cardUnlock + 1
			end
		end

		cardUnlock = math.min(cardUnlock, activityCfg.cardNum)

		if cardUnlock ~= self._cardUnlockNum[activityId] then
			isChange = true
		end

		self._cardUnlockNum[activityId] = cardUnlock

		if self._curPetTeam[activityId] then
			for i = 1, self._cardUnlockNum[activityId] do
				self._curPetTeam[activityId][i] = self._curPetTeam[activityId][i] or {
					petId = 0,
					lv = 1
				}
			end
		end
	end

	return isChange, self._cardUnlockNum[activityId]
end

function AoQiHeroModel:saveEndlessStageInfo(activityId, stageId, lastStageRound)
	local info = self._info[activityId]

	if info then
		local curStageId = info.endlessMaxStageId
		local curCircleNum = info.endlessMinCircleNum

		if curStageId < stageId then
			info.endlessMaxStageId = stageId
			info.endlessMinCircleNum = lastStageRound
		elseif curStageId == stageId and lastStageRound < curCircleNum then
			info.endlessMinCircleNum = lastStageRound
		end
	end
end

function AoQiHeroModel:getEndlessStageInfo(activityId)
	local info = self._info[activityId]

	if info then
		local stageId = checknumber(info.endlessMaxStageId)
		local circleNum = checknumber(info.endlessMinCircleNum)

		return stageId, circleNum
	end
end

function AoQiHeroModel:savePassStage(msg)
	local info = self._info[msg.activityId]

	if info then
		info.normalStageId = msg.stageId

		local isChange, changePos = self:checkUnlockPet(msg.activityId)

		return isChange, changePos
	end
end

function AoQiHeroModel:getPassStage(activityId)
	local info = self._info[activityId]

	if info then
		return info.normalStageId
	end
end

function AoQiHeroModel:getPetInfo(activityId, petId)
	if self._curPet[activityId] then
		return self._curPet[activityId][petId]
	end
end

function AoQiHeroModel:getCurPetTeams(activityId)
	return self._curPetTeam[activityId]
end

function AoQiHeroModel:getCurPetTeam(activityId, posId)
	if self._curPetTeam[activityId] then
		return self._curPetTeam[activityId][posId]
	end
end

function AoQiHeroModel:getUnlockNum(activityId)
	return self._cardUnlockNum[activityId]
end

function AoQiHeroModel:changeCurTeamPet(activityId, posId, petId)
	if self._curPetTeam[activityId] and self._curPetTeam[activityId][posId] then
		local hasEmpty = false
		local emptyIndex = 0

		for i, v in ipairs(self._curPetTeam[activityId]) do
			if v.petId == 0 then
				hasEmpty = true
				emptyIndex = i

				break
			end
		end

		local changePetId = self._curPetTeam[activityId][posId].petId

		for i, v in ipairs(self._curPetTeam[activityId]) do
			if v.petId == petId and i ~= posId and hasEmpty == false then
				self:setPosPetRecord(activityId, i, changePetId)

				self._curPetTeam[activityId][i].petId = changePetId
			end
		end

		if hasEmpty == true then
			self:setPosPetRecord(activityId, emptyIndex, petId)

			self._curPetTeam[activityId][emptyIndex].petId = petId
		else
			self:setPosPetRecord(activityId, posId, petId)

			self._curPetTeam[activityId][posId].petId = petId
		end
	end
end

function AoQiHeroModel:saveTempChangeSetId(changeSetId)
	self._tempChangeSetId = changeSetId
end

function AoQiHeroModel:getTempChangeSetId()
	return self._tempChangeSetId
end

function AoQiHeroModel:saveEndlessGainPrize(msg)
	if self._gainedEndlessPrizeMap[msg.activityId] then
		self._gainedEndlessPrizeMap[msg.activityId][msg.prizeId] = true
	end
end

function AoQiHeroModel:getEndlessGainPrize(activityId, prizeId)
	if self._gainedEndlessPrizeMap[activityId] then
		return self._gainedEndlessPrizeMap[activityId][prizeId]
	end
end

function AoQiHeroModel:savePvpMapInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local mapInfo = {}

	mapInfo.mapId = data.creepsMasterId
	mapInfo.pets = {}

	for i, v in ipairs(data.items) do
		mapInfo.pets[v.raceId] = v.posId
	end

	self._pvpMapInfo[data.activityId] = mapInfo
end

function AoQiHeroModel:getPvPMapInfo(activityId)
	return self._pvpMapInfo[activityId]
end

function AoQiHeroModel:getPvPScroe(activityId)
	local info = self._info[activityId]

	if info then
		return info.pvpScore
	end
end

function AoQiHeroModel:savePvpOpInfo(msg)
	self._pvpInfo = GameUtil.pbToTable(msg)

	local info = self._info[msg.activityId]

	if info then
		info.pvpTimes = info.pvpTimes + 1
	end
end

function AoQiHeroModel:clearPvpOpInfo(msg)
	self._pvpInfo = nil
end

function AoQiHeroModel:getPvPOpInfo()
	return self._pvpInfo
end

function AoQiHeroModel:saveTempPvpInfo(msg)
	self._tempPvpInfo = GameUtil.pbToTable(msg)

	local info = self._info[msg.activityId]

	if info then
		if self._tempPvpInfo.newScore then
			info.pvpScore = self._tempPvpInfo.newScore
		end

		if self._tempPvpInfo.winStreak then
			info.pvpWinStreak = self._tempPvpInfo.winStreak
		end
	end

	if self._tempPvpInfo.newRank then
		self._myRank = self._tempPvpInfo.newRank
	end
end

function AoQiHeroModel:getTempPvpInfo()
	return self._tempPvpInfo
end

function AoQiHeroModel:getPvpScore(activityId)
	local info = self._info[activityId]

	if info then
		return info.pvpScore
	end
end

function AoQiHeroModel:getPvpTimes(activityId)
	local info = self._info[activityId]

	if info then
		return info.pvpTimes
	end
end

function AoQiHeroModel:getPvpRank(activityId)
	local info = self._info[activityId]

	if info then
		return info.pvpRank
	end
end

function AoQiHeroModel:getPvpWinStreak(activityId)
	local info = self._info[activityId]

	if info then
		return info.pvpWinStreak
	end
end

function AoQiHeroModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if msg.typeId == 3 then
		local info = self._info[msg.activityId]

		if info then
			info.pvpRank = data.myRank
		end
	end

	self._myRank = data.myRank
	self._rankType = data.typeId
	self._rankInfoList = data.rankInfos
end

function AoQiHeroModel:getMyRank()
	return self._myRank
end

function AoQiHeroModel:getRankInfoList()
	return self._rankInfoList
end

function AoQiHeroModel:saveRecordInfo(msg)
	self._recordInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function AoQiHeroModel:getRecordInfo(activityId)
	local info = self._recordInfo[activityId]

	if info then
		return info.records
	end
end

function AoQiHeroModel:getOpenNormalRule(activityId)
	local key = string.format("%s#NormalRule#%d", AoQiHeroModel.ReadFlag, activityId)

	return GameUtil.getUserData(key)
end

function AoQiHeroModel:saveOpenNormalRule(activityId)
	local key = string.format("%s#NormalRule#%d", AoQiHeroModel.ReadFlag, activityId)

	GameUtil.saveUserData(key, true)
end

function AoQiHeroModel:getTempPVPDefenceCreepsMasterId()
	return self._tempCreepsMasterId
end

function AoQiHeroModel:setTempPVPDefenceCreepsMasterId(creepsMasterId)
	self._tempCreepsMasterId = creepsMasterId
end

function AoQiHeroModel:getHadGainedTodayPrize(activityId)
	local info = self._info[activityId]

	if info then
		return info.hadGainedTodayPrize
	end
end

function AoQiHeroModel:saveHadGainTodayPrize(activityId)
	if self._info[activityId] then
		self._info[activityId].hadGainedTodayPrize = true
	end
end

AoQiHeroModel.instance = AoQiHeroModel.New()

return AoQiHeroModel
