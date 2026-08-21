_class("PieceRefreshSystem", MainStateSystem)
PieceRefreshSystem = PieceRefreshSystem

function PieceRefreshSystem:_GetMainStateID()
  return GameStateID.PieceRefresh
end

function PieceRefreshSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local result = self:_DoLogicFillPiece(teamEntity)
  self:_DoRenderFillPiece(TT, result)
  self:_DoLogicSyncPieceType()
  self:_DoRenderShowStoryTips(TT)
  self:_DoLogicSwitchState()
end

function PieceRefreshSystem:_DoLogicSwitchState()
  self._world:EventDispatcher():Dispatch(GameEventType.PieceRefreshFinish, 1)
end

function PieceRefreshSystem:_DoLogicFillPiece(teamEntity)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  if #logicChainPathCmpt:GetLogicChainPath() == 0 then
    return
  end
  local result = {}
  local affixSvc = self._world:GetService("Affix")
  local pieceRefreshType, fallingDir, param = affixSvc:ReplacePieceRefreshType()
  result.pieceRefreshType = pieceRefreshType
  if pieceRefreshType == PieceRefreshType.Inplace then
    self:CalcPieceRefreshInplace(teamEntity, result)
  elseif pieceRefreshType == PieceRefreshType.FallingDown then
    self:CalcPieceFallingDown(teamEntity, fallingDir, result)
  elseif pieceRefreshType == PieceRefreshType.Destroy then
    local trapID = param:GetGapTrapID()
    self:CalcPieceDestroy(teamEntity, trapID, result)
  end
  local nt = NTAfterPieceRefreshBeginChainSkill:New(teamEntity, logicChainPathCmpt:GetLogicChainPath())
  self._world:GetService("Trigger"):Notify(nt)
  result.ntAfterPieceRefreshBeginChainSkill = nt
  return result
end

