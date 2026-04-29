require("skill_effect_param_base")
_class("SkillEffectParamSummonWithCasterAttribute", SkillEffectParam_SummonEverything)
SkillEffectParamSummonWithCasterAttribute = SkillEffectParamSummonWithCasterAttribute
local SummonWithCasterAttributeType = {HpPercent = 1, MAX = 9}
_enum("SummonWithCasterAttributeType", SummonWithCasterAttributeType)

function SkillEffectParamSummonWithCasterAttribute:Constructor(t)
  self._compareType = t.compareType or SummonWithCasterAttributeType.HpPercent
  self._compareParam = t.compareParam or 1
  self._compareSymbol = t.compareSymbol
  self._monsterID = t.monsterID
end

function SkillEffectParamSummonWithCasterAttribute:GetEffectType()
  return SkillEffectType.SummonWithCasterAttribute
end

function SkillEffectParamSummonWithCasterAttribute:GetCompareType()
  return self._compareType
end

function SkillEffectParamSummonWithCasterAttribute:GetCompareParam()
  return self._compareParam
end

function SkillEffectParamSummonWithCasterAttribute:GetCompareSymbol()
  return self._compareSymbol
end

function SkillEffectParamSummonWithCasterAttribute:GetMonsterID()
  return self._monsterID
end

function SkillEffectParamSummonWithCasterAttribute:GetInitCasterBornBuff()
  return self._initCasterBornBuff
end
