_class("SkillTransformationEffectResult", SkillEffectResultBase)
SkillTransformationEffectResult = SkillTransformationEffectResult

function SkillTransformationEffectResult:Constructor(caster, monsterID, useHpPercent)
  self.caster = caster
  self.monsterID = monsterID
  self.useHpPercent = useHpPercent
  self.elementType = nil
  self.transformationHp = 0
  self.transformationHpMax = 0
  self.newPos = nil
end

function SkillTransformationEffectResult:GetEffectType()
  return SkillEffectType.Transformation
end

function SkillTransformationEffectResult:GetCaster()
  return self.caster
end

function SkillTransformationEffectResult:GetMonsterID()
  return self.monsterID
end

function SkillTransformationEffectResult:GetUseHpPercent()
  return self.useHpPercent
end

function SkillTransformationEffectResult:SetElementType(type)
  self.elementType = type
end

function SkillTransformationEffectResult:GetElementType()
  return self.elementType
end

function SkillTransformationEffectResult:SetTransformationHp(transformationHp)
  self.transformationHp = transformationHp
end

function SkillTransformationEffectResult:GetTransformationHp()
  return self.transformationHp
end

function SkillTransformationEffectResult:SetTransformationHpMax(transformationHpMax)
  self.transformationHpMax = transformationHpMax
end

function SkillTransformationEffectResult:GetTransformationHpMax()
  return self.transformationHpMax
end

function SkillTransformationEffectResult:SetNewPos(newPos)
  self.newPos = newPos
end

function SkillTransformationEffectResult:GetNewPos()
  return self.newPos
end
