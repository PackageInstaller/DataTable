-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/model/ArmorHeroFmtMo.lua

module("logic.extensions.armorhero.model.ArmorHeroFmtMo", package.seeall)

local ArmorHeroFmtMo = class("ArmorHeroFmtMo", BaseCustomFmtMo)

function ArmorHeroFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = ArmorHeroConfig.instance:getStageCfgByIdAndStageId(self.activityId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = ArmorHeroConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = ArmorHeroConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
end

function ArmorHeroFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		ArmorHeroController.instance:sendChallenge(self.activityId, simpleForm, self.stageId)
	end

	self:setFightHandler(handler, nil)
end

function ArmorHeroFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ArmorHeroFmtMo:getFmtInfoConfig()
	return self._masterData
end

return ArmorHeroFmtMo
