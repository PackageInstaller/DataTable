require("base_service")
_class("PopStarServiceLogic", BaseService)
PopStarServiceLogic = PopStarServiceLogic

function PopStarServiceLogic:Constructor(world)
  self._world = world
end

function PopStarServiceLogic:GetPopStarLogicComponent()
  local component = self._world:GetBoardEntity():PopStarLogic()
  return component
end

function PopStarServiceLogic:GetPopGridNum()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetPopGridNum()
end

function PopStarServiceLogic:AddPopGridNum(num)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:AddPopGridNum(num)
end

function PopStarServiceLogic:GetChallengeIndex()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetChallengeIndex()
end

function PopStarServiceLogic:SetChallengeIndex(index)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:SetChallengeIndex(index)
end

function PopStarServiceLogic:GetTrapRandomData()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetTrapRandomData()
end

function PopStarServiceLogic:SetTrapRandomData(totalWeight, trapRandomTab)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:SetTrapRandomData(totalWeight, trapRandomTab)
end

function PopStarServiceLogic:GetTrapRandomCount()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetTrapRandomCount()
end

function PopStarServiceLogic:AddTrapRandomCount(trapID)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:AddTrapRandomCount(trapID)
end

function PopStarServiceLogic:AddPropID(num, propID)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:AddPropID(num, propID)
end

function PopStarServiceLogic:GetPropIDByPopNum(num)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetPropIDByPopNum(num)
end

function PopStarServiceLogic:_GetChallengeScoreByIndex(index)
  local popStarCreateInfo = self._world.BW_WorldInfo.clientCreateInfo.popstar_mission_info[1]
  local missionID = popStarCreateInfo.mission_id
  local cfgList = Cfg.cfg_popstar_mission[missionID].ChallengeIndexScoreList
  if not cfgList or index > #cfgList then
    return 0
  end
  return cfgList[index]
end

function PopStarServiceLogic:_GetChallengeIndexByScore(score)
  local popStarCreateInfo = self._world.BW_WorldInfo.clientCreateInfo.popstar_mission_info[1]
  local missionID = popStarCreateInfo.mission_id
  local cfgList = Cfg.cfg_popstar_mission[missionID].ChallengeIndexScoreList
  for index, cfgScore in ipairs(cfgList) do
    if score < cfgScore then
      return index
    end
  end
  return #cfgList
end

function PopStarServiceLogic:GetPopStarStageInfo()
  local index = self:GetChallengeIndex()
  local challengeScore = self:_GetChallengeScoreByIndex(index)
  local preScore = 0
  if 1 < index then
    preScore = self:_GetChallengeScoreByIndex(index - 1)
  end
  return index, challengeScore, preScore
end

function PopStarServiceLogic:_CalculateChallengeState()
  local popStarCreateInfo = self._world.BW_WorldInfo.clientCreateInfo.popstar_mission_info[1]
  if not popStarCreateInfo.is_challenge then
    return false
  end
  local index, score = self:GetPopStarStageInfo()
  local curScore = self:GetPopGridNum()
  if score <= curScore then
    local nextIndex = self:_GetChallengeIndexByScore(curScore)
    if index < nextIndex then
      self:SetChallengeIndex(nextIndex)
      return true
    end
  end
  return false
end

