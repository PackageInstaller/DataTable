_class("BoardPushComponent", Object)
BoardPushComponent = BoardPushComponent

function BoardPushComponent:Constructor()
  self._pieceCacheTab = {}
  self._posIndex2Pos = {}
  self._blockFlags = {}
  self.ChangePos = {}
  self._gridEntityTable = {}
  self._pushIndex = 0
  self._oriY = 0
  self._pushedPieceCacheTab = {}
end

function BoardPushComponent:SetPushIndex(index)
  self._pushIndex = index
end

function BoardPushComponent:GetPushIndex()
  return self._pushIndex
end

function BoardPushComponent:InitPieceTableData(pieceTable)
  for x, col in pairs(pieceTable) do
    self._pieceCacheTab[x] = {}
    for y, grid in pairs(col) do
      self._pieceCacheTab[x][y] = grid.color
      self:AddGridEntityData(Vector2(x, y), grid.color)
    end
  end
end

function BoardPushComponent:CloneBoardPosList()
  local pieceList = {}
  for x, row in pairs(self._pieceCacheTab) do
    for y, color in pairs(row) do
      pieceList[#pieceList + 1] = Vector2(x, y)
    end
  end
  return pieceList
end

function BoardPushComponent:GetPieceType(pos)
  local x, y = pos.x, pos.y
  if self._pieceCacheTab[x] and self._pieceCacheTab[x][y] then
    return self._pieceCacheTab[x][y]
  end
  return PieceType.None
end

function BoardPushComponent:SetPieceElement(pos, pieceType)
  local old = self._pieceCacheTab[pos.x][pos.y]
  self._pieceCacheTab[pos.x][pos.y] = pieceType
  self:PrintBoardCmptLog("SetPieceElement() pos=", Vector2.Pos2Index(pos), " from=", old, " to=", pieceType)
end

function BoardPushComponent:PrintBoardCmptLog(...)
  if self._entity._world and self._entity._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BoardPushComponent:GetChangePosAndClear()
  local chagePosArray = self.ChangePos
  self.ChangePos = {}
  return chagePosArray
end

function BoardPushComponent:GetGridEntityData()
  return self._gridEntityTable
end

function BoardPushComponent:AddGridEntityData(pos, pieceType)
  self._gridEntityTable[pos] = pieceType
end

function Entity:BoardPush()
  return self:GetComponent(self.WEComponentsEnum.BoardPush)
end

function Entity:HasBoardPush()
  return self:HasComponent(self.WEComponentsEnum.BoardPush)
end

function Entity:ReplaceBoardPush()
  local index = self.WEComponentsEnum.BoardPush
  local component = BoardPushComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:AddBoardPush()
  local index = self.WEComponentsEnum.BoardPush
  local component = BoardPushComponent:New()
  self:AddComponent(index, component)
end
