-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/model/CampScuffleModel.lua

module("logic.extensions.funcamp.model.CampScuffleModel", package.seeall)

local CampScuffleModel = class("CampScuffleModel", BaseModel)

CampScuffleModel.LevelPath = "ui/icon/scuffle/%s.png"

function CampScuffleModel:onInit()
	self:onReset()
end

function CampScuffleModel:onReset()
	self._isRecieveScuffleInfo = false
	self._maxBanPetCount = checknumber(CampGameConfig.instance:getCommonValueByKey("BAN_PET_NUM"))
	self._score = 0
	self._myRank = -1
	self._winStreak = 0
	self._campScore = 0
	self._campId = 0
	self._todayGameTimes = 0
	self._todayBuyTimes = 0
	self._maxScore = 0
	self._gainBit = 0
	self._rankList = {}
	self._battleRecordList = {}
	self._seasonInfoList = {}

	self:onTempReset()

	self._oldScore = -1
	self._campOldScore = -1
end

function CampScuffleModel:onTempReset()
	self._isFunMode = false
	self._myInitPets = {}
	self._enemyInitPets = {}
	self._myRandomPets = {}
	self._enemyRandomPets = {}
	self._poolPets = {}
	self._myBanPetIds = {}
	self._enemyBanPetIds = {}
	self._myFmtPetIds = {}
	self._enemyFmtPetIds = {}
	self._enemyAreaName = "匿名"
	self._enemyScore = 0
	self._enemyRank = -1
	self._inspireValue = 0
	self._opCampScore = 0
	self._isCanSelectBanPet = false
	self._selectBanPetList = {}
	self._bagPetMoDic = {}
	self._formation = nil
	self._teamId = 1
	self._resultState = 0
	self._battleResult = nil
	self._myTeamId = 0
	self._fun = nil
	self._oldRank = -1
	self._result = -1
	self._winStreak = 0
end

function CampScuffleModel:onScuffleInfoRes(msg)
	self._isRecieveScuffleInfo = true
	self._score = msg.score
	self._myRank = msg.myRank
	self._winStreak = msg.winStreak
	self._campScore = msg.campScore
	self._campId = msg.campId
	self._todayGameTimes = msg.todayGameTimes
	self._todayBuyTimes = msg.todayBuyTimes
end

function CampScuffleModel:onGameStartRes(msg)
	self._enemyPlayerInfo = msg.opHeadInfo
	self._myInitPets = msg.myPetIds
	self._enemyInitPets = msg.enemyPetIds
	self._poolPets = msg.poolPetIds
	self._enemyAreaName = msg.opAreaName
	self._enemyScore = msg.opScore
	self._enemyRank = msg.opRank
	self._inspireValue = msg.inspireValue
	self._opCampScore = msg.opCampScore
end

function CampScuffleModel:onNofityStartSetFormRes(msg)
	self._myInitPets = msg.myInitPetIds
	self._myRandomPets = msg.myRandomPetIds
	self._myBanPetIds = msg.myBanPetIds
	self._enemyBanPetIds = msg.enemyBanPetIds
	self._myFmtPetIds = msg.myPetIds
	self._enemyFmtPetIds = msg.enemyPetids
	self._enemyRandomPets = self:_calculateEnemyRandomPets(msg.enemyPetids, self._enemyInitPets)
end

function CampScuffleModel:_calculateEnemyRandomPets(totalPets, initPets)
	local randomPets = {}

	for i, v in ipairs(totalPets) do
		if not TableUtil.isHad(initPets, v) then
			table.insert(randomPets, v)
		end
	end

	return randomPets
end

function CampScuffleModel:onGameEndRes(msg)
	self._resultState = msg.state
	self._battleResult = msg.battleResult
	self._myTeamId = msg:HasField("myTeamId") and msg.myTeamId or 0

	if msg:HasField("oldScore") then
		self._oldScore = msg.oldScore or -1
	end

	if msg:HasField("newSocre") then
		self._score = msg.newSocre or self._score
	end

	if msg:HasField("oldRank") then
		self._oldRank = msg.oldRank or -1
	end

	if msg:HasField("rank") then
		self._myRank = msg.rank or self._myRank
	end

	if msg:HasField("result") then
		self._result = msg.result or -1
	end

	if msg:HasField("campOldScore") then
		self._campOldScore = msg.campOldScore or -1
	end

	if msg:HasField("campNewScore") then
		self._campScore = msg.campNewScore or self._campScore
	end

	self._todayGameTimes = msg.todayGameTimes
end

