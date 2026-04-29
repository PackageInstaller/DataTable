require("skill_effect_param_base")
_class("SkillTransformationParam", SkillEffectParamBase)
SkillTransformationParam = SkillTransformationParam

function SkillTransformationParam:Constructor(t)
  self._targetMonsterID = t.targetID
  self._useHpPercent = t.useHpPercent or 0
  self.m_InheritAttribute = {}
  if t.InheritAttribute ~= nil and type(t.InheritAttribute) == "table" then
    self.m_InheritAttribute = t.InheritAttribute
  end
  self._useTargetBodyArea = t.useTargetBodyArea or 0
  self._inheritElement = t.inheritElement or false
  self._setTargetPosByOriBodyAreaIndex = t.setTargetPosByOriBodyAreaIndex or 0
end

function SkillTransformationParam:GetEffectType()
  return SkillEffectType.Transformation
end

function SkillTransformationParam:GetTargetMonsterID()
  return self._targetMonsterID
end

function SkillTransformationParam:GetUseHpPercent()
  return self._useHpPercent
end

function SkillTransformationParam:GetInheritAttribute()
  return self.m_InheritAttribute
end

function SkillTransformationParam:IsUseTargetBodyArea()
  return self._useTargetBodyArea == 1
end

function SkillTransformationParam:GetInheritElement()
  return self._inheritElement
end

function SkillTransformationParam:GetSetTargetPosByOriBodyAreaIndex()
  return self._setTargetPosByOriBodyAreaIndex
end