function PopStarServiceLogic:CalculatePopStarConnectPieces(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(gridPos)
  local pieces = utilDataSvc:GetReplicaBoardPieces()
  local connMap = {}
  for x, _ in pairs(pieces) do
    connMap[x] = {}
  end
  local connectPieces = {}
  table.insert(connectPieces, gridPos)
  connMap[gridPos.x][gridPos.y] = true
  
  local function searchConnectPiece(center, next)
    for _, offset in ipairs(Offset4) do
      local pos = Vector2(center.x + offset[1], center.y + offset[2])
      if utilDataSvc:IsValidPiecePos(pos) then
        local connectPieceType = utilDataSvc:GetPieceType(pos)
        local pieceMatch = PopStarCanMatchPieceType(pieceType, connectPieceType)
        if not connMap[pos.x][pos.y] and pieceMatch then
          table.insert(connectPieces, pos)
          connMap[pos.x][pos.y] = true
          next(pos, next)
        end
      end
    end
  end
  
  searchConnectPiece(gridPos, searchConnectPiece)
  return connectPieces
end

function PopStarServiceLogic:GetPopConnectPieces()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetPopConnectPieces()
end

function PopStarServiceLogic:SetPopConnectPieces(connectPieces)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:SetPopConnectPieces(connectPieces)
end

function PopStarServiceLogic:CalculatePopPieces(connectPieces)
  local utilDataSvc = self._world:GetService("UtilData")
  local result = DataPopStarResult:New()
  result:SetPopConnectPieces(connectPieces)
  local affixSvc = self._world:GetService("Affix")
  local refreshType, fallingDir = affixSvc:ReplacePieceRefreshType()
  fallingDir = refreshType == PieceRefreshType.FallingDown and fallingDir or Vector2(0, -1)
  local superGridNum = 0
  for _, pos in ipairs(connectPieces) do
    local trapIDList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Super, pos)
    if trapIDList and 0 < #trapIDList then
      superGridNum = superGridNum + 1
    end
  end
  local popNum = #connectPieces + superGridNum
  local oldScore = self:GetPopGridNum()
  self:AddPopGridNum(popNum)
  result:SetPopNum(popNum)
  local newScore = self:GetPopGridNum()
  local isIndexChange = self:_CalculateChallengeState()
  if isIndexChange then
    result:SetIndexChange()
  end
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTPopStarScoreChange:New())
  local destroyTrapList, posList = self:_CalculateDestroyTrapAndPiece(connectPieces)
  result:SetDelTrapList(destroyTrapList)
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:SyncGridTilesColor()
  local delSet, newSet, moveSet = boardLogicSvc:PopStarGridByFallDir(posList, fallingDir)
  result:SetDelSet(delSet)
  result:SetMoveSet(moveSet)
  result:SetNewSet(newSet)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  for _, v in ipairs(newSet) do
    boardLogicSvc:SetPieceTypeLogic(v.color, Vector2(v.pos.x, v.pos.y))
  end
  for _, v in ipairs(moveSet) do
    boardLogicSvc:SetPieceTypeLogic(v.color, Vector2(v.to.x, v.to.y))
  end
  
  local function filter(e)
    return e:HasTrapID() and e:Trap():FallWithGrid() and not e:HasDeadMark()
  end
  
  local moveTraps = {}
  for _, v in ipairs(moveSet) do
    local es = boardCmpt:GetPieceEntities(v.from, filter)
    for i, e in ipairs(es) do
      moveTraps[#moveTraps + 1] = {
        entity = e,
        from = v.from,
        to = v.to
      }
      e:SetGridPosition(v.to)
      boardLogicSvc:UpdateEntityBlockFlag(e, v.from, v.to)
    end
  end
  result:SetMoveTrapList(moveTraps)
  local newTraps = self:_CalculateNewTraps(newSet, oldScore, newScore)
  result:SetNewTrapList(newTraps)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTPopStarEnd:New(popNum))
  return result
end

function PopStarServiceLogic:Calculate3StarProgress()
  local configService = self._world:GetService("Config")
  local battleStatCmpt = self._world:BattleStat()
  local threeStarConditions = configService:GetPopStar3StarCondition(self._world.BW_WorldInfo.missionID)
  local star3CalcService = self._world:GetService("Star3Calc")
  for _, conditionId in ipairs(threeStarConditions) do
    local ret = star3CalcService:CalcProgress(conditionId)
    battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
  end
end

