require("skill_effect_result_base")
_class("SkillEffectResult_DecreaseSanByScope", SkillEffectResultBase)
SkillEffectResult_DecreaseSanByScope = SkillEffectResult_DecreaseSanByScope
SkillEffectResult_DecreaseSanByScope.__EFFECT_TYPE = SkillEffectType.DecreaseSanByScope

function SkillEffectResult_DecreaseSanByScope:Constructor(entityID, range, val, debtVal, modifyTimes)
  self._entityID = entityID
  self._range = range
  self._val = val
  self._debtVal = debtVal
  self._modifyTimes = modifyTimes
end

function SkillEffectResult_DecreaseSanByScope:GetEntityID()
  return self._entityID
end

function SkillEffectResult_DecreaseSanByScope:GetRange()
  return self._range
end

function SkillEffectResult_DecreaseSanByScope:GetVal()
  return self._val
end

function SkillEffectResult_DecreaseSanByScope:SetOldSanValue(v)
  self._oldSanVal = v
end

function SkillEffectResult_DecreaseSanByScope:SetNewSanValue(v)
  self._currentSanVal = v
end

function SkillEffectResult_DecreaseSanByScope:SetDebtValue(v)
  self._debtVal = v
end

function SkillEffectResult_DecreaseSanByScope:SetModifyTimes(v)
  self._modifyTimes = v
end

function SkillEffectResult_DecreaseSanByScope:GetOldSanValue()
  return self._oldSanVal
end

function SkillEffectResult_DecreaseSanByScope:GetNewSanValue()
  return self._currentSanVal
end

function SkillEffectResult_DecreaseSanByScope:GetDebtValue()
  return self._debtVal
end

function SkillEffectResult_DecreaseSanByScope:GetModifyTimes()
  return self._modifyTimes
end