function CampScuffleModel:onGetRankInfoRes(msg)
	self._rankList = GameUtil.pbToTable(msg.ranks) or {}
	self._myRank = msg.myRank
end

function CampScuffleModel:onGetBattleRecordRes(msg)
	self._battleRecordList = GameUtil.pbToTable(msg.battleRecords) or {}
end

function CampScuffleModel:onGetBattleVideoRes(msg)
	self._singleBattleVideo = msg.battleResult
end

function CampScuffleModel:onGetAllSeasonInfoRes(msg)
	self._seasonInfoList = GameUtil.pbToTable(msg.infos) or {}
end

function CampScuffleModel:onAchievePrizeInfoRes(msg)
	self._maxScore = msg.maxScore
	self._gainBit = msg.gainBit
end

function CampScuffleModel:onBuyTimesRes(msg)
	self._todayBuyTimes = msg.todayBuyTimes
end

function CampScuffleModel:isRecieveScuffleInfoRes()
	return self._isRecieveScuffleInfo
end

function CampScuffleModel:getMaxScore()
	return self._maxScore
end

function CampScuffleModel:isAchievePrizeGet(id)
	return GameUtil.isBitOpenByDigit(self._gainBit, id)
end

function CampScuffleModel:updateAchievePrizeGainBit(id)
	self._gainBit = GameUtil.setBitByDigit(self._gainBit, id, true)
end

function CampScuffleModel:getBattleRecordList()
	return self._battleRecordList
end

function CampScuffleModel:getSeasonInfoList()
	return self._seasonInfoList
end

function CampScuffleModel:getSingleBattleVideo()
	return self._singleBattleVideo
end

function CampScuffleModel:getEnemyHeadInfo()
	return self._enemyPlayerInfo
end

function CampScuffleModel:getEnemyName()
	if self._enemyPlayerInfo then
		return self._enemyPlayerInfo.userName
	else
		return ""
	end
end

function CampScuffleModel:getEnemyAreaName()
	return self._enemyAreaName
end

function CampScuffleModel:getEnemyScore()
	return self._enemyScore
end

function CampScuffleModel:getEnemyRank()
	return self._enemyRank
end

function CampScuffleModel:getResultState()
	return self._resultState
end

function CampScuffleModel:getMyTeamId()
	return self._myTeamId or 0
end

function CampScuffleModel:isNormalBattle()
	return self._resultState == 1
end

function CampScuffleModel:getBattleResult()
	return self._battleResult
end

function CampScuffleModel:getAreaName()
	return RoleModel.instance:getAreaName()
end

function CampScuffleModel:isHaveOldScore()
	printInfo("test isHaveOldScore", self._oldScore)

	return self._oldScore >= 0
end

function CampScuffleModel:getOldScore()
	return self._oldScore
end

function CampScuffleModel:getOldScoreAndReset()
	self._oldScore = -1

	return self._oldScore
end

function CampScuffleModel:isHaveCampOldScore()
	printInfo("test isHaveCampOldScore", self._campOldScore)

	return self._campOldScore >= 0
end

function CampScuffleModel:getCampOldScore()
	return self._campOldScore
end

function CampScuffleModel:getCampOldScoreAndReset()
	self._campOldScore = -1

	return self._campOldScore
end

function CampScuffleModel:getScore()
	return self._score
end

function CampScuffleModel:getCampScore()
	return self._campScore
end

function CampScuffleModel:getEnemyCampScore()
	return self._opCampScore
end

function CampScuffleModel:getMyRank()
	if self._myRank == -1 then
		return "未上榜"
	else
		return self._myRank
	end
end

function CampScuffleModel:getMyInitPets()
	return self._myInitPets
end

function CampScuffleModel:getEnemyInitPets()
	return self._enemyInitPets
end

function CampScuffleModel:getMyRandomPets()
	return self._myRandomPets
end

function CampScuffleModel:getEnemyRandomPets()
	return self._enemyRandomPets
end

function CampScuffleModel:getMyAllPets()
	local result = {}

	table.insertto(result, self._myFmtPetIds)

	return result
end

function CampScuffleModel:getEnemyAllPets()
	local result = {}

	table.insertto(result, self._enemyFmtPetIds)

	return result
end

function CampScuffleModel:getPoolPets()
	return self._poolPets
end

function CampScuffleModel:isExistMyRandomPet(id)
	return TableUtil.isHad(self._myRandomPets, id)
end

function CampScuffleModel:isExistEnemyRandomPet(id)
	return TableUtil.isHad(self._enemyRandomPets, id)
end

function CampScuffleModel:isExistMyBanPet(id)
	return TableUtil.isHad(self._myBanPetIds, id)
