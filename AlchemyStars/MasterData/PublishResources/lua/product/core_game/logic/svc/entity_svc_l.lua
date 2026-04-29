require("entity_assemble_extension")
_class("LogicEntityService", BaseService)
LogicEntityService = LogicEntityService

function LogicEntityService:Constructor(world)
  self._world = world
end

function LogicEntityService:CreateLogicEntity(entityConstId, bShow)
  local ctx = EntityCreationContext:New()
  ctx.entity_config_id = entityConstId
  if bShow == nil then
    ctx.bShow = true
  else
    ctx.bShow = bShow
  end
  local entity = self._world:CreateEntity()
  self._world:SetEntityIdByEntityConfigId(entity, entityConstId)
  EntityAssembler.AssembleEntityComponents(entity, ctx)
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    self:LogNotice("CreateEntity entityConfigID=", entityConstId, " entityID=", entity:GetID())
    self._world:GetSyncLogger():Trace({
      key = "CreateEntity",
      entityConstId = entityConstId,
      entityID = entity:GetID()
    })
  end
  if GameGlobal.GetModule and GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    GameGlobal.GetModule(SkillPerfModule):AddEffectEntity(entity)
  end
  return entity
end

function LogicEntityService:CreateBoardEntity()
  local eBoard = self:CreateLogicEntity(EntityConfigIDConst.Board)
  self._world:SetBoardEntity(eBoard)
  return eBoard
end

function LogicEntityService:CreateNetworkEntity()
  local networkEntity = self:CreateLogicEntity(EntityConfigIDConst.Network)
  self._world:Player():SetNetworkEntity(networkEntity)
  return networkEntity
end

function LogicEntityService:GenerateBoardData()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local gridGenID = levelConfigData:GetGridGenID()
  self:GenerateBoardDataByID(gridGenID)
  local multiBoard = levelConfigData:GetMultiBoard()
  self:GenerateMultiBoardDataByID(multiBoard)
  self:GenerateSpliceBoardDataByID(gridGenID)
  self:GeneratePushBoardDataByID(gridGenID)
end

