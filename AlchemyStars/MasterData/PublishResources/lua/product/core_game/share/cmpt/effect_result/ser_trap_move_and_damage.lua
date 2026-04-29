require("skill_effect_result_base")
_class("SkillEffectTrapMoveAndDamageResult", SkillEffectResultBase)
SkillEffectTrapMoveAndDamageResult = SkillEffectTrapMoveAndDamageResult

function SkillEffectTrapMoveAndDamageResult:Constructor(entityID, walkResultList, damageResult, isOut)
  self._entityID = entityID
  self._walkResultList = walkResultList
  self._damageResult = damageResult
  self._isOut = isOut
end

function SkillEffectTrapMoveAndDamageResult:GetEffectType()
  return SkillEffectType.TrapMoveAndDamage
end

function SkillEffectTrapMoveAndDamageResult:GetEntityID()
  return self._entityID
end

function SkillEffectTrapMoveAndDamageResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectTrapMoveAndDamageResult:GetDamageResult()
  return self._damageResult
end

function SkillEffectTrapMoveAndDamageResult:IsOutBoard()
  return self._isOut
end
