require("command_base_handler")
_class("MovePathDownCommandHandler", CommandBaseHandler)
MovePathDownCommandHandler = MovePathDownCommandHandler

function MovePathDownCommandHandler:DoHandleCommand(cmd)
  local chainPath = cmd:GetChainPath()
  local elementType = cmd:GetElementType()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local triggerSvc = self._world:GetService("Trigger")
  local ntPlayerMoveStart = NTPlayerMoveStart:New()
  ntPlayerMoveStart:SetChainCount(#chainPath)
  ntPlayerMoveStart:SetChainPathType(elementType)
  ntPlayerMoveStart:SetTeamEntity(teamEntity)
  triggerSvc:Notify(ntPlayerMoveStart)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  sMonsterShowLogic:DoAllMonsterDeadLogic()
  self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideWeakLine, {
    [1] = elementType,
    [2] = #chainPath
  })
  self:_DoLinkLineLogic(cmd)
  local st = {}
  for i, v in ipairs(chainPath) do
    st[#st + 1] = Vector2.Pos2Index(v)
  end
  local s = table.concat(st, " ")
  Log.debug("[chainPath] ", s)
  local utilDataSvc = self._world:GetService("UtilData")
  local casterPstID = cmd:GetCasterPstID()
  local activeSkillID = cmd:GetActiveSkillID()
  local casterEntityID
  local isActiveSkillLinkLine = false
  Log.info("MovePathCmd casterPstID:", casterPstID, " activeSkillID:", activeSkillID)
  if casterPstID ~= 0 and activeSkillID ~= 0 then
    isActiveSkillLinkLine = true
    casterEntityID = utilDataSvc:GetEntityIDByPstID(casterPstID)
  end
  Log.info("IsActiveSkillLinkLine", isActiveSkillLinkLine)
  local valid = true
  if BattleConst.Kick then
    if isActiveSkillLinkLine then
      valid = self:_CheckActiveSkillLinkLineMovePathValid(chainPath, casterEntityID, activeSkillID, casterPstID)
    else
      valid = self:_CheckMovePathValid(teamEntity, elementType, chainPath)
    end
    if not valid then
      Log.fatal("move path command invalid")
      return
    end
  end
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetActiveSkillLinkLineState(isActiveSkillLinkLine, casterEntityID, activeSkillID)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  lsvcFeature:OnMovePathDone(chainPath)
  battleStatCmpt:AddTotalChainNum()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:SetLogicChainPath(chainPath, elementType)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  logicChainPathCmpt:SetChainRateAtIndex(1, 0)
  for i = 2, #chainPath do
    local finalChainRate, superGridNum = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, i)
    logicChainPathCmpt:SetChainRateAtIndex(i, finalChainRate)
  end
  local allMonsterPos = utilDataSvc:GetAllMonsterPos()
  logicChainPathCmpt:SetChainMonsterPosList(allMonsterPos)
  local oldPos = teamEntity:GetGridPosition()
  if isActiveSkillLinkLine then
    utilDataSvc:SaveActiveSkillLinkLinePosAndDir(teamEntity)
  end
  local skillLogicService = self._world:GetService("SkillLogic")
  skillLogicService:UpdateTeamGridLocationByChainPath(teamEntity, chainPath)
  if not isActiveSkillLinkLine then
    local syncMoveSvcLogic = self._world:GetService("SyncMoveLogic")
    if syncMoveSvcLogic then
      syncMoveSvcLogic:OnMovePathDone(chainPath)
    end
  end
  local ntSelectRoundTeamNormalBefore = NTSelectRoundTeamNormalBefore:New(elementType, chainPath)
  triggerSvc:Notify(ntSelectRoundTeamNormalBefore)
  local l2RSvc = self._world:GetService("L2R")
  l2RSvc:L2RNTSelectRoundTeamNormalBefore(elementType, chainPath)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  self:_CalcNormal(teamEntity, elementType)
  self:_DoRevertCutPathPrism(cmd)
  local svc = self._world:GetService("L2R")
  svc:L2RChainPathData(teamEntity)
  local combo = self._world:GetService("Battle"):GetLogicComboNum()
  self._world:GetDataLogger():AddDataLog("OnChainPath", table.count(chainPath) - 1, combo)
  self._world:GetDataLogger():AddDataLog("OnLinkEnd")
  self._world:GetDataLogger():AddDataLog("OnShowStart")
  local logicChainPath = logicChainPathCmpt:GetLogicChainPath()
  local newPos = logicChainPath[#logicChainPath]
  boardServiceLogic:UpdateEntityBlockFlag(teamEntity, oldPos, newPos)
  if 2 <= #logicChainPath then
    battleStatCmpt:AddChainIndex()
    battleStatCmpt:SetOneMatchMaxNum(teamEntity, elementType, #logicChainPath - 1)
  end
  self:_UpdateDeadMark()
  if not isActiveSkillLinkLine then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 1)
  elseif self._world:RunAtClient() then
    local inputCmpt = self._world:Input()
    inputCmpt:SetPreviewActiveSkill(false)
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 5)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 1)
  end