function LogicEntityService:GenerateBoardDataByID(gridGenID, teamEntity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local boardConfig = Cfg.cfg_board[gridGenID]
  if boardConfig.GapTiles then
    local cloneGapTiles = {}
    for idx, GapTile in pairs(boardConfig.GapTiles) do
      cloneGapTiles[idx] = GapTile
    end
    boardServiceLogic:ChangeGapTiles(cloneGapTiles)
  end
  if boardConfig.BoardCenterPos then
    local v = Vector2(boardConfig.BoardCenterPos[1], boardConfig.BoardCenterPos[2])
    boardServiceLogic:SetBoardCenterPos(v)
  end
  if boardConfig.ExtraBoard then
    boardServiceLogic:SetExtraBoardPosList(boardConfig.ExtraBoard)
  end
  local pieceTable = boardServiceLogic:GenerateBoard(gridGenID, teamEntity)
  local isRefresh = teamEntity and true or false
  local boardComponent = boardEntity:Board()
  if boardComponent then
    boardComponent:ClearGridEntityData()
    boardComponent:InitPieceTableData(pieceTable, isRefresh)
    local changePosArray = boardComponent:GetChangePosAndClear()
    if changePosArray then
      for i = 1, #changePosArray do
        local pos = changePosArray[i]
        local pieceType = boardComponent:GetPieceType(pos)
        if boardServiceLogic:IsPosBlock(pos, BlockFlag.Skill | BlockFlag.SkillSkip) then
          pieceType = PieceType.None
        end
        if boardServiceLogic:IsValidPiecePos(pos) and not boardServiceLogic:IsObstacleTrapTile(pos) and pieceType ~= nil then
          boardComponent:AddGridEntityData(Vector2(pos.x, pos.y), pieceType)
        end
      end
    end
  end
  boardServiceLogic:SetGapTilesBlock()
end

function LogicEntityService:GenerateMultiBoardDataByID(multiBoard)
  if not multiBoard or table.count(multiBoard) == 0 then
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMultiServiceLogic = self._world:GetService("BoardMultiLogic")
  local boardEntity = self._world:GetBoardEntity()
  for i, boardInfo in ipairs(multiBoard) do
    local boardIndex = boardInfo.index
    local gridGenID = boardInfo.board
    local boardConfig = Cfg.cfg_board[gridGenID]
    if boardConfig.GapTiles then
      boardMultiServiceLogic:ChangeGapTiles(boardIndex, boardConfig.GapTiles)
    end
    if boardConfig.BoardCenterPos then
      local v = Vector2(boardConfig.BoardCenterPos[1], boardConfig.BoardCenterPos[2])
      boardMultiServiceLogic:SetBoardCenterPos(boardIndex, v)
    end
    local pieceTable = boardMultiServiceLogic:GenerateBoard(boardIndex, gridGenID)
    local boardMultiComponent = boardEntity:BoardMulti()
    if boardMultiComponent then
      boardMultiComponent:InitPieceTableData(pieceTable, boardIndex)
      local changePosArray = boardMultiComponent:GetChangePosAndClear(boardIndex)
      if changePosArray then
        for i = 1, #changePosArray do
          local pos = changePosArray[i]
          local pieceType = boardMultiComponent:GetPieceType(pos, boardIndex)
          if boardServiceLogic:IsPosBlock(pos, BlockFlag.Skill | BlockFlag.SkillSkip) then
            pieceType = PieceType.None
          end
          if boardServiceLogic:IsValidPiecePos(pos) and not boardServiceLogic:IsObstacleTrapTile(pos) and pieceType ~= nil then
            boardMultiComponent:AddGridEntityData(Vector2(pos.x, pos.y), pieceType, boardIndex)
          end
        end
      end
    end
  end
end

function LogicEntityService:GenerateSpliceBoardDataByID(gridGenID)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local boardConfig = Cfg.cfg_board[gridGenID]
  if not boardConfig.SpliceBoard then
    return
  end
  boardServiceLogic:SetSpliceBoardPosList(boardConfig.SpliceBoard)
  local pieceTable = boardServiceLogic:GenerateSpliceBoard(gridGenID)
  local boardSpliceComponent = boardEntity:BoardSplice()
  if boardSpliceComponent then
    boardSpliceComponent:InitPieceTableData(pieceTable)
    local changePosArray = boardSpliceComponent:GetChangePosAndClear()
    if changePosArray then
      for i = 1, #changePosArray do
        local pos = changePosArray[i]
        local pieceType = boardSpliceComponent:GetPieceType(pos)
        if pieceType ~= nil then
          boardSpliceComponent:AddGridEntityData(Vector2(pos.x, pos.y), pieceType)
        end
      end
    end
  end
end

function LogicEntityService:GeneratePushBoardDataByID(gridGenID)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local boardConfig = Cfg.cfg_board[gridGenID]
  if not boardConfig.PushBoard then
    return
  end
  local pieceTable = boardServiceLogic:GeneratePushBoard(boardConfig.PushBoard)
  local boardPushComponent = boardEntity:BoardPush()
  if boardPushComponent then
    boardPushComponent:InitPieceTableData(pieceTable)
  end
end

function LogicEntityService:CreateWaveMonsters(waveNum)
  local playerPos
  if self._world:MatchType() ~= MatchType.MT_Chess then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    playerPos = teamEntity:GridLocation():GetGridPos()
  end
  local levelConfigData = self._configService:GetLevelConfigData()
  local monsterArray
  local createMonsterPosService = self._world:GetService("CreateMonsterPos")
  local monsterRefreshParam = levelConfigData:GetLevelWaveBeginRefreshMonsterParam(waveNum, playerPos)
  if monsterRefreshParam == nil then
    Log.error("[wave] _CreateMonsters error ", waveNum)
  end
  local monsterRefreshPosType = monsterRefreshParam:GetMonsterRefreshPosType()
  monsterArray = createMonsterPosService:GetMonsterRefreshPos(monsterRefreshPosType, monsterRefreshParam)
  if not monsterArray then
    Log.fatal("CreateMonsterArray Failed LevelID:")
  end
  local hitbackResult
  if monsterRefreshPosType == MonsterRefreshPosType.PositionHitBack then
    hitbackResult = self:_DoLogicRefreshMonsterHitBackTeam(monsterArray)
  end
  local eMonsters = {}
  local monsterIds = {}
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  for _, v in ipairs(monsterArray) do
    local eMonster, monsterId = monsterCreationSvc:CreateMonster(v)
    table.insert(eMonsters, eMonster)
    table.insert(monsterIds, monsterId)
    self._world:GetSyncLogger():Trace({
      key = "CreateWaveMonsters",
      waveNum = waveNum,
      monsterID = monsterId,
      entityID = eMonster:GetID(),
      pos = tostring(v:GetPosition())
    })
  end
  eMonsters = self:_OnCheckMonsterDoppelganger(eMonsters, waveNum)
  return eMonsters, hitbackResult
end

function LogicEntityService:_OnCheckMonsterDoppelganger(eMonsters, waveNum)
  local needAddDoppelgangerList = {}
  for _, e in ipairs(eMonsters) do
    local monsterIDCmpt = e:MonsterID()
    local doppelgangerValue = monsterIDCmpt:GetDoppelgangerValue()
    if doppelgangerValue == 0 then
      table.insert(needAddDoppelgangerList, e)
    end
  end
  if table.count(needAddDoppelgangerList) == 0 then
    return eMonsters
  end
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local monsterDoppelgangerList = {}
  local hasPosList = {}
  for _, e in ipairs(needAddDoppelgangerList) do
    local monsterIDCmpt = e:MonsterID()
    local doppelgangerParam = monsterIDCmpt:GetDoppelgangerParam()
    for i = 1, doppelgangerParam.count do
      local bornPos
      if doppelgangerParam.type == 1 then
        local isRandom = true
        bornPos = self:_OnCalcMonsterDoppelgangerPos(e, SkillScopeType.SquareRing, {
          doppelgangerParam.param
        }, isRandom, hasPosList)
        if not bornPos then
          bornPos = self:_OnCalcMonsterDoppelgangerPos(e, SkillScopeType.FullScreen, {1}, isRandom, hasPosList)
        end
      elseif doppelgangerParam.type == 2 then
        local isRandom = false
        bornPos = self:_OnCalcMonsterDoppelgangerPos(e, SkillScopeType.FullScreen, {1}, isRandom, hasPosList)
      end
      if bornPos then
        table.insert(hasPosList, bornPos)
        local monsterTransformParam = MonsterTransformParam:New(monsterIDCmpt:GetMonsterID())
        monsterTransformParam:SetPosition(bornPos)
        local dir = teamPos - bornPos
        monsterTransformParam:SetRotation(e:GetGridDirection())
        monsterTransformParam:SetForward(dir)
        local doppelgangerMonster, monsterId = monsterCreationSvc:CreateMonster(monsterTransformParam)
        doppelgangerMonster:Attributes():Modify("MaxHP", 1)
        doppelgangerMonster:Attributes():Modify("HP", 1)
        local monsterIDCmpt = doppelgangerMonster:MonsterID()
        monsterIDCmpt:SetDoppelgangerValue(1)
        monsterIDCmpt:SetSkipComplateCondition(true)
        table.insert(eMonsters, doppelgangerMonster)
        self._world:GetSyncLogger():Trace({
          key = "CreateWaveMonsters",
          waveNum = waveNum,
          monsterID = monsterId,
          entityID = doppelgangerMonster:GetID(),
          pos = tostring(monsterTransformParam:GetPosition())
        })
      end
    end
  end
  return eMonsters
end

function LogicEntityService:_OnCalcMonsterDoppelgangerPos(e, scopeType, scopeParam, isRandom, hasPosList)
  local createPos
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local casterBodyArea = e:BodyArea():GetArea()
  local casterPos = e:GetGridPosition()
  local skillResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, casterPos, casterBodyArea)
  local skillRange = skillResult:GetAttackRange()
  if isRandom == true then
    local randomSvc = self._world:GetService("RandomLogic")
    local tmpSkillRange = {}
    for i = 1, table.count(skillRange) do
      local randomIndex = randomSvc:LogicRand(1, table.count(skillRange))
      local randomPos = skillRange[randomIndex]
      table.insert(tmpSkillRange, randomPos)
      table.removev(skillRange, randomPos)
    end
    skillRange = tmpSkillRange
  else
    table.sort(skillRange, function(a, b)
      local dis1 = Vector2.Distance(casterPos, a)
      local dis2 = Vector2.Distance(casterPos, b)
      return dis1 < dis2
    end)
  end
  for _, pos in ipairs(skillRange) do
    local isBlock = utilDataSvc:IsPosBlock(pos, BlockFlag.MonsterLand)
    if not isBlock and not table.icontains(hasPosList, pos) then
      createPos = pos
      break
    end
  end
  return createPos
