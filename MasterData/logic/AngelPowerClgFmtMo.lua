-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/model/AngelPowerClgFmtMo.lua

module("logic.extensions.angelpowerclg.model.AngelPowerClgFmtMo", package.seeall)

local AngelPowerClgFmtMo = class("AngelPowerClgFmtMo", ICustomFmtMo)

function AngelPowerClgFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._stageId = stageId

	local challengeCfg = AngelPowerClgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self._cfgEnemy = AngelPowerClgConfig.instance:getTeamCfg(challengeCfg.creepsMasterId)
	self._masterList = AngelPowerClgConfig.instance:getCreepsCfg(challengeCfg.creepsMasterId)
end

function AngelPowerClgFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()
end

function AngelPowerClgFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local allPass = AngelPowerClgController.instance:allStagePass(self._activityId)

			if allPass then
				AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.AngelPowerClg, self._activityId)
			end
		end

		UIJumper.instance:pushOneStack(ViewName.AngelPowerClgMainView, true, self._activityId)
		UIJumper.instance:pushOneStack(ViewName.AngelPowerClgLevelView, true, self._activityId)

		local simpleForm = self:getCurSimpleForm()

		AngelPowerAgent.instance:sendPM_AngelPowerChallengeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function AngelPowerClgFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function AngelPowerClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function AngelPowerClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function AngelPowerClgFmtMo:getActivityId()
	return self._activityId
end

function AngelPowerClgFmtMo:getStageId()
	return self._stageId
end

function AngelPowerClgFmtMo:getExtendViewName()
	return ViewName.AngelPowerClgFmtView
end

return AngelPowerClgFmtMo
