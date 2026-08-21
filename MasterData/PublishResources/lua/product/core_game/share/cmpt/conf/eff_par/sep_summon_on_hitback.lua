require("skill_effect_param_base")
_class("SkillEffectSummonOnHitbackParam", SkillEffectParamBase)
SkillEffectSummonOnHitbackParam = SkillEffectSummonOnHitbackParam

function SkillEffectSummonOnHitbackParam:Constructor(t)
  self._trapID = t.trapID
  self._summonOnSides = t.summonOnSides
end

function SkillEffectSummonOnHitbackParam:GetTrapID()
  return self._trapID
end

function SkillEffectSummonOnHitbackParam:GetEffectType()
  return SkillEffectType.SummonOnHitbackPosition
end

function SkillEffectSummonOnHitbackParam:IsSummonOnSides()
  return self._summonOnSides
end
