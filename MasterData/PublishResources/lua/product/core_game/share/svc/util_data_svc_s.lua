_class("UtilDataServiceShare", BaseService)
UtilDataServiceShare = UtilDataServiceShare

function UtilDataServiceShare:Constructor(world)
  self._world = world
end

function UtilDataServiceShare:Initialize()
  self._boardLogicSvc = self._world:GetService("BoardLogic")
end

function UtilDataServiceShare:GetCurMainStateID()
  local gameFsmStateID = GameStateID.Invalid
  local hasGameFsm = self._world:HasGameFSM()
  if hasGameFsm then
    local gameFsmCmpt = self._world:GameFSM()
    gameFsmStateID = gameFsmCmpt:CurStateID()
  end
  return gameFsmStateID
end

function UtilDataServiceShare:GetMainStateInputEnable()
  local enable = false
  local hasGameFsm = self._world:HasGameFSM()
  if hasGameFsm then
    local gameFsmCmpt = self._world:GameFSM()
    enable = gameFsmCmpt:GetHandleInputEnable()
  end
  return enable
end

function UtilDataServiceShare:GetReplicaGridEntityData()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local gridEntityData = boardComponent:GetGridEntityData()
  if not gridEntityData then
    return
  end
  local extraBoardPosList = self:GetExtraBoardPosList()
  local replica = {}
  for k, v in pairs(gridEntityData) do
    local posWork = Vector2(k.x, k.y)
    if not table.intable(extraBoardPosList, posWork) then
      replica[k] = v
    end
  end
  return replica
end

function UtilDataServiceShare:GetReplicaBoardPieces()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local replica = {}
  for x, col in pairs(boardComponent.Pieces) do
    replica[x] = {}
    for y, grid in pairs(col) do
      replica[x][y] = grid
    end
  end
  return replica
end

function UtilDataServiceShare:IsPrismPiece(gridPos)
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  return boardComponent:IsPrismPiece(gridPos)
end

function UtilDataServiceShare:GetBoardPieceEffectType(gridPos)
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  return boardComponent:GetBoardPieceEffectType(gridPos)
end

function UtilDataServiceShare:PlayerIsDead(teamEntity)
  local battlesvc = self._world:GetService("Battle")
  return battlesvc:PlayerIsDead(teamEntity)
end

function UtilDataServiceShare:GetEntityIDByPstID(checkPstID)
  local casterPetEntityID = -1
  local petPstIDGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  for _, e in ipairs(petPstIDGroup:GetEntities()) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == checkPstID then
      casterPetEntityID = e:GetID()
    end
  end
  return casterPetEntityID
end

function UtilDataServiceShare:GetPlayerArea()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetPlayerArea()
end

function UtilDataServiceShare:GetGridTiles()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetGridTiles()
end

function UtilDataServiceShare:GetEntityElementType(entity, checkFetters)
  local elementCmpt = entity:Element()
  if elementCmpt == nil then
    Log.fatal("GetEntityElementType failed,no element cmpt")
    return
  end
  local elementType = PieceType.None
  local useSecondary = elementCmpt:IsUseSecondaryType()
  if useSecondary == true then
    elementType = elementCmpt:GetSecondaryType()
  else
    elementType = elementCmpt:GetPrimaryType()
  end
  if checkFetters then
    local fettersSvc = self._world:GetService("Fetters")
    if fettersSvc and fettersSvc:IsFettersActive(entity) then
      elementType = fettersSvc:GetFettersPrimaryType(entity)
    end
  end
  return elementType
end

function UtilDataServiceShare:FindEntityByPosAndType(pos, nEntityType, nTypeParam)
  local pieceBlockData = self:FindBlockByPos(pos)
  if nil == pieceBlockData then
    return {}
  end
  return pieceBlockData:FindEntity(self._world, nEntityType, nTypeParam)
end

function UtilDataServiceShare:IsValidPiecePos(pos)
  local eBoard = self._world:GetBoardEntity()
  local cBoard = eBoard:Board()
  return cBoard:GetPieceData(pos)
end

function UtilDataServiceShare:FindBlockByPos(pos)
  local eBoard = self._world:GetBoardEntity()
  local cBoard = eBoard:Board()
  return cBoard:FindBlockByPos(pos)
end

function UtilDataServiceShare:IsPosBlock(pos, blockFlag)
  if not pos then
    return false
  end
  if not self:IsValidPiecePos(pos) then
    return true
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

function UtilDataServiceShare:IsPosBlockLinkLineForChain(pos)
  if not pos then
    return false
  end
  if not self:IsValidPiecePos(pos) then
    return true
  end
  local pieceBlock = self:FindBlockByPos(pos)
  if nil == pieceBlock then
    return true
  end
  local remoteTeamPos
  local remoteTeam = self._world:Player():GetRemoteTeamEntity()
  if remoteTeam then
    remoteTeamPos = remoteTeam:GetGridPosition()
  end
  local isBlock = pieceBlock:CheckBlock(BlockFlag.LinkLine)
  if isBlock == false then
    if pos == remoteTeamPos then
      return true
    else
      return false
    end
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainAcrossMonster = logicChainPathCmpt:GetChainAcrossMonster()
  if chainAcrossMonster then
    local isHaveMonster = self:IsPosListHaveMonster({pos})
    if isHaveMonster then
      return false
    end
  end
  local chainAcrossMonsterIDList = logicChainPathCmpt:GetChainAcrossMonsterIDList()
  if chainAcrossMonsterIDList and table.count(chainAcrossMonsterIDList) > 0 then
    local monsterEntity = self:GetMonsterAtPos(pos)
    if monsterEntity and table.icontains(chainAcrossMonsterIDList, monsterEntity:GetID()) then
      return false
    end
  end
  return isBlock
end

function UtilDataServiceShare:IsPosBlockForPreviewLinkLine(pos, canLinkMonster)
  if not pos then
    return false
  end
  if not self:IsValidPiecePos(pos) then
    return true
  end
  local pieceBlock = self:FindBlockByPos(pos)
  if nil == pieceBlock then
    return true
  end
  local isBlock = pieceBlock:CheckBlock(BlockFlag.LinkLine)
  if isBlock == false then
    return false
  end
  if canLinkMonster then
    local isHaveMonster = self:GetMonsterAtPos(pos)
    if isHaveMonster then
      return false
    end
  end
  return isBlock
end

function UtilDataServiceShare:IsPosBlockLinkLineForChainChainEnd(pos)
  local pieceBlock = self:FindBlockByPos(pos)
  local isBlock = pieceBlock:CheckBlock(BlockFlag.LinkLine)
  return isBlock
end

function UtilDataServiceShare:IsPosCanMapOtherPiece(pos, chainPieceType, previewPieceType)
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local mapByPieceType = boardComponent:GetMapByPieceType()
  if not mapByPieceType or table.count(mapByPieceType) == 0 then
    return false
  end
  for sourcePiece, targetPiece in pairs(mapByPieceType) do
    if previewPieceType == sourcePiece then
      if targetPiece == PieceType.Any then
        return true
      end
      if targetPiece == chainPieceType then
        return true
      end
      break
    end
  end
  return false
end

function UtilDataServiceShare:GetMapForFirstChainPath()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local mapForFirstChainPath = boardComponent:GetMapForFirstChainPath()
  return mapForFirstChainPath
end

function UtilDataServiceShare:IsPosBlockWithEntityRace(pos, blockFlag, targetEntity)
  if not self:IsValidPiecePos(pos) then
    return true
  end
  local listTrap = self:GetTrapsAtPos(pos)
  for _, value in ipairs(listTrap) do
    local entityTrap = value
    local trapCmp = entityTrap:Trap()
    local blockByRaceType = trapCmp:GetBlockByRaceType()
    if blockByRaceType then
      local curRaceType = TrapRaceType.All
      local curBlock = 0
      if targetEntity:HasTeam() then
        curRaceType = TrapRaceType.Team
      elseif targetEntity:HasMonsterID() then
        curRaceType = TrapRaceType.Monster
      elseif targetEntity:HasChessPet() then
        curRaceType = TrapRaceType.ChessPet
      end
      for _, blockRaceInfo in ipairs(blockByRaceType) do
        if curRaceType == blockRaceInfo.RaceType then
          curBlock = blockRaceInfo.Block
          break
        end
      end
      if 0 < curBlock then
        local boardServiceL = self._world:GetService("BoardLogic")
        local curBlockFlag = boardServiceL:GetBlockFlagByBlockId(curBlock)
        if 0 < blockFlag & curBlockFlag then
          return true
        end
      end
    end
  end
  return false
end

function UtilDataServiceShare:FindPieceElement(pos)
  local board = self._world:GetBoardEntity():Board()
  if board.Pieces[pos.x] and board.Pieces[pos.x][pos.y] then
    return board.Pieces[pos.x][pos.y]
  else
    return PieceType.None
  end
end

function UtilDataServiceShare:GetPieceType(pos)
  local boardEntity = self._world:GetBoardEntity()
  return boardEntity:Board():GetPieceType(pos)
end

function UtilDataServiceShare:GetPiecePosByType(pieceTypeList)
  local boardEntity = self._world:GetBoardEntity()
  return boardEntity:Board():GetPiecePosByType(pieceTypeList)
end

function UtilDataServiceShare:IsPosExistNegtiveBlock(pos)
  local block = self:FindBlockByPos(pos)
  return block:IsExistNegative()
end

function UtilDataServiceShare:IgnoreElementMatchOnPos(pos)
  local isExit = self:IsPosExit(pos)
  return isExit
end

function UtilDataServiceShare:IsPosExit(pos)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:IsPosExit(pos)
end

function UtilDataServiceShare:IsPosDimensionDoor(pos)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:IsPosDimensionDoor(pos)
end

function UtilDataServiceShare:HasDimensionDoor()
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  return cBoard:HasDimensionDoor()
end

function UtilDataServiceShare:IsAdjacentPos(center, pos)
  if math.abs(center.x - pos.x) > 1 or 1 < math.abs(center.y - pos.y) or center == pos then
    return false
  end
  return true
end

function UtilDataServiceShare:IsPosListHaveMonster(posList)
  local monsterPosList = self:GetAllMonsterPos()
  for k, v in pairs(posList) do
    if table.icontains(monsterPosList, v) then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:GetAllMonsterPos()
  local monsterPosList = {}
  if self._world:GetRunningPosition() == WorldRunPostion.Performance then
    return {}
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local monsterGridPos = e:GridLocation().Position
    if not e:HasDeadMark() then
      if e:HasBodyArea() then
        local bodyAreaCmpt = e:BodyArea()
        local areaArray = bodyAreaCmpt:GetArea()
        for i = 1, #areaArray do
          local curAreaPos = areaArray[i]
          table.insert(monsterPosList, monsterGridPos + curAreaPos)
        end
      else
        table.insert(monsterPosList, monsterGridPos)
      end
    end
  end
  return monsterPosList
end

function UtilDataServiceShare:GetRoundGrid(grid, filter)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetRoundGrid(grid, filter)
end

function UtilDataServiceShare:IsHaveEntity(pos, nEntityType, nTypeParam)
  local listFindEntity = self:FindEntityByPosAndType(pos, nEntityType, nTypeParam)
  if listFindEntity and table.count(listFindEntity) > 0 then
    return true
  end
  return false
end

function UtilDataServiceShare:GetMonsterAtPos(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    if self._world:MatchType() == MatchType.MT_BlackFist then
      return e:HasTeam()
    else
      return e:HasMonsterID()
    end
  end)
  if 0 < #es then
    return es[1]
  end
end

function UtilDataServiceShare:GetAllMonstersAtPos(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    if self._world:MatchType() == MatchType.MT_BlackFist then
      return e:HasTeam()
    else
      return e:HasMonsterID()
    end
  end)
  return es
end

function UtilDataServiceShare:GetBoardCenterPos()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetBoardCenterPos()
end

function UtilDataServiceShare:GetAppearSkillId(e)
  local configService = self._world:GetService("Config")
  local monsterConfigData = configService:GetMonsterConfigData()
  local monsterId = e:MonsterID():GetMonsterID()
  local skillId = monsterConfigData:GetAppearSkillID(monsterId)
  return skillId
end

function UtilDataServiceShare:GetDropSkill(monsterEntity)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local cMonsterID = monsterEntity:MonsterID()
  local skillId
  if cMonsterID then
    skillId = monsterConfigData:GetDropSkillID(cMonsterID:GetMonsterID())
  end
  return skillId
end

function UtilDataServiceShare:GetMonsterBackSkill(monsterEntity)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local cMonsterID = monsterEntity:MonsterID()
  local skillId
  if cMonsterID then
    skillId = monsterConfigData:GetBackSkillID(cMonsterID:GetMonsterID())
  end
  return skillId
end

function UtilDataServiceShare:GetTrapPreviewSkillID(entityTrap)
  local skillID = 0
  local cAI = entityTrap:AI()
  if cAI then
    skillID = cAI:GetPreviewSkillID()
  else
    local cmptTrap = entityTrap:Trap()
    skillID = cmptTrap:GetTriggerSkillID()
  end
  return skillID
end

function UtilDataServiceShare:GetTrapFakeTriggerSkillID(trapEntity)
  local skillID = 0
  local cTrap = trapEntity:Trap()
  if not cTrap then
    return nil
  end
  return cTrap:GetFakeTriggerSkillID()
end

function UtilDataServiceShare:GetTrapTriggerSkillIDByTriggerEntity(trapEntity, triggerEntity)
  local skillID = 0
  local cTrap = trapEntity:Trap()
  if not cTrap then
    return skillID
  end
  local raceType = cTrap:GetTrapRaceType()
  local trapTargetSelector = TrapTargetSelector:New(self._world)
  if not trapTargetSelector:CanSelectTargetByType(trapEntity, triggerEntity, raceType) then
    return skillID
  end
  local triggerSkillByRaceType = cTrap:GetTriggerSkillByRaceType()
  if triggerEntity and triggerSkillByRaceType then
    for _, triggerRaceInfo in ipairs(triggerSkillByRaceType) do
      if trapTargetSelector:CanSelectTargetByType(trapEntity, triggerEntity, triggerRaceInfo.RaceType) then
        skillID = triggerRaceInfo.SkillID
        return skillID
      end
    end
  end
  skillID = cTrap:GetTriggerSkillID()
  local isFakeSkill = false
  if cTrap:GetFakeTriggerSkillID() then
    isFakeSkill = true
  end
  return skillID, isFakeSkill
end

function UtilDataServiceShare:GetGroupTrap(eTrap)
  local cTrap = eTrap:Trap()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local traps = {}
  local triggerTargetTrapID = cTrap:GetGroupTriggerTrapID()
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    local cTrapInGroup = trapEntity:Trap()
    if eTrap:GetID() ~= trapEntity:GetID() and cTrap:GetGroupID() ~= 0 and cTrapInGroup:GetGroupID() ~= 0 and cTrap:GetGroupID() == cTrapInGroup:GetGroupID() and (not triggerTargetTrapID or triggerTargetTrapID == cTrapInGroup:GetTrapID()) then
      table.insert(traps, trapEntity)
    end
  end
  return traps
end

function UtilDataServiceShare:GetProtectedTrap()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    local trapComponent = trapEntity:Trap()
    if trapComponent:GetTrapType() == TrapType.Protected then
      return trapEntity
    end
  end
  return nil
end

local function Filter_GetTrapAndNoDeadMark(e)
  return e:HasTrapID() and not e:HasDeadMark()
end

function UtilDataServiceShare:IsHasTrapOnPos(pos, trapID)
  local board = self._world:GetBoardEntity():Board()
  local entities = board:GetPieceEntities(pos, Filter_GetTrapAndNoDeadMark)
  for i, entity in ipairs(entities) do
    if entity:HasTrap() and entity:Trap():GetTrapID() == trapID then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:GetTrapsAtPos(pos)
  local board = self._world:GetBoardEntity():Board()
  local es = board:GetPieceEntities(pos, Filter_GetTrapAndNoDeadMark)
  return es
end

