require("skill_effect_result_base")
_class("SkillConvertGridElementEffectResult", SkillEffectResultBase)
SkillConvertGridElementEffectResult = SkillConvertGridElementEffectResult

function SkillConvertGridElementEffectResult:Constructor(gridArray, targetElementType, blockGridArray)
  self._gridArray = gridArray
  self._targetElementType = targetElementType
  self._blockGridArray = blockGridArray
  self._notifyBuff = true
  self._saveTetrisIndex = nil
  self._saveTetrisDirType = nil
end

function SkillConvertGridElementEffectResult:GetEffectType()
  return SkillEffectType.ConvertGridElement
end

function SkillConvertGridElementEffectResult:GetTargetGridArray()
  return self._gridArray
end

function SkillConvertGridElementEffectResult:GetTargetElementType()
  return self._targetElementType
end

function SkillConvertGridElementEffectResult:GetNewGridNumByType(pieceType)
  if self._targetElementType == pieceType then
    return #self._gridArray
  end
  return 0
end

function SkillConvertGridElementEffectResult:GetBlockGridArray()
  return self._blockGridArray
end

function SkillConvertGridElementEffectResult:SetForceConvert()
  self._forceConvert = true
end

function SkillConvertGridElementEffectResult:IsForceConvert()
  return self._forceConvert
end

function SkillConvertGridElementEffectResult:GetNotifyBuff()
  return self._notifyBuff
end

function SkillConvertGridElementEffectResult:SetNotifyBuff(notifyBuff)
  self._notifyBuff = notifyBuff
end

function SkillConvertGridElementEffectResult:SetSaveTetrisIndex(index)
  self._saveTetrisIndex = index
end

function SkillConvertGridElementEffectResult:GetSaveTetrisIndex()
  return self._saveTetrisIndex
end

function SkillConvertGridElementEffectResult:SetSaveTetrisDirType(dirType)
  self._saveTetrisDirType = dirType
end

function SkillConvertGridElementEffectResult:GetSaveTetrisDirType()
  return self._saveTetrisDirType
end
