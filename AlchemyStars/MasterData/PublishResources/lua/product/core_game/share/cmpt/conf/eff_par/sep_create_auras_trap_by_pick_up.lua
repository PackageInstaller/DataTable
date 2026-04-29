require("skill_effect_param_base")
_class("SkillCreateAurasTrapByPickUpEffectParam", SkillEffectParamBase)
SkillCreateAurasTrapByPickUpEffectParam = SkillCreateAurasTrapByPickUpEffectParam

function SkillCreateAurasTrapByPickUpEffectParam:Constructor(t)
  self._trapID = t.trapID
  self._squareRingNum = t.squareRingNum or 1
end

function SkillCreateAurasTrapByPickUpEffectParam:GetEffectType()
  return SkillEffectType.CreateAurasTrapByPickUp
end

function SkillCreateAurasTrapByPickUpEffectParam:GetTrapID()
  return self._trapID
end

function SkillCreateAurasTrapByPickUpEffectParam:GetSquareRingNum()
  return self._squareRingNum
end