end

function LogicEntityService:_DoLogicRefreshMonsterHitBackTeam(monsterArray)
  local targetPos
  local needHitBack = false
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local scopeMonsterBodyArea = {}
  local monsterConfigData = self._configService:GetMonsterConfigData()
  for _, monsterTransform in ipairs(monsterArray) do
    local monsterPosition = monsterTransform:GetPosition()
    local monsterID = monsterTransform:GetMonsterID()
    local areaArray = monsterConfigData:GetMonsterArea(monsterID)
    for _, area in ipairs(areaArray) do
      local workPos = monsterPosition + area
      table.insert(scopeMonsterBodyArea, workPos)
    end
  end
  if table.icontains(scopeMonsterBodyArea, teamPos) then
    needHitBack = true
  end
  if not needHitBack then
    return
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.CanMovePos, {}, teamPos, {
    Vector2(0, 0)
  })
  local attackRange = scopeResult:GetAttackRange()
  local scopeFilter = {}
  for _, pos in ipairs(attackRange) do
    if not table.icontains(scopeMonsterBodyArea, pos) then
      table.insert(scopeFilter, pos)
    end
  end
  local nearestPos = Vector2(1000, 1000)
  for _, pos in ipairs(scopeFilter) do
    local lastPosToTargetPosDistance = Vector2.Distance(nearestPos, teamPos)
    local curPosToTargetPosDistance = Vector2.Distance(pos, teamPos)
    if lastPosToTargetPosDistance > curPosToTargetPosDistance then
      nearestPos = pos
    end
  end
  targetPos = nearestPos
  local dir = targetPos - teamPos
  local boardEntity = self._world:GetBoardEntity()
  local skillEffectService = self._world:GetService("SkillEffectCalc")
  local hitbackResult = skillEffectService:CalcHitbackEffectResultProcess(teamEntity:GetID(), HitBackCalcType.Instant, boardEntity, dir, targetPos)
  return hitbackResult
end