end

function MovePathDownCommandHandler:_UpdateDeadMark()
  local deadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  local data = DataDeadMarkResult:New()
  for _, e in ipairs(deadGroup:GetEntities()) do
    data:AddDeadEntityID(e:GetID())
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function MovePathDownCommandHandler:_CalcNormal(teamEntity, elementType)
  local skillLogicService = self._world:GetService("SkillLogic")
  skillLogicService:SelectTeam(teamEntity, elementType)
  skillLogicService:SelectNormalAttackTarget(teamEntity)
  skillLogicService:CalcNormalSkillDamage(teamEntity)
end

function MovePathDownCommandHandler:_CheckMovePathElement(cmdElementType, chainPath)
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  end
  local moveStartPos = chainPath[1]
  local utilDataSvc = self._world:GetService("UtilData")
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local pathPointIndex = 2
  local pathPointCount = #chainPath
  local lastPathPointPos = moveStartPos
  while pathPointIndex <= pathPointCount do
    local pathPointPos = chainPath[pathPointIndex]
    if pathPointIndex == pathPointCount and boardCmpt:IsPosExit(pathPointPos) then
      break
    end
    local gridPieceType = boardCmpt:GetPieceType(pathPointPos)
    if pathPointIndex == 2 then
      local mapForFirstChainPath = utilDataSvc:GetMapForFirstChainPath()
      if mapForFirstChainPath then
        gridPieceType = mapForFirstChainPath
      end
    end
    local gridPieceTypeMapList = boardCmpt:GetPieceTypeMapList(pathPointPos)
    local isMatch = self:_CheckPieceTypeMatch(gridPieceType, cmdElementType, pathPointIndex, chainPath, gridPieceTypeMapList)
    if not isMatch then
      local errorMsg = "MovePathValid failed,grid element no match pos: x = " .. pathPointPos.x .. " y = " .. pathPointPos.y .. " client element = " .. cmdElementType .. " server element = " .. gridPieceType
      self:_HandleServerSyncFailed(BattleFailedType.PositionElementNoMatch, errorMsg)
      return false
    end
    if cmdElementType == PieceType.Any and not table.intable(gridPieceTypeMapList, cmdElementType) and gridPieceType ~= PieceType.Any then
      local errorMsg = "MovePathValid failed,Chain element no match pos: x = " .. pathPointPos.x .. " y = " .. pathPointPos.y .. " Chain element = " .. cmdElementType .. " server element = " .. gridPieceType
      self:_HandleServerSyncFailed(BattleFailedType.PositionElementNoMatch, errorMsg)
      return false
    end
    pathPointIndex = pathPointIndex + 1
  end
  return true
end

function MovePathDownCommandHandler:_CheckMovePathConnect(cmdElementType, chainPath)
  local utilDataService = self._world:GetService("UtilData")
  if 3 < #chainPath then
    for i = 2, #chainPath - 1 do
      local pos1 = chainPath[i]
      local pos2 = chainPath[i + 1]
      local needCheck = self:_IsNeedCheckConnect(i, pos2, chainPath)
      if needCheck then
        local ret, msg = utilDataService:Is2PosCanConnect(pos1, pos2, cmdElementType, i, false)
        if not ret then
          local errorMsg = self:_MakeConnectFailedMsg(cmdElementType, pos1, pos2, msg)
          self:_HandleServerSyncFailed(BattleFailedType.ChainPathConnectInvalid, errorMsg)
          return false
        end
      end
    end
  end
  return true
end

function MovePathDownCommandHandler:_MakeConnectFailedMsg(cmdElementType, pos1, pos2, msg)
  local errorMsg = "MovePathValid failed,connect Invalid   client element = " .. cmdElementType .. "pos1:" .. tostring(pos1) .. " pos2 = " .. tostring(pos2) .. msg
  return errorMsg
