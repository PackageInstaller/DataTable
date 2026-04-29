require("skill_effect_param_base")
_class("SkillEffectParamEachGridAddBlood", SkillEffectParamBase)
SkillEffectParamEachGridAddBlood = SkillEffectParamEachGridAddBlood

function SkillEffectParamEachGridAddBlood:Constructor(t)
  self._baseAddValue = t.baseAddValue
  self._baseAddType = t.baseAddType
  self._onePieceAddValue = t.addValue
  self._onePieceAddType = t.addType
  self._enhanceGridRecoverValue = t.enhanceGridAddValue
end

function SkillEffectParamEachGridAddBlood:GetEffectType()
  return SkillEffectType.EachGridAddBlood
end

function SkillEffectParamEachGridAddBlood:GetBaseAddValue()
  return self._baseAddValue
end

function SkillEffectParamEachGridAddBlood:GetBaseAddType()
  return self._baseAddType
end

function SkillEffectParamEachGridAddBlood:GetOnePieceAddValue()
  return self._onePieceAddValue
end

function SkillEffectParamEachGridAddBlood:GetOnePieceAddType()
  return self._onePieceAddType
end

function SkillEffectParamEachGridAddBlood:GetEnhanceGridRecoverValue()
  return self._enhanceGridRecoverValue
end
