require("skill_damage_effect_param")
_class("SkillEffectExchangeGridColorParam", SkillEffectParamBase)
SkillEffectExchangeGridColorParam = SkillEffectExchangeGridColorParam

function SkillEffectExchangeGridColorParam:Constructor(t)
  self._trapID = t.trapID
  self._summonTrapGridTypeList = t.summonTrapGridTypeList
end

function SkillEffectExchangeGridColorParam:GetEffectType()
  return SkillEffectType.ExChangeGridColor
end

function SkillEffectExchangeGridColorParam:GetTrapID()
  return self._trapID
end

function SkillEffectExchangeGridColorParam:GetSummonTrapGridTypeList()
  return self._summonTrapGridTypeList
end
