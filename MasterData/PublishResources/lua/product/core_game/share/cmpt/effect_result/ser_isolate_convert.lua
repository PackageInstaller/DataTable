require("skill_effect_result_base")
_class("SkillEffectResult_IsolateConvert_AtomicData", Object)
SkillEffectResult_IsolateConvert_AtomicData = SkillEffectResult_IsolateConvert_AtomicData

function SkillEffectResult_IsolateConvert_AtomicData:Constructor(gridPos, oldPieceType, newPieceType, trapArray)
  self._position = gridPos
  self._oldPieceType = oldPieceType
  self._targetPieceType = newPieceType
  self._destroyedTrapArray = trapArray
end

function SkillEffectResult_IsolateConvert_AtomicData:GetPosition()
  return self._position
end

function SkillEffectResult_IsolateConvert_AtomicData:GetOldPieceType()
  return self._oldPieceType
end

function SkillEffectResult_IsolateConvert_AtomicData:GetTargetPieceType()
  return self._targetPieceType
end

function SkillEffectResult_IsolateConvert_AtomicData:GetDestroyedTrapArray()
  return self._destroyedTrapArray
end

_class("SkillEffectResult_IsolateConvert", SkillEffectResultBase)
SkillEffectResult_IsolateConvert = SkillEffectResult_IsolateConvert

function SkillEffectResult_IsolateConvert:Constructor(tAtomData)
  self._atomicDataArray = tAtomData
end

function SkillEffectResult_IsolateConvert:GetEffectType()
  return SkillEffectType.IsolateConvert
end

function SkillEffectResult_IsolateConvert:GetAtomicDataArray()
  return self._atomicDataArray
end
