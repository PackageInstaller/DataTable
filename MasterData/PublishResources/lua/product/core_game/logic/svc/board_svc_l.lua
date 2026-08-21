require("base_service")
_class("BoardServiceLogic", BaseService)
BoardServiceLogic = BoardServiceLogic

function BoardServiceLogic:Constructor(world)
  self.GapTiles = {}
  self.AIArea = {
    minX = 0,
    maxX = BattleConst.DefaultAIAreaSize,
    minY = 0,
    maxY = BattleConst.DefaultAIAreaSize
  }
  self.BoardCenterPos = BattleConst.BoardCenterPos
  self.PlayerArea = {
    minX = 1,
    maxX = BattleConst.DefaultPlayerAreaSize,
    minY = 1,
    maxY = BattleConst.DefaultPlayerAreaSize
  }
end

function BoardServiceLogic:IsValidPiecePos(pos)
  local x, y = pos.x, pos.y
  if x == nil or y == nil then
    return
  end
  if self.GridTiles[x] and self.GridTiles[x][y] then
    return true
  end
  return false
end

function BoardServiceLogic:IsPosEmptyExceptConveyor(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  
  local function filter(e)
    if e:HasTeam() or e:HasMonsterID() then
      return true
    end
    if e:HasTrapID() and e:Trap():GetTrapType() ~= TrapType.Conveyor then
      return true
    end
    return false
  end
  
  local es = boardCmpt:GetPieceEntities(pos, filter)
  return #es == 0
end

function BoardServiceLogic:IsPosEmptyExceptConveyorNoDeadMark(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  
  local function filter(e)
    if e:HasDeadMark() then
      return false
    end
    if e:HasTeam() or e:HasMonsterID() then
      return true
    end
    if e:HasTrapID() and e:Trap():GetTrapType() ~= TrapType.Conveyor then
      return true
    end
    return false
  end
  
  local es = boardCmpt:GetPieceEntities(pos, filter)
  return #es == 0
end

function BoardServiceLogic:GetMultiBodyAreaMonster(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  
  local function filter(e)
    if e:HasMonsterID() then
      local arr = e:BodyArea():GetArea()
      if 1 < #arr then
        return true
      end
    end
    return false
  end
  
  local es = boardCmpt:GetPieceEntities(pos, filter)
  return es[1]
end

function BoardServiceLogic:GetFlyMonster(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  
  local function filter(e)
    if e:HasMonsterID() then
      local raceType = e:MonsterID():GetMonsterRaceType()
      if raceType == MonsterRaceType.Fly then
        return true
      end
    end
    return false
  end
  
  local es = boardCmpt:GetPieceEntities(pos, filter)
  return es[1]
end

function BoardServiceLogic:GetValidSummonPos(posTable, bodyArea, posArrayHaveDown, nBlockFlag, searchRing9, noRandom)
  local posList = {}
  table.appendArray(posList, posTable)
  for i, v in ipairs(posArrayHaveDown) do
    table.removev(posList, v)
  end
  if not noRandom then
    local randSvc = self._world:GetService("RandomLogic")
    randSvc:Shuffle(posList)
  end
  for i, pos in ipairs(posList) do
    local pos = self:_GetOneValidSummonPos(pos, nBlockFlag, bodyArea, posArrayHaveDown, searchRing9)
    if pos then
      for i = 1, #bodyArea do
        local posCheck = pos + bodyArea[i]
        table.insert(posArrayHaveDown, posCheck)
      end
      return pos
    end
  end
end

function BoardServiceLogic:_GetOneValidSummonPos(centerPos, nBlockFlag, bodyArea, posArrayHaveDown, searchRing9)
  if self:_IsValidSummonPos(centerPos, nBlockFlag, bodyArea, posArrayHaveDown) then
    return centerPos
  end
  if searchRing9 then
    local ringMax = self:GetCurBoardRingMax()
    for i, v in ipairs(ringMax) do
      local pos = centerPos + Vector2(v[1], v[2])
      if self:_IsValidSummonPos(pos, nBlockFlag, bodyArea, posArrayHaveDown) then
        return pos
      end
    end
  end
end

function BoardServiceLogic:_IsValidSummonPos(centerPos, nBlockFlag, bodyArea, posArrayHaveDown)
  for i = 1, #bodyArea do
    local posCheck = centerPos + bodyArea[i]
    if table.icontains(posArrayHaveDown, posCheck) then
      return false
    end
  end
  if self:IsPosBlockByArea(centerPos, nBlockFlag, bodyArea) then
    return false
  end
  return true
end

function BoardServiceLogic:IsInAIArea(pos)
  local x, y = pos.x, pos.y
  if x == nil or y == nil then
    return
  end
  return x >= self.AIArea.minX and x <= self.AIArea.maxX and y >= self.AIArea.minY and y <= self.AIArea.maxY
end

function BoardServiceLogic:GetPieceType(pos)
  local boardEntity = self._world:GetBoardEntity()
  return boardEntity:Board():GetPieceType(pos)
end

function BoardServiceLogic:GetPieceTypeMapList(pos)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  return boardCmpt:GetPieceTypeMapList(pos)
end

function BoardServiceLogic:GetPieceTypeMapListByPosIndex(posIndex)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  return boardCmpt:GetPieceTypeMapListByPosIndex(posIndex)
end

function BoardServiceLogic:ChangeGapTiles(GapTilesList)
  self.GapTiles = GapTilesList
end

function BoardServiceLogic:GetGapTiles()
  return self.GapTiles
end

function BoardServiceLogic:IsPosDimensionDoor(pos)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:IsPosDimensionDoor(pos)
end

function BoardServiceLogic:IsPosExit(pos)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:IsPosExit(pos)
end

function BoardServiceLogic:IsObstacleTrapTile(pos)
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    return false
  end
  local listTrap = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(listTrap) do
    local trapCmpt = e:Trap()
    local trapType = trapCmpt:GetTrapType()
    if trapType == TrapType.Obstacle or trapType == TrapType.BlockGrid then
      local trapPosList = {}
      local trapPos = e:GridLocation().Position
      if e:BodyArea() then
        local bodyArea = e:BodyArea():GetArea()
        for i, v in ipairs(bodyArea) do
          table.insert(trapPosList, Vector2(trapPos.x + v.x, trapPos.y + v.y))
        end
      else
        table.insert(trapPosList, trapPos)
      end
      for i, v in ipairs(trapPosList) do
        if v.x == pos.x and v.y == pos.y then
          return true
        end
      end
    end
  end
  return false
end

function BoardServiceLogic:GetBoardCenterPos()
  return self.BoardCenterPos
end

function BoardServiceLogic:SetBoardCenterPos(boardCenterPos)
  self.BoardCenterPos = boardCenterPos
end

function BoardServiceLogic:CanCreateMonsterAtPos(posList, monsterRaceType)
  if not monsterRaceType then
    Log.fatal("function Param monsterRaceType is Nil ")
    return false
  end
  local utilData = self._world:GetService("UtilData")
  for _, pos in ipairs(posList) do
    if not utilData:IsValidPiecePos(pos) then
      return false
    end
    if monsterRaceType == MonsterRaceType.Land and self:IsPosBlock(pos, BlockFlag.MonsterLand) then
      return false
    end
    if monsterRaceType == MonsterRaceType.Fly and self:IsPosBlock(pos, BlockFlag.MonsterFly) then
      return false
    end
  end
  return true
end

function BoardServiceLogic:GetTrapPosList()
  local posTable = {}
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    return {}
  end
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapCmpt = e:Trap()
    local trapType = trapCmpt:GetTrapType()
    if trapType ~= TrapType.Conveyor then
      local trapPos = e:GridLocation().Position
      if e:BodyArea() then
        local bodyArea = e:BodyArea():GetArea()
        for i, v in ipairs(bodyArea) do
          table.insert(posTable, Vector2(trapPos.x + v.x, trapPos.y + v.y))
        end
      else
        table.insert(posTable, trapPos)
      end
    end
  end
  return posTable
end

function BoardServiceLogic:IsPosListHaveTrap(posList)
  local trapPosList = self:GetTrapPosList()
  for k, v in ipairs(posList) do
    if table.icontains(trapPosList, v) then
      return true
    end
  end
  return false
end

function BoardServiceLogic:IsBoardPositionsEmpty(posList, extendMonsterAreaPosList, monsterRaceType)
  local boardEntity = self._world:GetBoardEntity()
  local utilDataSvc = self._world:GetService("UtilData")
  if boardEntity and (utilDataSvc:IsPosListHaveMonster(posList) or self:IsPosListHaveTrap(posList)) then
    return false
  end
  if utilDataSvc:IsPosListBlockWithTrapWall(posList, monsterRaceType) then
    return false
  end
  if not self:CanCreateMonsterAtPos(posList, monsterRaceType) then
    return false
  end
  local playerPosList = {}
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    local levelConfigData = self._configService:GetLevelConfigData()
    playerPosList[#playerPosList + 1] = levelConfigData:GetPlayerBornPos()
  else
    local teamEntities = self._world:Player():GetAllTeamEntities()
    for _, teamEntity in ipairs(teamEntities) do
      playerPosList[#playerPosList + 1] = teamEntity:GetGridPosition()
    end
  end
  for _, pos in ipairs(posList) do
    for _, v in ipairs(playerPosList) do
      if v == pos then
        return false
      end
    end
    if extendMonsterAreaPosList then
      for k, v in ipairs(extendMonsterAreaPosList) do
        if v == pos then
          return false
        end
      end
    end
  end
  return true
end

function BoardServiceLogic:CreateMonsterGetValidPos(posTable, bodyArea, monsterBodyPosArray, monsterRaceType)
  return self:_GetValidPos(posTable, bodyArea, monsterBodyPosArray, monsterRaceType)
end

function BoardServiceLogic:GetRandomPiecePos(bodyArea, monsterBodyPosArray, monsterRaceType)
  local boardEntity = self._world:GetBoardEntity()
  local piecePosTable = {}
  if boardEntity then
    local boardComponent = boardEntity:Board()
    for x, piece in pairs(boardComponent.Pieces) do
      for y, pieceType in pairs(piece) do
        table.insert(piecePosTable, Vector2(x, y))
      end
    end
  else
    local levelConfigData = self._configService:GetLevelConfigData()
    local playerPos = levelConfigData:GetPlayerBornPos()
    local maxX = self:GetCurBoardMaxX()
    local maxY = self:GetCurBoardMaxY()
    for x = 1, maxX do
      for y = 1, maxY do
        table.insert(piecePosTable, Vector2(x, y))
      end
    end
  end
  table.sort(piecePosTable, function(a, b)
    return a.x * 100 + a.y < b.x * 100 + b.y
  end)
  return self:_GetValidPos(piecePosTable, bodyArea, monsterBodyPosArray, monsterRaceType)
end

function BoardServiceLogic:_GetValidPos(posTable, bodyArea, monsterBodyPosArray, monsterRaceType, noRandom)
  local boardEntity = self._world:GetBoardEntity()
  local piecePosTable = {}
  for k, p in ipairs(posTable) do
    table.insert(piecePosTable, Vector2(p.x, p.y))
  end
  local blockedPieces = {}
  local trapPosTable = {}
  local playerPos = Vector2(0, 0)
  if boardEntity and self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    local utilDataSvc = self._world:GetService("UtilData")
    blockedPieces = utilDataSvc:GetAllMonsterPos()
    for k, pos in ipairs(blockedPieces) do
      Log.notice("[CreateMonsterPos] BlockPiece Pos:", tostring(pos))
      table.removev(piecePosTable, pos)
    end
    trapPosTable = self:GetTrapPosList()
    for k, pos in ipairs(trapPosTable) do
      Log.notice("[CreateMonsterPos] Trap Pos:", tostring(pos))
      table.removev(piecePosTable, pos)
    end
    local teamGroup = self._world:GetGroup(self._world.BW_WEMatchers.Team)
    for _, team in ipairs(teamGroup:GetEntities()) do
      local teamPos = team:GetGridPosition()
      table.removev(piecePosTable, teamPos)
    end
  else
    local levelConfigData = self._configService:GetLevelConfigData()
    playerPos = levelConfigData:GetPlayerBornPos()
    Log.notice("[CreateMonsterPos] Player Pos:", tostring(playerPos))
    table.removev(piecePosTable, playerPos)
  end
  while #piecePosTable ~= 0 do
    local index = 1
    if not noRandom then
      index = self:_GetRandomNumber(1, #piecePosTable)
    end
    local pos = piecePosTable[index]
    local bodyPosTable = {}
    if bodyArea then
      for k, p in ipairs(bodyArea) do
        table.insert(bodyPosTable, Vector2(pos.x + p.x, pos.y + p.y))
      end
    end
    if self:IsBoardPositionsEmpty(bodyPosTable, nil, monsterRaceType) then
      local isFind = false
      if monsterBodyPosArray then
        for k, p in ipairs(bodyPosTable) do
          if table.icontains(monsterBodyPosArray, p) or table.icontains(blockedPieces, p) or table.icontains(trapPosTable, p) or p == playerPos then
            isFind = true
            break
          end
        end
      end
      if isFind == false then
        table.removev(posTable, pos)
        Log.notice("Find Valid Pos:", tostring(pos))
        return pos
      else
        table.remove(piecePosTable, index)
      end
    else
      table.remove(piecePosTable, index)
    end
  end
  return nil
end

function BoardServiceLogic:GetPlayerArea()
  return self.PlayerArea
end

function BoardServiceLogic:GetGridTiles()
  return self.GridTiles
end

function BoardServiceLogic:GetPlayerAreaPosList()
  local utilData = self._world:GetService("UtilData")
  local ret = {}
  for x = self.PlayerArea.minX, self.PlayerArea.maxX do
    for y = self.PlayerArea.minY, self.PlayerArea.maxY do
      local pos = Vector2(x, y)
      if utilData:IsValidPiecePos(pos) then
        ret[#ret + 1] = pos
      end
    end
  end
  return ret
end

function BoardServiceLogic:GetGridPosByPieceType(pieceTypeList)
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  return boardComponent:GetPiecePosByType(pieceTypeList)
end

function BoardServiceLogic:IsPlayerOnDimension(eTeam)
  if eTeam == nil then
    return false
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  if not boardCmpt:IsPosDimensionDoor(eTeam:GetGridPosition()) then
    eTeam:RemoveDimensionFlag()
  end
  local hasDimensionFlag = eTeam:HasDimensionFlag()
  return hasDimensionFlag
end

function BoardServiceLogic:IsDoor(pos)
  local isDimensionDoor = self:IsPosDimensionDoor(pos)
  if isDimensionDoor then
    return true
  end
  return false
end

function BoardServiceLogic:GetCanConvertGridElement(pos)
  if not pos then
    return false
  end
  if self:IsPosBlock(pos, BlockFlag.ChangeElement) then
    return false
  end
  return true
end

function BoardServiceLogic:GetCanConvertGridElementForTeamPos(pos)
  if not pos then
    return false
  end
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:CanChangePieceToGray() then
    return false
  end
  if self:IsPosBlock(pos, BlockFlag.ChangeElement) then
    if self:IsDoor(pos) or self:IsPosExit(pos) then
      return false
    else
      return true
    end
  end
  return true
end

function BoardServiceLogic:CanFallGrid(pos)
  if not pos then
    return false
  end
  if self:IsPosBlock(pos, BlockFlag.FallGrid) then
    return false
  end
  return true
end

function BoardServiceLogic:SetPieceTypeLogic(pieceType, gridPos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  boardCmpt:SetPieceElement(gridPos, pieceType)
end

function BoardServiceLogic:FindPieceElementByTypeCountAndCenterFromParam(centerPos, pieceTypeList, maxCount, pieceList)
  if type(pieceTypeList) ~= "table" then
    pieceTypeList = {pieceTypeList}
  end
  local boardEntity = self._world:GetBoardEntity()
  local board = boardEntity:Board()
  local retPieceList = {}
  for k, pos in ipairs(pieceList) do
    if board.Pieces[pos.x] and board.Pieces[pos.x][pos.y] and table.icontains(pieceTypeList, board.Pieces[pos.x][pos.y]) then
      table.insert(retPieceList, Vector2(pos.x, pos.y))
    end
  end
  HelperProxy:SortPosByCenterPosDistance(centerPos, retPieceList)
  for i = maxCount + 1, #retPieceList do
    retPieceList[i] = nil
  end
  return retPieceList
end

function BoardServiceLogic:CheckBodyAreaInRange(entity, range)
  local cBodyArea = entity:BodyArea()
  if not cBodyArea then
    return false
  end
  local v2GridPos = entity:GetGridPosition()
  if not v2GridPos then
    return false
  end
  local tv2AbsolutePosInRange = {}
  local tv2RelativeBody = cBodyArea:GetArea()
  for _, v2RelativeBodyPos in ipairs(tv2RelativeBody) do
    local v2AbsoluteBodyPos = v2RelativeBodyPos + v2GridPos
    if table.icontains(range, v2AbsoluteBodyPos) then
      table.insert(tv2AbsolutePosInRange, v2AbsoluteBodyPos)
    end
  end
  return 0 < #tv2AbsolutePosInRange, tv2AbsolutePosInRange
end

function BoardServiceLogic:CalcPieceEntities()
  local posEntities = {}
  local teamGroup = self._world:GetGroup(self._world.BW_WEMatchers.Team)
  for _, team in ipairs(teamGroup:GetEntities()) do
    local teamPos = team:GetGridPosition()
    posEntities[Vector2.Pos2Index(teamPos)] = {team}
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  local es = monsterGroup:GetEntities()
  table.appendArray(es, trapGroup:GetEntities())
  for i, e in ipairs(es) do
    if not e:HasOutsideRegion() then
      local pos = e:GridLocation():GetGridPos()
      local bodyArea = e:BodyArea():GetArea()
      for i, area in ipairs(bodyArea) do
        local posWork = pos + area
        local posIndex = Vector2.Pos2Index(posWork)
        local t = posEntities[posIndex] or {}
        t[#t + 1] = e
        posEntities[posIndex] = t
      end
    end
  end
  return posEntities
end

function BoardServiceLogic:GetMonstersAtPos(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return e:HasMonsterID()
  end)
  return es
end

function BoardServiceLogic:GetEntityMoveBlockFlag(entity)
  local blockVal = 0
  if entity:HasMonsterID() then
    local configService = self._world:GetService("Config")
    local monsterConfigData = configService:GetMonsterConfigData()
    local monsterID = entity:MonsterID():GetMonsterID()
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    if monsterRaceType == MonsterRaceType.Fly then
      blockVal = BlockFlag.MonsterFly
    else
      blockVal = BlockFlag.MonsterLand
    end
  else
    blockVal = BlockFlag.LinkLine
  end
  return blockVal
end

function BoardServiceLogic:SetExtraBoardPosList(ExtraBoard)
  self._extraBoardPosList = ExtraBoard
end

function BoardServiceLogic:GetExtraBoardPosList()
  return self._extraBoardPosList or {}
end

function BoardServiceLogic:SaveMonsterIDCmptOffBoard()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local removeList = {}
  for i, e in ipairs(monsterGroup:GetEntities()) do
    local offBoardCmpt = e:OffBoardMonster()
    if offBoardCmpt then
      local monsterIDCmpt = e:MonsterID()
      offBoardCmpt:SetMonsterID(monsterIDCmpt)
      table.insert(removeList, e)
    end
  end
  for i, e in ipairs(removeList) do
    e:RemoveMonsterID()
  end
end

function BoardServiceLogic:ApplyPrism(prePos, prismPos)
  local board = self._world:GetBoardEntity():Board()
  local posIdx = Vector2.Pos2Index(prismPos)
  if not board:IsPrismPiece(prismPos) then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local utilScope = self._world:GetService("UtilScopeCalc")
  local mapByPosition = board:GetMapByPosition()
  local prismPieceType = board:GetPieceType(prismPos)
  local dir = prismPos - prePos
  local tTargetPieces = {}
  local prismEntityID = board:GetPrismEntityIDAtPos(prismPos)
  local scopeType, scopeParam = utilData:GetPrismCustomScopeConfig(prismEntityID)
  if scopeType then
    local calc = SkillScopeCalculator:New(utilScope)
    local result = calc:ComputeScopeRange(scopeType, scopeParam, prismPos, {
      Vector2.zero
    })
    local range = result:GetAttackRange() or {}
    for _, v2 in ipairs(range) do
      local canChange = not board:IsPosBlock(v2, BlockFlag.ChangeElement)
      if mapByPosition and mapByPosition[posIdx] == PieceType.Any and canChange then
        table.insert(tTargetPieces, {
          pos = v2,
          pieceType = PieceType.Any,
          oriPieceType = board:GetPieceType(v2)
        })
      else
        local targetPieceType = board:GetPieceType(v2)
        if targetPieceType and targetPieceType ~= PieceType.None and canChange then
          table.insert(tTargetPieces, {
            pos = v2,
            pieceType = prismPieceType,
            oriPieceType = targetPieceType
          })
        end
      end
    end
  else
    for i = 1, BattleConst.PrismEffectPieceCount do
      local targetPos = prismPos + dir * i
      local targetPieceType = board:GetPieceType(targetPos)
      local canChange = not board:IsPosBlock(targetPos, BlockFlag.ChangeElement)
      if mapByPosition and mapByPosition[posIdx] == PieceType.Any and canChange then
        table.insert(tTargetPieces, {
          pos = targetPos,
          pieceType = PieceType.Any,
          oriPieceType = targetPieceType
        })
      elseif targetPieceType and targetPieceType ~= PieceType.None and canChange then
        table.insert(tTargetPieces, {
          pos = targetPos,
          pieceType = prismPieceType,
          oriPieceType = targetPieceType
        })
      end
    end
  end
  self._world:GetService("Trigger"):Notify(NTCovCrystalPrism:New(tTargetPieces))
  for _, data in ipairs(tTargetPieces) do
    local targetPos = data.pos
    local pieceType = data.pieceType
    board:SetPieceElement(targetPos, pieceType)
  end
  board:RecordPrismChangeGrid(prismPos, tTargetPieces)
end

function BoardServiceLogic:UnapplyPrism(prismPos)
  local board = self._world:GetBoardEntity():Board()
  board:UnapplyPrism(prismPos)
end

function BoardServiceLogic:ResetPrismChangeRecord()
  local board = self._world:GetBoardEntity():Board()
  board:ResetPrismChangeRecord()
end

function BoardServiceLogic:SetSpliceBoardPosList(spliceBoard)
  self._spliceBoardPosList = spliceBoard
end

function BoardServiceLogic:GetSpliceBoardPosList()
  return self._spliceBoardPosList or {}
end

function BoardServiceLogic:CalcPosRing(pos1, pos2)
  if pos1 == pos2 then
    return 0
  end
  local boardLen = math.max(self:GetCurBoardMaxX(), self:GetCurBoardMaxY())
  for i = 1, boardLen do
    local range = ComputeScopeRange.ComputeRange_SquareRing(pos1, 1, i)
    if table.Vector2Include(range, pos2) then
      return i
    end
  end
end

function BoardServiceLogic:IsInBoardEdge(casterPos)
  local up = self:GetMinYOfColX(casterPos.x)
  local down = self:GetMaxYOfColX(casterPos.x)
  local left = self:GetMinXOfRowY(casterPos.y)
  local right = self:GetMaxXOfRowY(casterPos.y)
  if casterPos.x == left or casterPos.x == right or casterPos.y == up or casterPos.y == down then
    return true
  end
  return false
end

function BoardServiceLogic:InsertListValidPos(posList, validPos)
  if self:IsValidPiecePos(validPos) then
    table.insert(posList, validPos)
  end
end

function BoardServiceLogic:CalcScopeColOrRowByEdgePos(casterPos, needFinalPos)
  if not self:IsInBoardEdge(casterPos) then
    return {}
  end
  local ret = {}
  local maxY = self:GetCurBoardMaxY()
  local maxX = self:GetCurBoardMaxX()
  local up = self:GetMinYOfColX(casterPos.x)
  local down = self:GetMaxYOfColX(casterPos.x)
  local left = self:GetMinXOfRowY(casterPos.y)
  local right = self:GetMaxXOfRowY(casterPos.y)
  if casterPos.y == maxY then
    for i = maxY - 1, 2, -1 do
      self:InsertListValidPos(ret, Vector2(casterPos.x, i))
    end
    if needFinalPos then
      self:InsertListValidPos(ret, Vector2(casterPos.x, 1))
    end
  elseif casterPos.y == 1 then
    for i = 1, maxY - 1 do
      self:InsertListValidPos(ret, Vector2(casterPos.x, i))
    end
    if needFinalPos then
      self:InsertListValidPos(ret, Vector2(casterPos.x, maxY))
    end
  elseif casterPos.x == 1 then
    for i = 1, maxX - 1 do
      self:InsertListValidPos(ret, Vector2(i, casterPos.y))
    end
    if needFinalPos then
      self:InsertListValidPos(ret, Vector2(maxX, casterPos.y))
    end
  elseif casterPos.x == maxX then
    for i = maxX - 1, 2, -1 do
      self:InsertListValidPos(ret, Vector2(i, casterPos.y))
    end
    if needFinalPos then
      self:InsertListValidPos(ret, Vector2(1, casterPos.y))
    end
  end
  return ret
end
