_class("DataTeamCreationResult", Object)
DataTeamCreationResult = DataTeamCreationResult

function DataTeamCreationResult:Constructor()
  self._teamEntityID = -1
  self._firstPetEntityID = -1
  self._BornPos = nil
  self._BornRotation = nil
  self._hpOffset = nil
  self._elementType = ElementType.ElementType_None
  self._hp = -1
  self._maxHp = -1
  self._logicPos = nil
  self._petCreationOrder = {}
  self._petCreationResultList = {}
end

function DataTeamCreationResult:AddPetCreationOrder(petPstID)
  self._petCreationOrder[#self._petCreationOrder + 1] = petPstID
end

function DataTeamCreationResult:GetPetCreationOrder()
  return self._petCreationOrder
end

function DataTeamCreationResult:SetCreationResultTeamEntityID(id)
  self._teamEntityID = id
end

function DataTeamCreationResult:GetCreationResultTeamEntityID()
  return self._teamEntityID
end

function DataTeamCreationResult:SetCreationResultFirstPetEntityID(id)
  self._firstPetEntityID = id
end

function DataTeamCreationResult:GetCreationResultFirstPetEntityID()
  return self._firstPetEntityID
end

function DataTeamCreationResult:SetCreationResultHPOffset(offset)
  self._hpOffset = offset
end

function DataTeamCreationResult:GetCreationResultHPOffset()
  return self._hpOffset
end

function DataTeamCreationResult:SetCreationResultElement(element)
  self._elementType = element
end

function DataTeamCreationResult:GetCreationResultElement()
  return self._elementType
end

function DataTeamCreationResult:SetCreationResultHP(hp)
  self._hp = hp
end

function DataTeamCreationResult:GetCreationResultHP()
  return self._hp
end

function DataTeamCreationResult:SetCreationResultMaxHP(maxHp)
  self._maxHp = maxHp
end

function DataTeamCreationResult:GetCreationResultMaxHP()
  return self._maxHp
end

function DataTeamCreationResult:SetCreationResultLogicPos(pos)
  self._logicPos = pos
end

function DataTeamCreationResult:GetCreationResultLogicPos()
  return self._logicPos
end

function DataTeamCreationResult:SetCreationResultBornPos(pos)
  self._BornPos = pos
end

function DataTeamCreationResult:GetCreationResultBornPos()
  return self._BornPos
end

function DataTeamCreationResult:SetCreationResultBornRotation(rotation)
  self._BornRotation = rotation
end

function DataTeamCreationResult:GetCreationResultBornRotation()
  return self._BornRotation
end

function DataTeamCreationResult:GetPetCreationResultList()
  return self._petCreationResultList
end

function DataTeamCreationResult:SetPetCreationResultList(petResList)
  self._petCreationResultList = petResList
end