end

function MovePathDownCommandHandler:_IsNeedCheckConnect(curIndex, nextPos, chainPath)
  local nextIndex = curIndex + 1
  local isTwoColorChain, firstElementType, firstElementIndex = self:_CalcTwoColorChainData(chainPath)
  if isTwoColorChain and (firstElementIndex == curIndex or firstElementIndex == nextIndex) then
    return false
  end
  if nextIndex ~= #chainPath then
    return true
  end
  local utilDataService = self._world:GetService("UtilData")
  local isPosExit = utilDataService:IsPosExit(nextPos)
  if isPosExit then
    return false
  end
  local isDimensionDoor = utilDataService:IsPosDimensionDoor(nextPos)
  if isDimensionDoor then
    return false
  end
  return true
end

function MovePathDownCommandHandler:_CheckMovePathValid(teamEntity, cmdElementType, chainPath)
  local playerPos = teamEntity:GridLocation().Position
  if chainPath == nil or #chainPath < 1 then
    local errorMsg = "CheckMovePathValid failed,chain path has no point"
    self:_HandleServerSyncFailed(BattleFailedType.MovePathNoPoint, errorMsg)
    return false
  end
  local moveStartPos = chainPath[1]
  if moveStartPos.x ~= playerPos.x or moveStartPos.y ~= playerPos.y then
    local errorMsg = "chain path start pos invalid,client pos: x = " .. moveStartPos.x .. " y = " .. moveStartPos.y .. " server: pos: x = " .. playerPos.x .. " y = " .. playerPos.y
    self:_HandleServerSyncFailed(BattleFailedType.StartPathPosInvalid, errorMsg)
    return false
  end
  local connectCheckRes = self:_CheckMovePathConnect(cmdElementType, chainPath)
  if not connectCheckRes then
    return false
  end
  local elementCheckRes = self:_CheckMovePathElement(cmdElementType, chainPath)
  if not elementCheckRes then
    return false
  end
  return true
end

function MovePathDownCommandHandler:_DoLinkLineLogic(cmd)
  local chainPath = cmd:GetChainPath()
  local board = self._world:GetBoardEntity():Board()
  local boardService = self._world:GetService("BoardLogic")
  local len = #chainPath
  if 1 < len then
    for i = 2, len do
      local curPos = chainPath[i]
      if board:IsPrismPiece(curPos) then
        local prePos = chainPath[i - 1]
        boardService:ApplyPrism(prePos, curPos)
      end
    end
  end
end

function MovePathDownCommandHandler:_DoRevertCutPathPrism()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local board = self._world:GetBoardEntity():Board()
  local boardService = self._world:GetService("BoardLogic")
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local logicCutPath = logicChainPathCmpt:GetCutChainPath()
  if logicCutPath then
    local indexArray = {}
    for index, pos in pairs(logicCutPath) do
      table.insert(indexArray, index)
    end
    table.sort(indexArray, function(a, b)
      return b < a
    end)
    for _, tarIndex in ipairs(indexArray) do
      local pos = logicCutPath[tarIndex]
      if board:IsPrismPiece(pos) then
        boardService:UnapplyPrism(pos)
      end
    end
  end
  boardService:ResetPrismChangeRecord()
end

function MovePathDownCommandHandler:_CheckPieceTypeMatch(gridPieceType, cmdElementType, pathPointIndex, chainPath, gridPieceTypeMapList)
  local isMatch = CanMatchPieceType(gridPieceType, cmdElementType)
  if not isMatch then
    local isTwoColorChain, firstElementType, firstElementIndex = self:_CalcTwoColorChainData(chainPath)
    if firstElementIndex == pathPointIndex and firstElementType == gridPieceType then
      isMatch = true
    end
    if table.intable(gridPieceTypeMapList, PieceType.Any) or table.intable(gridPieceTypeMapList, cmdElementType) then
      isMatch = true
    end
    local utilDataSvc = self._world:GetService("UtilData")
    local isFirstStepUseMapPiece = false
    if pathPointIndex == 2 then
      local mapForFirstChainPath = utilDataSvc:GetMapForFirstChainPath()
      if mapForFirstChainPath then
        isMatch = CanMatchPieceType(mapForFirstChainPath, cmdElementType)
        isFirstStepUseMapPiece = true
      end
    end
    if not isFirstStepUseMapPiece and utilDataSvc:IsPosCanMapOtherPiece(chainPath[pathPointIndex], cmdElementType, gridPieceType) then
      isMatch = true
    end
  end
  return isMatch
