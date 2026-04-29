_class("BoardSpliceComponent", Object)
BoardSpliceComponent = BoardSpliceComponent

function BoardSpliceComponent:Constructor(pieceTable)
  self.Pieces = {}
  self._posIndex2Pos = {}
  self._blockFlags = {}
  self.ChangePos = {}
  self._gridEntityTable = {}
  if pieceTable then
    for x, col in pairs(pieceTable) do
      self.Pieces[x] = {}
      for y, grid in pairs(col) do
        self.Pieces[x][y] = grid.color
        self.ChangePos[#self.ChangePos + 1] = Vector2(x, y)
      end
    end
  end
  self._piecesEffectTypeList = {}
  self._prismEntityIDs = {}
end

function BoardSpliceComponent:InitPieceTableData(pieceTable)
  self._blockFlags = {}
  for x, ys in pairs(pieceTable) do
    self._blockFlags[x] = {}
    for y, _ in pairs(ys) do
      self._blockFlags[x][y] = PieceBlockData:New(x, y)
      self._posIndex2Pos[x * 100 + y] = Vector2(x, y)
    end
  end
  local t = {}
  for x, col in pairs(pieceTable) do
    self.Pieces[x] = {}
    for y, grid in pairs(col) do
      self.Pieces[x][y] = grid.color
      self.ChangePos[#self.ChangePos + 1] = Vector2(x, y)
      t[x * 100 + y] = grid.color
    end
  end
end

function BoardSpliceComponent:CloneBoardPosList()
  local pieceList = {}
  for x, row in pairs(self.Pieces) do
    for y, color in pairs(row) do
      pieceList[#pieceList + 1] = Vector2(x, y)
    end
  end
  return pieceList
end

function BoardSpliceComponent:GetPieceType(pos)
  local x, y = pos.x, pos.y
  if self.Pieces[x] and self.Pieces[x][y] then
    return self.Pieces[x][y]
  end
  return PieceType.None
end

function BoardSpliceComponent:SetPieceElement(pos, pieceType)
  local old = self.Pieces[pos.x][pos.y]
  self.Pieces[pos.x][pos.y] = pieceType
  self:PrintBoardCmptLog("SetPieceElement() pos=", Vector2.Pos2Index(pos), " from=", old, " to=", pieceType)
end

function BoardSpliceComponent:PrintBoardCmptLog(...)
  if self._entity._world and self._entity._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BoardSpliceComponent:GetChangePosAndClear()
  local chagePosArray = self.ChangePos
  self.ChangePos = {}
  return chagePosArray
end

function BoardSpliceComponent:GetGridEntityData()
  return self._gridEntityTable
end

function BoardSpliceComponent:AddGridEntityData(pos, pieceType)
  self._gridEntityTable[pos] = pieceType
end

function BoardSpliceComponent:GetPrismEntityIDAtPos(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._prismEntityIDs[posIdx]
end

function BoardSpliceComponent:IsSpecialPieceEffect(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._piecesEffectTypeList[posIdx]
end

function BoardSpliceComponent:GetBoardPieceEffectType(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._piecesEffectTypeList[posIdx]
end

function BoardSpliceComponent:SetBoardPieceEffectType(pos, pieceEffectType, pieceEffectEntityID)
  local posIdx = Vector2.Pos2Index(pos)
  self._piecesEffectTypeList[posIdx] = pieceEffectType
  self._prismEntityIDs[posIdx] = pieceEffectEntityID
end

function BoardSpliceComponent:RemoveBoardPieceEffectType(pos)
  local posIdx = Vector2.Pos2Index(pos)
  self:SetBoardPieceEffectType(pos, nil, nil)
end

function Entity:BoardSplice()
  return self:GetComponent(self.WEComponentsEnum.BoardSplice)
end

function Entity:HasBoardSplice()
  return self:HasComponent(self.WEComponentsEnum.BoardSplice)
end

function Entity:ReplaceBoardSplice(pieceTable)
  local index = self.WEComponentsEnum.BoardSplice
  local component = BoardSpliceComponent:New(pieceTable)
  self:ReplaceComponent(index, component)
end

function Entity:AddBoardSplice(pieceTable)
  local index = self.WEComponentsEnum.BoardSplice
  local component = BoardSpliceComponent:New(pieceTable)
  self:AddComponent(index, component)
end
