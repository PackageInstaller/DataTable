_class("BoardMultiComponent", Object)
BoardMultiComponent = BoardMultiComponent

function BoardMultiComponent:Constructor(pieceTable, index)
end

function BoardMultiComponent:InitBoardMulti(pieceTable, index)
  if not self._multiBoard then
    self._multiBoard = {}
  end
  if not self._multiBoard[index] then
    self._multiBoard[index] = {}
  end
  local curBoard = self._multiBoard[index]
  curBoard.Pieces = {}
  curBoard.DimensionDoor = {}
  curBoard.Exit = {}
  curBoard.BenumbTrigger = {}
  curBoard.GridEdgeMinDistance = {}
  curBoard._blockFlags = {}
  curBoard._posIndex2Pos = {}
  if pieceTable then
    for x, ys in pairs(pieceTable) do
      curBoard._blockFlags[x] = {}
      for y, _ in pairs(ys) do
        curBoard._blockFlags[x][y] = PieceBlockData:New(x, y)
        curBoard._posIndex2Pos[x * 100 + y] = Vector2(x, y)
      end
    end
  end
  curBoard.ChangePos = {}
  curBoard._gridEntityTable = {}
  curBoard.isFilling = false
  curBoard.PieceFillTable = {}
  if pieceTable then
    for x, col in pairs(pieceTable) do
      curBoard.Pieces[x] = {}
      for y, grid in pairs(col) do
        curBoard.Pieces[x][y] = grid.color
        curBoard.ChangePos[#curBoard.ChangePos + 1] = Vector2(x, y)
      end
    end
  end
  curBoard._chainPathNewGridElementList = {}
  curBoard._piecesEffectTypeList = {}
  curBoard._prismEntityIDs = {}
  curBoard._pieceEntities = nil
  self:InitGridEdgeDistance(pieceTable, curBoard)
  curBoard._blockChangeFlag = false
  curBoard._blockFlagMaps = {}
end

function BoardMultiComponent:SetPieceEntities(boardIndex, t)
  local curBoard = self._multiBoard[boardIndex]
  curBoard._pieceEntities = t
end

function BoardMultiComponent:AddPieceEntity(boardIndex, pos, entity)
  local curBoard = self._multiBoard[boardIndex]
  if entity:HasTeam() or entity:HasTrapID() or entity:HasMonsterID() then
    if not curBoard._pieceEntities then
      curBoard._pieceEntities = {}
    end
    local posIdx = Vector2.Pos2Index(pos)
    local es = curBoard._pieceEntities[posIdx] or {}
    if not table.icontains(es, entity) then
      es[#es + 1] = entity
    end
    curBoard._pieceEntities[posIdx] = es
  end
end

function BoardMultiComponent:RemovePieceEntity(boardIndex, pos, entity)
  local curBoard = self._multiBoard[boardIndex]
  if not curBoard._pieceEntities then
    return
  end
  local posIdx = Vector2.Pos2Index(pos)
  local es = curBoard._pieceEntities[posIdx]
  if not es then
    return
  end
  table.removev(es, entity)
end

function BoardMultiComponent:GetPieceEntities(boardIndex, pos, filter)
  local curBoard = self._multiBoard[boardIndex]
  if not curBoard._pieceEntities then
    return {}
  end
  local posIdx = Vector2.Pos2Index(pos)
  local es = curBoard._pieceEntities[posIdx]
  if not es then
    return {}
  end
  local ret = {}
  if filter then
    for i, e in ipairs(es) do
      if filter(e) then
        ret[#ret + 1] = e
      end
    end
  else
    ret = es
  end
  return ret
end

function BoardMultiComponent:GetChangePosAndClear(boardIndex)
  local curBoard = self._multiBoard[boardIndex]
  local chagePosArray = curBoard.ChangePos
  curBoard.ChangePos = {}
  return chagePosArray
end

function BoardMultiComponent:GetGridEntityData()
  local gridEntityTableList = {}
  for index, curBoard in pairs(self._multiBoard) do
    gridEntityTableList[index] = curBoard
  end
  return gridEntityTableList
end

function BoardMultiComponent:AddGridEntityData(pos, pieceType, boardIndex)
  local curBoard = self._multiBoard[boardIndex]
  curBoard._gridEntityTable[pos] = pieceType
end

function BoardMultiComponent:IsSpecialPieceEffect(boardIndex, pos)
  local curBoard = self._multiBoard[boardIndex]
  local posIdx = Vector2.Pos2Index(pos)
  return curBoard._piecesEffectTypeList[posIdx]
end

function BoardMultiComponent:GetBoardPieceEffectType(boardIndex, pos)
  local curBoard = self._multiBoard[boardIndex]
  local posIdx = Vector2.Pos2Index(pos)
  return curBoard._piecesEffectTypeList[posIdx]
end

function BoardMultiComponent:SetBoardPieceEffectType(boardIndex, pos, pieceEffectType, pieceEffectEntityID)
  local curBoard = self._multiBoard[boardIndex]
  local posIdx = Vector2.Pos2Index(pos)
  curBoard._piecesEffectTypeList[posIdx] = pieceEffectType
  curBoard._prismEntityIDs[posIdx] = pieceEffectEntityID
end

function BoardMultiComponent:RemoveBoardPieceEffectType(boardIndex, pos)
  local curBoard = self._multiBoard[boardIndex]
  local posIdx = Vector2.Pos2Index(pos)
  self:SetBoardPieceEffectType(boardIndex, pos, nil, nil)
end

function BoardMultiComponent:InitPieceTableData(pieceTable, boardIndex)
  if not self._multiBoard then
    self._multiBoard = {}
  end
  if not self._multiBoard[boardIndex] then
    self:InitBoardMulti(pieceTable, boardIndex)
  end
  local curBoard = self._multiBoard[boardIndex]
  self:InitGridEdgeDistance(pieceTable, curBoard)
end

function BoardMultiComponent:GetPieceType(pos, boardIndex)
  local curBoard = self._multiBoard[boardIndex]
  local x, y = pos.x, pos.y
  if curBoard.Pieces[x] and curBoard.Pieces[x][y] then
    return curBoard.Pieces[x][y]
  end
  return PieceType.None
end

function BoardMultiComponent:GetPieceData(pos, boardIndex)
  local curBoard = self._multiBoard[boardIndex]
  local x, y = pos.x, pos.y
  if curBoard.Pieces[x] and curBoard.Pieces[x][y] then
    return curBoard.Pieces[x][y]
  end
  return nil
end

function BoardMultiComponent:SetPieceElement(boardIndex, pos, pieceType)
  local curBoard = self._multiBoard[boardIndex]
  local old = curBoard.Pieces[pos.x][pos.y]
  curBoard.Pieces[pos.x][pos.y] = pieceType
  local boardMultiServiceLogic = self._entity._world:GetService("BoardMultiLogic")
  local GridTiles = boardMultiServiceLogic:GetGridTiles(boardIndex)
  if GridTiles[pos.x] and GridTiles[pos.x][pos.y] then
    GridTiles[pos.x][pos.y].color = pieceType
  end
  self._entity._world:GetSyncLogger():Trace({
    key = "SetPieceElement",
    pos = Vector2.Pos2Index(pos),
    from = old,
    to = pieceType
  })
  self:PrintBoardCmptLog("SetPieceElement() pos=", Vector2.Pos2Index(pos), " from=", old, " to=", pieceType)
end

function BoardMultiComponent:FindBlockByPos(boardIndex, pos)
  local curBoard = self._multiBoard[boardIndex]
  local nX = math.floor(pos.x)
  if nil == curBoard._blockFlags[nX] then
    return nil
  end
  local nY = math.floor(pos.y)
  local blockData = curBoard._blockFlags[nX][nY]
  if nil == blockData then
  end
  return blockData
end

function BoardMultiComponent:IsPosBlock(boardIndex, pos, blockFlag)
  if not pos then
    return false
  end
  if not blockFlag then
    return false
  end
  local pieceBlock = self:FindBlockByPos(boardIndex, pos)
  if nil == pieceBlock then
    return true
  end
  return pieceBlock:CheckBlock(blockFlag)
end

function BoardMultiComponent:CloneBoardPosList()
  local multiBoardPieceList = {}
  for boardIndex, board in pairs(self._multiBoard) do
    local pieceList = {}
    for x, row in pairs(board.Pieces) do
      for y, color in pairs(row) do
        pieceList[#pieceList + 1] = Vector2(x, y)
      end
    end
    multiBoardPieceList[boardIndex] = pieceList
  end
  return multiBoardPieceList
end

function BoardMultiComponent:InitGridEdgeDistance(pieceTable, curBoard)
  if type(pieceTable) ~= "table" then
    return
  end
  local columnXMinMax = {}
  local rowYMinMax = {}
  for x, col in pairs(pieceTable) do
    for y, v2 in pairs(col) do
      if not columnXMinMax[y] then
        columnXMinMax[y] = {}
      end
      if not columnXMinMax[y].min or x < columnXMinMax[y].min then
        columnXMinMax[y].min = x
      end
      if not columnXMinMax[y].max or x > columnXMinMax[y].max then
        columnXMinMax[y].max = x
      end
      if not rowYMinMax[x] then
        rowYMinMax[x] = {}
      end
      if not rowYMinMax[x].min or y < rowYMinMax[x].min then
        rowYMinMax[x].min = y
      end
      if not rowYMinMax[x].max or y > rowYMinMax[x].max then
        rowYMinMax[x].max = y
      end
    end
  end
  curBoard.GridMinEdgeDistanceX = {}
  curBoard.GridMinEdgeDistanceY = {}
  for x, col in pairs(pieceTable) do
    for y, v2 in pairs(col) do
      if columnXMinMax[y] and rowYMinMax[x] then
        local posIndex = x * 100 + y
        local rowYEdgeDis1 = x - columnXMinMax[y].min
        local rowYEdgeDis2 = columnXMinMax[y].max - x
        local rowYEdgeMinDis = math.min(rowYEdgeDis1, rowYEdgeDis2)
        curBoard.GridMinEdgeDistanceX[posIndex] = rowYEdgeMinDis
        local colXEdgeDis1 = y - rowYMinMax[x].min
        local colXEdgeDis2 = rowYMinMax[x].max - y
        local colXEdgeMinDis = math.min(colXEdgeDis1, colXEdgeDis2)
        curBoard.GridMinEdgeDistanceY[posIndex] = colXEdgeMinDis
      end
    end
  end
  curBoard._columnXMinMax = columnXMinMax
  curBoard._rowYMinMax = rowYMinMax
end

function BoardMultiComponent:PrintBoardCmptLog(...)
  if self._entity._world and self._entity._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function Entity:BoardMulti()
  return self:GetComponent(self.WEComponentsEnum.BoardMulti)
end

function Entity:HasBoardMulti()
  return self:HasComponent(self.WEComponentsEnum.BoardMulti)
end

function Entity:AddBoardMulti(pieceTable)
  local index = self.WEComponentsEnum.BoardMulti
  local component = BoardMultiComponent:New(pieceTable)
  self:AddComponent(index, component)
end
