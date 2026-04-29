_class("DataChessPetCreationResult", Object)
DataChessPetCreationResult = DataChessPetCreationResult

function DataChessPetCreationResult:Constructor()
  self._entityID = -1
  self._templateID = -1
  self._resPath = nil
  self._curHp = -1
  self._maxHp = -1
  self._hpOffset = nil
  self._elementType = ElementType.ElementType_None
  self._lockHpList = nil
  self._gridLocRes = nil
end

function DataChessPetCreationResult:GetChessPetEntityIID()
  return self._entityID
end

function DataChessPetCreationResult:SetChessPetEntityID(entityID)
  self._entityID = entityID
end

function DataChessPetCreationResult:GetChessPetTemplateID()
  return self._templateID
end

function DataChessPetCreationResult:SetChessPetTemplateID(id)
  self._templateID = id
end

function DataChessPetCreationResult:GetChessPetResPath()
  return self._resPath
end

function DataChessPetCreationResult:SetChessPetResPath(path)
  self._resPath = path
end

function DataChessPetCreationResult:GetChessPetHP()
  return self._curHp
end

function DataChessPetCreationResult:SetChessPetHP(hp)
  self._curHp = hp
end

function DataChessPetCreationResult:GetChessPetMaxHP()
  return self._maxHp
end

function DataChessPetCreationResult:SetChessPetMaxHP(hp)
  self._maxHp = hp
end

function DataChessPetCreationResult:GetChessPetHPOffset()
  return self._hpOffset
end

function DataChessPetCreationResult:SetChessPetHPOffset(offset)
  self._hpOffset = offset
end

function DataChessPetCreationResult:GetChessPetElement()
  return self._elementType
end

function DataChessPetCreationResult:SetChessPetElement(element)
  self._elementType = element
end

function DataChessPetCreationResult:GetChessPetLockHPList()
  return self._lockHpList
end

function DataChessPetCreationResult:SetChessPetLockHPList(list)
  self._lockHpList = list
end

function DataChessPetCreationResult:GetChessPetGridLocResult()
  return self._gridLocRes
end

function DataChessPetCreationResult:SetChessPetGridLocResult(res)
  self._gridLocRes = res
end
