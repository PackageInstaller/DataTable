-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualfuben/model/AnnualFubenBrokenClgFmtMo.lua

module("logic.extensions.annualfuben.model.AnnualFubenBrokenClgFmtMo", package.seeall)

local AnnualFubenBrokenClgFmtMo = class("AnnualFubenBrokenClgFmtMo", BaseCustomFmtMo)

function AnnualFubenBrokenClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = AnnualFubenConfig.instance:getBrokenStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = AnnualFubenConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = AnnualFubenConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)
end

function AnnualFubenBrokenClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AnnualFubenAgent.instance:sendPM_AnnualFubenStageChallengeReq(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function AnnualFubenBrokenClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function AnnualFubenBrokenClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function AnnualFubenBrokenClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return AnnualFubenModel.instance:isRaceLock(self.activityId, petMo.raceId) ~= nil
end

function AnnualFubenBrokenClgFmtMo:showForbitPetAlert(petMo)
	if AnnualFubenModel.instance:isRaceLock(self.activityId, petMo.raceId) ~= nil then
		FloatWordMgr.instance:show(lang("精灵已被封印"))
	end
end

return AnnualFubenBrokenClgFmtMo
