require("skill_effect_param_base")
_class("SkillEffectParamSummonTrapByTargetPos", SkillEffectParamBase)
SkillEffectParamSummonTrapByTargetPos = SkillEffectParamSummonTrapByTargetPos

function SkillEffectParamSummonTrapByTargetPos:Constructor(t)
  self._trapID = t.trapID
  self._ignoreBlock = t.ignoreBlock or false
end

function SkillEffectParamSummonTrapByTargetPos:GetEffectType()
  return SkillEffectType.SummonTrapByTargetPos
end

function SkillEffectParamSummonTrapByTargetPos:GetTrapID()
  return self._trapID
end

function SkillEffectParamSummonTrapByTargetPos:IgnoreBlock()
  return self._ignoreBlock
end
