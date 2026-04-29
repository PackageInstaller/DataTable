_class("DataPetCreationResult", Object)
DataPetCreationResult = DataPetCreationResult

function DataPetCreationResult:Constructor()
  self._resPath = nil
  self._logicEntityID = -1
  self._templateID = -1
  self._pstID = -1
  self._firstElementType = nil
  self._secondElementType = nil
  self._gridPos = nil
  self._curHp = nil
  self._maxHp = nil
end

function DataPetCreationResult:GetPetCreationGridPos()
  return self._gridPos
end

function DataPetCreationResult:SetPetCreationGridPos(pos)
  self._gridPos = pos
end

function DataPetCreationResult:GetPetCreationFirstElementType()
  return self._firstElementType
end

function DataPetCreationResult:GetPetCreationSecondElementType()
  return self._secondElementType
end

function DataPetCreationResult:SetPetCreationElementType(firstType, secondType)
  self._firstElementType = firstType
  self._secondElementType = secondType
end

function DataPetCreationResult:GetPetCreationTemplateID()
  return self._templateID
end

function DataPetCreationResult:SetPetCreationTemplateID(id)
  self._templateID = id
end

function DataPetCreationResult:GetPetCreationPstID()
  return self._pstID
end

function DataPetCreationResult:SetPetCreationPstID(id)
  self._pstID = id
end

function DataPetCreationResult:GetPetCreationLogicEntityID()
  return self._logicEntityID
end

function DataPetCreationResult:SetPetCreationLogicEntityID(id)
  self._logicEntityID = id
end

function DataPetCreationResult:SetPetCreationRes(resPath)
  self._resPath = resPath
end

function DataPetCreationResult:GetPetCreationRes()
  return self._resPath
end

function DataPetCreationResult:SetPetCreation_CurHp(hp)
  self._curHp = hp
end

function DataPetCreationResult:GetPetCreation_CurHp()
  return self._curHp
end

function DataPetCreationResult:SetPetCreation_MaxHp(hp)
  self._maxHp = hp
end

function DataPetCreationResult:GetPetCreation_MaxHp()
  return self._maxHp
end
