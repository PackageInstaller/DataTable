-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/awakenoathancestor/model/AwakenOathAncestorFmtMo.lua

module("logic.extensions.awakenoathancestor.model.AwakenOathAncestorFmtMo", package.seeall)

local AwakenOathAncestorFmtMo = class("AwakenOathAncestorFmtMo", BaseCustomFmtMo)

function AwakenOathAncestorFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = AwakenOathAncestorConfig.instance:getStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = AwakenOathAncestorController.instance:getSubMo(self._activityId)
	self._masterData = AwakenOathAncestorConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = AwakenOathAncestorConfig.instance:getCreepsCfg(creepsMasterId)
	self._supportCfg = AwakenOathAncestorConfig.instance:getSupportCfg(self._activityId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isOnlyUpdateExistPet = true
end

function AwakenOathAncestorFmtMo:initPetList()
	self:clearAllPetList()

	local fmo = FightingPowerPetMo.New()

	for _, data in pairs(self._supportCfg or {}) do
		fmo:fromChallengeCreepCo(data)

		local petMo = fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function AwakenOathAncestorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AwakenOathAncestorController.instance:sendPM_AwakenOathAncestorChallengeReq(self._activityId, simpleForm, self._stageId)
	end, nil)
end

function AwakenOathAncestorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function AwakenOathAncestorFmtMo:getFmtInfoConfig()
	return self._masterData
end

return AwakenOathAncestorFmtMo
