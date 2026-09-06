-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/model/BoccaccioclgFmtMo.lua

module("logic.extensions.boccaccioclg.model.BoccaccioclgFmtMo", package.seeall)

local BoccaccioclgFmtMo = class("BoccaccioclgFmtMo", BaseCustomFmtMo)

function BoccaccioclgFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageCfg = BoccaccioclgConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = BoccaccioclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = BoccaccioclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function BoccaccioclgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function BoccaccioclgFmtMo:initFightHandler()
	local function handler()
		if not BoccaccioclgController.instance:isInChallengeTime(self._activityId) then
			FloatWordMgr.instance:show("不在挑战时间内")
			self:close()

			return
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		BoccaccioClgAgent.instance:sendPM_BoccaccioClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function BoccaccioclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BoccaccioclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function BoccaccioclgFmtMo:getExtendViewName()
	return ViewName.BoccaccioclgextView
end

return BoccaccioclgFmtMo
