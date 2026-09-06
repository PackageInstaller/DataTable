-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/AthenaModel.lua

module("logic.extensions.timelimitedchallenge.model.AthenaModel", package.seeall)

local AthenaModel = class("AthenaModel", BaseModel)

AthenaModel.CHALLENGEID = 28
AthenaModel.CHALLENGEID_LIANJIN = 115
AthenaModel.CHALLENGEID_SYGMY = 138

function AthenaModel:onInit()
	self:onReset()
end

function AthenaModel:onReset()
	self._challengeInfoMap = {}
	self._petMoMap = {}
end

function AthenaModel:setChallenge(challengeId)
	self._challengeId = challengeId
end

function AthenaModel:_getChallengeInfo(challengeId)
	self._challengeInfoMap[challengeId] = self._challengeInfoMap[challengeId] or {}

	return self._challengeInfoMap[challengeId]
end

function AthenaModel:setPowerTowerStageId(challengeId, powerTowerStageId)
	local info = self:_getChallengeInfo(challengeId)

	info._powerTowerStageId = powerTowerStageId
end

function AthenaModel:getPowerTowerStageId(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._powerTowerStageId
end

function AthenaModel:setWisdomTowerStageId(challengeId, wisdomTowerStageId)
	local info = self:_getChallengeInfo(challengeId)

	info._wisdomTowerStageId = wisdomTowerStageId
end

function AthenaModel:getWisdomTowerStageId(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._wisdomTowerStageId
end

function AthenaModel:setPowerTowerDailyTimes(challengeId, powerTowerDailyTimes)
	local info = self:_getChallengeInfo(challengeId)

	info._powerTowerDailyTimes = powerTowerDailyTimes
end

function AthenaModel:getPowerTowerDailyTimes(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._powerTowerDailyTimes
end

function AthenaModel:setPowerTowerBuyTimes(challengeId, powerTowerBuyTimes)
	local info = self:_getChallengeInfo(challengeId)

	info._powerTowerBuyTimes = powerTowerBuyTimes
end

function AthenaModel:getPowerTowerBuyTimes(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._powerTowerBuyTimes
end

function AthenaModel:setScore(challengeId, score)
	local info = self:_getChallengeInfo(challengeId)

	info._score = score
end

function AthenaModel:getScore(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._score
end

function AthenaModel:setGainedPrize(challengeId, gainedPrize)
	local info = self:_getChallengeInfo(challengeId)

	info._gainedPrizeIds = {}

	for i, v in ipairs(gainedPrize) do
		info._gainedPrizeIds[v] = true
	end
end

function AthenaModel:getGainedPrize(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._gainedPrizeIds
end

function AthenaModel:setCurBuffLevel(challengeId, curBuffLevel)
	local info = self:_getChallengeInfo(challengeId)

	info._curBuffLevel = curBuffLevel
end

function AthenaModel:getCurBuffLevel(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._curBuffLevel
end

function AthenaModel:setHadGotBuff(challengeId, hadGotBuff)
	local info = self:_getChallengeInfo(challengeId)

	info._hadGotBuff = hadGotBuff
end

function AthenaModel:getHadGotBuff(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._hadGotBuff
end

function AthenaModel:getTodayCanUpgrade(challengeId)
	local info = self:_getChallengeInfo(challengeId)
	local nextBuff = WaterLightHeroTowerConfig.instance:getBuffById(challengeId, info._curBuffLevel + 1)

	return nextBuff and not info._hadGotBuff
end

function AthenaModel:setDefaultSupportPlan(challengeId, defaultSupportPlan)
	local info = self:_getChallengeInfo(challengeId)

	info._defaultSupportPlan = defaultSupportPlan
end

function AthenaModel:getPetMo(petId, planId, challengeId)
	local pet = BagPetsController.instance:getPet(petId)

	if pet then
		return pet
	end

	local supportCfg = WaterLightHeroTowerConfig.instance:getSupportById(planId or self:_getChallengeInfo(self._challengeId)._defaultSupportPlan) or {}
	local creepCfg

	for _, v in pairs(supportCfg) do
		if v.creepsId == petId then
			creepCfg = v

			break
		end
	end

	return self:_createPet(creepCfg)
end

function AthenaModel:getAllHelpPets(planId)
	local helpPets = {}
	local supportCfg = WaterLightHeroTowerConfig.instance:getSupportById(planId) or {}

	for _, v in pairs(supportCfg) do
		local pet = self:_createPet(v)

		table.insert(helpPets, pet)
	end

	return helpPets
end

function AthenaModel:_createPet(creepCfg)
	if not creepCfg then
		return
	end

	if self._petMoMap[creepCfg.creepsId] then
		return self._petMoMap[creepCfg.creepsId]
	end

	local fPowerPet = FightingPowerPetMo.New()

	if creepCfg.summonMasterId == "" or creepCfg.summonMasterId == nil then
		local cloneT = clone(creepCfg)

		cloneT.summonedPetId = self._curSummon

		fPowerPet:fromChallengeCreepCo(cloneT)

		creepCfg = cloneT
	else
		fPowerPet:fromChallengeCreepCo(creepCfg)
	end

	local petMo = fPowerPet:toBaseBagPetMo()

	petMo.isSupportedPet = true
	self._petMoMap[creepCfg.creepsId] = petMo

	return petMo
end

function AthenaModel:initWitFormation(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	info._witFormation = FormationMO.New()
	info._witFormation.myGetPetFunc = GameUtil.handler(self.getPetMo, self)
end

function AthenaModel:getWitFormation(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._witFormation
end

function AthenaModel:setBattleType(challengeId, battleType)
	local info = self:_getChallengeInfo(challengeId)

	info._battleType = battleType
end

function AthenaModel:getBattleType(challengeId)
	local info = self:_getChallengeInfo(challengeId)

	return info._battleType
end

AthenaModel.instance = AthenaModel.New()

return AthenaModel
