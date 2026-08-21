_class("SkillEffectResult_RotateByPickSector", SkillEffectResultBase)
SkillEffectResult_RotateByPickSector = SkillEffectResult_RotateByPickSector

function SkillEffectResult_RotateByPickSector:Constructor(rotateAngle, dirNew)
  self._rotateAngle = rotateAngle
  self._dirNew = dirNew:Clone()
end

function SkillEffectResult_RotateByPickSector:GetEffectType()
  return SkillEffectType.RotateByPickSector
end

function SkillEffectResult_RotateByPickSector:GetRotateAngle()
  return self._rotateAngle
end

function SkillEffectResult_RotateByPickSector:GetDirNew()
  return self._dirNew
end