function UtilDataServiceShare:FindTrapByTypeAndPos(nTrapType, pos)
  local listReturn = {}
  local listFindID = self:FindEntityByPosAndType(pos, EnumTargetEntity.Trap, nTrapType)
  for i = 1, #listFindID do
    local trapEntity = self._world:GetEntityByID(listFindID[i])
    if not trapEntity:HasDeadMark() then
      table.insert(listReturn, trapEntity)
    end
  end
  return listReturn
end

function UtilDataServiceShare:IsMaintainColorTrap(pos)
  local listTrap = self:FindMaintainColorTrapByPos(pos)
  return 0 < #listTrap
end

function UtilDataServiceShare:FindMaintainColorTrapByPos(pos)
  local listReturn = {}
  local trapList = self:GetTrapsAtPos(pos)
  for _, trapEntity in ipairs(trapList) do
    local trapComponent = trapEntity:Trap()
    if trapComponent:IsMaintainColorGrid() then
      table.insert(listReturn, trapEntity)
    end
  end
  return listReturn
end

function UtilDataServiceShare:IsArchivedBattle()
  local mazeService = self._world:GetService("Maze")
  return mazeService:IsArchivedBattle()
end

function UtilDataServiceShare:GetArchivedBattle()
  local mazeService = self._world:GetService("Maze")
  return mazeService:GetBattleArchive()
end

function UtilDataServiceShare:GetLightCount()
  local mazeService = self._world:GetService("Maze")
  return mazeService:GetLightCount()
end

function UtilDataServiceShare:IsGridElementMatch(checkPos, convertGridTypeArray)
  local checkPosType = self:FindPieceElement(checkPos)
  for k, v in ipairs(convertGridTypeArray) do
    local curGridType = tonumber(v)
    if curGridType == checkPosType then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:GetMonsterGridAreaList(monsterEntity)
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local monsterRenderPos = monsterEntity:GetRenderGridPosition()
  local targetPos = monsterRenderPos
  local areaPosList = {}
  for i = 1, #bodyArea do
    local pos = targetPos + bodyArea[i]
    table.insert(areaPosList, pos)
  end
  return areaPosList
end

function UtilDataServiceShare:GetEntityElementPrimaryType(entity)
  local elementCmpt = entity:Element()
  if elementCmpt then
    return elementCmpt:GetPrimaryType()
  end
end

function UtilDataServiceShare:GetAIPreviewSkillID(aiEntity)
  local aiCmpt = aiEntity:AI()
  return aiCmpt:GetPreviewSkillID()
end

function UtilDataServiceShare:GetAIMobilityConfig(aiEntity)
  local aiCmpt = aiEntity:AI()
  return aiCmpt:GetMobilityConfig()
end

function UtilDataServiceShare:GetAISkillScopeResult(aiEntity)
  local aiCmpt = aiEntity:AI()
  return aiCmpt:GetSkillScopeResult()
end

function UtilDataServiceShare:GetBoardIsPosNil(pos)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  return boardCmpt:IsPosNil(pos)
end

function UtilDataServiceShare:GetCloneBoardGridPos()
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  return boardCmpt:CloneBoardPosList()
end

function UtilDataServiceShare:Is2PosCanConnect(pos1, pos2, pieceType, chainPathIndex1, forMonster)
  local bConnect = false
  local pieceType1 = 99
  local pieceType2 = 99
  local canLinkLine = false
  for i = -1, 1 do
    for j = -1, 1 do
      if pos1.x + i == pos2.x and pos1.y + j == pos2.y then
        if self:IsValidPiecePos(pos2) then
          pieceType1 = self._boardLogicSvc:GetPieceType(pos1)
          if chainPathIndex1 and chainPathIndex1 == 2 then
            local mapForFirstChainPath = self:GetMapForFirstChainPath()
            if mapForFirstChainPath then
              pieceType1 = mapForFirstChainPath
            end
          end
          pieceType2 = self._boardLogicSvc:GetPieceType(pos2)
          canLinkLine = not self:IsPosBlockLinkLineForChain(pos2)
          local isPieceMatch = false
          if not forMonster then
            if self:IsNeedShowLinkageNumForCostStep() then
              isPieceMatch = true
            else
              isPieceMatch = CanMatchPieceType(pieceType, pieceType2) and CanMatchPieceType(pieceType1, pieceType2)
            end
          else
            isPieceMatch = CanMatchPieceType(pieceType, pieceType2) and CanMatchPieceType(pieceType1, pieceType2)
          end
          if isPieceMatch and canLinkLine then
            bConnect = true
          end
          if bConnect == false then
            local gridPieceTypeMapList1 = self._boardLogicSvc:GetPieceTypeMapList(pos1)
            local gridPieceTypeMapList2 = self._boardLogicSvc:GetPieceTypeMapList(pos2)
            if table.intable(gridPieceTypeMapList1, PieceType.Any) or table.intable(gridPieceTypeMapList2, PieceType.Any) then
              bConnect = true
            end
            if table.intable(gridPieceTypeMapList1, pieceType2) or table.intable(gridPieceTypeMapList2, pieceType1) then
              bConnect = true
            end
            if pieceType1 ~= pieceType and self:IsPosCanMapOtherPiece(pos1, pieceType, pieceType1) then
              bConnect = true
            end
            if pieceType2 ~= pieceType and self:IsPosCanMapOtherPiece(pos2, pieceType, pieceType2) then
              bConnect = true
            end
          end
        end
        break
      end
    end
  end
  local msg = "pieceType1=" .. pieceType1 .. " pieceType2=" .. pieceType2 .. " canLinkLine=" .. tostring(canLinkLine)
  return bConnect, msg
end

function UtilDataServiceShare:UpdateRenderHPLockInfoByLogic(defenderEntity)
  local buffComponent = defenderEntity:BuffComponent()
  local buffViewComponent = defenderEntity:BuffView()
  if buffComponent and buffViewComponent then
    buffViewComponent:AddHpLockState(buffComponent:GetLockHPRoundIndex(), buffComponent:GetHPLockIndex(), buffComponent:GetLockGSMState(), buffComponent:IsAlwaysLock(), buffComponent:GetBuffValue("LockHPType"), buffComponent:GetUnlockHPIndex())
  end
end

function UtilDataServiceShare:GetAICanMove(aiEntity)
  local aiCmpt = aiEntity:AI()
  if aiCmpt == nil then
    return false
  end
  return aiCmpt:CanMove()
end

function UtilDataServiceShare:GetStatCurWaveIndex()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:GetCurWaveIndex()
end

function UtilDataServiceShare:GetStatCurWaveRoundNum()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:GetCurWaveRoundNum()
end

function UtilDataServiceShare:GetStatCurWaveTotalRoundCount()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:GetCurWaveTotalRoundCount()
end

function UtilDataServiceShare:GetStatIsRoundAuroraTime()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:IsRoundAuroraTime()
end

function UtilDataServiceShare:GetStatIsReEnterAuroraTime()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:IsReEnterAuroraTime()
end

function UtilDataServiceShare:GetStatBossWaveInfo()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  local isBossWave = levelConfigData:GetIsBoss(waveNum)
  local bossIDs = {}
  if isBossWave then
    bossIDs = levelConfigData:GetBossID(waveNum)
  end
  return isBossWave, bossIDs
end

function UtilDataServiceShare:GetStatAutoFight()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:GetAutoFight()
end

function UtilDataServiceShare:GetStatIsFirstWave()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  if waveNum == 1 then
    return true
  end
  return false
end

function UtilDataServiceShare:GetStatIsRealZeroRound()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:IsRealZeroRound()
end

function UtilDataServiceShare:GetStatIsZeroRound()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:GetCurWaveRound() == 0 and 0 < battleStatCmpt:GetCurWavePunishmentRoundCount()
end

function UtilDataServiceShare:GetCurWavePunishmentRoundCount()
  return self._world:BattleStat():GetCurWavePunishmentRoundCount()
end

function UtilDataServiceShare:GetStatLevelCompleteLimitAllRoundCount()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:LevelCompleteLimitAllRoundCount()
end

function UtilDataServiceShare:GetStatIsAssignWaveResult()
  local battleStatCmpt = self._world:BattleStat()
  return battleStatCmpt:AssignWaveResult()
end

function UtilDataServiceShare:PosIsSingleMonster(pos)
  local e = self:GetMonsterAtPos(pos)
  local areaCmpt = e:BodyArea()
  return #areaCmpt:GetArea() == 1
end

