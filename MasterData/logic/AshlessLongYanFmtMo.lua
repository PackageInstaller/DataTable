-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/model/AshlessLongYanFmtMo.lua

module("logic.extensions.ashlesslongyan.model.AshlessLongYanFmtMo", package.seeall)

local AshlessLongYanFmtMo = class("AshlessLongYanFmtMo", BaseCustomFmtMo)

function AshlessLongYanFmtMo:onReset()
	AshlessLongYanFmtMo.super.onReset(self)
end

function AshlessLongYanFmtMo:updateCfg(activityId, phaseId, stageId)
	self._activityId = activityId
	self._phaseId = phaseId
	self._stageId = stageId

	local stageData = AshlessLongYanConfig.instance:getStageData(self._activityId, self._phaseId, self._stageId)

	self._creepsMasterId = stageData.woodCreepsMasterId
	self._masterData = AshlessLongYanConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = AshlessLongYanConfig.instance:getCreepsCfg(self._creepsMasterId)

	local key = string.format("AshlessLongYan_Rule_%s_%s_%s", self._activityId, self._phaseId, self._stageId)

	local function firstCallback()
		self.isPopRuleDesc = true
	end

	local function nextCallBack()
		self.isPopRuleDesc = false
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback, nextCallBack)
end

function AshlessLongYanFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function AshlessLongYanFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		AshlessLongYanController.instance:sendPM_AshlessLongYanChallengeReq(self._activityId, self._phaseId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function AshlessLongYanFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function AshlessLongYanFmtMo:getFmtInfoConfig()
	return self._masterData
end

return AshlessLongYanFmtMo
