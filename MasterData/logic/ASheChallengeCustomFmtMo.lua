-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/model/ASheChallengeCustomFmtMo.lua

module("logic.extensions.ashechallenge.model.ASheChallengeCustomFmtMo", package.seeall)

local ASheChallengeCustomFmtMo = class("ASheChallengeCustomFmtMo", BaseCustomFmtMo)

function ASheChallengeCustomFmtMo:onInit()
	ASheChallengeCustomFmtMo.super.onInit(self)

	self.isShowTab = false
end

function ASheChallengeCustomFmtMo:onReset()
	ASheChallengeCustomFmtMo.super.onReset(self)
end

function ASheChallengeCustomFmtMo:initParams(activityId, difficultyId, creepsMasterId, enterView, mainView)
	self._activityId = activityId
	self._difficultyId = difficultyId
	self._creepsMasterId = creepsMasterId
	enterView = enterView or ViewName.ASheEnterView
	mainView = mainView or ViewName.ASheMainView
	self._enterView = enterView
	self._mainView = mainView
end

function ASheChallengeCustomFmtMo:updateData()
	local cfg = ASheConfig.instance:getTeam(self._creepsMasterId)

	self.topTitleStr = cfg.name
	self.ruleDescStr = cfg.description

	self:setFormCondition(cfg.formCondition)
	self:initPetList()
end

function ASheChallengeCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function ASheChallengeCustomFmtMo:initFightHandler()
	local function handler()
		ASheChallengeAgent.instance:sendPM_ASheChallengeBattleReq(self._activityId, self._difficultyId)
		UIJumper.instance:pushOneStack(self._enterView, true)
		UIJumper.instance:pushOneStack(self._mainView, true)
	end

	self:setFightHandler(handler, nil)
end

function ASheChallengeCustomFmtMo:getMonsterConfigList()
	return ASheConfig.instance:getCreepsList(self._creepsMasterId)
end

function ASheChallengeCustomFmtMo:getFmtInfoConfig()
	return ASheConfig.instance:getTeam(self._creepsMasterId)
end

return ASheChallengeCustomFmtMo