function UtilDataServiceShare:IsMonsterCanTel2TargetPos(monsterEntity, targetPos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local entity = monsterEntity
  if monsterEntity:HasSuperEntity() and monsterEntity:GetSuperEntity() then
    entity = monsterEntity:GetSuperEntity()
  end
  if entity:HasTeam() or entity:HasPet() then
    return not boardServiceLogic:IsPosBlock(targetPos, BlockFlag.LinkLine)
  end
  local monsterRaceType = entity:MonsterID():GetMonsterRaceType()
  local raceBlockFlag
  local hitBackBlockFlag = BlockFlag.HitBack
  if monsterRaceType == MonsterRaceType.Land then
    raceBlockFlag = BlockFlag.MonsterLand
  elseif monsterRaceType == MonsterRaceType.Fly then
    raceBlockFlag = BlockFlag.MonsterFly
    hitBackBlockFlag = BlockFlag.HitBackFly
  end
  return not boardServiceLogic:IsMonsterPosBlock(entity, targetPos, raceBlockFlag) and not boardServiceLogic:IsMonsterPosBlock(entity, targetPos, hitBackBlockFlag) and not self:IsPosBlockWithEntityRace(targetPos, hitBackBlockFlag, entity)
end

function UtilDataServiceShare:IsFinalAttack()
  local battlesvc = self._world:GetService("Battle")
  return battlesvc:IsFinalAttack()
end

function UtilDataServiceShare:IsTeamLeaderCanAttack(teamEntity, pieceType)
  local affixService = self._world:GetService("Affix")
  local canAttackByAffix = affixService:IsTeamLeaderCanAttack(teamEntity, pieceType)
  local buffSvc = self._world:GetService("BuffLogic")
  local canAttackByBuff = buffSvc:IsTeamLeaderCanAttack(teamEntity, pieceType)
  return canAttackByAffix and canAttackByBuff
end

function UtilDataServiceShare:GetFirstWaveMonsterIDList()
  return self._world:BattleStat():GetFirstWaveMonsterIDList()
end

function UtilDataServiceShare:GetFirstWaveTrapIDList()
  return self._world:BattleStat():GetFirstWaveTrapIDList()
end

function UtilDataServiceShare:IsCloseAuroraTime()
  local affixService = self._world:GetService("Affix")
  return affixService:IsCloseAuroraTime()
end

function UtilDataServiceShare:IsNoAuroraTimeLimit()
  local affixService = self._world:GetService("Affix")
  return affixService:IsNoAuroraTimeLimit()
end

function UtilDataServiceShare:GetWorldBossEntity()
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:GetWorldBossEntity()
end

function UtilDataServiceShare:GetWorldBossEntityArray()
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:GetWorldBossEntityArray()
end

function UtilDataServiceShare:IsFifthPetInTeamOrder(petPstID)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petPstIDArray = teamEntity:Team():GetTeamOrder()
  local lastPetPstID = petPstIDArray[5]
  if petPstID == lastPetPstID then
    return true
  end
  return false
end

function UtilDataServiceShare:IsFourthPetInTeamOrder(petPstID)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petPstIDArray = teamEntity:Team():GetTeamOrder()
  local lastPetPstID = petPstIDArray[4]
  if petPstID == lastPetPstID then
    return true
  end
  return false
end

function UtilDataServiceShare:IsFourthOrEightPetInTeamOrder(petPstID)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local petPstIDArray = teamEntity:Team():GetTeamOrder()
  local lastPetPstID = petPstIDArray[4]
  if petPstID == lastPetPstID then
    return true
  end
  if #petPstIDArray == 8 then
    return petPstID == petPstIDArray[8]
  end
  return false
end

function UtilDataServiceShare:GetLatestEffectParamArray(eid, skillId)
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(eid, skillId)
  return skillEffectArray
end

function UtilDataServiceShare:IsTrapPosCanMoveMonster(trapEntity, monsterEntity)
  local ownerPos = trapEntity:GetGridPosition()
  local areaCmpt = trapEntity:BodyArea()
  local areaList = areaCmpt:GetArea()
  local beValid = true
  for i, area in ipairs(areaList) do
    local pos = Vector2(ownerPos.x + area.x, ownerPos.y + area.y)
    if not self:IsMonsterCanTel2TargetPos(monsterEntity, pos) then
      beValid = false
    end
  end
  return beValid
end

function UtilDataServiceShare:GetHPBarTypeByEntity(entity)
  if entity:HasMonsterID() then
    if entity:HasBoss() then
      if entity:MonsterID():IsEliteMonster() then
        return HPBarType.EliteBoss
      else
        return HPBarType.Boss
      end
    elseif entity:MonsterID():IsEliteMonster() then
      return HPBarType.EliteMonster
    else
      return HPBarType.NormalMonster
    end
  end
  if entity:HasTrapID() then
    return HPBarType.Trap
  end
end

function UtilDataServiceShare:IsAIChangePreviewSkillID(aiEntity)
  local aiCmpt = aiEntity:AI()
  return aiCmpt:IsReplacePreviewSkill()
end

function UtilDataServiceShare:OnCheckPetForceChain(petEntity)
  local buffComponent = petEntity:BuffComponent()
  local petForceChain = buffComponent:GetBuffValue("PetForceChain") or 0
  return petForceChain == 1
end

function UtilDataServiceShare:CreatePieceBlockBlackboard(tPawnEntityID)
  tPawnEntityID = tPawnEntityID or {}
  local isEntityPawn = {}
  for _, id in ipairs(tPawnEntityID) do
    isEntityPawn[id] = true
  end
  local currentBlockFlags = self._world:GetBoardEntity():Board():GetBlockFlagArray()
  local blockDataByGridPos = {}
  for x, ty in pairs(currentBlockFlags) do
    if not blockDataByGridPos[x] then
      blockDataByGridPos[x] = {}
    end
    for y, logicBlockData in pairs(ty) do
      local blockData = PieceBlockData:New()
      for eid, blockVal in pairs(logicBlockData.m_listBlock) do
        if not isEntityPawn[eid] then
          blockData:AddBlock(eid, blockVal)
        else
          local pawnBlock = PieceBlockData:New()
          local val = self._world:GetEntityByID(eid):BlockFlag():GetBlockFlag()
          pawnBlock:AddBlock(eid, val)
        end
      end
      blockDataByGridPos[x][y] = blockData
    end
  end
  return blockDataByGridPos
end

function UtilDataServiceShare:OnGetAITargetType(entity)
  local aiTargetType = AITargetType.Normal
  local aiCmpt = entity:AI()
  if aiCmpt then
    aiTargetType = aiCmpt:GetAITargetType()
  end
  return aiTargetType
end

function UtilDataServiceShare:EntityAITargetTypeIsNormal(entity)
  local aiTargetType = self:OnGetAITargetType(entity)
  return aiTargetType == AITargetType.Normal
end

function UtilDataServiceShare:GetEntityByPstID(checkPstID)
  local casterPetEntity
  local petPstIDGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  for i, e in ipairs(petPstIDGroup:GetEntities()) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == checkPstID then
      casterPetEntity = e
    end
  end
  return casterPetEntity
end

function UtilDataServiceShare:CheckActiveSkillCastCondition(petPstID, skillID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  local log = {
    tostring(BattleConst.Kick),
    tostring(self:GetEntityByPstID(petPstID) ~= nil),
    tostring(castPetEntity and castPetEntity:HasSkillInfo() and castPetEntity:SkillInfo():GetActiveSkillID()),
    tostring(castPetEntity and castPetEntity:HasAttributes() and castPetEntity:Attributes():GetAttribute("Ready")),
    tostring(castPetEntity and castPetEntity:HasAttributes() and castPetEntity:Attributes():GetAttribute("LegendPower")),
    tostring(castPetEntity and castPetEntity:HasAttributes() and castPetEntity:Attributes():GetAttribute("Power")),
    tostring(castPetEntity and castPetEntity:HasPetPstID() and castPetEntity:PetPstID():GetPstID()),
    tostring(castPetEntity and castPetEntity:HasPetPstID() and castPetEntity:PetPstID():GetTemplateID()),
    tostring(petPstID),
    tostring(skillID)
  }
  if not BattleConst.Kick then
    return true, log
  end
  if not castPetEntity then
    return false, log
  end
  local localSkillID = castPetEntity:SkillInfo():GetActiveSkillID()
  local extraActiveSkillIDList = castPetEntity:SkillInfo():GetExtraActiveSkillIDList()
  if extraActiveSkillIDList and table.icontains(extraActiveSkillIDList, skillID) then
    localSkillID = skillID
  else
    local variantActiveSkillInfo = castPetEntity:SkillInfo():GetVariantActiveSkillInfo()
    if variantActiveSkillInfo then
      local variantList = variantActiveSkillInfo[localSkillID]
      if variantList and table.icontains(variantList, skillID) then
        localSkillID = skillID
      end
    end
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(localSkillID, castPetEntity)
  local subSkillList = skillConfigData:GetSubSkillIDList()
  local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  if cfgExtraParam then
    if 0 < #subSkillList and table.icontains(subSkillList, skillID) then
      localSkillID = skillID
      skillConfigData = configService:GetSkillConfigData(localSkillID, castPetEntity)
      local trapID = cfgExtraParam[SkillTriggerTypeExtraParam.TrapID]
      if trapID then
        local trapServiceLogic = self._world:GetService("TrapLogic")
        if trapServiceLogic:IsTrapCovered(trapID, petPstID) then
          return false, log
        end
      end
    end
    local paramHPVal = cfgExtraParam[SkillTriggerTypeExtraParam.HPValPercent]
    if paramHPVal then
      local eTeam = castPetEntity:Pet():GetOwnerTeamEntity()
      local maxHPPercent = paramHPVal[1]
      local remainHPPercent = paramHPVal[2]
      local casterCurrentHP = eTeam:Attributes():GetCurrentHP()
      local casterMaxHP = eTeam:Attributes():CalcMaxHp()
      local requiredMaxVal = math.ceil(casterMaxHP * maxHPPercent)
      local remainHP = casterCurrentHP - requiredMaxVal
      if remainHP <= 0 then
        return false, log, BattleUIActiveSkillCannotCastReason.HPValPercent
      end
      local requiredRemainHP = math.ceil(remainHP * remainHPPercent)
      if remainHP <= requiredRemainHP then
        return false, log, BattleUIActiveSkillCannotCastReason.HPValPercent
      end
    end
    local paramHPVal = cfgExtraParam[SkillTriggerTypeExtraParam.HPValPercent]
    if paramHPVal then
      local maxHPPercent = paramHPVal[1]
      local remainHPPercent = paramHPVal[2]
      local casterCurrentHP = castPetEntity:Attributes():GetCurrentHP()
      local casterMaxHP = castPetEntity:Attributes():CalcMaxHp()
      local requiredMaxVal = casterMaxHP * maxHPPercent
      local remainHP = casterCurrentHP - requiredMaxVal
      if remainHP <= 0 then
        return false, log, BattleUIActiveSkillCannotCastReason.HPValPercent
      end
      local requiredRemainHP = remainHP * remainHPPercent
      if remainHP <= requiredRemainHP then
        return false, log, BattleUIActiveSkillCannotCastReason.HPValPercent
      end
    end
    local param = cfgExtraParam[SkillTriggerTypeExtraParam.Pet1702361InTeam]
    if param and not castPetEntity:BuffComponent():HasFlag(BuffFlags.Pet1702361NotLinkLine) then
      return false, log, BattleUIActiveSkillCannotCastReason.Pet1702361InTeam
    end
  end
  if localSkillID ~= skillID then
    return false, log, BattleUIActiveSkillCannotCastReason.NotReady
  end
  local ready = self:GetPetSkillReadyAttr(castPetEntity, skillID)
  local canOverdraw = castPetEntity:HasBuffFlag(BuffFlags.CanOverdraw)
  if canOverdraw then
    ready = 1
  end
  if ready == 0 then
    return false, log, BattleUIActiveSkillCannotCastReason.NotReady
  end
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local legendPower = castPetEntity:Attributes():GetAttribute("LegendPower")
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    costLegendPower = self:_GetLegendPowerConstByExtraParam(costLegendPower, skillConfigData, petPstID)
    if legendPower < costLegendPower then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    local extraParam = skillConfigData:GetSkillTriggerExtraParam()
    local buffEffectType = extraParam.buffEffectType
    local blsvc = self._world:GetService("BuffLogic")
    local currentVal = blsvc:GetBuffLayer(castPetEntity, buffEffectType)
    local requiredVal = skillConfigData:GetSkillTriggerParam()
    if currentVal < requiredVal then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.AlchemyEnergy then
    local alchemyPower = castPetEntity:Attributes():GetAttribute("AlchemyPower")
    local costAlchemyPower = skillConfigData:GetSkillTriggerParam()
    if alchemyPower < costAlchemyPower then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
    local colorPalette = castPetEntity:ColorPalette()
    if colorPalette and not colorPalette:IsSatisfy() then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  else
    local power = self:GetPetPowerAttr(castPetEntity, skillID)
    if power ~= 0 and canOverdraw == false then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  end
  return true, log
end

function UtilDataServiceShare:IsSkillDisabledWhenCasterIsTeamLeader(petPstID, skillID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false
  end
  local configDecoSvc = self._world:GetService("ConfigDecoration")
  local skillConfig = configDecoSvc:GetLatestEffectParamArray(castPetEntity:GetID(), skillID)
  for index, config in ipairs(skillConfig) do
    if config:IsDisableTeamLeaderActiveSkill() then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:IsPetCurrentTeamLeader(petPstID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity or not castPetEntity:HasPet() then
    return false
  end
  local eTeam = castPetEntity:Pet():GetOwnerTeamEntity()
  if not eTeam or not eTeam:HasTeam() then
    return false
  end
  local cTeam = eTeam:Team()
  local teamLeaderPstID = cTeam:GetTeamLeaderPetPstID()
  return petPstID == teamLeaderPstID
end

function UtilDataServiceShare:CheckCanCastActiveSkillBySwapPetTeamOrder(petPstID, skillID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false
  end
  local configDecoSvc = self._world:GetService("ConfigDecoration")
  local skillConfig = configDecoSvc:GetLatestEffectParamArray(castPetEntity:GetID(), skillID)
  for index, config in ipairs(skillConfig) do
    if config:GetEffectType() == SkillEffectType.SwapPetTeamOrder and config:GetTargetOrderType() == SwapPetTeamOrderType.CASTER_SELECT_TEAM_POS then
      local validSelectPos, validSelectTarget
      local cTeam = castPetEntity:Pet():GetOwnerTeamEntity():Team()
      local selected = cTeam:GetSelectedTeamOrderPosition()
      local isSelfTeamLeader = cTeam:GetTeamLeaderEntity():GetID() == castPetEntity:GetID()
      local GLOBALteamOrder = cTeam:GetTeamOrder()
      validSelectPos = 0 < selected and selected <= #GLOBALteamOrder
      local pstID = GLOBALteamOrder[selected]
      local selectedPetEntity = pstID and cTeam:GetPetEntityByPetPstID(pstID)
      if selectedPetEntity and not selectedPetEntity:PetPstID():IsHelpPet() then
        validSelectTarget = not isSelfTeamLeader or not selectedPetEntity:BuffComponent():HasFlag(BuffFlags.SealedCurse)
      end
      return validSelectPos and validSelectTarget
    end
  end
  return true
end

function UtilDataServiceShare:IsSilenceState(petPstID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false
  end
  local isSilence = castPetEntity:BuffComponent():HasFlag(BuffFlags.Silence)
  return isSilence
end

function UtilDataServiceShare:IsPuzzleState()
  local previewPuzzleSvc = self._world:GetService("PreviewPuzzle")
  return previewPuzzleSvc:IsPuzzleState()
end

function UtilDataServiceShare:IsBuffSetActiveSkillCanNotReady(petPstID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false
  end
  local blsvc = self._world:GetService("BuffLogic")
  local canNotReady, reason = blsvc:IsPetActiveSkillCanNotReadyByBuff(castPetEntity)
  return canNotReady, reason
end

function UtilDataServiceShare:IsBuffSetExtraActiveSkillCanNotReady(petPstID, skillID)
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false
  end
  local blsvc = self._world:GetService("BuffLogic")
  local canNotReady, reason = blsvc:IsPetExtraActiveSkillCanNotReadyByBuff(castPetEntity, skillID)
  return canNotReady, reason
end

function UtilDataServiceShare:IsPosHasSpTrap(pos, trapType)
  local traps = self:GetTrapsAtPos(pos)
  if traps then
    local hasBadGrid = false
    for index, e in ipairs(traps) do
      if e:Trap():GetTrapType() == trapType then
        return true
      end
    end
  end
  return false
end

function UtilDataServiceShare:GetCurBoardMaxX()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetCurBoardMaxX()
end

function UtilDataServiceShare:GetCurBoardMaxY()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetCurBoardMaxY()
end

function UtilDataServiceShare:GetCurBoardMaxLen()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetCurBoardMaxLen()
end

function UtilDataServiceShare:GetCurBoardGapTiles()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetGapTiles()
end

function UtilDataServiceShare:GetCurBoardCenterPos()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetBoardCenterPos()
end

function UtilDataServiceShare:_GetLegendPowerConstByExtraParam(defaultCost, skillConfigData, castSkillPetPstID)
  local cost = defaultCost
  local castPetEntity = self:GetEntityByPstID(castSkillPetPstID)
  if castPetEntity and skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    local pickCmpt = castPetEntity:ActiveSkillPickUpComponent()
    pickCmpt = pickCmpt or castPetEntity:PreviewPickUpComponent()
    if cfgExtraParam and pickCmpt then
      if cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
        if pickCmpt:HasPickExtraParam(SkillTriggerTypeExtraParam.PickPosNoCfgTrap) then
          cost = cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
        end
      elseif cfgExtraParam[SkillTriggerTypeExtraParam.CostPickUpUIAndTrap] then
        cost = self:GetCasterPickUpExtraChainPowerCount(castPetEntity, skillConfigData:GetID())
      end
    end
  end
  return cost
end

function UtilDataServiceShare:GetFeatureUiInitData()
  local featureInitList = {}
  local boardEntity = self._world:GetBoardEntity()
  local logicFeatureCmpt = boardEntity:LogicFeature()
  if logicFeatureCmpt then
    local typeList = logicFeatureCmpt:GetFeatureTypeList()
    for i, featureType in ipairs(typeList) do
      local featureData = logicFeatureCmpt:GetFeatureData(featureType)
      if featureData then
        table.insert(featureInitList, featureData)
      end
    end
  end
  return featureInitList
end

function UtilDataServiceShare:IsUseCurHPInitRedHP(entity)
  local useCur = entity:Attributes():GetAttribute("InitRedHPUseCurHP")
  if useCur then
    return true
  end
  return false
end

function UtilDataServiceShare:GetCurrentLogicHP(entity)
  local v = 0
  if entity:HasPet() then
    local matchType = self._world:MatchType()
    if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
      v = entity:Pet():GetOwnerTeamEntity():Attributes():GetCurrentHP()
    else
      v = entity:Attributes():GetCurrentHP()
    end
  else
    v = entity:Attributes():GetCurrentHP()
  end
  return v
end

function UtilDataServiceShare:GetCurrentLogicMaxHP(entity)
  local v = 0
  if entity:HasPet() then
    local matchType = self._world:MatchType()
    if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
      v = entity:Pet():GetOwnerTeamEntity():Attributes():CalcMaxHp()
    else
      v = entity:Attributes():CalcMaxHp()
    end
  else
    v = entity:Attributes():CalcMaxHp()
  end
  return v
end

function UtilDataServiceShare:OnCalcTargetPosMonsterBuffEffectMatch(targetPos, buffEffect, casterEntity)
  local targetMonster
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasSuperEntity() then
      casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
    end
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
    local enemyPos = enemyEntity:GetGridPosition()
    if targetPos == enemyPos then
      targetMonster = enemyEntity
    end
  else
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      if not e:HasDeadMark() then
        local pos = e:GetGridPosition()
        local bodyArea = e:BodyArea()
        local bodyAreaList = bodyArea:GetArea()
        for _, area in ipairs(bodyAreaList) do
          if area.x + pos.x == targetPos.x and area.y + pos.y == targetPos.y then
            targetMonster = e
            break
          end
        end
      end
      if targetMonster then
        break
      end
    end
  end
  if not targetMonster then
    return false
  end
  local buffCmp = targetMonster:BuffComponent()
  if not buffCmp then
    return false
  end
  if buffCmp:HasBuffEffect(buffEffect) then
    return true
  end
  return false
end

function UtilDataServiceShare:IsPosHasTrapByTrapID(pos, trapID)
  local traps = self:GetTrapsAtPos(pos)
  if traps then
    for _, trap in ipairs(traps) do
      if trap:TrapID():GetTrapID() == trapID then
        return true
      end
    end
  end
  return false
end

function UtilDataServiceShare:GetTrapAtPosByTrapID(pos, trapID)
  local traps = self:GetTrapsAtPos(pos)
  if traps then
    for _, trap in ipairs(traps) do
      if trap:TrapID():GetTrapID() == trapID then
        return trap:GetID()
      end
    end
  end
end

function UtilDataServiceShare:GetAllTrapEntitiesAtPosByTrapID(pos, trapID)
  local t = {}
  local traps = self:GetTrapsAtPos(pos)
  if traps then
    for _, trap in ipairs(traps) do
      if trap:TrapID():GetTrapID() == trapID then
        table.insert(t, trap)
      end
    end
  end
  return t
end

function UtilDataServiceShare:GetTrapByID(trapID)
  local idList = {}
  if type(trapID) == "number" then
    idList[#idList + 1] = trapID
  elseif type(trapID) == "table" then
    idList = trapID
  end
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local entityList = {}
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    local trapComponent = trapEntity:Trap()
    local tID = trapComponent:GetTrapID()
    if table.icontains(idList, tID) then
      table.insert(entityList, trapEntity)
    end
  end
  return entityList
end

function UtilDataServiceShare:GetReplicaBoardMultiGridEntityData()
  local boardEntity = self._world:GetBoardEntity()
  local boardMultiComponent = boardEntity:BoardMulti()
  local gridEntityData = boardMultiComponent:GetGridEntityData()
  if not gridEntityData then
    return
  end
  local replica = {}
  for k, v in pairs(gridEntityData) do
    replica[k] = v
  end
  return replica
end

function UtilDataServiceShare:GetMultiBoardInfo(boardIndex)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  return levelConfigData:GetMultiBoardInfo(boardIndex)
end

function UtilDataServiceShare:IsValidPiecePosMultiBoard(boardIndex, pos)
  local eBoard = self._world:GetBoardEntity()
  local cBoard = eBoard:BoardMulti()
  return cBoard:GetPieceData(pos, boardIndex)
end

function UtilDataServiceShare:GetCloneMultiBoardGridPos()
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:BoardMulti()
  return boardCmpt:CloneBoardPosList()
end

function UtilDataServiceShare:GetExtraBoardPosList()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = {}
  local extraBoard = boardServiceLogic:GetExtraBoardPosList()
  for i = 1, table.count(extraBoard) do
    local posWork = Vector2(extraBoard[i][1], extraBoard[i][2])
    table.insert(posList, posWork)
  end
  return posList
end

function UtilDataServiceShare:IsExtraBoardPos(pos)
  local posList = self:GetExtraBoardPosList()
  return table.intable(posList, pos)
end

function UtilDataServiceShare:GetSkillEffectTargetSelectionMode(skillID, skillEffectParam)
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local skillEffectType = skillEffectParam:GetEffectType()
  local effectScopeFilterParam = skillEffectParam:GetScopeFilterParam()
  local finalScopeFilterParam = effectScopeFilterParam:IsDefault() and scopeFilterParam or effectScopeFilterParam
  return finalScopeFilterParam:GetTargetSelectionMode()
end

function UtilDataServiceShare:IsBadGridPos(pos)
  local hasBadGrid = false
  local traps = self:GetTrapsAtPos(pos)
  if traps then
    for index, e in ipairs(traps) do
      if e:Trap():GetTrapType() == TrapType.BadGrid then
        hasBadGrid = true
        break
      end
    end
  end
  return hasBadGrid
end

function UtilDataServiceShare:IsAIAttachState(entity, round, waveIndex)
  if not entity then
    return false
  end
  if not entity:HasAI() then
    return false
  end
  return entity:AI():IsAttachState(round, waveIndex)
end

function UtilDataServiceShare:IsPetCastActiveSkill(teamEntity)
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  local activeSkillData = BattleSkillCfg(activeSkillID)
  local isPetActiveSkill = activeSkillData.Type == SkillType.Active
  return isPetActiveSkill
end

function UtilDataServiceShare:GetEntityAttributeByName(entity, attributeName)
  local attributeCmpt = entity:Attributes()
  if not attributeCmpt then
    Log.fatal("can not find attr cmpt ")
    return nil
  end
  local attributeVal = attributeCmpt:GetAttribute(attributeName)
  return attributeVal
end

function UtilDataServiceShare:GetEntityAttack(entity)
  local attributeCmpt = entity:Attributes()
  if not attributeCmpt then
    Log.fatal("can not find attr cmpt ")
    return nil
  end
  return attributeCmpt:GetAttack()
end

function UtilDataServiceShare:GetEntityBuffValue(entity, key)
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    Log.fatal("entity not have buff cmpt")
    return nil
  end
  local buffValue = buffCmpt:GetBuffValue(key)
  if not buffValue then
    return nil
  end
  return buffValue
end

function UtilDataServiceShare:OnCheckEntityHasBuffFlag(entity, BuffFlag)
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return nil
  end
  local hasBuffFlag = buffCmpt:HasFlag(BuffFlag)
  if hasBuffFlag then
    return true
  end
  return false
end

function UtilDataServiceShare:GetEntityAIRuntimeData(entity, key)
  local aiCmpt = entity:AI()
  if not aiCmpt then
    return nil
  end
  local runTimeData = aiCmpt:GetRuntimeData(key)
  return runTimeData
end

function UtilDataServiceShare:GetTrapCurseTowerState(entity)
  local curseTowerCmpt = entity:CurseTower()
  if curseTowerCmpt == nil then
    return nil
  end
  local state = curseTowerCmpt:GetTowerState()
  return state
end

function UtilDataServiceShare:GetPieceType(pos)
  local eBoard = self._world:GetBoardEntity()
  local cBoard = eBoard:Board()
  return cBoard:GetPieceData(pos)
end

function UtilDataServiceShare:GetBuffLayer(entity, buffEffectType)
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffLayer = buffLogicService:GetBuffLayer(entity, buffEffectType)
  return buffLayer
end

function UtilDataServiceShare:HasBuffEffect(entity, buffEffectType)
  local buffCmp = entity:BuffComponent()
  return buffCmp and buffCmp:HasBuffEffect(buffEffectType)
end

function UtilDataServiceShare:IsEntityLogicDead(entity)
  return entity:HasDeadMark()
end

function UtilDataServiceShare:IsPetExtraActiveSkill(petEntity, skillID)
  if petEntity then
    local skillInfoCmpt = petEntity:SkillInfo()
    local extraSkillIDList = skillInfoCmpt:GetExtraActiveSkillIDList()
    if extraSkillIDList then
      for extraSkillIndex, extraSkillID in ipairs(extraSkillIDList) do
        if extraSkillID == skillID then
          return true, extraSkillIndex
        end
      end
    end
  end
  return false
end

function UtilDataServiceShare:IsPetVariantActiveSkillUseBuffLayer(petEntity, skillID)
  if petEntity then
    local localSkillID = petEntity:SkillInfo():GetActiveSkillID()
    local skillInfoCmpt = petEntity:SkillInfo()
    local variantActiveSkillInfo = skillInfoCmpt:GetVariantActiveSkillInfo()
    if variantActiveSkillInfo then
      local variantList = variantActiveSkillInfo[localSkillID]
      if variantList and table.icontains(variantList, skillID) then
        local configSvc = self._world:GetService("Config")
        local skillConfigData = configSvc:GetSkillConfigData(skillID, petEntity)
        if skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
          return true, skillID
        end
      end
    end
  end
  return false
end

function UtilDataServiceShare:SetPetSkillReadyAttr(petEntity, ready, skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    local isUseBuffLayerVariantSkill, variantIndex = self:IsPetVariantActiveSkillUseBuffLayer(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "Ready" .. tostring(extraSkillIndex)
        attr:SetSimpleAttribute(extraKey, ready)
      end
    elseif isUseBuffLayerVariantSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "Ready" .. tostring(variantIndex)
        attr:SetSimpleAttribute(extraKey, ready)
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        attr:Modify("Ready", ready)
      end
    end
  end
end

function UtilDataServiceShare:GetPetSkillReadyAttr(petEntity, skillID)
  Log.fatal("GetPetSkillReadyAttr SkillID:", skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    local isUseBuffLayerVariantSkill, variantIndex = self:IsPetVariantActiveSkillUseBuffLayer(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local readyKey = "Ready" .. tostring(extraSkillIndex)
        local ready = attr:GetAttribute(readyKey)
        ready = ready or 0
        return ready
      end
    elseif isUseBuffLayerVariantSkill then
      local attr = petEntity:Attributes()
      if attr then
        local readyKey = "Ready" .. tostring(variantIndex)
        local ready = attr:GetAttribute(readyKey)
        ready = ready or 0
        return ready
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        local ready = attr:GetAttribute("Ready")
        return ready
      end
    end
  end
end

function UtilDataServiceShare:ChangePetActiveSkillReady(e, ready, skillID)
  local buffSvc = self._world:GetService("BuffLogic")
  buffSvc:ChangePetActiveSkillReady(e, ready, skillID)
end

function UtilDataServiceShare:GetPetPowerAttr(petEntity, skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "Power" .. tostring(extraSkillIndex)
        local power = attr:GetAttribute(extraKey)
        power = power or 0
        return power
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        local power = attr:GetAttribute("Power")
        return power
      end
    end
  end
end

function UtilDataServiceShare:SetPetPowerAttr(petEntity, power, skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "Power" .. tostring(extraSkillIndex)
        attr:SetSimpleAttribute(extraKey, power)
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        attr:Modify("Power", power)
      end
    end
  end
end

function UtilDataServiceShare:GetPetMaxPowerAttr(petEntity, skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "MaxPower" .. tostring(extraSkillIndex)
        local maxPower = attr:GetAttribute(extraKey)
        maxPower = maxPower or 0
        return maxPower
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        local maxPower = attr:GetAttribute("MaxPower")
        return maxPower
      end
    end
  end
end

function UtilDataServiceShare:SetPetMaxPowerAttr(petEntity, maxPower, skillID)
  if petEntity then
    local isExtraSkill, extraSkillIndex = self:IsPetExtraActiveSkill(petEntity, skillID)
    if isExtraSkill then
      local attr = petEntity:Attributes()
      if attr then
        local extraKey = "MaxPower" .. tostring(extraSkillIndex)
        attr:SetSimpleAttribute(extraKey, maxPower)
      end
    else
      local attr = petEntity:Attributes()
      if attr then
        attr:Modify("MaxPower", maxPower)
      end
    end
  end
end

function UtilDataServiceShare:GetPetLegendPowerAttr(petEntity, skillID)
  if petEntity then
    local attr = petEntity:Attributes()
    if attr then
      local legendPower = attr:GetAttribute("LegendPower")
      return legendPower
    end
  end
  return 0
end

function UtilDataServiceShare:GetPreviousReadyRoundCount(petPstID)
  local petEntity = self:GetEntityByPstID(petPstID)
  if petEntity then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    if teamEntity then
      local readyCount = teamEntity:ActiveSkill():GetPreviousReadyRoundCount(petEntity:GetID())
      return readyCount
    end
  end
  return 0
end

function UtilDataServiceShare:FindSyncMonsterTargetList(entity)
  if not entity:HasMonsterID() then
    return {}
  end
  local syncType = entity:MonsterID():GetDamageSyncFindType()
  local paramID = entity:MonsterID():GetDamageSyncMonsterID()
  local monsterEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local retEntity = {}
  for _, e in ipairs(monsterEntities) do
    local monsterIDCmpt = e:MonsterID()
    if syncType == MonsterSyncFindType.MonsterID then
      if monsterIDCmpt:GetMonsterID() == paramID then
        table.insert(retEntity, e)
      end
    elseif syncType == MonsterSyncFindType.MonsterClassID and monsterIDCmpt:GetMonsterClassID() == paramID then
      table.insert(retEntity, e)
    end
  end
  return retEntity
end

function UtilDataServiceShare:FindMonsterByMonsterID(monsterID)
  local monsterEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local retEntity = {}
  for _, e in ipairs(monsterEntities) do
    local monsterIDCmpt = e:MonsterID()
    if monsterIDCmpt:GetMonsterClassID() == monsterID then
      table.insert(retEntity, e)
    end
  end
  return retEntity
end

function UtilDataServiceShare:GetMapByPosition()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local mapByPosition = boardComponent:GetMapByPosition()
  return mapByPosition
end

function UtilDataServiceShare:CheckForceMoveImmunity(entity)
  local buffSvc = self._world:GetService("BuffLogic")
  return buffSvc:CheckForceMoveImmunity(entity)
end

function UtilDataServiceShare:IsEntityForceMovementTarget(e, includeMultiSize, includeTrap)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if includeTrap and e:HasTrapID() then
      return true
    end
    return e:HasTeam() or e:HasPet()
  end
  local isTrap = false
  if not e:HasMonsterID() then
    if includeTrap and e:HasTrapID() then
      isTrap = true
    else
      return false
    end
  end
  if not isTrap then
    local cfgsvc = self._world:GetService("Config")
    local monsterConfigData = cfgsvc:GetMonsterConfigData()
    local monsterID = e:MonsterID():GetMonsterID()
    if monsterConfigData:IsBoss(monsterID) then
      return false
    end
  end
  if not includeMultiSize and e:BodyArea():GetAreaCount() ~= 1 then
    return false
  end
  local buffComponent = e:BuffComponent()
  if buffComponent and buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
    return false
  end
  local bufflsvc = self._world:GetService("BuffLogic")
  if bufflsvc:CheckForceMoveImmunity(e) then
    return false
  end
  return true
end

function UtilDataServiceShare:ScanTrapOnBoard()
  local trapTemplateID = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, entity in ipairs(globalTrapEntities) do
    local trapID = entity:TrapID():GetTrapID()
    if not entity:HasDeadMark() and Cfg.cfg_trap_scan[trapID] then
      table.insert(trapTemplateID, trapID)
    end
  end
  return trapTemplateID
end

function UtilDataServiceShare:ScanTrapInMatch()
  local trapTemplateID = {}
  local trapIDInMatch = self._world:BattleStat():GetAllScanTrapIDInMatch()
  for _, id in ipairs(trapIDInMatch) do
    if Cfg.cfg_trap_scan[id] then
      table.insert(trapTemplateID, id)
    end
  end
  return trapTemplateID
end

function UtilDataServiceShare:GetScanSelection()
  local boardEntity = self._world:GetBoardEntity()
  local cLogicFeature = boardEntity:LogicFeature()
  local info = {
    skillType = cLogicFeature:GetScanActiveSkillType(),
    trapID = cLogicFeature:GetScanTrapID()
  }
  return info
end

function UtilDataServiceShare:GetLocalMatchPetByTemplateID(tid)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local cTeam = eLocalTeam:Team()
  local pets = cTeam:GetTeamPetEntities()
  for _, e in ipairs(pets) do
    local petPstID = e:PetPstID():GetTemplateID()
    if tid == petPstID then
      return e:MatchPet():GetMatchPet()
    end
  end
end

function UtilDataServiceShare:IsPosCanConvertGridElement(pos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetCanConvertGridElement(pos)
end

function UtilDataServiceShare:CalcZhongxuForceMovementCostByPick(casterEntity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    local pickCmpt = casterEntity:ActiveSkillPickUpComponent()
    pickCmpt = pickCmpt or casterEntity:PreviewPickUpComponent()
    if cfgExtraParam and pickCmpt and cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
      local costParamTb = cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep]
      local recordBuffCmpt = casterEntity:BuffComponent()
      local buffValueKey = "CurRoundForceMoveStep"
      local curRoundForceMoveStep = recordBuffCmpt:GetBuffValue(buffValueKey) or 0
      local eachMoveCostParam = costParamTb[1]
      local trapMoveCostExtraParam = costParamTb[2]
      local specificTrapID = costParamTb[3]
      local curLegendPower = casterEntity:Attributes():GetAttribute("LegendPower")
      local allPickGrids = pickCmpt:GetAllValidPickUpGridPos()
      if allPickGrids and #allPickGrids == 2 then
        local firstPickGrid = allPickGrids[1]
        local secondPickGrid = allPickGrids[2]
        local foundTrapEntity, foundMonsterEntity, foundEnemyTeamEntity
        local centerPos = firstPickGrid
        local traps = self:GetTrapsAtPos(centerPos)
        if traps then
          for index, e in ipairs(traps) do
            local trapId = e:Trap():GetTrapID()
            if specificTrapID == trapId then
              foundTrapEntity = e
              break
            end
          end
        end
        local moveEntity
        local isTrap = false
        if foundTrapEntity then
          isTrap = true
          moveEntity = foundTrapEntity
        elseif self._world:MatchType() == MatchType.MT_BlackFist then
          if casterEntity:HasPet() then
            local enemy = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
            local enemyPos = enemy:GetGridPosition()
            if enemyPos == centerPos then
              foundEnemyTeamEntity = enemy
              moveEntity = foundEnemyTeamEntity
            end
          end
        else
          local utilScopeSvc = self._world:GetService("UtilScopeCalc")
          local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(centerPos)
          if isHasMonster then
            local monsterEntity = self._world:GetEntityByID(monsterID)
            if monsterEntity then
              foundMonsterEntity = monsterEntity
              moveEntity = foundMonsterEntity
            end
          end
        end
        if moveEntity then
          local moveDirAnti, moveStep = self:_CalcFroceMoveDirByTargetAndPick(moveEntity, firstPickGrid, secondPickGrid, 0, true)
          local totalCost = 0
          for i = 1, moveStep do
            local eachCost = eachMoveCostParam
            if isTrap then
              eachCost = trapMoveCostExtraParam
            end
            local curStep = curRoundForceMoveStep + i
            local curStepCost = eachCost * curStep
            totalCost = totalCost + curStepCost
          end
          return totalCost, moveStep
        end
      end
    end
  end
  return -1
end

function UtilDataServiceShare:CalcZhongxuForceMovementMoveStepByPick(casterEntity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    local pickCmpt = casterEntity:ActiveSkillPickUpComponent()
    pickCmpt = pickCmpt or casterEntity:PreviewPickUpComponent()
    if cfgExtraParam and pickCmpt and cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
      local costParamTb = cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep]
      local recordBuffCmpt = casterEntity:BuffComponent()
      local buffValueKey = "CurRoundForceMoveStep"
      local curRoundForceMoveStep = recordBuffCmpt:GetBuffValue(buffValueKey) or 0
      local eachMoveCostParam = costParamTb[1]
      local trapMoveCostExtraParam = costParamTb[2]
      local specificTrapID = costParamTb[3]
      local curLegendPower = casterEntity:Attributes():GetAttribute("LegendPower")
      local allPickGrids = pickCmpt:GetAllValidPickUpGridPos()
      if allPickGrids and #allPickGrids == 2 then
        local firstPickGrid = allPickGrids[1]
        local secondPickGrid = allPickGrids[2]
        local foundTrapEntity, foundMonsterEntity, foundEnemyTeamEntity
        local centerPos = firstPickGrid
        local traps = self:GetTrapsAtPos(centerPos)
        if traps then
          for index, e in ipairs(traps) do
            local trapId = e:Trap():GetTrapID()
            if specificTrapID == trapId then
              foundTrapEntity = e
              break
            end
          end
        end
        local moveEntity
        local isTrap = false
        if foundTrapEntity then
          isTrap = true
          moveEntity = foundTrapEntity
        elseif self._world:MatchType() == MatchType.MT_BlackFist then
          if casterEntity:HasPet() then
            local enemy = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
            local enemyPos = enemy:GetGridPosition()
            if enemyPos == centerPos then
              foundEnemyTeamEntity = enemy
              moveEntity = foundEnemyTeamEntity
            end
          end
        else
          local utilScopeSvc = self._world:GetService("UtilScopeCalc")
          local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(centerPos)
          if isHasMonster then
            local monsterEntity = self._world:GetEntityByID(monsterID)
            if monsterEntity then
              foundMonsterEntity = monsterEntity
              moveEntity = foundMonsterEntity
            end
          end
        end
        if moveEntity then
          local moveDirAnti, moveStep = self:_CalcFroceMoveDirByTargetAndPick(moveEntity, firstPickGrid, secondPickGrid, 0, true)
          local totalCost = 0
          for i = 1, moveStep do
            local eachCost = eachMoveCostParam
            if isTrap then
              eachCost = trapMoveCostExtraParam
            end
            local curStep = curRoundForceMoveStep + i
            local curStepCost = eachCost * curStep
            totalCost = totalCost + curStepCost
          end
          return totalCost
        end
      end
    end
  end
  return -1
end

function UtilDataServiceShare:CalcZhongxuForceMovementMinCost(casterEntity, skillID, moveStepNotRecoreded, forAutoFight)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if cfgExtraParam and cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
      local costParamTb = cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep]
      local recordBuffCmpt = casterEntity:BuffComponent()
      local buffValueKey = "CurRoundForceMoveStep"
      local curRoundForceMoveStep = recordBuffCmpt:GetBuffValue(buffValueKey) or 0
      if moveStepNotRecoreded then
        curRoundForceMoveStep = curRoundForceMoveStep + moveStepNotRecoreded
      end
      local eachMoveCostParam = costParamTb[1]
      local trapMoveCostExtraParam = costParamTb[2]
      local specificTrapID = costParamTb[3]
      local moveStep = 1
      local totalCost = 0
      for i = 1, moveStep do
        local curStep = curRoundForceMoveStep + i
        local eachCost = eachMoveCostParam
        if forAutoFight and trapMoveCostExtraParam then
          eachCost = trapMoveCostExtraParam
        end
        local curStepCost = eachCost * curStep
        totalCost = totalCost + curStepCost
      end
      return totalCost
    end
  end
  return -1
end

function UtilDataServiceShare:CalcMinCostLegendPowerByExtraParam(entity, defaultCost, skillConfigData, zhongxuForceMoveStep, forAutoFight)
  local cost = defaultCost
  if skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if cfgExtraParam then
      if cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
        cost = self:CalcZhongxuForceMovementMinCost(entity, skillConfigData:GetID(), zhongxuForceMoveStep, forAutoFight)
        if cost < 0 then
          cost = defaultCost
        end
      end
      if cfgExtraParam[SkillTriggerTypeExtraParam.CostPickUpUIAndTrap] then
        cost = self:CalcYiSiTaWanCastActiveSkillMinimum(entity, skillConfigData:GetID(), forAutoFight)
      end
    end
  end
  return cost
end

function UtilDataServiceShare:_CalcFroceMoveDirByTargetAndPick(targetEntity, pickPos, dirPos, defaultStep, isCalcStepByPick)
  local dir
  local step = defaultStep
  local targetPos = targetEntity:GetGridPosition()
  local bodyArea = targetEntity:BodyArea():GetArea()
  if bodyArea then
    if #bodyArea == 1 then
      dir = dirPos - pickPos
      step = math.abs(dir.x) + math.abs(dir.y)
      if dir.x > 0 then
        dir.x = 1
      elseif dir.x < 0 then
        dir.x = -1
      end
      if dir.y > 0 then
        dir.y = 1
      elseif dir.y < 0 then
        dir.y = -1
      end
    else
      local upMaxY, downMinY, rightMaxX, leftMinX
      for index, off in ipairs(bodyArea) do
        local bodyPos = targetPos + off
        if not upMaxY then
          upMaxY = bodyPos.y
        elseif upMaxY < bodyPos.y then
          upMaxY = bodyPos.y
        end
        if not downMinY then
          downMinY = bodyPos.y
        elseif downMinY > bodyPos.y then
          downMinY = bodyPos.y
        end
        if not rightMaxX then
          rightMaxX = bodyPos.x
        elseif rightMaxX < bodyPos.x then
          rightMaxX = bodyPos.x
        end
        if not leftMinX then
          leftMinX = bodyPos.x
        elseif leftMinX > bodyPos.x then
          leftMinX = bodyPos.x
        end
      end
      if upMaxY < dirPos.y then
        dir = Vector2.up
        if isCalcStepByPick then
          step = dirPos.y - upMaxY
        end
      elseif downMinY > dirPos.y then
        dir = Vector2.down
        if isCalcStepByPick then
          step = downMinY - dirPos.y
        end
      elseif rightMaxX < dirPos.x then
        dir = Vector2.right
        if isCalcStepByPick then
          step = dirPos.x - rightMaxX
        end
      elseif leftMinX > dirPos.x then
        dir = Vector2.left
        if isCalcStepByPick then
          step = leftMinX - dirPos.x
        end
      end
    end
  end
  if dir.x > 0 then
    dir.x = 1
  elseif dir.x < 0 then
    dir.x = -1
  end
  if dir.y > 0 then
    dir.y = 1
  elseif dir.y < 0 then
    dir.y = -1
  end
  dir = dir * -1
  return dir, step
end

function UtilDataServiceShare:GetPrismCustomScopeConfig(entityID)
  local entity = self._world:GetEntityByID(entityID)
  if not entity then
    return
  end
  if not entity:HasTrap() then
    return
  end
  local cTrap = entity:Trap()
  if not cTrap:IsPrismGrid() then
    return
  end
  return cTrap:GetCustomPrismGridScopeType(), cTrap:GetCustomPrismGridScopeParam()
end

function UtilDataServiceShare:CalcZhongxuForceMovementNextMinCostForUI(entity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, entity)
  local minCost = skillConfigData:GetSkillTriggerParam()
  local cost, zhongxuForceMoveStep = self:CalcZhongxuForceMovementCostByPick(entity, skillID)
  if cost < 0 then
    cost = minCost
  end
  if zhongxuForceMoveStep < 0 then
    zhongxuForceMoveStep = 0
  end
  minCost = self:CalcMinCostLegendPowerByExtraParam(entity, minCost, skillConfigData, zhongxuForceMoveStep, false)
  return minCost
end

function UtilDataServiceShare:GetSummonMeantimeLimitEntityID(trapID)
  local battleFlags = self._world:BattleFlags()
  local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(trapID)
  return entityIDList
end

function UtilDataServiceShare:IsPieceRefreshTypeDestroy()
  local affixService = self._world:GetService("Affix")
  local refreshType = affixService:ReplacePieceRefreshType()
  if refreshType == PieceRefreshType.Destroy then
    return true
  end
  return false
end

function UtilDataServiceShare:GetReplicaSpliceGridEntityData()
  local boardEntity = self._world:GetBoardEntity()
  local boardSpliceComponent = boardEntity:BoardSplice()
  local gridEntityData = boardSpliceComponent:GetGridEntityData()
  if not gridEntityData then
    return
  end
  local replica = {}
  for k, v in pairs(gridEntityData) do
    replica[k] = v
  end
  return replica
end

function UtilDataServiceShare:GetReplicaSpliceBoardPieces()
  local boardEntity = self._world:GetBoardEntity()
  local boardSpliceComponent = boardEntity:BoardSplice()
  local replica = {}
  for x, col in pairs(boardSpliceComponent.Pieces) do
    replica[x] = {}
    for y, grid in pairs(col) do
      replica[x][y] = grid
    end
  end
  return replica
end

function UtilDataServiceShare:GetCloneBoardSpliceGridPos()
  local boardEntity = self._world:GetBoardEntity()
  local boardSpliceComponent = boardEntity:BoardSplice()
  return boardSpliceComponent:CloneBoardPosList()
end

function UtilDataServiceShare:GetCurrentTeamSuperChainCount()
  local count = BattleConst.SuperChainCount
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if teamEntity then
    local teamAttr = teamEntity:Attributes()
    if teamAttr then
      local superChainCountAddValue = teamAttr:GetAttribute("SuperChainCountAddValue")
      if superChainCountAddValue then
        count = count + superChainCountAddValue
      end
    end
  end
  return count
end

function UtilDataServiceShare:GetRoundBeginPlayerPos()
  return self._world:BattleStat():GetRoundBeginPlayerPos()
end

function UtilDataServiceShare:GetRenderPieceType(pos)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local gridEntity = renderBoardCmpt:GetGridRenderEntity(pos)
  local pieceType = gridEntity:Piece():GetPieceType()
  return pieceType
end

function UtilDataServiceShare:GetReplicaPushGridEntityData()
  local boardEntity = self._world:GetBoardEntity()
  local boardPushComponent = boardEntity:BoardPush()
  local gridEntityData = boardPushComponent:GetGridEntityData()
  if not gridEntityData then
    return
  end
  local replica = {}
  for k, v in pairs(gridEntityData) do
    replica[k] = v
  end
  return replica
end

function UtilDataServiceShare:GetCloneBoardPushGridPos()
  local boardEntity = self._world:GetBoardEntity()
  local boardPushComponent = boardEntity:BoardPush()
  return boardPushComponent:CloneBoardPosList()
end

function UtilDataServiceShare:GetTrapHPPercentByTrapID(trapID)
  local trapSvc = self._world:GetService("TrapLogic")
  local trapGroup = trapSvc:GetTrapGroup()
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    local trapComponent = trap:Trap()
    if trapComponent and trapComponent:GetTrapID() == trapID then
      local attrCmpt = trap:Attributes()
      local curHP = attrCmpt:GetCurrentHP()
      local maxHP = attrCmpt:CalcMaxHp()
      return math.floor(curHP / maxHP * 100 + 0.5)
    end
  end
  return 0
end

function UtilDataServiceShare:GetMaxYOfColX(colX)
  return self._boardLogicSvc:GetMaxYOfColX(colX)
end

function UtilDataServiceShare:ProcessChianSkillConfig(oriSkillConfigData, entity)
  if not oriSkillConfigData or not entity then
    return oriSkillConfigData
  end
  local attr = entity:Attributes()
  if not attr then
    return oriSkillConfigData
  end
  local skillConfigData = oriSkillConfigData
  local bChange = false
  local buffChangeTargetCount = attr:GetAttribute("BuffChangeChainSkillTargetCount")
  if buffChangeTargetCount and buffChangeTargetCount ~= 0 then
    local chainSkillID = oriSkillConfigData:GetID()
    local configService = self._world:GetService("Config")
    if oriSkillConfigData:GetSkillScopeType() == SkillScopeType.Nearest then
      bChange = true
      skillConfigData = configService:GetSkillConfigData(chainSkillID, entity, true)
      skillConfigData._scopeParamData = skillConfigData._scopeParamData + buffChangeTargetCount
    elseif oriSkillConfigData:GetSkillScopeType() == SkillScopeType.NearestInSquareRing then
      bChange = true
      skillConfigData = configService:GetSkillConfigData(chainSkillID, entity, true)
      skillConfigData._scopeParamData = table.cloneconf(skillConfigData._scopeParamData)
      skillConfigData._scopeParamData[2] = skillConfigData._scopeParamData[2] + buffChangeTargetCount
    end
  end
  local buffExpandSingleChainScope = entity:BuffComponent():GetBuffValue("ExpandSingleChainScope")
  if not bChange and buffExpandSingleChainScope and buffExpandSingleChainScope ~= 0 then
    local chainSkillID = oriSkillConfigData:GetID()
    local configService = self._world:GetService("Config")
    skillConfigData = configService:GetSkillConfigData(chainSkillID, entity, true)
    if oriSkillConfigData:GetSkillScopeType() == SkillScopeType.NearestInSquareRing then
      skillConfigData._scopeParamData = table.cloneconf(skillConfigData._scopeParamData)
    end
  end
  bChange = self:ExpandSingleChainScope(entity, oriSkillConfigData:GetSkillScopeType(), skillConfigData._scopeParamData)
  return skillConfigData
end

function UtilDataServiceShare:ExpandSingleChainScope(entity, skillScopeType, scopeParamData)
  if not scopeParamData then
    return false
  end
  local buffExpandSingleChainScope = entity:BuffComponent():GetBuffValue("ExpandSingleChainScope")
  if buffExpandSingleChainScope and buffExpandSingleChainScope ~= 0 and skillScopeType == SkillScopeType.NearestInSquareRing then
    scopeParamData[1] = scopeParamData[1] + buffExpandSingleChainScope
    return true
  end
  return false
end

function UtilDataServiceShare:ProcessAutoBeadSkillConfig(oriSkillConfigData, entity)
  if not oriSkillConfigData or not entity then
    return oriSkillConfigData
  end
  if not entity:EntityType():IsAutoBeadSkillHolder() then
    return oriSkillConfigData
  end
  if oriSkillConfigData:GetSkillType() ~= SkillType.AutoBeadSkill then
    return oriSkillConfigData
  end
  local selectMode = oriSkillConfigData:GetTargetSelectionModeConfig()
  if selectMode and selectMode == SkillTargetSelectionMode.Entity then
  else
    return oriSkillConfigData
  end
  local attr = entity:Attributes()
  if not attr then
    return oriSkillConfigData
  end
  local buffChangeTargetCount = attr:GetAttribute("BuffChangeAutoBeadSkillTargetCount")
  if buffChangeTargetCount and buffChangeTargetCount ~= 0 then
    local skillConfigData = oriSkillConfigData
    local skillID = oriSkillConfigData:GetID()
    local configService = self._world:GetService("Config")
    if oriSkillConfigData:GetSkillScopeType() == SkillScopeType.Nearest then
      skillConfigData = configService:GetSkillConfigData(skillID, entity, true)
      skillConfigData._scopeParamData = skillConfigData._scopeParamData + buffChangeTargetCount
    elseif oriSkillConfigData:GetSkillScopeType() == SkillScopeType.NearestInSquareRing then
      skillConfigData = configService:GetSkillConfigData(skillID, entity, true)
      skillConfigData._scopeParamData = table.cloneconf(skillConfigData._scopeParamData)
      skillConfigData._scopeParamData[2] = skillConfigData._scopeParamData[2] + buffChangeTargetCount
    elseif oriSkillConfigData:GetSkillTargetType() == SkillTargetType.HighestHPMonster then
      skillConfigData = configService:GetSkillConfigData(skillID, entity, true)
      if skillConfigData._targetTypeParam then
        skillConfigData._targetTypeParam = table.cloneconf(skillConfigData._targetTypeParam)
      else
        skillConfigData._targetTypeParam = {}
      end
      local oriCount = skillConfigData._targetTypeParam[1] or 1
      skillConfigData._targetTypeParam[1] = oriCount + buffChangeTargetCount
    elseif oriSkillConfigData:GetSkillTargetType() == SkillTargetType.LowestHPPercentMonster then
      skillConfigData = configService:GetSkillConfigData(skillID, entity, true)
      if skillConfigData._targetTypeParam then
        skillConfigData._targetTypeParam = table.cloneconf(skillConfigData._targetTypeParam)
      else
        skillConfigData._targetTypeParam = {}
      end
      local oriCount = skillConfigData._targetTypeParam[2] or 1
      skillConfigData._targetTypeParam[2] = oriCount + buffChangeTargetCount
    end
    return skillConfigData
  else
    return oriSkillConfigData
  end
end

function UtilDataServiceShare:CheckPuzzlePickUpIsValid(pickUpGridPos, gapTilePos, puzzleRange)
  if not self:IsValidPiecePos(pickUpGridPos) then
    return false
  end
  if not table.icontains(puzzleRange, pickUpGridPos) then
    return false
  end
  if gapTilePos == pickUpGridPos then
    return false
  end
  if self:FindPieceElement(pickUpGridPos) == PieceType.None then
    return false
  end
  local trapList = self:GetTrapsAtPos(pickUpGridPos)
  for _, trapEntity in ipairs(trapList) do
    local trapComponent = trapEntity:Trap()
    if trapComponent:IsLockedGrid() then
      return false
    end
  end
  for _, offset in ipairs(Offset4) do
    local pos = Vector2(gapTilePos.x + offset[1], gapTilePos.y + offset[2])
    if pos == pickUpGridPos then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:GetCurGlobalUnscaledCoundDownTime()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  if renderBoardEntity then
    local cdCmpt = renderBoardEntity:UnscaledCountDownRender()
    if cdCmpt and cdCmpt:GetIsActive() then
      local timeInfo = cdCmpt:GetCurRestTimeMs()
      return timeInfo
    end
  end
  return 0
end

function UtilDataServiceShare:IsPosBlockMoveForTrapWall(posCur, posTarget)
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if not logicTrapWallComponent then
    return false
  end
  if posCur == nil or posTarget == nil then
    return false
  end
  local dir = posTarget - posCur
  if posCur.x == posTarget.x or posCur.y == posTarget.y then
    local posBlock = posCur + dir / 2
    local trapWall = logicTrapWallComponent:GetTrapWall(posBlock)
    if trapWall then
      return true
    end
  else
    local posBlock1 = posCur + Vector2(0, dir.y / 2)
    local trapWall1 = logicTrapWallComponent:GetTrapWall(posBlock1)
    local posBlock2 = posCur + Vector2(dir.x / 2, 0)
    local trapWall2 = logicTrapWallComponent:GetTrapWall(posBlock2)
    if trapWall1 and trapWall2 then
      return true
    end
    local posBlock3 = posCur + Vector2(dir.x, dir.y / 2)
    local trapWall3 = logicTrapWallComponent:GetTrapWall(posBlock3)
    if trapWall1 and trapWall3 then
      return true
    end
    local posBlock4 = posCur + Vector2(dir.x / 2, dir.y)
    local trapWall4 = logicTrapWallComponent:GetTrapWall(posBlock4)
    if trapWall2 and trapWall4 then
      return true
    end
    if trapWall3 and trapWall4 then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:IsPosBlockMoveForTrapWallPosIndex(startPosIndex, endPosIndex)
  local startPos = Vector2.Index2Pos(startPosIndex)
  local endPos = Vector2.Index2Pos(endPosIndex)
  local isBlock = self:IsPosBlockMoveForTrapWall(startPos, endPos)
  return isBlock
end

function UtilDataServiceShare:CalcHitbackForTrapWallBlock(pos, targetPos, useCheckBlockFlag)
  if useCheckBlockFlag == BlockFlag.HitBackFly then
    return false
  end
  if self:IsPosBlockMoveForTrapWall(pos, targetPos) then
    return true
  end
  return false
end

function UtilDataServiceShare:CalcHitbackForTrapWallBlockMultiBodyArea(centerPos, bodyArea)
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if not logicTrapWallComponent then
    return false
  end
  local trapWallPosList = logicTrapWallComponent:GetWallList()
  if not trapWallPosList or table.count(trapWallPosList) == 0 then
    return false
  end
  if #bodyArea == 1 then
    return false
  elseif #bodyArea == 4 then
    local checkPosList = {
      Vector2(0.5, 0),
      Vector2(0.5, 1),
      Vector2(0, 0.5),
      Vector2(1, 0.5)
    }
    for _, pos in ipairs(checkPosList) do
      local checkPos = centerPos + pos
      local trapWall = logicTrapWallComponent:GetTrapWall(checkPos)
      if trapWall then
        return true
      end
    end
  end
  return false
end

function UtilDataServiceShare:IsPosAccessibleMonsterMove(startPos, endPos, bodyArea, monsterBlockData)
  if monsterBlockData == BlockFlag.MonsterFly then
    return true
  end
  if startPos == endPos then
    return true
  end
  local dir = endPos - startPos
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local coverList = utilDataSvc:GetCoverBodyAreaList(endPos, bodyArea)
  local coverListSelf = utilDataSvc:GetCoverBodyAreaList(startPos, bodyArea)
  for i = 1, #coverList do
    local posWork = coverList[i]
    local posWorkStart = posWork - dir
    if not table.icontains(coverListSelf, posWork) then
      if boardServiceLogic:IsPosBlock(posWork, monsterBlockData) then
        return false
      end
      local trapWallBlock = utilDataSvc:CalcHitbackForTrapWallBlock(posWorkStart, posWork, monsterBlockData)
      if trapWallBlock then
        return false
      end
    end
  end
  return true
end

function UtilDataServiceShare:GetCoverBodyAreaList(pos, area)
  local posList = {}
  if area then
    if 1 < #area then
      for i = 1, #area do
        posList[#posList + 1] = Vector2(pos.x + area[i].x, pos.y + area[i].y)
      end
    else
      posList[#posList + 1] = Vector2(pos.x + area[1].x, pos.y + area[1].y)
    end
  else
    posList[#posList + 1] = pos
  end
  return posList
end

function UtilDataServiceShare:IsBlockMoveWithTrapWall(startPos, endPos, entity)
  local isBlock = false
  local useCheckBlockFlag = BlockFlag.HitBack
  if entity:HasMonsterID() then
    local raceType = entity:MonsterID():GetMonsterRaceType()
    if MonsterRaceType.Fly == raceType then
      useCheckBlockFlag = BlockFlag.HitBackFly
    end
  end
  local bodyArea = entity:BodyArea():GetArea()
  local movePath = {startPos, endPos}
  local finalMovePath = self:CalcMovePathBlockForTrapWall(movePath, bodyArea, useCheckBlockFlag)
  if table.count(finalMovePath) < table.count(movePath) then
    isBlock = true
  end
  return isBlock
end

function UtilDataServiceShare:CalcMovePathBlockForTrapWallWithEntity(movePath, entity)
  local useCheckBlockFlag = BlockFlag.HitBack
  if entity:HasMonsterID() then
    local raceType = entity:MonsterID():GetMonsterRaceType()
    if MonsterRaceType.Fly == raceType then
      useCheckBlockFlag = BlockFlag.HitBackFly
    end
  end
  local bodyArea = entity:BodyArea():GetArea()
  local finalPathBlockForTrapWall = self:CalcMovePathBlockForTrapWall(movePath, bodyArea, useCheckBlockFlag)
  return finalPathBlockForTrapWall
end

function UtilDataServiceShare:CalcMovePathBlockForTrapWall(movePath, bodyArea, useCheckBlockFlag)
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if not logicTrapWallComponent then
    return movePath
  end
  local trapWallPosList = logicTrapWallComponent:GetWallList()
  if not trapWallPosList or table.count(trapWallPosList) == 0 then
    return movePath
  end
  local finalPathBlockForTrapWall = {}
  table.insert(finalPathBlockForTrapWall, movePath[1])
  for i = 2, #movePath do
    local posTarget = movePath[i]
    local posCur = movePath[i - 1]
    local trapWallBlock = self:CalcHitbackForTrapWallBlock(posCur, posTarget, useCheckBlockFlag)
    if trapWallBlock then
      break
    end
    trapWallBlock = self:CalcHitbackForTrapWallBlockMultiBodyArea(posTarget, bodyArea)
    if trapWallBlock then
      break
    end
    table.insert(finalPathBlockForTrapWall, movePath[i])
  end
  return finalPathBlockForTrapWall
end

function UtilDataServiceShare:CalcTrapWallPosEdgeAll(posList)
  local boardSvc = self._world:GetService("BoardLogic")
  local wallPosList = {}
  for _, pos in ipairs(posList) do
    local up = Vector2(pos.x, pos.y + 1)
    local down = Vector2(pos.x, pos.y - 1)
    local left = Vector2(pos.x - 1, pos.y)
    local right = Vector2(pos.x + 1, pos.y)
    if boardSvc:IsValidPiecePos(up) then
      local wallPos = pos + Vector2(0, 0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(down) then
      local wallPos = pos + Vector2(0, -0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(left) then
      local wallPos = pos + Vector2(-0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(right) then
      local wallPos = pos + Vector2(0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
  end
  return wallPosList
end

function UtilDataServiceShare:CalcTrapWallPosEdgeOut(posList)
  local boardSvc = self._world:GetService("BoardLogic")
  local wallPosList = {}
  for _, pos in ipairs(posList) do
    local up = Vector2(pos.x, pos.y + 1)
    local down = Vector2(pos.x, pos.y - 1)
    local left = Vector2(pos.x - 1, pos.y)
    local right = Vector2(pos.x + 1, pos.y)
    if boardSvc:IsValidPiecePos(up) and not table.Vector2Include(posList, up) then
      local wallPos = pos + Vector2(0, 0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(down) and not table.Vector2Include(posList, down) then
      local wallPos = pos + Vector2(0, -0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(left) and not table.Vector2Include(posList, left) then
      local wallPos = pos + Vector2(-0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(right) and not table.Vector2Include(posList, right) then
      local wallPos = pos + Vector2(0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
  end
  return wallPosList
end

function UtilDataServiceShare:CalcTrapWallPosEdgeIn(posList)
  local boardSvc = self._world:GetService("BoardLogic")
  local wallPosList = {}
  for _, pos in ipairs(posList) do
    local up = Vector2(pos.x, pos.y + 1)
    local down = Vector2(pos.x, pos.y - 1)
    local left = Vector2(pos.x - 1, pos.y)
    local right = Vector2(pos.x + 1, pos.y)
    if boardSvc:IsValidPiecePos(up) and table.Vector2Include(posList, up) then
      local wallPos = pos + Vector2(0, 0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(down) and table.Vector2Include(posList, down) then
      local wallPos = pos + Vector2(0, -0.5)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(left) and table.Vector2Include(posList, left) then
      local wallPos = pos + Vector2(-0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
    if boardSvc:IsValidPiecePos(right) and table.Vector2Include(posList, right) then
      local wallPos = pos + Vector2(0.5, 0)
      if not table.icontains(wallPosList, wallPos) then
        table.insert(wallPosList, wallPos)
      end
    end
  end
  return wallPosList
end

function UtilDataServiceShare:OnGetInvalidCreateTrapWallPosList()
  local invalidPosList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and e:HasBodyArea() then
      local bodyAreaCmpt = e:BodyArea()
      local areaArray = bodyAreaCmpt:GetArea()
      if table.count(areaArray) > 1 then
        local monsterGridPos = e:GetGridPosition()
        local monsterPosList = {}
        for i = 1, #areaArray do
          local curAreaPos = areaArray[i]
          table.insert(monsterPosList, monsterGridPos + curAreaPos)
        end
        local invalidTrapWallPosPosList = self:CalcTrapWallPosEdgeIn(monsterPosList)
        for _, pos in ipairs(invalidTrapWallPosPosList) do
          if not table.icontains(invalidPosList, pos) then
            table.insert(invalidPosList, pos)
          end
        end
      end
    end
  end
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if logicTrapWallComponent then
    local trapWallPosList = logicTrapWallComponent:GetTrapWallPosList()
    if trapWallPosList and table.count(trapWallPosList) > 0 then
      for _, pos in ipairs(trapWallPosList) do
        if not table.icontains(invalidPosList, pos) then
          table.insert(invalidPosList, pos)
        end
      end
    end
  end
  return invalidPosList
end

function UtilDataServiceShare:IsPosListBlockWithTrapWall(posList, monsterRaceType)
  if not monsterRaceType then
    Log.fatal("function Param monsterRaceType is Nil ")
    return true
  end
  if monsterRaceType == MonsterRaceType.Fly then
    return false
  end
  if table.count(posList) == 1 then
    return false
  end
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if not logicTrapWallComponent then
    return false
  end
  local trapWallPosEdgeInPosList = self:CalcTrapWallPosEdgeIn(posList)
  for _, pos in ipairs(trapWallPosEdgeInPosList) do
    local trapWall = logicTrapWallComponent:GetTrapWall(pos)
    if trapWall then
      return true
    end
  end
  return false
end

function UtilDataServiceShare:OnGetEntitySelectWeakEdgeDataList(entityID, selectKeyList)
  local selectMonsterWeakDataList = {}
  local allMonsterWeakDataList = self:OnGetEntityWeakEdgeDataList(entityID)
  if not allMonsterWeakDataList or table.count(allMonsterWeakDataList) == 0 then
    return {}
  end
  for _, v in ipairs(allMonsterWeakDataList) do
    local monsterWeakData = v
    local key = monsterWeakData:GetKey()
    if table.icontains(selectKeyList, key) then
      table.insert(selectMonsterWeakDataList, v)
    end
  end
  return selectMonsterWeakDataList
end

function UtilDataServiceShare:OnGetEntityWeakEdgeDataList(entityID)
  local targetEntity = self._world:GetEntityByID(entityID)
  if not targetEntity then
    return
  end
  local weakEdgeDataList = {}
  local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
  if bodyAreaCount == 1 or bodyAreaCount == 2 or bodyAreaCount == 3 or bodyAreaCount == 4 or bodyAreaCount == 9 then
    weakEdgeDataList = self:OnEntityWeakEdgeDataOrderly(entityID)
  else
    weakEdgeDataList = self:OnEntityWeakEdgeDataMussy(entityID)
  end
  return weakEdgeDataList
end

function UtilDataServiceShare:OnEntityWeakEdgeDataMussy(entityID)
  local targetEntity = self._world:GetEntityByID(entityID)
  local configService = self._world:GetService("Config")
  local monsterConfigData = configService:GetMonsterConfigData()
  local monsterID = targetEntity:MonsterID():GetMonsterID()
  local monsterResPath = monsterConfigData:GetMonsterResPath(monsterID)
  local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
  local weakEdgeDataList = {}
  if bodyAreaCount == 5 then
    if monsterResPath == "2905102.prefab" then
      weakEdgeDataList = self:OnEntityWeakEdgeDataOrderly(entityID)
      local longestEdge
      for _, v in ipairs(weakEdgeDataList) do
        local monsterWeakData = v
        local edgePosList = monsterWeakData:GetEdgePosList()
        if table.count(edgePosList) == 3 then
          longestEdge = v
          break
        end
      end
      local edgeKey = longestEdge:GetKey()
      local targetEdgeKey
      if edgeKey == WeakEdgeType.WeakUp then
        targetEdgeKey = WeakEdgeType.WeakDown
      elseif edgeKey == WeakEdgeType.WeakDown then
        targetEdgeKey = WeakEdgeType.WeakUp
      elseif edgeKey == WeakEdgeType.WeakRight then
        targetEdgeKey = WeakEdgeType.WeakLeft
      elseif edgeKey == WeakEdgeType.WeakLeft then
        targetEdgeKey = WeakEdgeType.WeakRight
      end
      local targetEdgeWeakData
      for _, v in ipairs(weakEdgeDataList) do
        local monsterWeakData = v
        local key = monsterWeakData:GetKey()
        if key == targetEdgeKey then
          targetEdgeWeakData = v
          break
        end
      end
      local targetEdgePosList = targetEdgeWeakData:GetEdgePosList()
      local targetBodyPosList = targetEdgeWeakData:GetBodyPosList()
      local extendWeakData1 = MonsterWeakData:New(targetEdgeKey + 10, {
        targetEdgePosList[1]
      }, {
        targetBodyPosList[1]
      }, entityID)
      local extendWeakData2 = MonsterWeakData:New(targetEdgeKey + 20, {
        targetEdgePosList[1]
      }, {
        targetBodyPosList[1]
      }, entityID)
      table.removev(weakEdgeDataList, targetEdgeWeakData)
      table.insert(weakEdgeDataList, extendWeakData1)
      table.insert(weakEdgeDataList, extendWeakData2)
    elseif monsterResPath == "2903601.prefab" and bodyAreaCount == 5 then
      weakEdgeDataList = self:OnEntityWeakEdgeDataOrderly(entityID)
      local monsterWeakDataUp1 = MonsterWeakData:New(WeakEdgeType.WeakUp_1, {
        Vector2(-1, 0.5)
      }, {
        Vector2(-1, 0)
      }, entityID)
      local monsterWeakDataUp2 = MonsterWeakData:New(WeakEdgeType.WeakUp_2, {
        Vector2(1, 0.5)
      }, {
        Vector2(1, 0)
      }, entityID)
      local monsterWeakDataDown1 = MonsterWeakData:New(WeakEdgeType.WeakDown_1, {
        Vector2(-1, -0.5)
      }, {
        Vector2(-1, 0)
      }, entityID)
      local monsterWeakDataDown2 = MonsterWeakData:New(WeakEdgeType.WeakDown_2, {
        Vector2(1, -0.5)
      }, {
        Vector2(1, 0)
      }, entityID)
      local monsterWeakDataLeft1 = MonsterWeakData:New(WeakEdgeType.WeakLeft_1, {
        Vector2(-0.5, -1)
      }, {
        Vector2(0, -1)
      }, entityID)
      local monsterWeakDataLeft2 = MonsterWeakData:New(WeakEdgeType.WeakLeft_2, {
        Vector2(-0.5, 1)
      }, {
        Vector2(0, 1)
      }, entityID)
      local monsterWeakDataRight1 = MonsterWeakData:New(WeakEdgeType.WeakRight_1, {
        Vector2(0.5, -1)
      }, {
        Vector2(0, -1)
      }, entityID)
      local monsterWeakDataRight2 = MonsterWeakData:New(WeakEdgeType.WeakRight_2, {
        Vector2(0.5, 1)
      }, {
        Vector2(0, 1)
      }, entityID)
      table.insert(weakEdgeDataList, monsterWeakDataUp1)
      table.insert(weakEdgeDataList, monsterWeakDataUp2)
      table.insert(weakEdgeDataList, monsterWeakDataDown1)
      table.insert(weakEdgeDataList, monsterWeakDataDown2)
      table.insert(weakEdgeDataList, monsterWeakDataLeft1)
      table.insert(weakEdgeDataList, monsterWeakDataLeft2)
      table.insert(weakEdgeDataList, monsterWeakDataRight1)
      table.insert(weakEdgeDataList, monsterWeakDataRight2)
    end
  elseif bodyAreaCount == 12 then
    weakEdgeDataList = self:OnEntityWeakEdgeDataOrderly(entityID)
  end
  return weakEdgeDataList
end

function UtilDataServiceShare:OnEntityWeakEdgeDataOrderly(entityID)
  local targetEntity = self._world:GetEntityByID(entityID)
  local targetPos = targetEntity:GetGridPosition()
  local targetDir = targetEntity:GetGridDirection()
  local bodyArea = targetEntity:BodyArea():GetArea()
  local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
  local gridOffset = targetEntity:GridLocation():GetGridOffset()
  local edgeCount = 4
  local xMin, xMax, yMin, yMax = 0, 0, 0, 0
  for _, pos in ipairs(bodyArea) do
    xMin = math.min(pos.x, xMin)
    xMax = math.max(pos.x, xMax)
    yMin = math.min(pos.y, yMin)
    yMax = math.max(pos.y, yMax)
  end
  local upEdgePosList = {}
  local downEdgePosList = {}
  local leftEdgePosList = {}
  local rightEdgePosList = {}
  local upBodyPosList = {}
  local downBodyPosList = {}
  local leftBodyPosList = {}
  local rightBodyPosList = {}
  for _, pos in ipairs(bodyArea) do
    if pos.x == xMin then
      local left = pos + Vector2(-0.5, 0)
      table.insert(leftEdgePosList, left)
      table.insert(leftBodyPosList, pos)
    end
    if pos.x == xMax then
      local right = pos + Vector2(0.5, 0)
      table.insert(rightEdgePosList, right)
      table.insert(rightBodyPosList, pos)
    end
    if pos.y == yMax then
      local up = pos + Vector2(0, 0.5)
      table.insert(upEdgePosList, up)
      table.insert(upBodyPosList, pos)
    end
    if pos.y == yMin then
      local down = pos + Vector2(0, -0.5)
      table.insert(downEdgePosList, down)
      table.insert(downBodyPosList, pos)
    end
  end
  local monsterWeakDataUp = MonsterWeakData:New(WeakEdgeType.WeakUp, upEdgePosList, upBodyPosList, entityID)
  local monsterWeakDataDown = MonsterWeakData:New(WeakEdgeType.WeakDown, downEdgePosList, downBodyPosList, entityID)
  local monsterWeakDataRight = MonsterWeakData:New(WeakEdgeType.WeakRight, rightEdgePosList, rightBodyPosList, entityID)
  local monsterWeakDataLeft = MonsterWeakData:New(WeakEdgeType.WeakLeft, leftEdgePosList, leftBodyPosList, entityID)
  return {
    monsterWeakDataUp,
    monsterWeakDataDown,
    monsterWeakDataRight,
    monsterWeakDataLeft
  }
end

function UtilDataServiceShare:OnCheckTargetCanAddWeak(entityID)
  local targetEntity = self._world:GetEntityByID(entityID)
  if not targetEntity then
    return false
  end
  if targetEntity:HasDeadMark() then
    return false
  end
  local buffComponent = targetEntity:BuffComponent()
  if buffComponent and buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
    return false
  end
  if targetEntity:HasRide() and targetEntity:Ride():GetRiderID() == entityID then
    return false
  end
  local monsterWeakComponent = targetEntity:MonsterWeak()
  if not monsterWeakComponent then
    return true
  end
  local bodyArea = targetEntity:BodyArea():GetArea()
  local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
  local edgeCount = 4
  if bodyAreaCount == 3 then
    edgeCount = 4
  elseif bodyAreaCount == 5 then
    local configService = self._world:GetService("Config")
    local monsterConfigData = configService:GetMonsterConfigData()
    local monsterID = targetEntity:MonsterID():GetMonsterID()
    local monsterResPath = monsterConfigData:GetMonsterResPath(monsterID)
    if monsterResPath == "2905102.prefab" then
      edgeCount = 5
    elseif monsterResPath == "2903601.prefab" and bodyAreaCount == 5 then
      edgeCount = 12
    end
  elseif bodyAreaCount == 12 then
    edgeCount = 4
  end
  local hasWeakCount = monsterWeakComponent:GetMonsterWeakCount()
  return edgeCount > hasWeakCount
end

function UtilDataServiceShare:OnGetPetChainTimes(petEntity)
  local buffComponent = petEntity:BuffComponent()
  local chainTimes = buffComponent:GetBuffValue("ChainSkillCount") or 1
  local extraChainCount
  if buffComponent:GetBuffValue("ExtraChainFlag") then
    chainTimes = chainTimes + 1
    extraChainCount = chainTimes
  end
  return chainTimes, extraChainCount
end

function UtilDataServiceShare:OnGetPetChainTimesForRender(petEntity)
  local buffViewComponent = petEntity:BuffView()
  local chainTimes = buffViewComponent:GetBuffValue("ChainSkillCount") or 1
  local extraChainCount
  if buffViewComponent:GetBuffValue("ExtraChainFlag") then
    chainTimes = chainTimes + 1
    extraChainCount = chainTimes
  end
  return chainTimes, extraChainCount
end

function UtilDataServiceShare:OnCheckPetCanMultiStageChainSkill(petEntity)
  local buffComponent = petEntity:BuffComponent()
  local multiStageChain = buffComponent:GetBuffValue("MultiStageChain")
  if multiStageChain == 1 then
    return true
  end
  return false
end

function UtilDataServiceShare:OnGetPetChainSkillConfigIDList(petEntity, roundIndex)
  local chainSkillStageInfoList
  local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local chain_rate = logicChainPathCmpt:GetChainRateAtIndex(#chainPath)
  local attributesComponent = petEntity:Attributes()
  local chainCountFix = attributesComponent:GetAttribute("ChainSkillReleaseFix")
  local chainCountMul = attributesComponent:GetAttribute("ChainSkillReleaseMul")
  local realChainCount = math.ceil((chain_rate + chainCountFix) * (1 + chainCountMul))
  local buffComponent = petEntity:BuffComponent()
  local chainExtraFix = buffComponent:GetBuffValue("ChangeExtraChainSkillReleaseFixForSkill")
  local skillInfoComponent = petEntity:SkillInfo()
  local petCanMultiStageChainSkill = self:OnCheckPetCanMultiStageChainSkill(petEntity)
  if petCanMultiStageChainSkill and roundIndex == 1 then
    chainSkillStageInfoList = skillInfoComponent:GetChainSkillConfigIDList(realChainCount, chainExtraFix)
  else
    local chainSkillID, chainSkillStage = self:GetChainSkillByChainCount(petEntity, realChainCount, chainExtraFix)
    local chainInfo = ChainSkillStageInfo:New(chainSkillID, chainSkillStage)
    chainSkillStageInfoList = {chainInfo}
  end
  return chainSkillStageInfoList
end

function UtilDataServiceShare:GetChainSkillByChainCount(petEntity, realChainCount, chainExtraFix)
  local skillInfoComponent = petEntity:SkillInfo()
  local chainSkillID, chainSkillStage = skillInfoComponent:GetChainSkillConfigID(realChainCount, chainExtraFix)
  return chainSkillID, chainSkillStage
end

function UtilDataServiceShare:OnGetCurChainSkillID(petEntity, roundIndex, index)
  local chainSkillStageInfoList = self:OnGetPetChainSkillConfigIDList(petEntity, roundIndex)
  local chainSkillStageInfo = chainSkillStageInfoList[index]
  local chainSkillID = chainSkillStageInfo:GetChainSkillID()
  return chainSkillID
end

function UtilDataServiceShare:OnGetPetBanSkillBuffValue(petEntityID)
  local petEntity = self._world:GetEntityByID(petEntityID)
  local buffCmpt = petEntity:BuffComponent()
  local banPetSkillList = buffCmpt:GetBuffValue("BanPetSkill") or {}
  return banPetSkillList
end

function UtilDataServiceShare:OnCheckPetCanCastNormalSkill(petEntityID)
  local banPetSkillList = self:OnGetPetBanSkillBuffValue(petEntityID)
  if table.icontains(banPetSkillList, EnumBanPetSkill.Normal) then
    return false
  end
  return true
end

function UtilDataServiceShare:OnCheckPetCanCastChainSkill(petEntityID)
  local banPetSkillList = self:OnGetPetBanSkillBuffValue(petEntityID)
  if table.icontains(banPetSkillList, EnumBanPetSkill.Chain) then
    return false
  end
  return true
end

function UtilDataServiceShare:OnCheckPetCanCastActiveSkill(petEntityID)
  local banPetSkillList = self:OnGetPetBanSkillBuffValue(petEntityID)
  if table.icontains(banPetSkillList, EnumBanPetSkill.Active) then
    return false
  end
  return true
end

function UtilDataServiceShare:IsMatchPieceType(petEntityID, pieceType)
  local fettersSvc = self._world:GetService("Fetters")
  if not fettersSvc then
    local petEntity = self._world:GetEntityByID(petEntityID)
    local elementCmpt = petEntity:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    return CanMatchPieceType(primaryType, pieceType), false
  end
  return fettersSvc:IsMatchPieceType(petEntityID, pieceType)
end

function UtilDataServiceShare:CanChangePieceToGray()
  return self._world:MatchType(GetMatchTypeType.NoLinkLine) ~= MatchType.MT_PopStarPro
end

function UtilDataServiceShare:CanCastChainSkill(teamEntity, gridPos, connectPieces)
  local canCast = true
  local chainPath = {gridPos}
  table.appendArray(chainPath, connectPieces)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainRate = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  local buffComp = teamEntity:BuffComponent()
  local popLimitVal = buffComp:GetBuffValue(PopStarConst.ChainAttackMinPopNumKey)
  if popLimitVal then
    local limitNum = tonumber(popLimitVal)
    if chainRate < limitNum then
      canCast = false
    end
  end
  return canCast
end

function UtilDataServiceShare:GetFettersPrimaryType(petEntity)
  local primaryType
  local fettersSvc = self._world:GetService("Fetters")
  if fettersSvc then
    primaryType = fettersSvc:GetFettersPrimaryType(petEntity)
  end
  if primaryType then
    return primaryType
  end
  return PieceType.None
end

function UtilDataServiceShare:IsHasExtraChainFlag(petPstID)
  local petEntityId = self:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local buffViewComponent = petEntity:BuffView()
  local flag = buffViewComponent:GetBuffValue("ExtraChainFlag")
  return flag ~= nil
end

function UtilDataServiceShare:GetEntityIstavanActiveCountByPetPstID(petPstID)
  local petEntityId = self:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  return self:GetEntityIstavanActiveCount(petEntity)
end

function UtilDataServiceShare:GetEntityIstavanActiveCount(entity)
  local buffCmpt = entity:BuffComponent()
  local value = buffCmpt:GetBuffValue("IstavanActiveCount")
  value = value or 0
  return value
end

function UtilDataServiceShare:AddEntityIstavanActiveCount(entity, count)
  local value = self:GetEntityIstavanActiveCount(entity)
  value = value + count
  local buffCmpt = entity:BuffComponent()
  buffCmpt:SetBuffValue("IstavanActiveCount", value)
end

function UtilDataServiceShare:GetPetExtraChainCastCount(petPstID, baseValue, mulValue)
  local retValue
  if petPstID then
    local petEntityId = self:GetEntityIDByPstID(petPstID)
    local petEntity = self._world:GetEntityByID(petEntityId)
    local buffCmpt = petEntity:BuffComponent()
    local value = self:GetEntityIstavanActiveCount(petEntity)
    value = value or 0
    retValue = baseValue + mulValue * value
  end
  return retValue
end

function UtilDataServiceShare:GetAllPetExtraChainCastCount(casterEntity, baseValue, mulValue)
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  local ret = {}
  for _, petEntity in ipairs(teamMembers) do
    if petEntity:GetID() ~= casterEntity:GetID() then
      local cPstId = petEntity:PetPstID()
      local pstId = cPstId:GetPstID()
      ret[pstId] = self:GetPetExtraChainCastCount(pstId, baseValue, mulValue)
    end
  end
  return ret
end

function UtilDataServiceShare:GetPetExtraChainCastCountBySkillID(entity, skillID, petPstID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, entity)
  local cfgEffectArray = skillConfigData:GetSkillEffect()
  local baseValue, mulValue
  for index, cfgEffectParam in ipairs(cfgEffectArray) do
    if cfgEffectParam:GetEffectType() == SkillEffectType.AppointCastChain then
      local param = cfgEffectParam
      baseValue = param:GetBaseValue()
      mulValue = param:GetMulValue()
    end
  end
  local needPower = self:GetPetExtraChainCastCount(petPstID, baseValue, mulValue)
  return needPower
end

function UtilDataServiceShare:CheckPetCanCastSkill(entity, skillID, petPstID)
  local needPower = self:GetPetExtraChainCastCountBySkillID(entity, skillID, petPstID)
  local power = entity:Attributes():GetAttribute("LegendPower")
  return needPower <= power
end

function UtilDataServiceShare:GetCasterPickUpExtraChainPowerCount(entity, skillID)
  local activeSkillPickUpComponent = entity:ActiveSkillPickUpComponent()
  local pickGridPos = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
  local pickPetPstID = activeSkillPickUpComponent:GetPickUpPetPstID()
  local power
  if pickGridPos and #pickGridPos ~= 0 then
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillID, entity)
    power = skillConfigData:GetSkillTriggerParam()
  else
    local utilDataSvc = self._world:GetService("UtilData")
    power = self:GetPetExtraChainCastCountBySkillID(entity, skillID, pickPetPstID)
  end
  return power
end

function UtilDataServiceShare:CalcYiSiTaWanCastActiveSkillMinimum(entity, skillID, forAutoFight)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, entity)
  local ret = 99
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.PickUpUIAndTrap then
    local cfgEffectArray = skillConfigData:GetSkillEffect()
    local baseValue, mulValue
    for index, cfgEffectParam in ipairs(cfgEffectArray) do
      if cfgEffectParam:GetEffectType() == SkillEffectType.AppointCastChain then
        local param = cfgEffectParam
        baseValue = param:GetBaseValue()
        mulValue = param:GetMulValue()
      end
    end
    local needPower = skillConfigData:GetSkillTriggerParam()
    local pickNum = skillConfigData:GetSkillPickParam()
    if not pickNum or pickNum[1] == 0 then
      local allPetExtraChainCastCount = self:GetAllPetExtraChainCastCount(entity, baseValue, mulValue)
      if 0 < table.count(allPetExtraChainCastCount) then
        return needPower
      else
        for petPstID, count in pairs(allPetExtraChainCastCount) do
          if ret > count then
            ret = count
          end
        end
      end
    else
      ret = needPower
    end
  end
  return ret
end

function UtilDataServiceShare:CheckCanCastActiveSkillMinimumCondition(entity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, entity)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.PickUpUIAndTrap then
    local power = entity:Attributes():GetAttribute("LegendPower")
    local minCostPower = self:CalcYiSiTaWanCastActiveSkillMinimum(entity, skillID)
    return power >= minCostPower
  end
  local extraParam = skillConfigData:GetSkillTriggerExtraParam()
  if extraParam and extraParam[SkillTriggerTypeExtraParam.Pet1702361InTeam] then
    local utilData = self._world:GetService("UtilData")
    local flag = utilData:OnCheckEntityHasBuffFlag(entity, BuffFlags.Pet1702361NotLinkLine)
    return flag
  end
  return true
end

function UtilDataServiceShare:CheckSkillCanCastByExtraParam(entity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, entity)
  local extraParam = skillConfigData:GetSkillTriggerExtraParam()
  if extraParam and extraParam[SkillTriggerTypeExtraParam.Pet1702361InTeam] then
    local utilData = self._world:GetService("UtilData")
    local flag = utilData:OnCheckEntityHasBuffFlag(entity, BuffFlags.Pet1702361NotLinkLine)
    return flag
  end
  return true
end

function UtilDataServiceShare:IsNeedShowLinkageNumForCostStep()
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  end
  return self:IsPreviewNeedShowLinkageNumForCostStep()
end

function UtilDataServiceShare:IsPreviewNeedShowLinkageNumForCostStep()
  local previewEntity = self._world:GetPreviewEntity()
  if not previewEntity then
    return false
  end
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  if previewChainPathCmpt and previewChainPathCmpt:GetLinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return true
  end
  return false
end

function UtilDataServiceShare:GetPreviewPetEntityID()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  return petEntityId
end

function UtilDataServiceShare:IsEnoughStepToLinkMore(chainPath)
  if self:IsNeedShowLinkageNumForCostStep() then
    local pathCount = -1
    if chainPath then
      pathCount = #chainPath
    end
    local curStepPoint = self:GetCurLinkStepPoint()
    if 0 <= pathCount and pathCount < curStepPoint + 1 then
      return true
    end
    return false
  end
  return true
end

function UtilDataServiceShare:GetCurLinkStepPoint()
  local point = 0
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature and not self:IsPreviewNeedShowLinkageNumForCostStep() then
    if lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
      point = lsvcFeature:GetCurStepPoint()
    else
      point = 15
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      if teamEntity then
        local buffCmpt = teamEntity:BuffComponent()
        if buffCmpt then
          local buffSetPoint = buffCmpt:GetBuffValue("NoFeatureStepPoint")
          if buffSetPoint then
            point = buffSetPoint
          end
        end
      end
    end
  elseif self:IsPreviewNeedShowLinkageNumForCostStep() then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
    local utilDataSvc = self._world:GetService("UtilData")
    local petPstID = pickUpTargetCmpt:GetPetPstid()
    local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
    local petEntity = self._world:GetEntityByID(petEntityId)
    point = self:GetPet1702361LinkLineStep(petEntity, activeSkillID)
  end
  return point
end

function UtilDataServiceShare:IsPetJoinChainSpecial(petPstID, chainPathLen, elementType, firstElementType)
  local beAffected = false
  local castPetEntity = self:GetEntityByPstID(petPstID)
  if not castPetEntity then
    return false, beAffected
  end
  if not elementType then
    return false, beAffected
  end
  local teamEntity = castPetEntity:Pet():GetOwnerTeamEntity()
  local cTeam = teamEntity:Team()
  local teamLeaderEntity = cTeam:GetTeamLeaderEntity()
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local teamBuffCmpt = teamEntity:BuffComponent()
    if teamBuffCmpt then
      local onlyTeamLeaderColorPet = teamBuffCmpt:GetBuffValue("OnlyTeamLeaderColorPet")
      if onlyTeamLeaderColorPet and onlyTeamLeaderColorPet == 1 then
        beAffected = true
        local teamLeaderElementCmpt = teamLeaderEntity:Element()
        if teamLeaderElementCmpt then
          local teamLeaderPrimaryType = teamLeaderElementCmpt:GetPrimaryType()
          local primaryMatch = self:IsMatchPieceType(castPetEntity:GetID(), teamLeaderPrimaryType)
          if primaryMatch then
            return true, beAffected
          else
            return false, beAffected
          end
        end
      else
        beAffected = true
        return true, beAffected
      end
    end
  end
  return false, beAffected
end

function UtilDataServiceShare:GetCurAutoBeadPowerInfo()
  local point = 0
  local pointEachPower = 0
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  if autoBeadServiceLogic then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
    if holderEntity then
      point = autoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
      pointEachPower = autoBeadServiceLogic:GetAutoBeadPointEachPower(teamEntity)
    end
  end
  return point, pointEachPower
end

function UtilDataServiceShare:GetAutoBeadList()
  local list
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  if autoBeadServiceLogic then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
    if holderEntity then
      list = autoBeadServiceLogic:GetAutoBeadList(teamEntity)
    end
  end
  return list
end

function UtilDataServiceShare:GetEntityHPShieldType(entityID)
  local buffSvc = self._world:GetService("BuffLogic")
  local hpShieldType = buffSvc:GetEntityHPShieldType(entityID)
  return hpShieldType
end

function UtilDataServiceShare:GetFeatureTetrisIndex()
  local featureSvcL = self._world:GetService("FeatureLogic")
  return featureSvcL:GetTetrisIndex()
end

function UtilDataServiceShare:GetFeatureTetrisDirIndex()
  local featureSvcL = self._world:GetService("FeatureLogic")
  local index = featureSvcL:GetTetrisDirIndex()
  return index
end

function UtilDataServiceShare:ParseFeatureTetrisDirTypeToVector2(dirType)
  if dirType == HitBackDirectionType.Up then
    return Vector2.up, 0
  elseif dirType == HitBackDirectionType.Left then
    return Vector2.left, -90
  elseif dirType == HitBackDirectionType.Down then
    return Vector2.down, 180
  elseif dirType == HitBackDirectionType.Right then
    return Vector2.right, 90
  end
end

function UtilDataServiceShare:GetFeatureTetrisDir()
  local featureSvcL = self._world:GetService("FeatureLogic")
  local dirType = featureSvcL:GetTetrisDir()
  return self:ParseFeatureTetrisDirTypeToVector2(dirType)
end

function UtilDataServiceShare:IsPetAnySkillReady(petEntity)
  local anyReady = false
  if petEntity then
    local skillInfoCmpt = petEntity:SkillInfo()
    local activeSkillID = skillInfoCmpt:GetActiveSkillID()
    local extraSkillIDList = skillInfoCmpt:GetExtraActiveSkillIDList()
    local allSkill = {}
    if activeSkillID then
      table.insert(allSkill, activeSkillID)
    end
    if extraSkillIDList then
      table.appendArray(allSkill, extraSkillIDList)
    end
    for index, skillId in ipairs(allSkill) do
      local readyAttr = self:GetPetSkillReadyAttr(petEntity, skillId)
      local bReady = readyAttr and readyAttr == 1
      if bReady then
        anyReady = true
        break
      end
    end
  end
  return anyReady
end

function UtilDataServiceShare:GetReplacedBuffIdForPlayIns(entity, buffId)
  local buffSvc = self._world:GetService("BuffLogic")
  return buffSvc:GetReplacedBuffIdForPlayIns(entity, buffId)
end

function UtilDataServiceShare:GetReplacedBuffEffectTypeForPlayIns(entity, buffEffectType)
  local buffSvc = self._world:GetService("BuffLogic")
  return buffSvc:GetReplacedBuffEffectTypeForPlayIns(entity, buffEffectType)
end

function UtilDataServiceShare:IsSkillInvalidated(casterEntity, activeSkillID)
  local hasInvalidate = self:GetEntityBuffValue(casterEntity, "InvalidateActiveSkill")
  if hasInvalidate and hasInvalidate == 1 then
    local excludeTriggerType = self:GetEntityBuffValue(casterEntity, "InvalidateActiveSkillExcludeTriggerType")
    if excludeTriggerType and type(excludeTriggerType) == "table" and activeSkillID then
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(activeSkillID)
      local skillTriggerType = skillConfigData:GetSkillTriggerType()
      if table.icontains(excludeTriggerType, skillTriggerType) then
        return false
      end
    end
    return true
  end
  return false
end

function UtilDataServiceShare:GetPreviewLinkLineCount()
end

function UtilDataServiceShare:GetPet1702361LinkLineStep(petEntity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  local legendPower = self:GetPetLegendPowerAttr(petEntity)
  if legendPower == 0 then
    return 0
  end
  local pickUpPerPower = self:GetPet1702361LinkLinePerPower(petEntity, skillID)
  local pickUpNum = math.floor(legendPower / pickUpPerPower)
  return pickUpNum
end

function UtilDataServiceShare:GetPet1702361LinkLinePerPower(petEntity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  local pickUpPerPower = tonumber(triggerExtraParam[SkillTriggerTypeExtraParam.Pet1702361LinkLinePerPower]) or 1
  return pickUpPerPower
end

function UtilDataServiceShare:GetPet1702361LinkLineBeginPos(petEntityID, skillID)
  local petEntity = self._world:GetEntityByID(petEntityID)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  if skillConfigData:GetSkillPickType() ~= SkillPickUpType.LinkLineSP then
    return playerPos
  end
  local trapID = skillConfigData._pickUpParam[2]
  local trapLogicSvc = self._world:GetService("TrapLogic")
  local trapEntityList = trapLogicSvc:FindTrapByTrapID(trapID)
  if not trapEntityList or #trapEntityList == 0 then
    return playerPos
  end
  local trapEntity = self._world:GetEntityByID(trapEntityList[1])
  local pos = trapEntity:GetGridPosition()
  return pos
end

function UtilDataServiceShare:Is2PosCanConnectNoPieceTypeCheck(pos1, pos2)
  local bConnect = false
  local pieceType1 = 99
  local pieceType2 = 99
  local canLinkLine = false
  local posCanLinkList = self:GetRoundGrid(pos1)
  for i, pos in ipairs(posCanLinkList) do
    if pos.x == pos2.x and pos.y == pos2.y and not self:IsPosBlockLinkLineForChain(pos) then
      bConnect = true
      canLinkLine = true
      break
    end
  end
  local msg = "pieceType1=" .. pieceType1 .. " pieceType2=" .. pieceType2 .. " canLinkLine=" .. tostring(canLinkLine)
  return bConnect, msg
end

function UtilDataServiceShare:SaveActiveSkillLinkLinePosAndDir(teamEntity)
  local logicPos = teamEntity:GetGridPosition()
  local logicDir = teamEntity:GetGridDirection()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetLogicActiveSkillLinkLineTeamPos(logicPos, logicDir)
  local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  if self._world:RunAtClient() then
    local boardServiceRender = self._world:GetService("BoardRender")
    local renderPos = boardServiceRender:GetRealEntityGridPos(teamLeader)
    local renderDir = teamLeader:GetDirection()
    battleStatCmpt:SetRenderActiveSkillLinkLineTeamPos(renderPos, renderDir)
  end
end

function UtilDataServiceShare:GetLogicActiveSkillLinkLineTeamPos()
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:IsActiveSkillLinkLine() then
    return battleStatCmpt:GetLogicActiveSkillLinkLineTeamPos()
  end
end

function UtilDataServiceShare:GetRenderActiveSkillLinkLineTeamPos()
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:IsActiveSkillLinkLine() then
    return battleStatCmpt:GetRenderActiveSkillLinkLineTeamPos()
  end
end

function UtilDataServiceShare:FindTrapByTrapID(trapID)
  local trapLogicSvc = self._world:GetService("TrapLogic")
  local trapEntityList = trapLogicSvc:FindTrapByTrapID(trapID)
  return trapEntityList
end

function UtilDataServiceShare:IsPet1702361ActiveSkillPreview()
  local renderBattleStatCmpt = self._world:RenderBattleStat()
  return renderBattleStatCmpt:IsPet1702361ActiveSkillPreview()
end

function UtilDataServiceShare:GetPet1702361Entity(casterEntity, skillID)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamCmpt = teamEntity:Team()
  local teamLeaderEntity = teamCmpt:GetTeamLeaderEntity()
  local playerAnimEntity = casterEntity
  local isTeamLeader = teamLeaderEntity:GetID() == casterEntity:GetID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local trapID = skillConfigData._pickUpParam[2]
  local utilDataSvc = self._world:GetService("UtilData")
  local trapEntityList = utilDataSvc:FindTrapByTrapID(trapID)
  local hasTrap = false
  if trapEntityList and 0 < #trapEntityList then
    playerAnimEntity = self._world:GetEntityByID(trapEntityList[1])
    hasTrap = true
  end
  if not hasTrap and not isTeamLeader then
    local playSkillService = self._world:GetService("PlaySkill")
    playSkillService:ShowCasterEntity(casterEntity:GetID())
  end
  return playerAnimEntity, isTeamLeader, hasTrap
end

function UtilDataServiceShare:GePetEntityByTemplateID(tid)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local cTeam = eLocalTeam:Team()
  local pets = cTeam:GetTeamPetEntities()
  for _, e in ipairs(pets) do
    local petPstID = e:PetPstID():GetTemplateID()
    if tid == petPstID then
      return e
    end
  end
end

function UtilDataServiceShare:IsActiveSkillLinkLine()
  local battleStatCmpt = self._world:BattleStat()
  local isActiveSkillLinkLine = battleStatCmpt:IsActiveSkillLinkLine()
  return isActiveSkillLinkLine
end

function UtilDataServiceShare:SetPet1702361TrapHide()
  local battleStatCmpt = self._world:BattleStat()
  local casterEntityID = battleStatCmpt:GetActiveSkillLinkLineCasterEntityID()
  local petEntity = self._world:GetEntityByID(casterEntityID)
  local skillID = battleStatCmpt:GetActiveSkillLinkLineSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  if skillConfigData:GetSkillPickType() ~= SkillPickUpType.LinkLineSP then
    return
  end
  local trapID = skillConfigData._pickUpParam[2]
  local trapLogicSvc = self._world:GetService("TrapLogic")
  local trapEntityList = trapLogicSvc:FindTrapByTrapID(trapID)
  if not trapEntityList or #trapEntityList == 0 then
    return
  end
  local trapEntity = self._world:GetEntityByID(trapEntityList[1])
  trapEntity:SetViewVisible(false)
end

function UtilDataServiceShare:FindDontNeedAliveTrapByTrapID(trapID)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapID() == trapID then
        table.insert(listRet, trap:GetID())
      end
    end
  end
  return listRet
end