function LogicEntityService:CreateArchivedMonsters(monsters)
  local t = {}
  for k, v in ipairs(monsters) do
    local param = MonsterTransformParam:New(v.monsterID)
    param:SetPosition(v.pos)
    param:SetForward(v.dir)
    param:SetBodyArea(v.bodyArea)
    param:SetOffset(v.offset)
    param._hp = v.hp
    param._airt = v.aiData
    param._bindeff = v.effect
    param._buffrt = v.buffData
    t[#t + 1] = param
  end
  local eMonsters = {}
  local monsterIds = {}
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  for _, v in ipairs(t) do
    local eMonster, monsterId = monsterCreationSvc:CreateMonsterWithInitADH(v, {
      curhp = v._hp,
      airt = v._airt,
      bindeff = v._bindeff,
      buffrt = v._buffrt
    })
    table.insert(eMonsters, eMonster)
    table.insert(monsterIds, monsterId)
    self._world:GetSyncLogger():Trace({
      key = "CreateArchivedMonsters",
      waveNum = 1,
      monsterID = monsterId,
      entityID = eMonster:GetID(),
      pos = tostring(v:GetPosition())
    })
  end
  return eMonsters
end

function LogicEntityService:CreateWaveTraps(waveNum)
  local playerPos
  if self._world:MatchType() ~= MatchType.MT_Chess then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    playerPos = teamEntity:GridLocation().Position
  end
  local levelConfigData = self._configService:GetLevelConfigData()
  local refreshParam = levelConfigData:GetLevelWaveBeginRefreshMonsterParam(waveNum, playerPos)
  local trapIDArray = refreshParam:GetTrapArray()
  self:ModifyTrapTransformByAssembleType(refreshParam, trapIDArray)
  local eTraps = {}
  for index, v in ipairs(trapIDArray) do
    local trapPos, eTrap = self:_CreateTrap(v, playerPos)
    if eTrap and eTrap:HasCurseTower() then
      local curseTowerCmpt = eTrap:CurseTower()
      curseTowerCmpt:SetTowerIndex(index)
    end
    if trapPos and eTrap then
      table.insert(eTraps, eTrap)
    end
  end
  return eTraps
end

function LogicEntityService:ModifyTrapTransformByAssembleType(refreshParam, trapTransformArray)
  local assembleType = refreshParam:GetTrapAssembleType()
  if assembleType == TrapAssembleType.Default then
    return
  end
  if assembleType == TrapAssembleType.CurseTower then
    local towerElementList, towerTrapIDList = self:CalcCurseTowerAssembleResult(trapTransformArray)
    for towerIndex, v in ipairs(trapTransformArray) do
      local trapParam = v
      local elementType = towerElementList[towerIndex]
      local towerTrapID = towerTrapIDList[elementType]
      trapParam:SetTrapID(towerTrapID)
    end
  end
end

function LogicEntityService:CalcCurseTowerAssembleResult(trapTransformArray)
  local towerElementList = {}
  local towerTrapIDList = {}
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamOrder = teamEntity:Team():GetTeamOrder()
  local teamCount = #teamOrder
  local teamMemberCount = teamCount - 1
  for towerIndex, v in ipairs(trapTransformArray) do
    local petPstID = -1
    if teamCount == 1 then
      petPstID = teamOrder[1]
    elseif towerIndex <= teamMemberCount then
      local teamMemberIndex = towerIndex + 1
      petPstID = teamOrder[teamMemberIndex]
    else
      petPstID = teamOrder[1]
    end
    local elementType = ElementType.ElementType_Blue
    local petEntity = self:GetPetEntityByPstID(petPstID)
    if petEntity ~= nil then
      local elementCmpt = petEntity:Element()
      elementType = elementCmpt:GetPrimaryType()
    end
    towerElementList[#towerElementList + 1] = elementType
    local trapParam = v
    towerTrapIDList[#towerTrapIDList + 1] = trapParam:GetTrapID()
  end
  return towerElementList, towerTrapIDList
end

function LogicEntityService:GetPetEntityByPstID(petPstID)
  local petEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.PetPstID)
  for _, e in ipairs(petEntities) do
    local petPstIDCmpt = e:PetPstID()
    if petPstIDCmpt:GetPstID() == petPstID then
      return e
    end
  end
  return nil
end

function LogicEntityService:CreateArchivedTraps(traps)
  local eTraps = {}
  local trapServiceLogic = self._world:GetService("TrapLogic")
  for k, v in ipairs(traps) do
    local eTrap = trapServiceLogic:CreateTrap(v.trapID, v.pos, v.dir, true)
    if eTrap then
      table.insert(eTraps, eTrap)
    end
  end
  return eTraps
end

function LogicEntityService:CreateWaveRefreshTraps(levelMonsterWaveParam, inheritAttributes)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local playerPos = teamEntity:GridLocation().Position
  local trapPosTable = {}
  local eTraps = {}
  for _, v in ipairs(levelMonsterWaveParam) do
    local trapPos, eTrap = self:_CreateTrap(v, playerPos, inheritAttributes)
    if trapPos and eTrap then
      table.insert(trapPosTable, trapPos)
      table.insert(eTraps, eTrap)
    end
  end
  return trapPosTable, eTraps
end

function LogicEntityService:_CreateTrap(trapTransform, playerPos, inheritAttributes)
  local trapID = trapTransform._trapID
  local posList = trapTransform._trapPositionList
  local rotList = trapTransform._trapRotationList
  local checkBlock = trapTransform._trapCheckBlock
  local playerPosIndex = 0
  for i = 1, #posList do
    if playerPos == posList[i] then
      playerPosIndex = i
      break
    end
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local randomRes = randomSvc:LogicRand(1, #posList)
  if randomRes == playerPosIndex then
    if #posList == 1 then
      Log.fatal("[CreateTrap] all trap born pos occupied by player")
      return
    end
    randomRes = randomRes + 1
    if randomRes > #posList then
      randomRes = 1
    end
  end
  local trapPosition = posList[randomRes]
  local trapRotation
  if rotList then
    if randomRes > #rotList then
      Log.fatal("[CreateTrap] trap refresh confit rotation count less than position")
      trapRotation = Vector2(0, -1)
    else
      trapRotation = rotList[randomRes]
    end
  else
    trapRotation = Vector2(0, -1)
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local cfgService = self._world:GetService("Config")
  local configTrap = cfgService:GetTrapConfigData()
  local configData = configTrap:GetTrapData(trapID)
  local bodyArea = configTrap:ExplainTrapArea(configData.Area)
  if checkBlock then
    local posSummon = boardServiceLogic:GetValidSummonPos(posList, bodyArea, {}, BlockFlag.SummonTrap, false)
    if not posSummon then
      return
    end
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local trapEntity = trapServiceLogic:CreateTrap(trapID, trapPosition, trapRotation, true, inheritAttributes)
  return trapPosition, trapEntity
end

function LogicEntityService:Handle_CreateBattleTeamLogic(teamEntity, listMatchPet)
  local petEntities = {}
  local teamOrder = {}
  local leader
  for petIndex, matchPet in ipairs(listMatchPet) do
    local petPstID = matchPet:GetPstID()
    local petEntity = self:_CreateTeamMemberLogic(matchPet, petPstID, teamEntity)
    self:LogNotice("CreateTeamMember() index=", petIndex, " petID=", matchPet:GetTemplateID(), " petPstID=", matchPet:GetPstID(), " petEntityID=", petEntity:GetID(), " awake=", matchPet:GetPetGrade(), " grade=", matchPet:GetPetAwakening(), " level=", matchPet:GetPetLevel(), " equipLv=", matchPet:GetEquipLv())
    if petIndex == 1 then
      leader = petEntity
    end
    table.insert(petEntities, petEntity)
    teamOrder[petIndex] = petPstID
  end
  teamEntity:Team():SetTeamOrder(teamOrder)
  teamEntity:Team():SetTeamPetEntities(petEntities)
  teamEntity:SetTeamLeaderPetEntity(leader)
  return petEntities
end

function LogicEntityService:CreateBattleTeamLogic()
  local levelConfigData = self._configService:GetLevelConfigData()
  local teamPos = levelConfigData:GetPlayerBornPos()
  local teamRotation = levelConfigData:GetPlayerBornRotation()
  if self._world:MatchType() == MatchType.MT_Maze then
    local battle_archive = self:GetService("Maze"):GetBattleArchive()
    if battle_archive then
      teamPos = battle_archive.team.pos
      teamRotation = battle_archive.team.dir
    end
  end
  local teamEntity
  if self._world:MatchType() ~= MatchType.MT_Chess then
    teamEntity = self:_CreateTeamLogic(teamPos, teamRotation)
    local localHelpPetPstID = self._world:GetLocalHelpPetPstID()
    if localHelpPetPstID then
      teamEntity:Team():SetHelpPetPstID(localHelpPetPstID)
    end
    self._world:Player():SetLocalTeamEntity(teamEntity)
    local listMatchPet = self._world:GetLocalMatchPetList()
    self:Handle_CreateBattleTeamLogic(teamEntity, listMatchPet)
    self:ModifyTeamHPPercent(teamEntity)
  end
  if self._world:MatchType() == MatchType.MT_Chess then
    self:_CreateChessPetList()
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamPos = levelConfigData:GetRemotePlayerBornPos()
    local teamRotation = levelConfigData:GetRemotePlayerBornRotation()
    local teamEntity2 = self:_CreateTeamLogic(teamPos, teamRotation)
    teamEntity2:ReplaceAlignment(AlignmentType.Monster)
    teamEntity2:ReplaceGameTurn(GameTurnType.RemotePlayerTurn)
    local listMatchPet = self._world:GetRemoteMatchPetList()
    local petEntities = self:Handle_CreateBattleTeamLogic(teamEntity2, listMatchPet)
    for _, e in ipairs(petEntities) do
      e:ReplaceAlignment(AlignmentType.Monster)
      e:ReplaceGameTurn(GameTurnType.RemotePlayerTurn)
    end
    self._world:Player():SetRemoteTeamEntity(teamEntity2)
    teamEntity2:Team():SetEnemyTeamEntity(teamEntity)
    teamEntity:Team():SetEnemyTeamEntity(teamEntity2)
  end
  if self._world:MatchType() == MatchType.MT_PopStarPro then
    local fettersSvc = self._world:GetService("Fetters")
    fettersSvc:InitFetters()
    local popStarProSvc = self._world:GetService("PopStarProLogic")
    popStarProSvc:ActiveCamp()
  end
  local initBead = false
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local createInfo = self._world.BW_WorldInfo:GetSeasonMazeCreateInfo()
    if createInfo then
      local autoBeadList = createInfo.autobead_list
      if 0 < #autoBeadList then
        initBead = true
      end
    end
  end
  if initBead then
    local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
    autoBeadServiceLogic:InitAutoBeadHolder(teamEntity)
  end
end

function LogicEntityService:_InitPetAttributes(entity, petData, maxCastPower, attackFix, defenseFix, healthFix, teamAlignmentType)
  local maxHP = petData:GetPetHealth()
  local defense = petData:GetPetDefence()
  local attack = petData:GetPetAttack()
  local curHP = maxHP
  local affixSvc = self._world:GetService("Affix")
  curHP, maxHP, defense = affixSvc:ChangePetAttr(maxHP, defense)
  local afterDamage = petData:GetAfterDamage()
  local power = petData:GetPetPower()
  local legendPower = petData:GetPetLegendPower()
  local alchemyPower = petData:GetPetAlchemyPower()
  if power == -1 then
    power = maxCastPower
  end
  local ready = 0
  if power == 0 then
    ready = 1
  end
  local exElementParam = petData:GetPropertyRestraint()
  local attributeComponent = entity:Attributes()
  attributeComponent:Modify("Attack", attack)
  attributeComponent:Modify("Defense", defense)
  attributeComponent:Modify("MaxPower", maxCastPower)
  attributeComponent:Modify("Power", power)
  attributeComponent:Modify("LegendPower", legendPower)
  attributeComponent:Modify("AlchemyPower", alchemyPower)
  attributeComponent:Modify("Ready", ready)
  attributeComponent:Modify("HP", curHP)
  attributeComponent:Modify("MaxHP", maxHP)
  attributeComponent:Modify("AfterDamage", afterDamage)
  attributeComponent:Modify("ExElementParam", exElementParam)
  local utilData = self._world:GetService("UtilData")
  local extraActiveSkill = petData:GetPetExtraActiveSkill()
  if extraActiveSkill and 0 < #extraActiveSkill then
    local configService = self._configService
    for index, extraSkillID in ipairs(extraActiveSkill) do
      local activeSkillConfigData = configService:GetSkillConfigData(extraSkillID)
      if activeSkillConfigData then
        local skillTriggerType = activeSkillConfigData:GetSkillTriggerType()
        if skillTriggerType == SkillTriggerType.Energy then
          local skillTriggerParam = activeSkillConfigData:GetSkillTriggerParam()
          utilData:SetPetMaxPowerAttr(entity, skillTriggerParam, extraSkillID)
          utilData:SetPetPowerAttr(entity, skillTriggerParam, extraSkillID)
          local extraReady = 0
          if skillTriggerParam == 0 then
            extraReady = 1
          end
          utilData:SetPetSkillReadyAttr(entity, extraReady, extraSkillID)
        end
      end
    end
  end
  if teamAlignmentType and teamAlignmentType == AlignmentType.Monster then
  else
    curHP, maxHP, defense = self:HandleEnlightenInfo(entity, petData, curHP, maxHP, defense)
  end
  return curHP, maxHP, defense
end

function LogicEntityService:_ModifyTeamHP(teamEntity, hp, maxhp)
  local attributeComponent = teamEntity:Attributes()
  local newHeroineHp = attributeComponent:GetCurrentHP() + hp
  attributeComponent:Modify("HP", newHeroineHp)
  local maxTeamHp = attributeComponent:GetAttribute("MaxHP") + maxhp
  attributeComponent:Modify("MaxHP", maxTeamHp)
  return maxTeamHp
end

function LogicEntityService:_ModifyTeamDefense(teamEntity, delta, modType)
  modType = modType or AttrModifyType.Default
  local attributeComponent = teamEntity:Attributes()
  local newHeroineDefense = attributeComponent:GetAttribute("Defense") + delta
  attributeComponent:Modify("Defense", newHeroineDefense, modType)
  return newHeroineDefense
end

function LogicEntityService:_CreateTeamLogic(teamPos, teamRotation)
  local teamEntity = self:CreateLogicEntity(EntityConfigIDConst.Team)
  local teamAttrConmpt = teamEntity:Attributes()
  local configService = self._world:GetService("Config")
  local leftCount = configService:GetChangeTeamLeaderCount()
  teamAttrConmpt:Modify("ChangeTeamLeaderCount", leftCount)
  teamEntity:SetGridPosition(teamPos)
  teamEntity:SetGridDirection(teamRotation)
  if self._world:MatchType() == MatchType.MT_PopStar then
    return teamEntity
  end
  local sBoard = self._world:GetService("BoardLogic")
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    local blockFlag = sBoard:GetBlockFlagByBlockId(BattleConst.BlockFlagCfgIDPet_PopStarPro)
    teamEntity:ReplaceBlockFlag(blockFlag)
    sBoard:UpdateEntityBlockFlag(teamEntity, teamEntity:GetGridPosition(), teamEntity:GetGridPosition())
    return teamEntity
  end
  local blockFlag = sBoard:GetBlockFlagByBlockId(BattleConst.BlockFlagCfgIDPet)
  teamEntity:ReplaceBlockFlag(blockFlag)
  sBoard:UpdateEntityBlockFlag(teamEntity, teamEntity:GetGridPosition(), teamEntity:GetGridPosition())
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  boardCmpt:SetPieceElement(teamPos, PieceType.None)
  return teamEntity
end

local passiveCountType = {
  [2] = true,
  [3] = true,
  [4] = true
}

function LogicEntityService:_CreateTeamMemberLogic(petData, petPstID, teamEntity)
  local petEntity = self:CreateLogicEntity(EntityConfigIDConst.Pet)
  petEntity:ReplaceMatchPet(petData)
  local affixService = self._world:GetService("Affix")
  local normalSkillID = petData:GetNormalSkill()
  local chainSkill = affixService:ChangePetSkillChainCount(petData:GetChainSkillInfo())
  local activeSkill = petData:GetPetActiveSkill()
  local extraActiveSkill = petData:GetPetExtraActiveSkill()
  local variantActiveSkill = petData:GetPetVariantActiveSkill()
  local passiveSkillID = petData:GetPetPassiveSkill()
  local intensifyBuffList = petData:GetPetIntensifyBuffList()
  local equipIntensifyParam = petData:GetEquipIntensifyParams()
  self:_InitPetEquipRefine(petData, petEntity)
  local equipRefineChainSkill = petEntity:EquipRefine():GetEquipRefineExtraChainSkillList()
  if equipRefineChainSkill ~= nil then
    for i, v in ipairs(equipRefineChainSkill) do
      if 0 < v then
        local chainSkillData = {
          Skill = v,
          Chain = BattleSkillCfg(v).TriggerParam
        }
        chainSkill[#chainSkill + 1] = chainSkillData
      end
    end
  end
  petEntity:ReplaceSkillInfo(normalSkillID, chainSkill, activeSkill, extraActiveSkill, variantActiveSkill)
  petEntity:SkillInfo():SetPassiveSkillID(passiveSkillID)
  petEntity:SkillInfo():SetIntensifyBuffList(intensifyBuffList)
  local countActiveSkillEnergy = true
  local passiveCountBuffIDArray = {}
  local cfgPassiveSkill = Cfg.cfg_passive_skill[passiveSkillID]
  if cfgPassiveSkill then
    local showMethod = cfgPassiveSkill.ShowMethod
    if showMethod then
      local type = tonumber(showMethod[1])
      if passiveCountType[type] then
        local metaSpecificBuff = showMethod[3]
        if metaSpecificBuff then
          local arr = string.split(metaSpecificBuff, "|")
          for _, buffID in ipairs(arr) do
            table.insert(passiveCountBuffIDArray, tonumber(buffID))
          end
        else
          for _, id in ipairs(cfgPassiveSkill.BuffID) do
            table.insert(passiveCountBuffIDArray, id)
          end
        end
      end
      if type == 4 then
        countActiveSkillEnergy = false
      end
    end
  end
  local cSkillInfo = petEntity:SkillInfo()
  cSkillInfo:SetPassiveCountBuffIDArray(passiveCountBuffIDArray)
  cSkillInfo:SetCountActiveSkillEnergy(countActiveSkillEnergy)
  if equipIntensifyParam and type(equipIntensifyParam) == "table" then
    local cloneEquipIntensifyParam = table.clone(equipIntensifyParam)
    local equipRefineIntensifyParams = petEntity:EquipRefine():GetEquipRefineIntensifyParam()
    if equipRefineIntensifyParams then
      for equipKey, equipParam in ipairs(cloneEquipIntensifyParam) do
        local curEquipBuffID = equipParam.BuffID
        for _, equipRefineParam in ipairs(equipRefineIntensifyParams) do
          if curEquipBuffID == equipRefineParam.BuffID then
            cloneEquipIntensifyParam[equipKey] = equipRefineParam
          end
        end
      end
    end
    petEntity:SkillInfo():SetEquipIntensifyParam(cloneEquipIntensifyParam)
  end
  self:_HandlePetSkinChangeBuff(petData, petEntity)
  local equipRefineActiveSkill = petEntity:EquipRefine():GetEquipRefineExtraActiveSkillList()
  if equipRefineActiveSkill ~= nil then
    petEntity:SkillInfo():SetExtraActiveSkillIDList(equipRefineActiveSkill)
  end
  local equipRefineVariantActiveSkillInfo = petEntity:EquipRefine():GetEquipRefineVariantActiveSkillInfo()
  if equipRefineVariantActiveSkillInfo ~= nil then
    petEntity:SkillInfo():SetVariantActiveSkillInfo(equipRefineVariantActiveSkillInfo)
  end
  local configService = self._configService
  local activeSkillConfigData = configService:GetSkillConfigData(activeSkill)
  local castPower = activeSkillConfigData:GetSkillTriggerParam()
  local attackFix = 0
  local defenseFix = 0
  local healthFix = 0
  local attributeCmpt = petEntity:Attributes()
  local alignmentType
  if self._world:MatchType() == MatchType.MT_BlackFist and teamEntity:HasAlignment() then
    alignmentType = teamEntity:Alignment():GetAlignmentType()
  end
  local hp, maxhp, defense = self:_InitPetAttributes(petEntity, petData, castPower, attackFix, defenseFix, healthFix, alignmentType)
  petEntity:SetGridPosition(teamEntity:GetGridPosition())
  petEntity:SetGridDirection(teamEntity:GetGridDirection())
  local newTeamHp = self:_ModifyTeamHP(teamEntity, hp, maxhp)
  local teamDefense = self:_ModifyTeamDefense(teamEntity, defense)
  local firstElement = petData:GetPetFirstElement()
  local secondElement = petData:GetPetSecondElement()
  attributeCmpt:SetSimpleAttribute("Element", firstElement)
  petEntity:ReplaceElement(firstElement, secondElement)
  local bodyAreaArray = {}
  bodyAreaArray[#bodyAreaArray + 1] = Vector2(0, 0)
  petEntity:ReplaceBodyArea(bodyAreaArray)
  petEntity:ReplacePetPstID(petPstID, petData:GetTemplateID(), petData:GetPetCamp(), petData:IsLegendPet())
  petEntity:Pet():SetOwnerTeamEntity(teamEntity)
  local helpPetPstID = teamEntity:Team():GetHelpPetPstID()
  if helpPetPstID and petPstID == helpPetPstID then
    Log.info("helpPstID: ", helpPetPstID, " logicEntityID:", petEntity:GetID())
    petEntity:PetPstID():SetHelpPet(true)
  end
  self:_HandlePetSkinChangeSkillParam(petData, petEntity)
  return petEntity
end

function LogicEntityService:_HandlePetSkinChangeBuff(petData, petEntity)
  local skinID = petData:GetSkinId()
  local equipIntensifyParam = petData:GetEquipIntensifyParams()
  local skinCfg = Cfg.cfg_pet_skin[skinID]
  if skinCfg then
    local skinIntensifyParam = skinCfg.elementParam
    if skinIntensifyParam then
      local cloneSkinIntensifyParam = table.clone(skinIntensifyParam)
      local curIntensifyParam = equipIntensifyParam
      local equipIntensifyParamInSkillInfo = petEntity:SkillInfo():GetEquipIntensifyParam()
      if equipIntensifyParamInSkillInfo then
        curIntensifyParam = equipIntensifyParamInSkillInfo
      end
      if curIntensifyParam and type(curIntensifyParam) == "table" then
        local cloneEquipIntensifyParam = table.clone(curIntensifyParam)
        local appendList = {}
        for _, skinParam in ipairs(cloneSkinIntensifyParam) do
          local skinBuffID = skinParam.BuffID
          local findInOldParam = false
          for _, equipParam in ipairs(cloneEquipIntensifyParam) do
            local curEquipBuffID = equipParam.BuffID
            if curEquipBuffID == skinBuffID then
              findInOldParam = true
              table.appendArray(equipParam, skinParam)
              break
            end
          end
          if not findInOldParam then
            table.insert(appendList, skinParam)
          end
        end
        table.appendArray(cloneEquipIntensifyParam, appendList)
        petEntity:SkillInfo():SetEquipIntensifyParam(cloneEquipIntensifyParam)
      end
    end
  end
end

function LogicEntityService:_HandlePetSkinChangeSkillParam(petData, petEntity)
  local skinChangeSkillParamConstID = 555
  local skinID = petData:GetSkinId()
  local cfgdecorsvc = self._world:GetService("ConfigDecoration")
  local skinCfg = Cfg.cfg_pet_skin[skinID]
  if skinCfg then
    local skinChangeSkillParam = skinCfg.ChangeSkillParam
    if skinChangeSkillParam and type(skinChangeSkillParam) == "table" then
      local cloneSkinChangeSkillParam = table.clone(skinChangeSkillParam)
      for index, changeSkillParam in ipairs(cloneSkinChangeSkillParam) do
        local skillIDList
        if type(changeSkillParam.skillID) == "number" then
          skillIDList = {
            changeSkillParam.skillID
          }
        else
          skillIDList = changeSkillParam.skillID
        end
        local effectIndex = changeSkillParam.effectIndex
        local appendTb = changeSkillParam.append or {}
        local setTb = changeSkillParam.set or {}
        local removeTb = changeSkillParam.remove or {}
        local appendArray = changeSkillParam.appendArray or {}
        for _, skillID in ipairs(skillIDList) do
          cfgdecorsvc:DecorateSkillEffect(skinChangeSkillParamConstID, petEntity, skillID, effectIndex, appendTb, setTb, removeTb, appendArray)
        end
      end
    end
  end
end

function LogicEntityService:_InitPetEquipRefine(petData, petEntity)
  local equipRefineExtraActiveSkill = petData:GetEquipRefineExtraActiveSkill()
  local equipIntensifyRefineParam = petData:GetEquipRefineIntensifyParams()
  local extraChainSkillListData = petData:GetPetExtraChainSkillList()
  if extraChainSkillListData then
    local chainSkillList = table.clone(extraChainSkillListData)
    petEntity:EquipRefine():SetEquipRefineExtraChainSkillList(chainSkillList)
  end
  local equipRefineBuffListData = petData:GetEquipRefineBuffListData()
  if equipRefineBuffListData then
    local equipRefineBuffList = table.clone(equipRefineBuffListData)
    petEntity:EquipRefine():SetEquipRefineBuffList(equipRefineBuffList)
  end
  local equipRefineFeatureData = petData:GetEquipRefineFeatureList()
  if equipRefineFeatureData then
    local equipRefineFeatureList = table.clone(equipRefineFeatureData)
    petEntity:EquipRefine():SetEquipRefineFeatureList(equipRefineFeatureList)
  end
  petEntity:EquipRefine():SetEquipRefineIntensifyParam(equipIntensifyRefineParam)
  petEntity:EquipRefine():SetEquipRefineExtraActiveSkillList(equipRefineExtraActiveSkill)
  local equipRefineVariantActiveSkillData = petData:GetEquipRefineVariantActiveSkillInfo()
  if equipRefineVariantActiveSkillData then
    local equipRefineVariantActiveSkillInfo = table.clone(equipRefineVariantActiveSkillData)
    petEntity:EquipRefine():SetEquipRefineVariantActiveSkillInfo(equipRefineVariantActiveSkillInfo)
  end
end

function LogicEntityService:_CreateTeamMemberShadow(petEntity)
  local shadowEntity = self:CreateLogicEntity(EntityConfigIDConst.PetShadow)
  local enemyPos = petEntity:GridLocation().Position
  local enemyDir = petEntity:GridLocation().Direction
  local enemyOffset = petEntity:GridLocation().Offset
  local ghostPos = Vector2(enemyPos.x, enemyPos.y)
  local ghostDir = Vector2(enemyDir.x, enemyDir.y)
  local ghostOffset = Vector2(enemyOffset.x, enemyOffset.y)
  shadowEntity:SetGridLocationAndOffset(ghostPos, ghostDir, ghostOffset)
  shadowEntity:ReplaceAlignment(petEntity:Alignment():GetAlignmentType())
  return shadowEntity
end

function LogicEntityService:_CreateChessPetList()
  local levelConfigData = self._configService:GetLevelConfigData()
  local chessPetRefreshIDs = levelConfigData:GetChessPetRefreshID()
  local monsterRefreshParamArray = {}
  for _, chessPetRefreshID in ipairs(chessPetRefreshIDs) do
    local chessPetRefreshConfig = Cfg.cfg_refresh_chesspet[chessPetRefreshID]
    if not chessPetRefreshConfig then
      Log.fatal("Cfg ChessPetRefreshID Not Find ID:", chessPetRefreshID)
    end
    local levelMonsterRefreshParam = LevelMonsterRefreshParam:New(self._world)
    levelMonsterRefreshParam:ParseChessPetRefreshParam(chessPetRefreshConfig)
    table.insert(monsterRefreshParamArray, levelMonsterRefreshParam)
  end
  local chessPetCreationSvc = self._world:GetService("ChessPetCreationLogic")
  local chessPets = chessPetCreationSvc:CreateInternalRefreshMonsterLogic(monsterRefreshParamArray)
  return chessPets
end

function LogicEntityService:CreateWaveMonstersMultiBoard(waveNum)
  local eMonsters = {}
  local playerPos
  local levelConfigData = self._configService:GetLevelConfigData()
  local createMonsterPosService = self._world:GetService("CreateMonsterPos")
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local multiBoard = levelConfigData:GetMultiBoard()
  for i, boardInfo in ipairs(multiBoard) do
    local boardIndex = boardInfo.index
    local monsterRefreshParam = levelConfigData:GetLevelWaveBeginRefreshMonsterParamMultiBoard(boardIndex, waveNum, playerPos)
    if monsterRefreshParam then
      local monsterRefreshPosType = monsterRefreshParam:GetMonsterRefreshPosType()
      local monsterArray = createMonsterPosService:GetMonsterRefreshPos(monsterRefreshPosType, monsterRefreshParam)
      if monsterArray then
        for _, v in ipairs(monsterArray) do
          local eMonster, monsterId = monsterCreationSvc:CreateMonster(v)
          eMonster:AddOutsideRegion(boardIndex)
          table.insert(eMonsters, eMonster)
          self._world:GetSyncLogger():Trace({
            key = "CreateWaveMonstersMultiBoard",
            waveNum = waveNum,
            monsterID = monsterId,
            entityID = eMonster:GetID(),
            pos = tostring(v:GetPosition())
          })
        end
      end
    end
  end
  return eMonsters
end

function LogicEntityService:CreateWaveTrapsMultiBoard(waveNum)
  local playerPos
  local eTraps = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local multiBoard = levelConfigData:GetMultiBoard()
  for i, boardInfo in ipairs(multiBoard) do
    local boardIndex = boardInfo.index
    local refreshParam = levelConfigData:GetLevelWaveBeginRefreshMonsterParamMultiBoard(boardIndex, waveNum, playerPos)
    local trapIDArray = refreshParam:GetTrapArray()
    self:ModifyTrapTransformByAssembleType(refreshParam, trapIDArray)
    for index, v in ipairs(trapIDArray) do
      local trapPos, eTrap = self:_CreateTrap(v, playerPos)
      if eTrap then
        eTrap:AddOutsideRegion(boardIndex)
      end
      if trapPos and eTrap then
        table.insert(eTraps, eTrap)
      end
    end
  end
  return eTraps
end

function LogicEntityService:HandleEnlightenInfo(petEntity, petData, curHPOri, maxHPOri, defenceOri)
  local buffLSvc = self._world:GetService("BuffLogic")
  local primaryType = petData:GetPetFirstElement()
  local enlightenInfo = self._world:GetEnlightenInfoByType(primaryType)
  if enlightenInfo then
    buffLSvc:ModifyAttributeValueByEnlighten(petEntity, enlightenInfo)
    local attributesCmpt = petEntity:Attributes()
    local maxHP = attributesCmpt:CalcMaxHp()
    local curHP = maxHP
    if maxHPOri ~= curHPOri then
      curHP = math.floor(maxHP * curHPOri / maxHPOri + 0.5)
    end
    local defence = attributesCmpt:GetDefence()
    return curHP, maxHP, defence
  end
  return curHPOri, maxHPOri, defenceOri
end

function LogicEntityService:ModifyTeamHPPercent(teamEntity)
  if self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) ~= MatchType.MT_PopStarPro then
    return
  end
  local popStarProSvc = self._world:GetService("PopStarProLogic")
  local hpPercent = popStarProSvc:GetTeamHPPercent()
  local attributesCmpt = teamEntity:Attributes()
  local maxTeamHP = attributesCmpt:GetAttribute("MaxHP")
  local curTeamHP = math.ceil(maxTeamHP * hpPercent / 100)
  attributesCmpt:Modify("HP", curTeamHP)
end
