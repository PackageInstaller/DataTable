_class("CreateMonsterPosService", Object)
CreateMonsterPosService = CreateMonsterPosService

function CreateMonsterPosService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._monsterRefreshFunc = {}
  self._monsterRefreshFunc[MonsterRefreshPosType.Position] = self._PositionRefresh
  self._monsterRefreshFunc[MonsterRefreshPosType.Random] = self._RandomRefresh
  self._monsterRefreshFunc[MonsterRefreshPosType.PositionTable] = self._PositionRandomRefresh
  self._monsterRefreshFunc[MonsterRefreshPosType.PositionHitBack] = self._PositionHitBackRefresh
  self._monsterRefreshFunc[MonsterRefreshPosType.PositionAndOffSet] = self._PositionAndOffSet
  self._monsterRefreshFunc[MonsterRefreshPosType.SelectFirstCanUse] = self._SelectFirstCanUsePos
  self._monsterRefreshFunc[MonsterRefreshPosType.PlayerCentered] = self._PlayerCentered
  self._monsterRefreshFunc[MonsterRefreshPosType.MonsterCentered] = self._MonsterCentered
  self._monsterRefreshFunc[MonsterRefreshPosType.PositionAndOffSetMultiBoard] = self._PositionAndOffSetMultiBoard
  self._monsterRefreshFunc[MonsterRefreshPosType.PositionOnExtraBoard] = self._PositionOnExtraBoard
  self._monsterRefreshExceptionFunc = {}
  self._monsterRefreshExceptionFunc[MonsterRefreshExceptionType.Random] = self._ExceptionRandom
  self._monsterRefreshExceptionFunc[MonsterRefreshExceptionType.ValidRing] = self._ExceptionValidRing
  self._monsterRefreshExceptionFunc[MonsterRefreshExceptionType.BackupTable] = self._ExceptionBackupTable
  self._monsterRefreshExceptionFunc[MonsterRefreshExceptionType.ValidRingNoRandom] = self._ExceptionValidRingNoRandom
end

function CreateMonsterPosService:GetMonsterRefreshPos(refreshPosType, monsterRefreshParam)
  local pFunc = self._monsterRefreshFunc[refreshPosType]
  if not pFunc then
    return {}
  end
  return pFunc(self, monsterRefreshParam)
end

