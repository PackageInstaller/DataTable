-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/model/AresMomOwerCustomFmtMo.lua

module("logic.extensions.aresmom.model.AresMomOwerCustomFmtMo", package.seeall)

local AresMomOwerCustomFmtMo = class("AresMomOwerCustomFmtMo", ICustomFmtMo)

function AresMomOwerCustomFmtMo:initParams(stageId, creespId, challengeId, type)
	self._stageId = stageId
	self._creespId = creespId
	self._challengeId = challengeId
	self._type = type
	self._masterList = AresMomConfig.instance:getCreepMonstersCfgs(creespId)
	self._creepsCfg = AresMomConfig.instance:getCreepCfg(creespId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
end

function AresMomOwerCustomFmtMo:initFightHandler()
	local function handler()
		local viewName = AresMomConfig.instance:getAmClientCommonValue(self._challengeId, "ARES_VIEW_NAME_TYPE")

		if not string.nilorempty(viewName) then
			UIJumper.instance:pushOneStack(viewName, true, self._challengeId, self._type)
		end

		AresMomController.instance:startFight(self._challengeId, self._type, self._stageId, self:getCurFormation())
	end

	self:setFightHandler(handler, nil)
end

function AresMomOwerCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function AresMomOwerCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function AresMomOwerCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function AresMomOwerCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

return AresMomOwerCustomFmtMo
