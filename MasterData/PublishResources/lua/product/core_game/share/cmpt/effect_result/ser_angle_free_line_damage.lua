require("skill_effect_result_base")
_class("SkillEffectAngleFreeLineDamageResult", SkillEffectResultBase)
SkillEffectAngleFreeLineDamageResult = SkillEffectAngleFreeLineDamageResult

function SkillEffectAngleFreeLineDamageResult:Constructor(casterPos, pickupPos, damageResults, pieceEntity)
  self._casterPos = casterPos
  self._pickupPos = pickupPos
  self._damageResults = damageResults
end

function SkillEffectAngleFreeLineDamageResult:GetEffectType()
  return SkillEffectType.AngleFreeLineDamage
end

function SkillEffectAngleFreeLineDamageResult:GetCasterPos()
  return self._casterPos
end

function SkillEffectAngleFreeLineDamageResult:GetPickupPos()
  return self._pickupPos
end

function SkillEffectAngleFreeLineDamageResult:GetDamageResults()
  return self._damageResults
end
