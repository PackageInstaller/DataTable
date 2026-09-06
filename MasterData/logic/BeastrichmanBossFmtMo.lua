-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/model/BeastrichmanBossFmtMo.lua

module("logic.extensions.beastrichman.model.BeastrichmanBossFmtMo", package.seeall)

local BeastrichmanBossFmtMo = class("BeastrichmanBossFmtMo", BaseCustomFmtMo)

function BeastrichmanBossFmtMo:initParams(activityId, zoneId, bossId)
	self.isHideFmtZdl = true
	self._activityId = activityId
	self._zoneId = zoneId
	self._bossType = BeastRichManEnum.BossType.Boss
	self._bossId = bossId
	self._stageId = 0
	self._bossCfg = BeastRichmanConfig.instance:getBossCfgById(self._activityId, self._bossId)
	self._masterData = BeastRichmanConfig.instance:getMasterCfg(self._bossCfg.creepsMasterId)
	self._creepsCfg = BeastRichmanConfig.instance:getCreepsCfgs(self._bossCfg.creepsMasterId)
	self._supportPetIdList = BeastRichmanModel.instance:getSuppurtPetIds(activityId)
end

function BeastrichmanBossFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	local fmo = FightingPowerPetMo.New()

	self:clearAllPetList()

	if self._supportPetIdList then
		for i, id in ipairs(self._supportPetIdList) do
			local cfgSupport = BeastRichmanConfig.instance:getSupportPetCfg(self._activityId, id)

			if cfgSupport then
				fmo:fromChallengeCreepCo(cfgSupport)
				fmo:setSupportedPet(true)

				local supportPetMo = fmo:toBaseBagPetMo()

				self:addPetToList(supportPetMo)
			end
		end
	end

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function BeastrichmanBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BeastRichmanAgent.instance:sendPM_BeastRichManFightBeastReq(self._activityId, self._zoneId, self._bossType, self._bossId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BeastrichmanBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BeastrichmanBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

return BeastrichmanBossFmtMo