function CreateMonsterPosService:_PositionRefresh(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosArray = monsterRefreshParam:GetMonsterPosArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local bodyAreaPosition = {}
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    if i > #monsterPosArray then
      break
    end
    local monsterPosition = monsterPosArray[i]
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, p in ipairs(areaArray) do
      table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
    end
    if self:CheckPositionCanPlaceMonster(bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
      for k, areaPos in ipairs(bodyAreaPosition) do
        table.insert(createMonsterAreaList, areaPos)
      end
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    else
      Log.fatal("[[CreateMonsterPos] MonsterID:", monsterID, "Pos Invalid")
    end
  end
  return monsterArray
end

function CreateMonsterPosService:_RandomRefresh(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterBodyPosArray = {}
  local trapArray = monsterRefreshParam:GetTrapArray()
  for k, v in ipairs(trapArray) do
    local posList = v:GetPositionList()
    for i = 1, #posList do
      table.insert(monsterBodyPosArray, posList[i])
    end
  end
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    local monsterPosition = boardServiceLogic:GetRandomPiecePos(areaArray, monsterBodyPosArray, monsterRaceType)
    if monsterPosition then
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      for k, p in ipairs(areaArray) do
        table.insert(monsterBodyPosArray, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
      end
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    else
      Log.fatal("No Valid PiecePos in board ID", monsterID)
    end
  end
  return monsterArray
end

function CreateMonsterPosService:_MonsterPosAndOffsetArray2MonsterPos(monsterPosAndOffSetArray)
  local playPos = self:_GetPlayerPos()
  local ret = {}
  for i, v in ipairs(monsterPosAndOffSetArray) do
    local monsterPosition
    local monsterPosType = v[1]
    if monsterPosType == MonsterPosType.Position then
      monsterPosition = v[2]
    elseif monsterPosType == MonsterPosType.OffSet then
      monsterPosition = playPos + v[2]
    end
    table.insert(ret, monsterPosition)
  end
  return ret
end

function CreateMonsterPosService:_PositionRandomRefresh(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterBodyPosArray = {}
  local trapArray = monsterRefreshParam:GetTrapArray()
  for k, v in ipairs(trapArray) do
    local posList = v:GetPositionList()
    for i = 1, #posList do
      table.insert(monsterBodyPosArray, posList[i])
    end
  end
  local monsterPosAndOffSetArray = monsterRefreshParam:GetMonsterPosAndOffSetArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local monsterPosArray = self:_MonsterPosAndOffsetArray2MonsterPos(monsterPosAndOffSetArray)
  for i, monsterID in ipairs(monsterIDArray) do
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    local monsterPosition = boardServiceLogic:CreateMonsterGetValidPos(monsterPosArray, areaArray, monsterBodyPosArray, monsterRaceType)
    if monsterPosition then
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      for k, p in ipairs(areaArray) do
        table.insert(monsterBodyPosArray, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
      end
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    elseif monsterRefreshParam:GetExceptionType() ~= MonsterRefreshExceptionType.None then
      monsterPosition = self:_DoException(monsterRefreshParam:GetExceptionType(), areaArray, monsterBodyPosArray, monsterRaceType)
      if monsterPosition then
        monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
        for k, p in ipairs(areaArray) do
          table.insert(monsterBodyPosArray, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
        end
        self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] UseDoException Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
      else
        Log.fatal("No Valid PiecePos in board After DoException")
      end
    else
      Log.fatal("No Valid PiecePos in board No DoException")
    end
  end
  return monsterArray
end

function CreateMonsterPosService:_DoException(exceptionType, areaArray, monsterBodyPosArray, monsterRaceType, index, invalidPos, exceptionData)
  exceptionType = exceptionType or MonsterRefreshExceptionType.Random
  return self._monsterRefreshExceptionFunc[exceptionType](self, areaArray, monsterBodyPosArray, monsterRaceType, index, invalidPos, exceptionData)
end

function CreateMonsterPosService:_ExceptionRandom(areaArray, monsterBodyPosArray, monsterRaceType)
  local boardService = self._world:GetService("BoardLogic")
  return boardService:GetRandomPiecePos(areaArray, monsterBodyPosArray, monsterRaceType)
end

function CreateMonsterPosService:_ExceptionValidRing(areaArray, monsterBodyPosArray, monsterRaceType, index, invalidPos)
  local boardService = self._world:GetService("BoardLogic")
  for i = 1, 10 do
    local ringList = ComputeScopeRange.ComputeRange_SquareRing(invalidPos, #areaArray, i)
    local retPos = boardService:_GetValidPos(ringList, areaArray, monsterBodyPosArray, monsterRaceType)
    if retPos then
      return retPos
    end
  end
end

function CreateMonsterPosService:_ExceptionBackupTable(areaArray, monsterBodyPosArray, monsterRaceType, index, invalidPos, exceptionData)
  local boardService = self._world:GetService("BoardLogic")
  local posArray = exceptionData[index]
  local monsterPosArray = self:_MonsterPosAndOffsetArray2MonsterPos(posArray)
  local retPos = boardService:_GetValidPos(monsterPosArray, areaArray, monsterBodyPosArray, monsterRaceType)
  if not retPos then
    return boardService:GetRandomPiecePos(areaArray, monsterBodyPosArray, monsterRaceType)
  end
  return retPos
end

function CreateMonsterPosService:_ExceptionValidRingNoRandom(areaArray, monsterBodyPosArray, monsterRaceType, index, invalidPos)
  local boardService = self._world:GetService("BoardLogic")
  for i = 1, 10 do
    local ringList = ComputeScopeRange.ComputeRange_SquareRing(invalidPos, #areaArray, i)
    local retPos = boardService:_GetValidPos(ringList, areaArray, monsterBodyPosArray, monsterRaceType, true)
    if retPos then
      return retPos
    end
  end
end

function CreateMonsterPosService:_PositionHitBackRefresh(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardService = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosArray = monsterRefreshParam:GetMonsterPosArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    local bodyAreaPosition = {}
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterPosition = monsterPosArray[i]
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, p in ipairs(areaArray) do
      table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
    end
    for k, areaPos in ipairs(bodyAreaPosition) do
      table.insert(createMonsterAreaList, areaPos)
    end
    monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
  end
  return monsterArray
end

function CreateMonsterPosService:_GetMonsterForward(forwardArray, index, monsterPos, monsterID)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local canTurn = monsterConfigData:CanTurn(monsterID)
  if forwardArray and index <= #forwardArray then
    return forwardArray[index]
  elseif canTurn then
    local playerPos = self:_GetPlayerPos()
    return playerPos - monsterPos
  else
    return Vector2(0, -1)
  end
end

function CreateMonsterPosService:_PositionAndOffSet(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardService = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosAndOffSetArray = monsterRefreshParam:GetMonsterPosAndOffSetArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local exceptionData = monsterRefreshParam:GetExceptionData()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    local bodyAreaPosition = {}
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterPosition = Vector2(0, 0)
    local monsterPosType = monsterPosAndOffSetArray[i][1]
    if monsterPosType == MonsterPosType.Position then
      monsterPosition = monsterPosAndOffSetArray[i][2]
    elseif monsterPosType == MonsterPosType.OffSet then
      local playPos = self:_GetPlayerPos()
      monsterPosition = playPos + monsterPosAndOffSetArray[i][2]
    end
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, p in ipairs(areaArray) do
      table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
    end
    if self:CheckPositionCanPlaceMonster(bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
      for k, areaPos in ipairs(bodyAreaPosition) do
        table.insert(createMonsterAreaList, areaPos)
      end
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    else
      if monsterRefreshParam:GetExceptionType() ~= MonsterRefreshExceptionType.None then
        monsterPosition = self:_DoException(monsterRefreshParam:GetExceptionType(), areaArray, createMonsterAreaList, monsterRaceType, i, monsterPosition, exceptionData)
        if monsterPosition then
          monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
          for k, p in ipairs(areaArray) do
            table.insert(createMonsterAreaList, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
          end
          self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] UseDoException Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
        else
          Log.fatal("No Valid PiecePos in board After DoException")
        end
      else
        Log.fatal("No Valid PiecePos in board No DoException")
      end
      Log.fatal("[[CreateMonsterPos] MonsterID:", monsterID, "Pos Invalid")
    end
  end
  return monsterArray
end

function CreateMonsterPosService:_FillMonsterTransformParam(monsterRotationArray, index, monsterPosition, monsterID, monsterTransformParam)
  local monsterForward = self:_GetMonsterForward(monsterRotationArray, index, monsterPosition, monsterID)
  monsterTransformParam:SetForward(monsterForward)
  monsterTransformParam:SetPosition(monsterPosition)
  return monsterTransformParam
end

function CreateMonsterPosService:_GetPlayerPos()
  local boardEntity = self._world:GetBoardEntity()
  local playerPos = Vector2(0, 0)
  if boardEntity and self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    if teamEntity then
      playerPos = teamEntity:GridLocation():GetGridPos()
    end
  else
    local levelConfigData = self._configService:GetLevelConfigData()
    playerPos = levelConfigData:GetPlayerBornPos()
  end
  return playerPos
end

function CreateMonsterPosService:_SelectFirstCanUsePos(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardService = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosArray = monsterRefreshParam:GetMonsterPosArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    if i > #monsterPosArray then
      break
    end
    local monsterPosList = monsterPosArray[i]
    local monsterRotationList = monsterRotationArray[i]
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for j = 1, #monsterPosList do
      local bodyAreaPosition = {}
      local monsterPosition = monsterPosList[j]
      for _, p in ipairs(areaArray) do
        table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
      end
      if self:CheckPositionCanPlaceMonster(bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
        for k, areaPos in ipairs(bodyAreaPosition) do
          table.insert(createMonsterAreaList, areaPos)
        end
        monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationList, j, monsterPosition, monsterID, monsterTransformParam)
        self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
        break
      end
    end
  end
  return monsterArray
end

function CreateMonsterPosService:_PlayerCentered(monsterRefreshParam)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    Log.exception("cfg_refresh_monster.MonsterRefreshType=8不适用于黑拳赛")
    return {}
  end
  local options = monsterRefreshParam:GetRefreshPosOptions()
  local preferRadius = options.preferRadius
  local ePlayerTeam = self._world:Player():GetLocalTeamEntity()
  local computer = CreateMonsterPosTargetCenteredUnit:New(self._world)
  computer:InitGridList(ePlayerTeam:GetGridPosition(), BlockFlag.MonsterLand & BlockFlag.MonsterFly)
  local monsterConfigData = self._world:GetService("Config"):GetMonsterConfigData()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local tMonsterTransformParam = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  for index, id in ipairs(monsterIDArray) do
    local cfgMonsterClass = monsterConfigData:GetMonsterClass(id)
    local area = cfgMonsterClass.Area
    local explainedArea = monsterConfigData:ExplainMonsterArea(area)
    local blockFlag = cfgMonsterClass.RaceType == MonsterRaceType.Fly and BlockFlag.MonsterFly or BlockFlag.MonsterLand
    local v2SummonPos = computer:GetPosByBlockFlag(blockFlag, preferRadius, explainedArea)
    if v2SummonPos then
      local genParam = MonsterTransformParam:New(id)
      self:_FillMonsterTransformParam(monsterRotationArray, index, v2SummonPos, id, genParam)
      table.insert(tMonsterTransformParam, genParam)
      computer:RemovePosFromCache(v2SummonPos, explainedArea)
    end
  end
  return tMonsterTransformParam
end

function CreateMonsterPosService:_MonsterCentered(monsterRefreshParam)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    Log.exception("cfg_refresh_monster.MonsterRefreshType=9不适用于黑拳赛")
    return {}
  end
  local options = monsterRefreshParam:GetRefreshPosOptions()
  local preferRadius = options.preferRadius
  local centerMonsterID = options.centerMonsterID
  local tv2Center = {}
  for _, e in ipairs(self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)) do
    local cMonsterID = e:MonsterID()
    local monsterID = cMonsterID:GetMonsterID()
    if monsterID == centerMonsterID then
      table.insert(tv2Center, e:GetGridPosition())
    end
  end
  local tMonsterTransformParam = {}
  local tv2Possessed = {}
  for _, v2 in ipairs(tv2Center) do
    local computer = CreateMonsterPosTargetCenteredUnit:New(self._world)
    computer:InitGridList(v2, BlockFlag.MonsterLand & BlockFlag.MonsterFly)
    for _, v2Possessed in ipairs(tv2Possessed) do
      computer:RemovePosFromCache(v2Possessed)
    end
    local monsterConfigData = self._world:GetService("Config"):GetMonsterConfigData()
    local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
    local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
    for index, id in ipairs(monsterIDArray) do
      local cfgMonsterClass = monsterConfigData:GetMonsterClass(id)
      local area = cfgMonsterClass.Area
      local explainedArea = monsterConfigData:ExplainMonsterArea(area)
      local blockFlag = cfgMonsterClass.RaceType == MonsterRaceType.Fly and BlockFlag.MonsterFly or BlockFlag.MonsterLand
      local v2SummonPos = computer:GetPosByBlockFlag(blockFlag, preferRadius, explainedArea)
      if v2SummonPos then
        local genParam = MonsterTransformParam:New(id)
        self:_FillMonsterTransformParam(monsterRotationArray, index, v2SummonPos, id, genParam)
        table.insert(tMonsterTransformParam, genParam)
        computer:RemovePosFromCache(v2SummonPos, explainedArea)
        for _, v2Area in ipairs(explainedArea) do
          local v2AbsBody = v2SummonPos + v2Area
          table.insert(tv2Possessed, v2AbsBody)
        end
      end
    end
  end
  return tMonsterTransformParam
end

function CreateMonsterPosService:CheckPositionCanPlaceMonster(posList, extendMonsterAreaPosList, monsterRaceType)
  local containPlayerPos = self:IsPosListContainPlayerPos(posList)
  if containPlayerPos then
    return false
  end
  local containExtendPos = self:IsPosListContainExtendMonsterList(posList, extendMonsterAreaPosList)
  if containExtendPos then
    return false
  end
  local isAllValid = self:IsPosListAllHaveValidPieceType(posList)
  if not isAllValid then
    return false
  end
  if self:IsPosListBlockMonsterRace(posList, monsterRaceType) then
    return false
  end
  local utilData = self._world:GetService("UtilData")
  if utilData:IsPosListBlockWithTrapWall(posList, monsterRaceType) then
    return false
  end
  return true
end

function CreateMonsterPosService:IsPosListContainPlayerPos(posList)
  local playerPosition = Vector2(0, 0)
  local teamEntity
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    teamEntity = self._world:Player():GetLocalTeamEntity()
  end
  if teamEntity then
    local playerGridLocation = teamEntity:GridLocation()
    playerPosition = playerGridLocation.Position
  else
    local levelConfigData = self._configService:GetLevelConfigData()
    playerPosition = levelConfigData:GetPlayerBornPos()
  end
  for _, pos in ipairs(posList) do
    if playerPosition.x == pos.x and playerPosition.y == pos.y then
      self:PrintCreateMonsterPosSvcLog("Player In MonsterArea")
      return true
    end
  end
  return false
end

function CreateMonsterPosService:IsPosListAllHaveValidPieceType(posList)
  local utilData = self._world:GetService("UtilData")
  for _, pos in ipairs(posList) do
    if not utilData:IsValidPiecePos(pos) then
      return false
    end
  end
  return true
end

function CreateMonsterPosService:IsPosListBlockMonsterRace(posList, monsterRaceType)
  if not monsterRaceType then
    Log.fatal("function Param monsterRaceType is Nil ")
    return true
  end
  local boardLogicSvc = self._world:GetService("BoardLogic")
  for _, pos in ipairs(posList) do
    if monsterRaceType == MonsterRaceType.Land and boardLogicSvc:IsPosBlock(pos, BlockFlag.MonsterLand) then
      return true
    end
    if monsterRaceType == MonsterRaceType.Fly and boardLogicSvc:IsPosBlock(pos, BlockFlag.MonsterFly) then
      return true
    end
  end
  return false
end

function CreateMonsterPosService:IsPosListContainExtendMonsterList(posList, extendMonsterAreaPosList)
  for _, pos in ipairs(posList) do
    if extendMonsterAreaPosList then
      for k, v in ipairs(extendMonsterAreaPosList) do
        if v == pos then
          self:PrintCreateMonsterPosSvcLog("NewMonsterIn pos：", tostring(v))
          return true
        end
      end
    end
  end
  return false
end

function CreateMonsterPosService:PrintCreateMonsterPosSvcLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function CreateMonsterPosService:_PositionAndOffSetMultiBoard(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardService = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosAndOffSetArray = monsterRefreshParam:GetMonsterPosAndOffSetArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local exceptionData = monsterRefreshParam:GetExceptionData()
  local boardIndex = monsterRefreshParam:GetBoardIndex()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    local bodyAreaPosition = {}
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterPosition = Vector2(0, 0)
    local monsterPosType = monsterPosAndOffSetArray[i][1]
    if monsterPosType == MonsterPosType.Position then
      monsterPosition = monsterPosAndOffSetArray[i][2]
    end
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, p in ipairs(areaArray) do
      table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
    end
    if self:CheckPositionCanPlaceMonsterMultiBoard(boardIndex, bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
      monsterTransformParam:SetBoardIndex(boardIndex)
      for k, areaPos in ipairs(bodyAreaPosition) do
        table.insert(createMonsterAreaList, areaPos)
      end
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    else
      if monsterRefreshParam:GetExceptionType() ~= MonsterRefreshExceptionType.None then
        monsterPosition = self:_DoException(monsterRefreshParam:GetExceptionType(), areaArray, createMonsterAreaList, monsterRaceType, i, monsterPosition, exceptionData)
        if monsterPosition then
          monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
          for k, p in ipairs(areaArray) do
            table.insert(createMonsterAreaList, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
          end
          self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] UseDoException Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
        else
          Log.fatal("No Valid PiecePos in board After DoException")
        end
      else
        Log.fatal("No Valid PiecePos in board No DoException")
      end
      Log.fatal("[[CreateMonsterPos] MonsterID:", monsterID, "Pos Invalid")
    end
  end
  return monsterArray
end

function CreateMonsterPosService:CheckPositionCanPlaceMonsterMultiBoard(boardIndex, posList, extendMonsterAreaPosList, monsterRaceType)
  local containExtendPos = self:IsPosListContainExtendMonsterList(posList, extendMonsterAreaPosList)
  if containExtendPos then
    return false
  end
  local isAllValid = self:IsPosListAllHaveValidPieceTypeMultiBoard(boardIndex, posList)
  if not isAllValid then
    return false
  end
  if self:IsPosListBlockMonsterRaceMultiBoard(boardIndex, posList, monsterRaceType) then
    return false
  end
  return true
end

function CreateMonsterPosService:IsPosListAllHaveValidPieceTypeMultiBoard(boardIndex, posList)
  local utilData = self._world:GetService("UtilData")
  for _, pos in ipairs(posList) do
    if not utilData:IsValidPiecePosMultiBoard(boardIndex, pos) then
      return false
    end
  end
  return true
end

function CreateMonsterPosService:IsPosListBlockMonsterRaceMultiBoard(boardIndex, posList, monsterRaceType)
  if not monsterRaceType then
    Log.fatal("function Param monsterRaceType is Nil ")
    return true
  end
  local boardMultiServiceLogic = self._world:GetService("BoardMultiLogic")
  for _, pos in ipairs(posList) do
    if monsterRaceType == MonsterRaceType.Land and boardMultiServiceLogic:IsPosBlockMultiBoard(boardIndex, pos, BlockFlag.MonsterLand) then
      return true
    end
    if monsterRaceType == MonsterRaceType.Fly and boardMultiServiceLogic:IsPosBlockMultiBoard(boardIndex, pos, BlockFlag.MonsterFly) then
      return true
    end
  end
  return false
end

function CreateMonsterPosService:_PositionOnExtraBoard(monsterRefreshParam)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterArray = {}
  local monsterIDArray = monsterRefreshParam:GetMonsterIDArray()
  local monsterPosArray = monsterRefreshParam:GetMonsterPosArray()
  local monsterRotationArray = monsterRefreshParam:GetMonsterRotationArray()
  local createMonsterAreaList = {}
  for i, monsterID in ipairs(monsterIDArray) do
    self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] MonsterID:", monsterID)
    local bodyAreaPosition = {}
    local monsterTransformParam = MonsterTransformParam:New(monsterID)
    local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
    if i > #monsterPosArray then
      break
    end
    local monsterPosition = monsterPosArray[i]
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, p in ipairs(areaArray) do
      table.insert(bodyAreaPosition, Vector2(monsterPosition.x + p.x, monsterPosition.y + p.y))
    end
    if self:CheckPositionCanPlaceMonsterOnExtraBoard(bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
      for k, areaPos in ipairs(bodyAreaPosition) do
        table.insert(createMonsterAreaList, areaPos)
      end
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    elseif self:CheckPositionCanPlaceMonster(bodyAreaPosition, createMonsterAreaList, monsterRaceType) then
      for k, areaPos in ipairs(bodyAreaPosition) do
        table.insert(createMonsterAreaList, areaPos)
      end
      monsterArray[#monsterArray + 1] = self:_FillMonsterTransformParam(monsterRotationArray, i, monsterPosition, monsterID, monsterTransformParam)
      self:PrintCreateMonsterPosSvcLog("[[CreateMonsterPos] Create MonsterID:", monsterID, "Pos:", tostring(monsterPosition))
    else
      Log.fatal("[[CreateMonsterPos] MonsterID:", monsterID, "Pos Invalid")
    end
  end
  return monsterArray
end

function CreateMonsterPosService:CheckPositionCanPlaceMonsterOnExtraBoard(posList, extendMonsterAreaPosList, monsterRaceType)
  local containExtendPos = self:IsPosListContainExtendMonsterList(posList, extendMonsterAreaPosList)
  if containExtendPos then
    return false
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  for _, pos in ipairs(posList) do
    if not table.intable(extraBoardPosRange, pos) then
      return false
    end
  end
  return true
end
