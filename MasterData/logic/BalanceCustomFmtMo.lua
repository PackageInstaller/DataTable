-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/model/BalanceCustomFmtMo.lua

module("logic.extensions.newsummonpetobtain.model.BalanceCustomFmtMo", package.seeall)

local BalanceCustomFmtMo = class("BalanceCustomFmtMo", ICustomFmtMo)

function BalanceCustomFmtMo:onReset()
	BalanceCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function BalanceCustomFmtMo:updateCfg(activityId, stagePlanId, stageId, isBlack)
	self._activityId = checknumber(activityId)
	self._stagePlanId = checknumber(stagePlanId)
	self._stageId = checknumber(stageId)
	self._isBlack = isBlack
	self._stageData = NewSummonPetObtainConfig.instance:getNspoStageData(self._stagePlanId, self._stageId)
	self._creepsMasterId = self._isBlack and self._stageData.blackCreepsMasterId or self._stageData.whiteCreepsMasterId
	self._masterData = NewSummonPetObtainConfig.instance:getNspoMasterData(self._creepsMasterId)
	self._creepsCfg = NewSummonPetObtainConfig.instance:getNspoCreepsCfg(self._creepsMasterId)
end

function BalanceCustomFmtMo:updateData()
	self:initPetList()

	if not string.nilorempty(self._masterData.name) then
		self.topTitleStr = self._masterData.name
	end

	if not string.nilorempty(self._masterData.WinDesc) then
		self.ruleDescStr = self._masterData.WinDesc
	end

	if not string.nilorempty(self._masterData.missionDesc) then
		self.validatorDescStr = self._masterData.missionDesc
	end

	if checknumber(self._masterData.formCondition) > 0 then
		self:setFormCondition(self._masterData.formCondition)
	end

	self.isShowMaxBuffFormLv = true
end

function BalanceCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainChallengeReq(self._activityId, self._stageId, self._isBlack, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BalanceCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

function BalanceCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BalanceCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

function BalanceCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(FightingPowerPetMo.getMaxPetMoByData(petMo))
	end
end

return BalanceCustomFmtMo
