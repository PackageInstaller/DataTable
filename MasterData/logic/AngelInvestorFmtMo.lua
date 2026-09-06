-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/model/AngelInvestorFmtMo.lua

module("logic.extensions.angelinvestor.model.AngelInvestorFmtMo", package.seeall)

local AngelInvestorFmtMo = class("AngelInvestorFmtMo", BaseCustomFmtMo)

function AngelInvestorFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = AngelInvestorConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = AngelInvestorConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = AngelInvestorConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self._sysPetCfgs = AngelInvestorConfig.instance:getSystemPetCfgs(self._activityId)
	self.isOnlyUpdateExistPet = true

	self:setFormCondition(self._masterData.formCondition)
end

function AngelInvestorFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AngelInvestorController.instance:sendPM_AngelInvestorChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function AngelInvestorFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function AngelInvestorFmtMo:getFmtInfoConfig()
	return self._masterData
end

function AngelInvestorFmtMo:initPetList()
	self:clearAllPetList()

	local fMo = FightingPowerPetMo.New()

	if self._sysPetCfgs then
		for _, supportCfg in ipairs(self._sysPetCfgs) do
			fMo:fromChallengeCreepCo(supportCfg)

			local petMo = fMo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

return AngelInvestorFmtMo
