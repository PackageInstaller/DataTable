-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/model/AresMomSupCustomFmtMo.lua

module("logic.extensions.aresmom.model.AresMomSupCustomFmtMo", package.seeall)

local AresMomSupCustomFmtMo = class("AresMomSupCustomFmtMo", ICustomFmtMo)

function AresMomSupCustomFmtMo:initParams(stageId, creespId, supPlanId, challengeId, type)
	self._supPlanId = supPlanId
	self._stageId = stageId
	self._supPlanId = supPlanId
	self._challengeId = challengeId
	self._type = type
	self._masterList = AresMomConfig.instance:getCreepMonstersCfgs(creespId)
	self._creepsCfg = AresMomConfig.instance:getCreepCfg(creespId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
	self.isShowBtnCutePet = false
end

function AresMomSupCustomFmtMo:updateData()
	self:initPetList()
end

function AresMomSupCustomFmtMo:initFightHandler()
	local function handler()
		local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_TYPE")

		if not string.nilorempty(viewName) then
			UIJumper.instance:pushOneStack(viewName, true, self._challengeId, self._type)
		end

		AresMomController.instance:startFight(self._challengeId, self._type, self._stageId, self:getCurFormation())
	end

	self:setFightHandler(handler, nil)
end

function AresMomSupCustomFmtMo:initPetList()
	self:clearAllPetList()

	local supportCfgs = AresMomConfig.instance:getSupportPetsCfgs(self._supPlanId) or {}

	for k, v in pairs(supportCfgs) do
		local fMo = FightingPowerPetMo.New()

		fMo:fromChallengeCreepCo(v)

		local petMo = fMo:toBaseBagPetMo()

		petMo.isSupportedPet = true

		self:addPetToList(petMo)
	end
end

function AresMomSupCustomFmtMo:refreshPetList(changePetMoMap)
	return
end

function AresMomSupCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function AresMomSupCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

return AresMomSupCustomFmtMo
