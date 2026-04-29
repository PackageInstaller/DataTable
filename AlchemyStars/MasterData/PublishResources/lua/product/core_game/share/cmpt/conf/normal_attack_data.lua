_class("NormalAttackData", Object)
NormalAttackData = NormalAttackData

function NormalAttackData:Constructor(attackGridData, petEntityID, normalSkillID, beAttackPos, chainIndex, pathPosition, isLastAttackPos)
  self._data = {
    attackGridData,
    petEntityID,
    normalSkillID,
    beAttackPos,
    chainIndex,
    pathPosition,
    isLastAttackPos
  }
end

function NormalAttackData:GetAttackGridData()
  return self._data[1]
end

function NormalAttackData:SetAttackGridData(attackGridData)
  self._data[1] = attackGridData
end

function NormalAttackData:GetPetEntityID()
  return self._data[2]
end

function NormalAttackData:GetNormalSkillID()
  return self._data[3]
end

function NormalAttackData:GetBeAttackPos()
  return self._data[4]
end

function NormalAttackData:GetChainIndex()
  return self._data[5]
end

function NormalAttackData:GetPathPosition()
  return self._data[6]
end

function NormalAttackData:GetisLastAttackPos()
  return self._data[7]
end

function NormalAttackData:GetNormalAttackIndex()
  return self._normalAttackIndex
end

function NormalAttackData:SetNormalAttackIndex(index)
  self._normalAttackIndex = index
end
