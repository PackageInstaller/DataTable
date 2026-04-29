_class("PieceBlockData", Object)
PieceBlockData = PieceBlockData

function PieceBlockData:Constructor(nX, nY)
  self.m_listBlock = {}
  self._x, self._y = nX, nY
end

function PieceBlockData:AddBlock(nEntityID, nBlockData)
  self.m_listBlock[nEntityID] = nBlockData
end

function PieceBlockData:AddBlockList(listBlock)
  if nil == listBlock or table.count(listBlock) <= 0 then
    return
  end
  for key, value in pairs(listBlock) do
    self.m_listBlock[key] = value
  end
end

function PieceBlockData:GetBlockList()
  return self.m_listBlock
end

function PieceBlockData:GetEntityBlock(entityID)
  return self.m_listBlock[entityID]
end

function PieceBlockData:DelBlock(nEntityID)
  self.m_listBlock[nEntityID] = nil
end

function PieceBlockData:GetBlock()
  local nReturn = 0
  for key, value in pairs(self.m_listBlock) do
    nReturn = nReturn | value
  end
  return nReturn
end

function PieceBlockData:CheckBlock(nBlockData)
  for key, value in pairs(self.m_listBlock) do
    if 0 < value & nBlockData then
      return true
    end
  end
  return false
end

function PieceBlockData.IsEnumMatch(entityWork, enumEntityType, nTypeParam)
  if EnumTargetEntity.IsEnumMatch(enumEntityType, EnumTargetEntity.Pet) and (entityWork:HasPetPstID() or entityWork:HasTeam()) then
    return true
  end
  if EnumTargetEntity.IsEnumMatch(enumEntityType, EnumTargetEntity.Monster) then
    local cmptMonsterID = entityWork:MonsterID()
    if cmptMonsterID and (nTypeParam and nTypeParam == cmptMonsterID.GetMonsterID() or nil == nTypeParam) then
      return true
    end
  end
  if EnumTargetEntity.IsEnumMatch(enumEntityType, EnumTargetEntity.Trap) then
    local cmptTrap = entityWork:Trap()
    if cmptTrap and (nTypeParam and nTypeParam == cmptTrap:GetTrapType() or nil == nTypeParam) then
      return true
    end
  end
  if EnumTargetEntity.IsEnumMatch(enumEntityType, EnumTargetEntity.ChessPet) then
    local chessPetCmpt = entityWork:ChessPet()
    if chessPetCmpt and (nTypeParam and nTypeParam == chessPetCmpt:GetChessPetID() or nil == nTypeParam) then
      return true
    end
  end
  return false
end

function PieceBlockData:FindEntity(world, enumEntityType, nTypeParam)
  local listFindEntity = {}
  for nEntityID, value in pairs(self.m_listBlock) do
    local entityWork = world:GetEntityByID(nEntityID)
    if entityWork then
      local bFind = PieceBlockData.IsEnumMatch(entityWork, enumEntityType, nTypeParam)
      if bFind then
        table.insert(listFindEntity, nEntityID)
      end
    end
  end
  return listFindEntity
end

function PieceBlockData:IsExistNegative()
  for key, value in pairs(self.m_listBlock) do
    if key < 0 then
      return true
    end
  end
  return false
end
