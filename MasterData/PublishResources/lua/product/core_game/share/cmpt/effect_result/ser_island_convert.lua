require("skill_effect_result_base")
_class("SkillEffectResult_IslandConvert_AtomicData", Object)
SkillEffectResult_IslandConvert_AtomicData = SkillEffectResult_IslandConvert_AtomicData

function SkillEffectResult_IslandConvert_AtomicData:Constructor(gridPos, oldPieceType, newPieceType, trapArray, groupCenterPos)
  self._position = gridPos
  self._oldPieceType = oldPieceType
  self._targetPieceType = newPieceType
  self._destroyedTrapArray = trapArray
  self._groupCenterPos = groupCenterPos
end

function SkillEffectResult_IslandConvert_AtomicData:GetPosition()
  return self._position
end

function SkillEffectResult_IslandConvert_AtomicData:GetOldPieceType()
  return self._oldPieceType
end

function SkillEffectResult_IslandConvert_AtomicData:GetTargetPieceType()
  return self._targetPieceType
end

function SkillEffectResult_IslandConvert_AtomicData:GetDestroyedTrapArray()
  return self._destroyedTrapArray
end

function SkillEffectResult_IslandConvert_AtomicData:GetGroupCenterPos()
  return self._groupCenterPos
end

_class("SkillEffectResult_IslandConvert", SkillEffectResultBase)
SkillEffectResult_IslandConvert = SkillEffectResult_IslandConvert

function SkillEffectResult_IslandConvert:Constructor(atomicDataArray, tv2GroupCenter)
  self._atomicDataArray = atomicDataArray
  self._tv2GroupCenters = tv2GroupCenter
end

function SkillEffectResult_IslandConvert:GetEffectType()
  return SkillEffectType.IslandConvert
end

function SkillEffectResult_IslandConvert:GetAtomicDataArray()
  return self._atomicDataArray
end

function SkillEffectResult_IslandConvert:GetGroupCenterArray()
  return self._tv2GroupCenters
end

function SkillEffectResult_IslandConvert:GetNewGridNumByType(pieceType)
  local retNum = 0
  for i = 1, #self._atomicDataArray do
    if self._atomicDataArray[i]._targetPieceType == pieceType then
      retNum = retNum + 1
    end
  end
  return retNum
end
