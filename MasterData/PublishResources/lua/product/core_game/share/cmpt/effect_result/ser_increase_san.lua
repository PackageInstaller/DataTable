require("skill_effect_result_base")
_class("SkillEffectResult_IncreaseSan", SkillEffectResultBase)
SkillEffectResult_IncreaseSan = SkillEffectResult_IncreaseSan

function SkillEffectResult_IncreaseSan:Constructor(val, debtVal, modifyTimes)
  self._val = val
  self._debtVal = debtVal
  self._modifyTimes = modifyTimes
end

function SkillEffectResult_IncreaseSan:GetVal()
  return self._val
end

function SkillEffectResult_IncreaseSan:GetEffectType()
  return SkillEffectType.IncreaseSan
end

function SkillEffectResult_IncreaseSan:SetOldSanValue(v)
  self._oldSanVal = v
end

function SkillEffectResult_IncreaseSan:SetNewSanValue(v)
  self._currentSanVal = v
end

function SkillEffectResult_IncreaseSan:SetDebtValue(v)
  self._debtVal = v
end

function SkillEffectResult_IncreaseSan:SetModifyTimes(v)
  self._modifyTimes = v
end

function SkillEffectResult_IncreaseSan:GetOldSanValue()
  return self._oldSanVal
end

function SkillEffectResult_IncreaseSan:GetNewSanValue()
  return self._currentSanVal
end

function SkillEffectResult_IncreaseSan:GetDebtValue()
  return self._debtVal
end

function SkillEffectResult_IncreaseSan:GetModifyTimes()
  return self._modifyTimes
end
