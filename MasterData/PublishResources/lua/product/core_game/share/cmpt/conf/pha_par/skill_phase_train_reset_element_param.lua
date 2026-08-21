require("skill_phase_param_base")
_class("SkillPhaseTrainResetElementParam", SkillPhaseParamBase)
SkillPhaseTrainResetElementParam = SkillPhaseTrainResetElementParam

function SkillPhaseTrainResetElementParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._gridIntervalTime = t.gridIntervalTime
  self._bestConvertTime = t.bestConvertTime
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseTrainResetElementParam:GetCacheTable()
  local t = {}
  local gridFxCacheElement = self:GenerateCacheTableElementByID(self._gridEffectID)
  table.insert(t, gridFxCacheElement)
  return t
end

function SkillPhaseTrainResetElementParam:GetPhaseType()
  return SkillViewPhaseType.TrainResetElement
end

function SkillPhaseTrainResetElementParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseTrainResetElementParam:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseTrainResetElementParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseTrainResetElementParam:GetFinishDelayTime()
  return self._finishDelayTime
end
