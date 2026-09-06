-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/model/AnnualFubenBossClgFmtMo.lua

module("logic.extensions.annualfuben.model.AnnualFubenBossClgFmtMo", package.seeall)

local AnnualFubenBossClgFmtMo = class("AnnualFubenBossClgFmtMo", BaseCustomFmtMo)

function AnnualFubenBossClgFmtMo:initParams(activityId)
	self.activityId = activityId

	local actCfg = AnnualFubenConfig.instance:getActivityCfg(activityId)
	local creepsMasterId = checknumber(actCfg.bossCreepsMaterId)

	self._cfgEnemy = AnnualFubenConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = AnnualFubenConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function AnnualFubenBossClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AnnualFubenAgent.instance:sendPM_AnnualFubenBossChallengeReq(self.activityId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function AnnualFubenBossClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function AnnualFubenBossClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

return AnnualFubenBossClgFmtMo