function PieceRefreshSystem:CalcPieceRefreshInplace(teamEntity, result)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local newPiecePosList = {}
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  for _, v in ipairs(chainPath) do
    newPiecePosList[#newPiecePosList + 1] = Vector2(v.x, v.y)
  end
  local lastPos = chainPath[#chainPath]
  self._world:BattleStat():AddPieceRefreshCount(1)
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:RemoveEntityBlockFlag(teamEntity, lastPos)
  local pieceFillTable, useMaintainColorList = boardLogicSvc:SupplyPieceList(newPiecePosList)
  local lastGrid = pieceFillTable[#pieceFillTable]
  local posBlockChangeColor = boardLogicSvc:IsPosBlock(Vector2(lastGrid.x, lastGrid.y), BlockFlag.ChangeElement)
  if not posBlockChangeColor then
    self:_RecoverMaintainColorForLastChainPath(useMaintainColorList, lastGrid)
    local battleCmpt = self._world:BattleStat()
    if not battleCmpt:IsActiveSkillLinkLine() then
      lastGrid.color = PieceType.None
    else
      local teamPos = battleCmpt:GetLogicActiveSkillLinkLineTeamPos()
      local firstGrid = pieceFillTable[1]
      if teamPos.x == firstGrid.x and teamPos.y == firstGrid.y then
        firstGrid.color = PieceType.None
      end
    end
  end
  boardLogicSvc:SetEntityBlockFlag(teamEntity, lastPos)
  result.inplaceResult = pieceFillTable
  local triggerSvc = self._world:GetService("Trigger")
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local oldGridList = {}
  for index, pos in ipairs(pieceFillTable) do
    if 1 < index then
      local pieceType = boardCmpt:GetPieceType(pos)
      oldGridList[pos] = pieceType
    end
  end
  boardCmpt:FillPieces(pieceFillTable)
  local newGridList = {}
  for index, v in ipairs(pieceFillTable) do
    if index < #pieceFillTable then
      newGridList[index] = {
        pos = Vector2(v.x, v.y),
        pieceType = v.color
      }
    end
  end
  local ntRefreshGridOnPetMoveDone = NTRefreshGridOnPetMoveDone:New(oldGridList, newGridList, teamEntity)
  local tConvertInfo = {}
  for _, grid in ipairs(result.inplaceResult) do
    local convertInfo = NTGridConvert_ConvertInfo:New(Vector2(grid.x, grid.y), PieceType.None, grid.color)
    table.insert(tConvertInfo, convertInfo)
  end
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetLinkLine(true)
  triggerSvc:Notify(ntRefreshGridOnPetMoveDone)
  triggerSvc:Notify(ntGridConvert)
  result.ntRefreshGridOnPetMoveDone = ntRefreshGridOnPetMoveDone
  result.ntGridConvert = ntGridConvert
end

function PieceRefreshSystem:_RecoverMaintainColorForLastChainPath(useMaintainColorList, lastGrid)
  if useMaintainColorList then
    local boardLogicSvc = self._world:GetService("BoardLogic")
    for index, grid in ipairs(useMaintainColorList) do
      if grid.x == lastGrid.x and grid.y == lastGrid.y then
        local pos = Vector2(lastGrid.x, lastGrid.y)
        local maintainColor = lastGrid.color
        boardLogicSvc:SetMaintainColorForSupply(pos, maintainColor)
        break
      end
    end
  end
end

function PieceRefreshSystem:CalcPieceFallingDown(teamEntity, fallingDir, result)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local posList = {}
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  for _, v in ipairs(chainPath) do
    posList[#posList + 1] = Vector2(v.x, v.y)
  end
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:SyncGridTilesColor()
  local delset, newset, movset, rolegrid = boardLogicSvc:FallGrids(posList, fallingDir, teamEntity)
  result.delset = delset
  result.newset = newset
  result.movset = movset
  result.rolegrid = rolegrid
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  for _, v in ipairs(movset) do
    boardCmpt.Pieces[v.to.x][v.to.y] = v.color
  end
  for _, v in ipairs(newset) do
    boardCmpt.Pieces[v.pos.x][v.pos.y] = v.color
  end
  if rolegrid.color then
    boardCmpt.Pieces[rolegrid.pos.x][rolegrid.pos.y] = rolegrid.color
  end
  local oldGridList = {}
  for i, v in ipairs(delset) do
    if 1 < i then
      local pieceType = boardCmpt:GetPieceType(v.pos)
      oldGridList[v.pos] = v.color
    end
  end
  local newGridList = {}
  for i, v in ipairs(newset) do
    newGridList[i] = {
      pos = Vector2(v.x, v.y),
      pieceType = v.color
    }
  end
  local triggerSvc = self._world:GetService("Trigger")
  local ntRefreshGridOnPetMoveDone = NTRefreshGridOnPetMoveDone:New(oldGridList, newGridList, teamEntity)
  local ntGridConvert
  local tConvertInfo = {}
  for _, v in ipairs(newset) do
    local convertInfo = NTGridConvert_ConvertInfo:New(v.pos, PieceType.None, v.color)
    table.insert(tConvertInfo, convertInfo)
  end
  ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetLinkLine(true)
  triggerSvc:Notify(ntRefreshGridOnPetMoveDone)
  triggerSvc:Notify(ntGridConvert)
  result.ntRefreshGridOnPetMoveDone = ntRefreshGridOnPetMoveDone
  result.ntGridConvert = ntGridConvert
  local trapSvc = self._world:GetService("TrapLogic")
  
  local function filter(e)
    return e:HasTrapID() and e:Trap():FallWithGrid() and not e:HasDeadMark()
  end
  
  local function filter2(e)
    return e:HasMonsterID()
  end
  
  local moveTraps = {}
  local triggerTraps = {}
  local movePrisms = {}
  for _, v in ipairs(movset) do
    local isPieceEffect = boardCmpt:IsSpecialPieceEffect(v.from)
    local pieceEffectType = boardCmpt:GetBoardPieceEffectType(v.from)
    local prismEntityID = boardCmpt:GetPrismEntityIDAtPos(v.from)
    if isPieceEffect then
      boardCmpt:RemoveBoardPieceEffectType(v.from)
      boardCmpt:SetBoardPieceEffectType(v.to, pieceEffectType, prismEntityID)
      movePrisms[#movePrisms + 1] = {
        from = v.from,
        to = v.to,
        pieceEffectType = pieceEffectType
      }
    end
    local es = boardCmpt:GetPieceEntities(v.from, filter)
    local ms = boardCmpt:GetPieceEntities(v.to, filter2)
    for i, e in ipairs(es) do
      moveTraps[#moveTraps + 1] = {
        entity = e,
        from = v.from,
        to = v.to
      }
      e:SetGridPosition(v.to)
      boardLogicSvc:UpdateEntityBlockFlag(e, v.from, v.to)
      if 0 < #ms then
        local triggerEntity = ms[1]
        local tps, triggerResults = trapSvc:CalcTrapTriggerSkill(e, triggerEntity)
        if tps then
          for i, trap in ipairs(tps) do
            local skillResult = triggerResults[i]
            triggerTraps[#triggerTraps + 1] = {
              trap,
              skillResult,
              triggerEntity
            }
          end
        end
      end
    end
  end
  result.movePrisms = movePrisms
  result.moveTraps = moveTraps
  result.triggerTraps = triggerTraps
end

function PieceRefreshSystem:CalcPieceDestroy(teamEntity, trapID, result)
  local isUseInPlaceType = false
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  if #chainPath < 2 then
    isUseInPlaceType = true
  end
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:IsRoundAuroraTime() then
    isUseInPlaceType = true
    result.pieceRefreshType = PieceRefreshType.Inplace
  end
  if isUseInPlaceType then
    result.pieceRefreshType = PieceRefreshType.Inplace
    self:CalcPieceRefreshInplace(teamEntity, result)
    return
  end
  
  local function trapFilter(e)
    if e:HasTrapID() and not e:HasDeadMark() then
      return true
    end
    return false
  end
  
  local function monsterFilter(e)
    if e:HasMonsterID() and not e:HasDeadMark() then
      return true
    end
    local outsideRegion = e:OutsideRegion()
    if outsideRegion and outsideRegion:GetMonsterID() then
      return true
    end
    return false
  end
  
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local refreshPiecePosList = {}
  local destroyPosList = {}
  local destroyTrapList = {}
  for i = 1, #chainPath - 1 do
    local pos = Vector2(chainPath[i].x, chainPath[i].y)
    local trapList = boardCmpt:GetPieceEntities(pos, trapFilter)
    local monsterList = boardCmpt:GetPieceEntities(pos, monsterFilter)
    if 0 < #monsterList then
      refreshPiecePosList[#refreshPiecePosList + 1] = pos
    else
      if 0 < #trapList then
        table.appendArray(destroyTrapList, trapList)
      end
      destroyPosList[#destroyPosList + 1] = pos
    end
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local destroyTrapIDList = {}
  for _, trapEntity in ipairs(destroyTrapList) do
    trapEntity:Attributes():Modify("HP", 0)
    trapServiceLogic:AddTrapDeadMark(trapEntity, true)
    destroyTrapIDList[#destroyTrapIDList + 1] = trapEntity:GetID()
  end
  if 0 < #destroyTrapIDList then
    result.destroyTrapIDList = destroyTrapIDList
  end
  local newTrapIDList = {}
  for _, pos in ipairs(destroyPosList) do
    local trapEntity = trapServiceLogic:CreateTrap(trapID, pos, Vector2.up)
    if trapEntity then
      newTrapIDList[#newTrapIDList + 1] = trapEntity:GetID()
    end
  end
  if 0 < #newTrapIDList then
    result.newTrapIDList = newTrapIDList
  end
  local lastPos = chainPath[#chainPath]
  refreshPiecePosList[#refreshPiecePosList + 1] = lastPos
  self._world:BattleStat():AddPieceRefreshCount(1)
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:RemoveEntityBlockFlag(teamEntity, lastPos)
  local pieceFillTable, useMaintainColorList = boardLogicSvc:SupplyPieceList(refreshPiecePosList)
  local lastGrid = pieceFillTable[#pieceFillTable]
  local posBlockChangeColor = boardLogicSvc:IsPosBlock(Vector2(lastGrid.x, lastGrid.y), BlockFlag.ChangeElement)
  if not posBlockChangeColor then
    self:_RecoverMaintainColorForLastChainPath(useMaintainColorList, lastGrid)
    lastGrid.color = PieceType.None
  end
  boardLogicSvc:SetEntityBlockFlag(teamEntity, lastPos)
  result.inplaceResult = pieceFillTable
  local triggerSvc = self._world:GetService("Trigger")
  local oldGridList = {}
  for _, pos in ipairs(pieceFillTable) do
    local pieceType = boardCmpt:GetPieceType(pos)
    oldGridList[pos] = pieceType
  end
  boardCmpt:FillPieces(pieceFillTable)
  local newGridList = {}
  for index, v in ipairs(pieceFillTable) do
    if index < #pieceFillTable then
      newGridList[index] = {
        pos = Vector2(v.x, v.y),
        pieceType = v.color
      }
    end
  end
  local ntRefreshGridOnPetMoveDone = NTRefreshGridOnPetMoveDone:New(oldGridList, newGridList, teamEntity)
  local tConvertInfo = {}
  for _, grid in ipairs(result.inplaceResult) do
    local convertInfo = NTGridConvert_ConvertInfo:New(Vector2(grid.x, grid.y), PieceType.None, grid.color)
    table.insert(tConvertInfo, convertInfo)
  end
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetLinkLine(true)
  triggerSvc:Notify(ntRefreshGridOnPetMoveDone)
  triggerSvc:Notify(ntGridConvert)
  result.ntRefreshGridOnPetMoveDone = ntRefreshGridOnPetMoveDone
  result.ntGridConvert = ntGridConvert
end

function PieceRefreshSystem:_DoRenderFillPiece(TT, result)
end

function PieceRefreshSystem:_DoRenderShowStoryTips(TT)
end
