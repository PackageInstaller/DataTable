require("skill_effect_result_base")
_class("SkillEffectResultChangeSanMax", SkillEffectResultBase)
SkillEffectResultChangeSanMax = SkillEffectResultChangeSanMax

function SkillEffectResultChangeSanMax:Constructor(deltaMax, deltaVal)
  self._deltaMax = deltaMax
  self._deltaVal = deltaVal
end

function SkillEffectResultChangeSanMax:GetDeltaMax()
  return self._deltaMax
end

function SkillEffectResultChangeSanMax:GetDeltaVal()
  return self._deltaVal
end

function SkillEffectResultChangeSanMax:GetEffectType()
  return SkillEffectType.ChangeSanMax
end

function SkillEffectResultChangeSanMax:SetOldSanValue(v)
  self._oldSanVal = v
end

function SkillEffectResultChangeSanMax:SetNewSanValue(v)
  self._currentSanVal = v
end

function SkillEffectResultChangeSanMax:SetDebtValue(v)
  self._debtVal = v
end

function SkillEffectResultChangeSanMax:SetModifyTimes(v)
  self._modifyTimes = v
end

function SkillEffectResultChangeSanMax:GetOldSanValue()
  return self._oldSanVal
end

function SkillEffectResultChangeSanMax:GetNewSanValue()
  return self._currentSanVal
end

function SkillEffectResultChangeSanMax:GetDebtValue()
  return self._debtVal
end

function SkillEffectResultChangeSanMax:GetModifyTimes()
  return self._modifyTimes
end

function SkillEffectResultChangeSanMax:SetOldSanMaxValue(v)
  self._oldSanMaxVal = v
end

function SkillEffectResultChangeSanMax:SetNewSanMaxValue(v)
  self._currentSanMaXVal = v
end

function SkillEffectResultChangeSanMax:GetOldSanMaxValue()
  return self._oldSanMaxVal
end

function SkillEffectResultChangeSanMax:GetNewSanMaxValue()
  return self._currentSanMaXVal
end
