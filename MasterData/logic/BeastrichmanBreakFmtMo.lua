-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/model/BeastrichmanBreakFmtMo.lua

module("logic.extensions.beastrichman.model.BeastrichmanBreakFmtMo", package.seeall)

local BeastrichmanBreakFmtMo = class("BeastrichmanBreakFmtMo", BeastrichmanBossFmtMo)

function BeastrichmanBreakFmtMo:initParams(activityId, zoneId, bossId, stageId)
	self._activityId = activityId
	self._zoneId = zoneId
	self._bossType = BeastRichManEnum.BossType.Break
	self._bossId = bossId
	self._stageId = stageId
	self._bossCfg = BeastRichmanConfig.instance:getBeakStageCfg(self._activityId, self._bossId, stageId)
	self._masterData = BeastRichmanConfig.instance:getMasterCfg(self._bossCfg.creepsMasterId)
	self._creepsCfg = BeastRichmanConfig.instance:getCreepsCfgs(self._bossCfg.creepsMasterId)
	self._supportPetIdList = BeastRichmanModel.instance:getSuppurtPetIds(activityId)
end

return BeastrichmanBreakFmtMo
