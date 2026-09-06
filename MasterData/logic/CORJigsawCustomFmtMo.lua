-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/model/CORJigsawCustomFmtMo.lua

module("logic.extensions.cantonoperaroad.model.CORJigsawCustomFmtMo", package.seeall)

local CORJigsawCustomFmtMo = class("CORJigsawCustomFmtMo", ICustomFmtMo)

function CORJigsawCustomFmtMo:onReset()
	CORJigsawCustomFmtMo.super.onReset(self)
end

function CORJigsawCustomFmtMo:updateCfg(jigsawId, stageId)
	self._jigsawId = checknumber(jigsawId)
	self._stageId = checknumber(stageId)
	self._activityId = CantonOperaRoadModel.instance:getCurActivityId()
	self._stageData = CantonOperaRoadConfig.instance:getCorJigsawChallengeDataById(self._activityId, self._stageId)
	self._enemyData = CantonOperaRoadConfig.instance:getCorEnemyData(self._stageData.creepsMasterId)
end

function CORJigsawCustomFmtMo:updateData()
	self.topTitleStr = self._enemyData.name
	self.ruleDescStr = self._enemyData.WinDesc
	self.validatorDescStr = self._enemyData.missionDesc
	self.isHideFmtZdl = true

	self:setFormCondition(self._enemyData.formCondition)
	self:initPetList()
end

function CORJigsawCustomFmtMo:_getFormationMoKey()
	return self._stageId
end

function CORJigsawCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		CantonOperaRoadController.instance:sendPM_CantonOperaRoadJigsawClgReq(self._activityId, self._jigsawId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function CORJigsawCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end

	local helpPetIdList = self._stageData.helpPetIds

	if helpPetIdList then
		local fmo = FightingPowerPetMo.New()

		for _, helpPetId in pairs(helpPetIdList) do
			local helpPetData = CantonOperaRoadConfig.instance:getCorHelpPetCfgData(helpPetId)

			fmo:fromChallengeCreepCo(helpPetData)

			local petMo = fmo:toBaseBagPetMo()

			petMo.isSupportedPet = true

			self:addPetToList(petMo)
		end

		fmo = nil
	end
end

function CORJigsawCustomFmtMo:getMonsterConfigList()
	return CantonOperaRoadConfig.instance:getCorCreepsCfg(self._stageData.creepsMasterId)
end

function CORJigsawCustomFmtMo:getFmtInfoConfig()
	return CantonOperaRoadConfig.instance:getCorCreepsCfg(self._stageData.creepsMasterId)
end

function CORJigsawCustomFmtMo:onClickCloseBtn(handler)
	CORJigsawCustomFmtMo.super.onClickCloseBtn(self, handler)
end

return CORJigsawCustomFmtMo
