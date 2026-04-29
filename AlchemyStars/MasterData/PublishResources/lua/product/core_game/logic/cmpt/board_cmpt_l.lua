_class("BoardComponent", Object)
BoardComponent = BoardComponent

function BoardComponent:Constructor(pieceTable)
  self.Pieces = {}
  self.DimensionDoor = {}
  self.Exit = {}
  self.BenumbTrigger = {}
  self.GridEdgeMinDistance = {}
  self._blockFlags = {}
  if pieceTable then
    for x, ys in pairs(pieceTable) do
      self._blockFlags[x] = {}
      for y, _ in pairs(ys) do
        self._blockFlags[x][y] = PieceBlockData:New(x, y)
      end
    end
  end
  self.ChangePos = {}
  self._gridEntityTable = {}
  self.isFilling = false
  self.PieceFillTable = {}
  if pieceTable then
    for x, col in pairs(pieceTable) do
      self.Pieces[x] = {}
      for y, grid in pairs(col) do
        self.Pieces[x][y] = grid.color
        self.ChangePos[#self.ChangePos + 1] = Vector2(x, y)
      end
    end
  end
  self._chainPathNewGridElementList = {}
  self._piecesEffectTypeList = {}
  self._prismEntityIDs = {}
  self._pieceEntities = nil
  self:InitGridEdgeDistance(pieceTable)
  self._blockChangeFlag = false
  self._blockFlagMaps = {}
  self._posIndex2Pos = {}
  self._tmpPiecePos = {}
  self._mapByPieceType = {}
  self._mapByPosition = {}
  self._mapForFirstChainPath = nil
  self._prismChangedPieces = {}
  self._maintainColorForSupplyMap = {}
end

function BoardComponent:SetPieceEntities(t)
  self._pieceEntities = t
end

function BoardComponent:AddPieceEntity(pos, entity)
  if entity:HasTeam() or entity:HasTrapID() or entity:HasMonsterID() then
    if not self._pieceEntities then
      self._pieceEntities = {}
    end
    local posIdx = Vector2.Pos2Index(pos)
    local es = self._pieceEntities[posIdx] or {}
    if not table.icontains(es, entity) then
      es[#es + 1] = entity
    end
    self._pieceEntities[posIdx] = es
  end
end

function BoardComponent:RemovePieceEntity(pos, entity)
  if not self._pieceEntities then
    return
  end
  local posIdx = Vector2.Pos2Index(pos)
  local es = self._pieceEntities[posIdx]
  if not es then
    return
  end
  table.removev(es, entity)
end

function BoardComponent:GetPieceEntities(pos, filter, ...)
  if not self._pieceEntities then
    return {}
  end
  local posIdx = Vector2.Pos2Index(pos)
  local es = self._pieceEntities[posIdx]
  if not es then
    return {}
  end
  local ret = {}
  if filter then
    for i, e in ipairs(es) do
      if filter(e, ...) then
        ret[#ret + 1] = e
      end
    end
  else
    ret = es
  end
  return ret
end

function BoardComponent:ClonePieceEntities()
  if not self._pieceEntities then
    return {}
  end
  local t = {}
  for idx, es in pairs(self._pieceEntities) do
    t[idx] = es
  end
  return t
end

function BoardComponent:GetChangePosAndClear()
  local chagePosArray = self.ChangePos
  self.ChangePos = {}
  return chagePosArray
end

function BoardComponent:GetGridEntityData()
  return self._gridEntityTable
end

function BoardComponent:AddGridEntityData(pos, pieceType)
  self._gridEntityTable[pos] = pieceType
end

function BoardComponent:ClearGridEntityData()
  self._gridEntityTable = {}
end

function BoardComponent:ClonePieceTable()
  local t = table_to_class(self.Pieces)
  return t
end

function BoardComponent:IsPrismPiece(pos)
  local posIdx = Vector2.Pos2Index(pos)
  local pieceEffectType = self:GetBoardPieceEffectType(pos)
  if pieceEffectType == PieceEffectType.Prism or pieceEffectType == PieceEffectType.CrossPrism then
    return true
  end
  return false
end

function BoardComponent:GetPrismEntityIDAtPos(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._prismEntityIDs[posIdx]
end

function BoardComponent:ClonePiecesEffectTypeList()
  local t = table_to_class(self._piecesEffectTypeList)
  return t
end

function BoardComponent:ClonePrismEntityIDs()
  return table_to_class(self._prismEntityIDs)
end

function BoardComponent:IsSpecialPieceEffect(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._piecesEffectTypeList[posIdx]
end

function BoardComponent:GetBoardPieceEffectType(pos)
  local posIdx = Vector2.Pos2Index(pos)
  return self._piecesEffectTypeList[posIdx]
end

function BoardComponent:SetBoardPieceEffectType(pos, pieceEffectType, pieceEffectEntityID)
  local posIdx = Vector2.Pos2Index(pos)
  self._piecesEffectTypeList[posIdx] = pieceEffectType
  self._prismEntityIDs[posIdx] = pieceEffectEntityID
end

function BoardComponent:RemoveBoardPieceEffectType(pos)
  local posIdx = Vector2.Pos2Index(pos)
  self:SetBoardPieceEffectType(pos, nil, nil)
end

function BoardComponent:IsPosDimensionDoor(pos)
  local t = self.DimensionDoor[pos.x]
  if not t then
    return false
  end
  return t[pos.y] ~= nil
end

function BoardComponent:RemoveDimensionDoor(pos)
  local t = self.DimensionDoor[pos.x]
  if t then
    t[pos.y] = nil
  end
end

function BoardComponent:AddDimensionDoor(pos, entity)
  local t = self.DimensionDoor[pos.x]
  if not t then
    t = {}
    self.DimensionDoor[pos.x] = t
  end
  t[pos.y] = entity
end

function BoardComponent:IsPosExit(pos)
  local t = self.Exit[pos.x]
  if not t then
    return false
  end
  return t[pos.y] ~= nil
end

function BoardComponent:RemoveExit(pos)
  local t = self.Exit[pos.x]
  if t then
    t[pos.y] = nil
  end
end

function BoardComponent:AddExit(pos, entity)
  local t = self.Exit[pos.x]
  if not t then
    t = {}
    self.Exit[pos.x] = t
  end
  t[pos.y] = entity
end

function BoardComponent:InitPieceTableData(pieceTable, isRefresh)
  if not isRefresh then
    self._blockFlags = {}
    for x, ys in pairs(pieceTable) do
      self._blockFlags[x] = {}
      for y, _ in pairs(ys) do
        self._blockFlags[x][y] = PieceBlockData:New(x, y)
        self._posIndex2Pos[x * 100 + y] = Vector2(x, y)
      end
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
  self:InitGridEdgeDistance(pieceTable)
end

function BoardComponent:RemovePiece(x, y)
  if self.Pieces[x] and self.Pieces[x][y] then
    self.Pieces[x][y] = nil
    self.ChangePos[#self.ChangePos + 1] = Vector2(x, y)
    return true
  end
  return false
end

function BoardComponent:FillPieces(PieceFillTable)
  self.PieceFillTable = PieceFillTable
  local t = {}
  for i, grid in ipairs(PieceFillTable) do
    self.Pieces[grid.x][grid.y] = grid.color
    t[grid.x * 100 + grid.y] = grid.color
  end
  self._entity._world:GetSyncLogger():Trace({key = "FillPieces", pieceTable = t})
  self:PrintBoardCmptLog("BoardComponent FillPieces() :", echo_one_line(ELogLevel.Debug, t))
end

function BoardComponent:GetPieceTypeByIndex(index)
  local pos = self:GetVector2PosByPosIndex(index)
  if pos then
    return self:GetPieceType(pos)
  else
    return PieceType.None
  end
end

function BoardComponent:AddTmpPieceType(pos, type)
  local posIndex = Vector2.Pos2Index(pos)
  self._tmpPiecePos[posIndex] = type
end

function BoardComponent:ClearTmpPieceType()
  self._tmpPiecePos = {}
end

function BoardComponent:GetTmpPieceType(pos)
  local posIndex = Vector2.Pos2Index(pos)
  return self._tmpPiecePos[posIndex]
end

function BoardComponent:GetPieceType(pos)
  if self:GetTmpPieceType(pos) then
    return self:GetTmpPieceType(pos)
  end
  local x, y = pos.x, pos.y
  if self.Pieces[x] and self.Pieces[x][y] then
    return self.Pieces[x][y]
  end
  return PieceType.None
end

function BoardComponent:OnlySetPieceType(pos, pieceType)
  if not self.Pieces[pos.x] then
    self.Pieces[pos.x] = {}
  end
  self.Pieces[pos.x][pos.y] = pieceType
end

function BoardComponent:GetPieceData(pos)
  if self:GetTmpPieceType(pos) then
    return self:GetTmpPieceType(pos)
  end
  local x, y = pos.x, pos.y
  if self.Pieces[x] and self.Pieces[x][y] then
    return self.Pieces[x][y]
  end
  return nil
end

function BoardComponent:GetPiecePosByType(pieceTypeList)
  if type(pieceTypeList) ~= "table" then
    pieceTypeList = {pieceTypeList}
  end
  local retPosList = {}
  for x, columnDic in pairs(self.Pieces) do
    for y, _ in pairs(columnDic) do
      local gridType = self:GetPieceType({x = x, y = y})
      if table.icontains(pieceTypeList, gridType) then
        table.insert(retPosList, Vector2(x, y))
      end
    end
  end
  return retPosList
end

function BoardComponent:RecordPrismChangeGrid(prismPos, changeRecord)
  local posIdx = Vector2.Pos2Index(prismPos)
  self._prismChangedPieces[posIdx] = {}
  local prismRecord = self._prismChangedPieces[posIdx]
  for _, data in ipairs(changeRecord) do
    local changedPosIdx = Vector2.Pos2Index(data.pos)
    prismRecord[changedPosIdx] = data.oriPieceType
  end
end

function BoardComponent:UnapplyPrism(prismPos)
  local posIdx = Vector2.Pos2Index(prismPos)
  local changed = self._prismChangedPieces[posIdx]
  if changed then
    for changedPosIdx, oriPieceType in pairs(changed) do
      local changedPos = Vector2.Index2Pos(changedPosIdx)
      self:SetPieceElement(changedPos, oriPieceType)
    end
    self._prismChangedPieces[posIdx] = nil
  end
end

function BoardComponent:ResetPrismChangeRecord()
  self._prismChangedPieces = {}
end

function BoardComponent:SetPieceElement(pos, pieceType)
  local old = self.Pieces[pos.x][pos.y]
  if not old then
    Log.fatal("SetPieceElement() try set empty pos=", Vector2.Pos2Index(pos), " from=", old, " to=", pieceType)
    return
  end
  self.Pieces[pos.x][pos.y] = pieceType
  local boardLogicSvc = self._entity._world:GetService("BoardLogic")
  local GridTiles = boardLogicSvc.GridTiles
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

function BoardComponent:GetBlockFlagArray()
  return self._blockFlags
end

function BoardComponent:RemoveBlockFlag(pos)
  local blockData = self._blockFlags[pos.x][pos.y]
  if blockData then
    self._blockFlags[pos.x][pos.y] = nil
  end
end

function BoardComponent:FindBlockByPos(pos)
  local nX = math.floor(pos.x)
  if nil == self._blockFlags[nX] then
    return nil
  end
  local nY = math.floor(pos.y)
  local blockData = self._blockFlags[nX][nY]
  if nil == blockData then
  end
  return blockData
end

function BoardComponent:SetBlockFlags(pos, pieceBlockData)
  self._blockFlags[pos.x][pos.y] = pieceBlockData
end

function BoardComponent:GetPosListByFlag(blockFlag)
  local t = {}
  for x, ys in pairs(self._blockFlags) do
    for y, blockData in pairs(ys) do
      if blockData:CheckBlock(blockFlag) then
        table.insert(t, Vector2(x, y))
      end
    end
  end
  return t
end

function BoardComponent:IsPosBlock(pos, blockFlag)
  if not pos then
    return false
  end
  if not blockFlag then
    return false
  end
  local pieceBlock = self:FindBlockByPos(pos)
  if nil == pieceBlock then
    return true
  end
  return pieceBlock:CheckBlock(blockFlag)
end

function BoardComponent:FillPieceUseChainGrid()
  self:FillPieces(self._chainPathNewGridElementList)
  return self._chainPathNewGridElementList
end

function BoardComponent:IsPosNil(pos)
  if self:GetPieceData(pos) then
    return false
  else
    return true
  end
end

function BoardComponent:CloneBoardPosList()
  local pieceList = {}
  for x, row in pairs(self.Pieces) do
    for y, color in pairs(row) do
      pieceList[#pieceList + 1] = Vector2(x, y)
    end
  end
  return pieceList
end

function BoardComponent:IsPosBenumbTrigger(pos)
  local t = self.BenumbTrigger[pos.x]
  if not t then
    return false
  end
  return t[pos.y] ~= nil
end

function BoardComponent:AddBenumbTrigger(pos, entity)
  local t = self.BenumbTrigger[pos.x]
  if not t then
    t = {}
    self.BenumbTrigger[pos.x] = t
  end
  t[pos.y] = entity
end

function BoardComponent:InitGridEdgeDistance(pieceTable)
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
  self.GridMinEdgeDistanceX = {}
  self.GridMinEdgeDistanceY = {}
  for x, col in pairs(pieceTable) do
    for y, v2 in pairs(col) do
      if columnXMinMax[y] and rowYMinMax[x] then
        local posIndex = x * 100 + y
        local rowYEdgeDis1 = x - columnXMinMax[y].min
        local rowYEdgeDis2 = columnXMinMax[y].max - x
        local rowYEdgeMinDis = math.min(rowYEdgeDis1, rowYEdgeDis2)
        self.GridMinEdgeDistanceX[posIndex] = rowYEdgeMinDis
        local colXEdgeDis1 = y - rowYMinMax[x].min
        local colXEdgeDis2 = rowYMinMax[x].max - y
        local colXEdgeMinDis = math.min(colXEdgeDis1, colXEdgeDis2)
        self.GridMinEdgeDistanceY[posIndex] = colXEdgeMinDis
      end
    end
  end
  self._columnXMinMax = columnXMinMax
  self._rowYMinMax = rowYMinMax
end

function BoardComponent:GetMinMaxGridXByGridY(y)
  return self._columnXMinMax[y]
end

function BoardComponent:GetMinMaxGridYByGridX(x)
  return self._rowYMinMax[x]
end

function BoardComponent:GetGridEdgeDistance(v2)
  return self:GetGridEdgeDistanceByPosIndex(v2:Pos2Index())
end

function BoardComponent:GetGridEdgeDistanceByPosIndex(posIndex)
  return self.GridMinEdgeDistanceX[posIndex], self.GridMinEdgeDistanceY[posIndex]
end

function BoardComponent:GetGridMinEdgeDistanceX()
  return self.GridMinEdgeDistanceX
end

function BoardComponent:GetGridMinEdgeDistanceY()
  return self.GridMinEdgeDistanceY
end

function BoardComponent:HasDimensionDoor()
  if not self.DimensionDoor then
    return false
  end
  local doorCnt = #self.DimensionDoor
  if 0 < doorCnt then
    return true
  end
  return false
end

function BoardComponent:PrintBoardCmptLog(...)
  if self._entity._world and self._entity._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BoardComponent:GetCloneVector2PosByPosIndex(posIndex)
  local pos = self._posIndex2Pos[posIndex]
  return pos:Clone()
end

function BoardComponent:GetVector2PosByPosIndex(posIndex)
  local pos = self._posIndex2Pos[posIndex]
  return pos
end

function BoardComponent:BuildBlockFlagMap(blockFlag)
  local posCanMove = {}
  local boardServiceLogic = self._entity._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local posIndex = x * 100 + y
      local pos = self._posIndex2Pos[posIndex]
      if not pos then
        pos = Vector2(x, y)
        self._posIndex2Pos[posIndex] = pos
      end
      if not self:IsPosBlock(pos, blockFlag) then
        posCanMove[posIndex] = true
      end
    end
  end
  return posCanMove
end

function BoardComponent:GetBlockFlagCanMoveMap(blockFlag)
  if not self._blockFlagMaps[blockFlag] then
    self._blockFlagMaps[blockFlag] = self:BuildBlockFlagMap(blockFlag)
  end
  return self._blockFlagMaps[blockFlag]
end

function BoardComponent:ClearBlockFlagCanMoveMap(blockFlag)
  self._blockFlagMaps[blockFlag] = nil
end

function BoardComponent:AddMapByPieceType(sourcePiece, targetPiece)
  self._mapByPieceType[sourcePiece] = targetPiece
end

function BoardComponent:SetMapByPieceType(mapByPieceType)
  self._mapByPieceType = mapByPieceType
end

function BoardComponent:GetMapByPieceType()
  return self._mapByPieceType
end

function BoardComponent:SetMapByPosition(mapByPosition)
  self._mapByPosition = mapByPosition
end

function BoardComponent:GetMapByPosition()
  return self._mapByPosition
end

function BoardComponent:SetMapForFirstChainPath(mapPieceType)
  self._mapForFirstChainPath = mapPieceType
end

function BoardComponent:GetMapForFirstChainPath()
  return self._mapForFirstChainPath
end

function BoardComponent:GetPieceTypeMapList(posWork)
  local pieceTypeMapList = {}
  for posindex, piece in pairs(self._mapByPosition) do
    local pos = Vector2.Index2Pos(posindex)
    if pos == posWork then
      table.insert(pieceTypeMapList, piece)
    end
  end
  return pieceTypeMapList
end

function BoardComponent:GetPieceTypeMapListByPosIndex(posIndexWork)
  local pieceTypeMapList = {}
  for posindex, piece in pairs(self._mapByPosition) do
    if posindex == posIndexWork then
      table.insert(pieceTypeMapList, piece)
    end
  end
  return pieceTypeMapList
end

function BoardComponent:SetMaintainColorForSupply(posIndex, maintainColor)
  self._maintainColorForSupplyMap[posIndex] = DataMaintainColor:New(posIndex, maintainColor)
end

function BoardComponent:ResetMaintainColorForSupply(posIndex)
  self._maintainColorForSupplyMap[posIndex] = nil
end

function BoardComponent:GetMaintainColorForSupply(posIndex)
  local data = self._maintainColorForSupplyMap[posIndex]
  if data then
    return data:GetMaintainColor()
  end
end

function BoardComponent:ResetAllMaintainColorForSupply()
  self._maintainColorForSupplyMap = {}
end

_class("DataMaintainColor", Object)
DataMaintainColor = DataMaintainColor

function DataMaintainColor:Constructor(posIndex, maintainColor)
  self._posIndex = posIndex
  self._maintainColor = maintainColor
end

function DataMaintainColor:GetMaintainColor()
  return self._maintainColor
end

function Entity:Board()
  return self:GetComponent(self.WEComponentsEnum.Board)
end

function Entity:HasBoard()
  return self:HasComponent(self.WEComponentsEnum.Board)
end

function Entity:AddBoard(pieceTable)
  local index = self.WEComponentsEnum.Board
  local component = BoardComponent:New(pieceTable)
  self:AddComponent(index, component)
end