end

function MovePathDownCommandHandler:_CalcTwoColorChainData(chainPath)
  local utilDataSvc = self._world:GetService("UtilData")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  local isTwoColorChain = buffCmpt:GetBuffValue("TwoColorChain")
  local firstElementType = PieceType.None
  local firstElementIndex = -1
  if isTwoColorChain then
    local boardEntity = self._world:GetBoardEntity()
    local boardCmpt = boardEntity:Board()
    for index = 2, #chainPath do
      local curPos = chainPath[index]
      local curPieceType = boardCmpt:GetPieceType(curPos)
      if index == 2 then
        local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
        if firstLinkMapPiece then
          curPieceType = firstLinkMapPiece
        end
      end
      if curPieceType ~= PieceType.Any then
        firstElementType = curPieceType
        firstElementIndex = index
        break
      end
    end
  end
  return isTwoColorChain, firstElementType, firstElementIndex
end

function MovePathDownCommandHandler:_CheckActiveSkillLinkLineMovePathValid(chainPath, casterEntityID, activeSkillID, casterPstID)
  local playerPos = self:GetActiveSkillLinkLineBeginPos(casterEntityID, activeSkillID)
  if chainPath == nil or #chainPath < 1 then
    local errorMsg = "CheckMovePathValid failed,chain path has no point"
    self:_HandleServerSyncFailed(BattleFailedType.MovePathNoPoint, errorMsg)
    return false
  end
  local moveStartPos = chainPath[1]
  if moveStartPos.x ~= playerPos.x or moveStartPos.y ~= playerPos.y then
    local errorMsg = "chain path start pos invalid,client pos: x = " .. moveStartPos.x .. " y = " .. moveStartPos.y .. " server: pos: x = " .. playerPos.x .. " y = " .. playerPos.y
    self:_HandleServerSyncFailed(BattleFailedType.StartPathPosInvalid, errorMsg)
    return false
  end
  local utilDataService = self._world:GetService("UtilData")
  if 3 < #chainPath then
    for i = 2, #chainPath - 1 do
      local pos1 = chainPath[i]
      local pos2 = chainPath[i + 1]
      local ret, msg = utilDataService:Is2PosCanConnectNoPieceTypeCheck(pos1, pos2)
      if not ret then
        local errorMsg = self:_MakeConnectFailedMsg(PieceType.AnyNone, pos1, pos2, msg)
        self:_HandleServerSyncFailed(BattleFailedType.ChainPathConnectInvalid, errorMsg)
        return false
      end
    end
  end
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local legendPower = utilDataService:GetPetLegendPowerAttr(casterEntity)
  Log.info("CasterBegin Power:", legendPower)
  if utilDataService:GetPet1702361LinkLineStep(casterEntity, activeSkillID) < #chainPath - 1 then
    legendPower = utilDataService:GetPetLegendPowerAttr(casterEntity)
    local errorMsg = "PetPower :" .. tostring(legendPower) .. " ChainPathCount:" .. tostring(#chainPath)
    Log.info("CasterInvalid Power:", legendPower, " ChainPathCount:", #chainPath)
    self:_HandleServerSyncFailed(BattleFailedType.Pet1702361NoEnoughPower, errorMsg)
  else
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    self:_ClearActivePower(teamEntity, casterPstID, activeSkillID, chainPath)
    legendPower = utilDataService:GetPetLegendPowerAttr(casterEntity)
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(activeSkillID, casterEntity)
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    local blsvc = self._world:GetService("BuffLogic")
    local bReady
    if legendPower >= costLegendPower then
      bReady = 1
    else
      bReady = 0
    end
    blsvc:ChangePetActiveSkillReady(casterEntity, bReady, activeSkillID)
    Log.info("CasterEnd Power:", legendPower)
    if self._world:RunAtClient() then
      self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, casterPstID, legendPower)
      if bReady == 0 then
        self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, casterPstID)
      end
    end
  end
  return true
end

function MovePathDownCommandHandler:GetActiveSkillLinkLineBeginPos(casterEntityID, activeSkillID)
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:GetPet1702361LinkLineBeginPos(casterEntityID, activeSkillID)
end
