require("skill_effect_param_base")
_class("SkillEffectParamSummonMeantimeLimit", SkillEffectParamBase)
SkillEffectParamSummonMeantimeLimit = SkillEffectParamSummonMeantimeLimit

function SkillEffectParamSummonMeantimeLimit:Constructor(t)
  self._trapID = t.trapID
  self._limitCount = t.limitCount
  self._trapDieSkillID = t.trapDieSkillID
  self._ignoreBlock = t.ignoreBlock or false
  self._overlapFlag = t.overlapFlag or 1
  self._absPosArray = t.absPos or {}
  self._replaceAttr = t.replaceAttr or {}
  self._checkTrapID = t.checkTrapID or {
    self._trapID
  }
end

function SkillEffectParamSummonMeantimeLimit:GetEffectType()
  return SkillEffectType.SummonMeantimeLimit
end

function SkillEffectParamSummonMeantimeLimit:GetTrapID()
  return self._trapID
end

function SkillEffectParamSummonMeantimeLimit:IgnoreBlock()
  return self._ignoreBlock
end

function SkillEffectParamSummonMeantimeLimit:GetCheckTrapID()
  return self._checkTrapID
end

function SkillEffectParamSummonMeantimeLimit:GetLimitCount()
  return self._limitCount
end

function SkillEffectParamSummonMeantimeLimit:GetTrapDieSkillID()
  return self._trapDieSkillID
end

function SkillEffectParamSummonMeantimeLimit:IsTrapOverlap()
  return self._overlapFlag == 1
end

function SkillEffectParamSummonMeantimeLimit:GetAbsPosArray()
  return self._absPosArray
end

function SkillEffectParamSummonMeantimeLimit:GetReplaceAttr()
  return self._replaceAttr
end
