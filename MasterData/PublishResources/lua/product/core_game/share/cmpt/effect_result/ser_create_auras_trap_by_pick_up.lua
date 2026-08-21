require("skill_effect_result_base")
_class("SkillCreateAurasTrapByPickUpEffectResult", SkillEffectResultBase)
SkillCreateAurasTrapByPickUpEffectResult = SkillCreateAurasTrapByPickUpEffectResult

function SkillCreateAurasTrapByPickUpEffectResult:Constructor(trapEntityID, pos, squareRingNum)
  self._trapEntityID = trapEntityID
  self._pos = pos
  self._squareRingNum = squareRingNum
end

function SkillCreateAurasTrapByPickUpEffectResult:GetEffectType()
  return SkillEffectType.CreateAurasTrapByPickUp
end

function SkillCreateAurasTrapByPickUpEffectResult:GetTrapEntityID()
  return self._trapEntityID
end

function SkillCreateAurasTrapByPickUpEffectResult:GetPos()
  return self._pos
end

function SkillCreateAurasTrapByPickUpEffectResult:GetSquareRingNum()
  return self._squareRingNum
end
