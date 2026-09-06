-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/model/CORBossCustomFmtMo.lua

module("logic.extensions.cantonoperaroad.model.CORBossCustomFmtMo", package.seeall)

local CORBossCustomFmtMo = class("CORBossCustomFmtMo", BaseCustomFmtMo)

function CORBossCustomFmtMo:updateCfg(challengeTimes)
	self._challengeTimes = checknumber(challengeTimes)
	self._activityId = CantonOperaRoadModel.instance:getCurActivityId()
	self._bossData = CantonOperaRoadConfig.instance:getCorBossChallengeDataById(self._activityId, self._challengeTimes)
	self._enemyData = CantonOperaRoadConfig.instance:getCorEnemyData(self._bossData.creepsMasterId)
	self._supportCfg = {}

	if not self._bossData.helpPetIds then
		for _, helpPetId in pairs(self._bossData.helpPetIds) do
			local helpPetData = CantonOperaRoadConfig.instance:getCorHelpPetCfgData(helpPetId)

			table.insert(self._supportCfg, helpPetData)
		end

		self._fixedPosListInHelp = {}

		for _, data in ipairs(self._supportCfg) do
			if data.posId > 0 and data.isFixedPos then
				table.insert(self._fixedPosListInHelp, data.posId)
			end
		end
	end
end

function CORBossCustomFmtMo:updateData()
	self.topTitleStr = self._enemyData.name
	self.ruleDescStr = self._enemyData.WinDesc
	self.validatorDescStr = self._enemyData.missionDesc
	self.isHideFmtZdl = true

	self:setFormCondition(self._enemyData.formCondition)
	self:initPetList()
	self:_setCurFormation()
end

function CORBossCustomFmtMo:_setCurFormation()
	self:getCurFormation():SetData(CantonOperaRoadModel.instance:getSimpleFormAsCORBoss())
end

function CORBossCustomFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		CantonOperaRoadController.instance:sendPM_CantonOperaRoadBossClgReq(self._activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function CORBossCustomFmtMo:initPetList()
	CORBossCustomFmtMo.super.initPetList(self)

	local cfg = self:_getSupportCfg()

	if not self._fpFmo then
		local fmo = FightingPowerPetMo.New()

		self._fpFmo = fmo

		for _, data in ipairs(cfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)
			self:addPetToList(petMo)
		end
	end
end

function CORBossCustomFmtMo:_getSupportCfg()
	return self._supportCfg
end

function CORBossCustomFmtMo:getFixedPosList()
	return self._fixedPosListInHelp
end

function CORBossCustomFmtMo:getMonsterConfigList()
	return CantonOperaRoadConfig.instance:getCorCreepsCfg(self._bossData.creepsMasterId)
end

function CORBossCustomFmtMo:getFmtInfoConfig()
	return CantonOperaRoadConfig.instance:getCorCreepsCfg(self._bossData.creepsMasterId)
end

return CORBossCustomFmtMo
