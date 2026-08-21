_class("SkillManualConvertGridElementEffectResult", SkillEffectResultBase)
SkillManualConvertGridElementEffectResult = SkillManualConvertGridElementEffectResult

function SkillManualConvertGridElementEffectResult:Constructor(gridArray, targetElementType)
  self._gridArray = gridArray
  self._targetElementType = targetElementType
end

function SkillManualConvertGridElementEffectResult:GetEffectType()
  return SkillEffectType.ManualConvert
end

function SkillManualConvertGridElementEffectResult:GetTargetGridArray()
  return self._gridArray
end

function SkillManualConvertGridElementEffectResult:GetTargetElementType()
  return self._targetElementType
end
