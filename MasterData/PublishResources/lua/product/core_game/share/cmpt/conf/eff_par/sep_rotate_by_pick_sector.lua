require("skill_damage_effect_param")
_class("SkillEffectParamRotateByPickSector", SkillEffectParamBase)
SkillEffectParamRotateByPickSector = SkillEffectParamRotateByPickSector

function SkillEffectParamRotateByPickSector:GetEffectType()
  return SkillEffectType.RotateByPickSector
end

function SkillEffectParamRotateByPickSector:Constructor(t)
  self._absRotateAngle = t.absRotateAngle or 0
end

function SkillEffectParamRotateByPickSector:GetAbsRotateAngle()
  return self._absRotateAngle
end
