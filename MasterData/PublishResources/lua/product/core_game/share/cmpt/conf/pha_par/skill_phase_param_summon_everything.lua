require("skill_phase_param_base")
_class("SkillPhaseParam_SummonEverything", SkillPhaseParamBase)
SkillPhaseParam_SummonEverything = SkillPhaseParam_SummonEverything

function SkillPhaseParam_SummonEverything:Constructor(t)
  self._showTimeDelay = t.showTimeDelay or 0
  self._gridEffectID = t.gridEffectID or 0
  self._gridEffectDelayTime = t.gridEffectDelayTime or 0
  self._gridIntervalTime = t.gridIntervalTime or 0
  self._fxNoRotation = tonumber(t.fxNoRotation) == 1
end

function SkillPhaseParam_SummonEverything:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._gridEffectID)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParam_SummonEverything:GetPhaseType()
  return SkillViewPhaseType.SummonEverything
end

function SkillPhaseParam_SummonEverything:GetShowTimeDelay()
  return self._showTimeDelay
end

function SkillPhaseParam_SummonEverything:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseParam_SummonEverything:GetGridEffectDelayTime()
  return self._gridEffectDelayTime
end

function SkillPhaseParam_SummonEverything:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseParam_SummonEverything:IsFxNoRotation()
  return self._fxNoRotation
end