end

function CampScuffleModel:isExistEnemyBanPet(id)
	return TableUtil.isHad(self._enemyBanPetIds, id)
end

function CampScuffleModel:isCanSelectBanPet()
	return self._isCanSelectBanPet
end

function CampScuffleModel:setIsCanSelectBanPet(active)
	self._isCanSelectBanPet = active
end

function CampScuffleModel:isMaxBanCount()
	return #self._selectBanPetList >= self._maxBanPetCount
end

function CampScuffleModel:addPetToBanList(id)
	local success = true

	if #self._selectBanPetList >= self._maxBanPetCount then
		return not success
	else
		table.insert(self._selectBanPetList, id)

		return success
	end
end

function CampScuffleModel:isSelectBanPet(id)
	return TableUtil.isHad(self._selectBanPetList, id)
end

function CampScuffleModel:removePetFromBanList(id)
	table.removebyvalue(self._selectBanPetList, id)
end

function CampScuffleModel:getMyBanList()
	return self._selectBanPetList or {}
end

function CampScuffleModel:getMyBanPetCount()
	return (self._selectBanPetList or nil) and (#self._selectBanPetList or 0)
end

function CampScuffleModel:getMaxBanPetCount()
	return self._maxBanPetCount
end

function CampScuffleModel:getFormationCountDown()
	return checknumber(CampGameConfig.instance:getCommonValueByKey("READY_TIME")) - 5
end

function CampScuffleModel:getRankList()
	return self._rankList
end

function CampScuffleModel:isHaveTaskRed()
	return false
end

function CampScuffleModel:isHaveRewardRed()
	return false
end

function CampScuffleModel:getCurGameTimes()
	return self._todayGameTimes
end

function CampScuffleModel:getGameBuyTimes()
	return self._todayBuyTimes
end

function CampScuffleModel:getTotalMaxGameTimes(maxConfigGameTimes)
	return self._todayBuyTimes + maxConfigGameTimes
end

function CampScuffleModel:initFormation()
	printInfo("test initFormation")

	local list = {}
	local pos = {}

	for i = 1, 9 do
		pos[i] = list[i] or 0
	end

	local form = {
		formId = 10,
		pos = pos,
		extParams = {
			heroSkillId = 0
		}
	}

	self:setFormation(form)
end

function CampScuffleModel:createPet(creepsId)
	if self._bagPetMoDic[creepsId] then
		return self._bagPetMoDic[creepsId]
	end

	if creepsId == 0 then
		return nil
	end

	local creepCfg = CampGameConfig.instance:getSystemPetCfg(creepsId)

	if creepCfg then
		local fPowerPet = FightingPowerPetMo.New()

		fPowerPet:fromChallengeCreepCo(creepCfg)

		local petMo = fPowerPet:toBaseBagPetMo()

		petMo.petId = creepsId
		petMo.rare = CharacterConfig.instance:getRareByAwakenLv(petMo.awakeLevel, petMo.raceId)
		self._bagPetMoDic[creepsId] = petMo

		return petMo
	else
		local cfg = CampGameConfig.instance:getHelpPetCfg(creepsId)

		if cfg then
			local fPowerPet = FightingPowerPetMo.New()

			fPowerPet:fromChallengeCreepCo(cfg)

			local petMo = fPowerPet:toBaseBagPetMo()

			petMo.petId = creepsId
			petMo.rare = CharacterConfig.instance:getRareByAwakenLv(petMo.awakeLevel, petMo.raceId)
			petMo.isSupportedPet = true
			self._bagPetMoDic[creepsId] = petMo

			return petMo
		else
			return nil
		end
	end
end

function CampScuffleModel:getPet(petId)
	return self:createPet(petId)
end

function CampScuffleModel:setFormation(form)
	self._teamId = self._teamId or 1
	self._formation = self._formation or CampScuffleFormationMO.New()

	self._formation:SetData(form)
end

function CampScuffleModel:getFormation()
	return self._formation
end

function CampScuffleModel:getCurFormationId()
	return self._formation:GetId()
end

function CampScuffleModel:setTeamId(id)
	self._teamId = id
end

function CampScuffleModel:getTeamId()
	return self._teamId
end

function CampScuffleModel:getAllPets()
	local allPets = {}
	local petIds = self:getMyAllPets()

	if petIds then
		for i = 1, #petIds do
			local petId = petIds[i]

			allPets[#allPets + 1] = self:createPet(petId)
		end
	end

	return allPets
end

CampScuffleModel.instance = CampScuffleModel.New()

return CampScuffleModel
