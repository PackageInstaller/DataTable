-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/model/BoccaccioChapterC3FmtMo.lua

module("logic.extensions.boccacciochapter.model.BoccaccioChapterC3FmtMo", package.seeall)

local BoccaccioChapterC3FmtMo = class("BoccaccioChapterC3FmtMo", BaseCustomFmtMo)

function BoccaccioChapterC3FmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = BoccaccioChapterConfig.instance:getChapter3StageData(self.activityId, self.stageId)
	self._creepsCfg = BoccaccioChapterConfig.instance:getCreepsDatas(self.stageCfg.creepsMasterId)
	self._creepsTeamData = BoccaccioChapterConfig.instance:getMasterData(self.stageCfg.creepsMasterId)
	self.topTitleStr = self._creepsTeamData.name
	self.ruleDescStr = self._creepsTeamData.ruleDesc

	self:tryInitPetList()
end

function BoccaccioChapterC3FmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local selectBuffId = BoccaccioChapterController.instance:getChapter3SelectedBuffId(self.activityId)
		local simpleForm = self:getCurSimpleForm()

		BoccaccioChapterController.instance:sendPM_BoccaccioChapter3ClgReq(self.activityId, self.stageId, simpleForm, selectBuffId)
	end

	self:setFightHandler(handler, nil)
end

function BoccaccioChapterC3FmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function BoccaccioChapterC3FmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function BoccaccioChapterC3FmtMo:getFmtInfoConfig()
	return self._creepsTeamData
end

return BoccaccioChapterC3FmtMo