function PopStarServiceLogic:DoParseTrapRefreshData(trapRefreshID)
  if not trapRefreshID then
    return
  end
  local cfgRefresh = Cfg.cfg_popstar_trap_refresh[trapRefreshID]
  if not cfgRefresh then
    Log.exception("ParseTrapRefreshData error!!! trap refresh ID = ", trapRefreshID)
    return
  end
  local totalWeight = cfgRefresh.TotalWeight
  local trapIDList = table.cloneconf(cfgRefresh.TrapIDList)
  local weightList = table.cloneconf(cfgRefresh.WeightList)
  local countLimitList = table.cloneconf(cfgRefresh.CountLimitList)
  if #trapIDList ~= #weightList or #trapIDList ~= #countLimitList then
    Log.exception("ParseTrapRefreshData list size is not match!!! trap refresh ID = ", trapRefreshID)
    return
  end
  local trapRandomTab = {}
  for index, trapID in ipairs(trapIDList) do
    local trapRandomData = {
      trapID = trapID,
      weight = weightList[index],
      countLimit = countLimitList[index]
    }
    trapRandomTab[#trapRandomTab + 1] = trapRandomData
  end
  self:SetTrapRandomData(totalWeight, trapRandomTab)
end

function PopStarServiceLogic:DoParsePropRefreshData(refreshIDList)
  if not refreshIDList then
    return
  end
  local popNumList = {}
  for _, ID in ipairs(refreshIDList) do
    local cfgProp = Cfg.cfg_popstar_prop_refresh[ID]
    if not cfgProp then
      Log.exception("ParsePropRefreshData error!!! prop refresh ID = ", ID)
    else
      self:_DoParsePropRandomData(cfgProp, popNumList)
    end
  end
end

function PopStarServiceLogic:_DoParsePropRandomData(cfgProp, popNumList)
  local randomSvc = self._world:GetService("RandomLogic")
  for _, randomInterval in ipairs(cfgProp.PopNumRandomInterval) do
    if #randomInterval ~= 2 then
      Log.exception("ParsePropRefreshData PopNumRandomInterval size error!!! prop refresh ID = ", cfgProp.ID)
    else
      local min = randomInterval[1]
      local max = randomInterval[2]
      local curNum = min
      local randomList = {}
      while max >= curNum do
        if not table.icontains(popNumList, curNum) then
          randomList[#randomList + 1] = curNum
        end
        curNum = curNum + 1
      end
      if 0 < #randomList then
        local index = randomSvc:LogicRand(1, #randomList)
        local popNum = randomList[index]
        table.insert(popNumList, popNum)
        self:AddPropID(popNum, cfgProp.TrapID)
      end
    end
  end
end

function PopStarServiceLogic:_CalculateNewTraps(newSet, oldScore, newScore)
  local newTraps = {}
  if not newSet or #newSet == 0 then
    return newTraps
  end
  self:_CalculateNewPropTrap(newTraps, newSet, oldScore, newScore)
  self:_CalculateNewSpecialTrap(newTraps, newSet)
  return newTraps
end

function PopStarServiceLogic:_CalculateNewPropTrap(newTraps, newSet, oldScore, newScore)
  local curNum = oldScore + 1
  local newPropIDList = {}
  while newScore >= curNum do
    local propID = self:GetPropIDByPopNum(curNum)
    if propID then
      newPropIDList[#newPropIDList + 1] = propID
    end
    curNum = curNum + 1
  end
  if #newPropIDList == 0 then
    return newTraps
  end
  local newSetCopy = table.cloneconf(newSet)
  local randomSvc = self._world:GetService("RandomLogic")
  local trapSvc = self._world:GetService("TrapLogic")
  local boardLogicSvc = self._world:GetService("BoardLogic")
  for _, ID in ipairs(newPropIDList) do
    if #newSetCopy == 0 then
      break
    end
    local index = randomSvc:LogicRand(1, #newSetCopy)
    local posData = newSetCopy[index]
    local trapEntity = trapSvc:CreateTrap(ID, posData.pos, Vector2(0, 1))
    if trapEntity then
      newTraps[#newTraps + 1] = {
        entity = trapEntity,
        from = posData.from,
        pos = posData.pos
      }
      trapEntity:SetGridPosition(posData.pos)
      boardLogicSvc:UpdateEntityBlockFlag(trapEntity, posData.from, posData.pos)
    end
    table.remove(newSetCopy, index)
  end
  return newTraps
end

function PopStarServiceLogic:_CalculateNewSpecialTrap(newTraps, newSet)
  local newSetCopy = table.cloneconf(newSet)
  local trapSvc = self._world:GetService("TrapLogic")
  local boardLogicSvc = self._world:GetService("BoardLogic")
  for _, posData in ipairs(newSetCopy) do
    local trapID = self:_RandomSpecialTrapID()
    if trapID then
      local trapEntity = trapSvc:CreateTrap(trapID, posData.pos, Vector2(0, 1))
      if trapEntity then
        newTraps[#newTraps + 1] = {
          entity = trapEntity,
          from = posData.from,
          pos = posData.pos
        }
        trapEntity:SetGridPosition(posData.pos)
        boardLogicSvc:UpdateEntityBlockFlag(trapEntity, posData.from, posData.pos)
        self:AddTrapRandomCount(trapID)
      end
    end
  end
  return newTraps
end

function PopStarServiceLogic:_RandomSpecialTrapID()
  local totalWeight, randomDataTab = self:GetTrapRandomData()
  if not totalWeight or totalWeight == 0 then
    return
  end
  local trapID
  local randomSvc = self._world:GetService("RandomLogic")
  local randomIndex = randomSvc:LogicRand(1, totalWeight)
  for _, data in ipairs(randomDataTab) do
    randomIndex = randomIndex - data.weight
    if randomIndex <= 0 then
      if self:GetTrapRandomCount() < data.countLimit then
        trapID = data.trapID
      end
      break
    end
  end
  return trapID
end

function PopStarServiceLogic:_CalculateDestroyTrapAndPiece(connectPieces)
  local utilDataSvc = self._world:GetService("UtilData")
  local destroyTrapList = {}
  local posList = {}
  for _, pos in ipairs(connectPieces) do
    local addPiece = true
    local propTrapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Prop, pos)
    if 0 < #propTrapList then
      table.appendArray(destroyTrapList, propTrapList)
    end
    local runeTrapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Rune, pos)
    if 0 < #runeTrapList then
      table.appendArray(destroyTrapList, runeTrapList)
    end
    local superTrapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Super, pos)
    if 0 < #superTrapList then
      table.appendArray(destroyTrapList, superTrapList)
    end
    local lockTrapList = utilDataSvc:FindTrapByTypeAndPos(TrapType.PopStar_Lock, pos)
    if 0 < #lockTrapList then
      table.appendArray(destroyTrapList, lockTrapList)
      addPiece = false
    end
    local maintainColorTrapList = utilDataSvc:FindMaintainColorTrapByPos(pos)
    if 0 < #maintainColorTrapList then
      table.appendArray(destroyTrapList, maintainColorTrapList)
      addPiece = false
    end
    if addPiece then
      posList[#posList + 1] = Vector2(pos.x, pos.y)
    end
  end
  if 0 < #destroyTrapList then
    local trapServiceLogic = self._world:GetService("TrapLogic")
    for _, trapEntity in ipairs(destroyTrapList) do
      if trapEntity then
        trapEntity:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(trapEntity)
      end
    end
  end
  return destroyTrapList, posList
end
