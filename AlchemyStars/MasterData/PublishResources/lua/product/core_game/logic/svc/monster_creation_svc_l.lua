_class("MonsterCreationServiceLogic", BaseService)
MonsterCreationServiceLogic = MonsterCreationServiceLogic

function MonsterCreationServiceLogic:GenerateMonsterCreationResult()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local eMonsters = group:GetEntities()
  local creationResultList = {}
  for _, v in ipairs(eMonsters) do
    local res = self:GenerateOneMonsterResult(v)
    creationResultList[#creationResultList + 1] = res
  end
  return creationResultList
end

function MonsterCreationServiceLogic:GenerateOneMonsterResult(monsterEntity)
  local cfgSvc = self._world:GetService("Config")
  local monsterConfigData = cfgSvc:GetMonsterConfigData()
  local res = DataMonsterCreationResult:New()
  local utilDataSvc = self._world:GetService("UtilData")
  local appearSkillId = utilDataSvc:GetAppearSkillId(monsterEntity)
  res:SetMonsterAppearSkillID(appearSkillId)
  local elementCmpt = monsterEntity:Element()
  local elementType = elementCmpt:GetPrimaryType()
  res:SetMonsterElement(elementType)
  local monsterIDCmpt = monsterEntity:MonsterID()
  local monsterTemplateID = monsterIDCmpt:GetMonsterID()
  res:SetMonsterTemplateID(monsterTemplateID)
  local hpOffset = monsterConfigData:GetMonsterHPHeightOffset(monsterTemplateID)
  res:SetMonsterHPOffset(hpOffset)
  res:SetMonsterIsBoss(monsterEntity:HasBoss())
  local attrCmpt = monsterEntity:Attributes()
  local maxhp = attrCmpt:CalcMaxHp()
  res:SetMonsterMaxHP(maxhp)
  local curHp = attrCmpt:GetCurrentHP()
  res:SetMonsterHP(curHp)
  local gridLocRes = self:GetMonsterCreationGridLocResult(monsterEntity)
  res:SetMonsterGridLocResult(gridLocRes)
  return res
end

function MonsterCreationServiceLogic:GetMonsterCreationGridLocResult(monsterEntity)
  local gridLocCmpt = monsterEntity:GridLocation()
  local gridLocRes = DataGridLocationResult:New()
  gridLocRes:SetGridLocResultBornPos(gridLocCmpt:GetGridPos())
  gridLocRes:SetGridLocResultBornDir(gridLocCmpt:GetGridDir())
  gridLocRes:SetGridLocResultBornHeight(gridLocCmpt:GetGridLocHeight())
  gridLocRes:SetGridLocResultBornOffset(gridLocCmpt:GetGridOffset())
  gridLocRes:SetGridLocResultDamageOffset(gridLocCmpt:GetDamageOffset())
  return gridLocRes
end

function MonsterCreationServiceLogic:GetCreateADH(monsterID)
  local cfgService = self._configService
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local attack = monsterConfigData:GetMonsterAttack(monsterID)
  local defense = monsterConfigData:GetMonsterDefense(monsterID)
  local hp = monsterConfigData:GetMonsterHealth(monsterID)
  local multiHPData = monsterConfigData:GetMonsterMultiHealth(monsterID)
  if multiHPData then
    hp = multiHPData[1]
  end
  return attack, defense, hp
end

function MonsterCreationServiceLogic:CreateMonster(monsterTransform)
  return self:_CreateMonster(monsterTransform, nil)
end

function MonsterCreationServiceLogic:CreateMonsterWithInitADH(monsterTransform, initAttributes)
  initAttributes.attack = initAttributes.attack ~= nil and math.floor(initAttributes.attack) or nil
  initAttributes.defense = initAttributes.defense ~= nil and math.floor(initAttributes.defense) or nil
  initAttributes.maxhp = initAttributes.maxhp ~= nil and math.floor(initAttributes.maxhp) or nil
  initAttributes.curhp = initAttributes.curhp ~= nil and math.floor(initAttributes.curhp) or nil
  return self:_CreateMonster(monsterTransform, initAttributes)
end

function MonsterCreationServiceLogic:_CreateMonster(monsterTransform, _InitMonsterAttributes)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterID = monsterTransform:GetMonsterID()
  local monsterPosition = monsterTransform:GetPosition()
  local dir = monsterTransform:GetForward()
  local areaArray = monsterTransform:GetBodyArea()
  local positionOffset = monsterTransform:GetOffset()
  local boardIndex = monsterTransform:GetBoardIndex()
  local configMonsterObject = monsterConfigData:GetMonsterObject(monsterID)
  local configMonsterClass = monsterConfigData:GetMonsterClassByMonsterConfig(configMonsterObject)
  local cBattleStat = self._world:BattleStat()
  cBattleStat:AddMonsterIDCreate(monsterID)
  cBattleStat:AddMonsterClassIDCreate(configMonsterObject.ClassID)
  areaArray = areaArray or monsterConfigData:GetMonsterArea(monsterID)
  local moveSpeed = monsterConfigData:GetMonsterSpeed(monsterID)
  local monsterType = monsterConfigData:GetMonsterType(monsterID)
  positionOffset = positionOffset or monsterConfigData:GetMonsterOffset(monsterID)
  local damageOffset = monsterConfigData:GetMonsterDamageOffset(monsterID)
  local isBoss = monsterConfigData:IsBoss(monsterID)
  local isWorldBoss = monsterConfigData:IsWorldBoss(monsterID)
  local monsterName = monsterConfigData:GetMonsterName(monsterID)
  local canMove = monsterConfigData:CanMove(monsterID)
  local canTurn = monsterConfigData:CanTurn(monsterID)
  local block = monsterConfigData:Block(monsterID)
  local affixService = self._world:GetService("Affix")
  local attack = monsterConfigData:GetMonsterAttack(monsterID)
  local defense = monsterConfigData:GetMonsterDefense(monsterID)
  local nEvade = monsterConfigData:GetMonsterEvade(monsterID)
  local maxhp = monsterConfigData:GetMonsterHealth(monsterID)
  local elementType = monsterConfigData:GetMonsterElementType(monsterID)
  local isEliteMonster = monsterConfigData:IsEliteMonster(monsterID)
  local absorbNormal = monsterConfigData:GetAbsorbNormal(monsterID)
  local absorbChain = monsterConfigData:GetAbsorbChain(monsterID)
  local absorbActive = monsterConfigData:GetAbsorbActive(monsterID)
  local damageSyncMonsterID, syncType = monsterConfigData:GetMonsterDamageSyncMonsterID(monsterID)
  local damageSyncEffect = monsterConfigData:GetMonsterDamageSyncEffect(monsterID)
  local snakeBodyEffectID = monsterConfigData:GetMonsterSnakeBodyEffectID(monsterID)
  local multiHPData = monsterConfigData:GetMonsterMultiHealth(monsterID)
  if multiHPData then
    maxhp = multiHPData[1]
  end
  local curhp = maxhp
  local airt, bindeff, buffrt
  if _InitMonsterAttributes ~= nil and type(_InitMonsterAttributes) == "table" then
    if _InitMonsterAttributes.attack ~= nil then
      attack = _InitMonsterAttributes.attack
    end
    if _InitMonsterAttributes.defense ~= nil then
      defense = _InitMonsterAttributes.defense
    end
    if _InitMonsterAttributes.nEvade ~= nil then
      nEvade = _InitMonsterAttributes.nEvade
    end
    if _InitMonsterAttributes.maxhp ~= nil then
      maxhp = _InitMonsterAttributes.maxhp
      curhp = maxhp
    end
    if _InitMonsterAttributes.curhp ~= nil then
      curhp = _InitMonsterAttributes.curhp
    end
    if _InitMonsterAttributes.elementType ~= nil then
      elementType = _InitMonsterAttributes.elementType
    end
    if _InitMonsterAttributes.airt ~= nil then
      airt = _InitMonsterAttributes.airt
    end
    if _InitMonsterAttributes.bindeff ~= nil then
      bindeff = _InitMonsterAttributes.bindeff
    end
    if _InitMonsterAttributes.buffrt ~= nil then
      buffrt = _InitMonsterAttributes.buffrt
    end
  end
  local sEntity = self._world:GetService("LogicEntity")
  local monster_entity = sEntity:CreateLogicEntity(EntityConfigIDConst.Monster)
  local raceType = monsterConfigData:GetMonsterRaceType(monsterID)
  local monsterGroupID = monsterConfigData:GetMonsterGroupID(monsterID)
  local monsterClassID = monsterConfigData:GetMonsterClassID(monsterID)
  local monsterCampType = monsterConfigData:GetMonsterCampType(monsterID)
  monster_entity:ReplaceMonsterID(monsterID, raceType, monsterType, monsterGroupID, monsterClassID, monsterCampType)
  local bossUIHPBarType = monsterConfigData:GetBossUIHPType(monsterID)
  monster_entity:MonsterID():SetUIBossHPBarType(bossUIHPBarType)
  if multiHPData then
    monster_entity:MonsterID():InitMultiHPData(multiHPData)
  end
  if damageSyncMonsterID then
    monster_entity:MonsterID():SetDamageSyncMonsterID(damageSyncMonsterID)
    monster_entity:MonsterID():SetDamageSyncFindType(syncType)
    if damageSyncEffect then
      monster_entity:MonsterID():SetDamageSyncEffect(damageSyncEffect.effectID)
    end
  end
  monster_entity:MonsterID():SetSnakeBodyEffect(snakeBodyEffectID)
  local auraData = monsterConfigData:GetMonsterAuraRangeData(monsterID)
  if auraData then
    local groupID = auraData.groupID
    local rangeSkillID = auraData.rangeSkillID
    monster_entity:MonsterID():SetAuraRangeData(rangeSkillID, groupID)
  end
  local monsterStep = monsterConfigData:GetMonsterStep(monsterID)
  local aiTargetType = monsterConfigData:GetMonsterAITargetType(monsterID)
  monster_entity:InitAI(self._world, monsterID, monsterStep, aiTargetType)
  monster_entity:SetAICanMoveTurn(monsterID, canMove, canTurn)
  local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID)
  monsterAIIDList = affixService:ChangeMonsterAI(monsterID, AILogicPeriodType.Main, monsterAIIDList)
  monster_entity:AddNewAI(monsterID, AILogicPeriodType.Main, monsterAIIDList)
  local monsterPreMoveAIIDList = monsterConfigData:GetMonsterPreMoveAIID(monsterID)
  monsterPreMoveAIIDList = affixService:ChangeMonsterAI(monsterID, AILogicPeriodType.Prev, monsterPreMoveAIIDList)
  monster_entity:AddNewAI(monsterID, AILogicPeriodType.Prev, monsterPreMoveAIIDList)
  local monsterAntiAttackAIIDList = monsterConfigData:GetMonsterAntiAttackAIID(monsterID)
  monsterAntiAttackAIIDList = affixService:ChangeMonsterAI(monsterID, AILogicPeriodType.Anti, monsterAntiAttackAIIDList)
  monster_entity:AddNewAI(monsterID, AILogicPeriodType.Anti, monsterAntiAttackAIIDList)
  monster_entity:InitPreviewLogic(AILogicPeriodType.Main)
  if airt then
    monster_entity:AI():SetRuntimeDataAll(airt)
  end
  if bindeff then
    monster_entity:AddArchivedEffect(bindeff)
  end
  monster_entity:ReplaceBodyArea(areaArray)
  monster_entity:SetGridLocationAndOffset(monsterPosition, dir, positionOffset, damageOffset, true)
  self._world:GetService("Battle"):AddMonsterAuraRange(monster_entity)
  local boardService = self._world:GetService("BoardLogic")
  local blockFlag = boardService:GetBlockFlagByBlockId(block)
  monster_entity:ReplaceBlockFlag(blockFlag)
  if not boardIndex then
    boardService:UpdateEntityBlockFlag(monster_entity, monsterPosition, monsterPosition)
  else
    local boardMultiServiceLogic = self._world:GetService("BoardMultiLogic")
    boardMultiServiceLogic:UpdateEntityBlockFlagMultiBoard(boardIndex, monster_entity, monsterPosition, monsterPosition)
  end
  attack = affixService:ChangeMonsterAttr(monsterID, attack, AffixAttrType.Attack)
  defense = affixService:ChangeMonsterAttr(monsterID, defense, AffixAttrType.Defence)
  maxhp = affixService:ChangeMonsterAttr(monsterID, maxhp, AffixAttrType.HP)
  if curhp > maxhp then
    curhp = maxhp
  end
  if isWorldBoss then
    curhp = BattleConst.WorldBossHP
    maxhp = BattleConst.WorldBossHP
    local battleStatCmpt = self:_GetBattleStatComponent()
    if not battleStatCmpt:GetMainWorldBossID() then
      battleStatCmpt:SetMainWorldBossID(monster_entity:GetID())
    end
  end
  local attributeCmpt = monster_entity:Attributes()
  attributeCmpt:Modify("Attack", attack)
  attributeCmpt:Modify("Defense", defense)
  attributeCmpt:Modify("Evade", nEvade)
  attributeCmpt:Modify("HP", curhp)
  attributeCmpt:Modify("MaxHP", maxhp)
  attributeCmpt:Modify("Mobility", monsterStep, 1, MultModifyOperator.PLUS)
  attributeCmpt:Modify("MaxMobility", 99)
  local battleDamageStatisticsServiceLogic = self._world:GetService("BattleDamageStatisticsLogic")
  battleDamageStatisticsServiceLogic:AddMonsterHPMaxStatistics(maxhp)
  monster_entity:ReplaceElement(elementType, nil)
  attributeCmpt:SetSimpleAttribute("Element", elementType)
  attributeCmpt:Modify("AbsorbNormal", absorbNormal)
  attributeCmpt:Modify("AbsorbChain", absorbChain)
  attributeCmpt:Modify("AbsorbActive", absorbActive)
  local antiAttackParam = monsterConfigData:GetMonsterAntiAttackParam(monsterID)
  if antiAttackParam then
    attributeCmpt:Modify("OriginalWaitActiveSkillCount", antiAttackParam.WaitActiveSkillCount)
    attributeCmpt:Modify("OriginalMaxAntiSkillCountPerRound", antiAttackParam.MaxAntiSkillCountPerRound)
    attributeCmpt:Modify("WaitActiveSkillCount", antiAttackParam.WaitActiveSkillCount)
    attributeCmpt:Modify("MaxAntiSkillCountPerRound", antiAttackParam.MaxAntiSkillCountPerRound)
    attributeCmpt:Modify("AntiActiveSkillType", antiAttackParam.AntiActiveSkillType or {})
    if antiAttackParam.AntiSkillEnabled then
      attributeCmpt:Modify("AntiSkillEnabled", antiAttackParam.AntiSkillEnabled)
    end
  end
  if isBoss then
    monster_entity:ReplaceBoss()
  end
  if isWorldBoss then
    self:InitWorldBossHPData(monster_entity, monsterID)
  end
  self._world:GetService("Trigger"):Notify(NTMonsterShow:New(monster_entity))
  local monsterBornBuffContext = {isMonsterBornBuff = true}
  local buffLogic = self._world:GetService("BuffLogic")
  local buffList = monsterConfigData:GetBornBuffList(monsterID)
  if 0 < #buffList then
    if not monster_entity:HasBuff() then
      monster_entity:AddBuffComponent()
    end
    for _, buffId in ipairs(buffList) do
      buffLogic:AddBuff(buffId, monster_entity, monsterBornBuffContext)
    end
  end
  local battleSvc = self._world:GetService("Battle")
  local eliteIDArray, eliteBuffArray = battleSvc:CalcEliteIDArray(monsterID)
  for _, eliteID in ipairs(eliteIDArray) do
    local c = Cfg.cfg_monster_elite[eliteID]
    if not c then
      Log.error("[ELITE_MSTR]", "invalid eliteID: ", eliteID)
    elseif c.Buff and #c.Buff ~= 0 then
      for _, buffID in ipairs(c.Buff) do
        Log.info("[ELITE_MSTR]", "entityID: ", monster_entity:GetID(), "elite ID: ", eliteID, ", buffID: ", buffID)
        buffLogic:AddBuff(buffID, monster_entity, monsterBornBuffContext)
      end
    end
  end
  for _, buffID in ipairs(eliteBuffArray) do
    Log.info("[ELITE_MSTR]", "entityID: ", monster_entity:GetID(), ", buffID: ", buffID)
    buffLogic:AddBuff(buffID, monster_entity, monsterBornBuffContext)
  end
  if 0 < #eliteIDArray then
    monster_entity:MonsterID():SetEliteIDArray(eliteIDArray)
  end
  if buffrt then
    monster_entity:BuffComponent():LoadArchivedData(buffrt)
    local utilDataSvc = self._world:GetService("UtilData")
    utilDataSvc:UpdateRenderHPLockInfoByLogic(monster_entity)
  end
  local trapsvc = self._world:GetService("TrapLogic")
  if self._world:GameFSM():CurStateID() ~= GameStateID.Loading and not self._world:GetService("Maze"):IsArchivedBattle() then
    self:CalcAppearSkill(monster_entity)
    local tEntities, tResults = trapsvc:TriggerTrapByEntity(monster_entity, TrapTriggerOrigin.Move)
    if 0 < #tEntities and 0 < #tResults then
      monster_entity:AddAppearTriggerTrap(tEntities, tResults)
    end
  end
  self._world:GetSyncLogger():Trace({
    key = "CreateMonster",
    monsterID = monsterID,
    entityID = monster_entity:GetID(),
    elementType = elementType,
    pos = tostring(Vector2.Pos2Index(monsterPosition))
  })
  return monster_entity, monsterID
end

function MonsterCreationServiceLogic:CreateInternalRefreshMonsterLogic(monsterWaveInternalTime)
  local monsterConfigDataArray = self:_GetInternalRefreshConfigData()
  if monsterConfigDataArray == nil then
    return
  end
  local monsterRefreshService = self._world:GetService("MonsterRefresh")
  local entityService = self._world:GetService("LogicEntity")
  local eTrapList = {}
  local eMonsterList = {}
  for _, refreshConfigData in ipairs(monsterConfigDataArray) do
    local refreshType = refreshConfigData:GetInternalRefreshType()
    local refreshParam = refreshConfigData:GetInternalRefreshParam()
    local hadRefreshRound = refreshConfigData:GetHadRefreshRound(refreshType)
    local isRefreshMonster = monsterRefreshService:IsRefreshMonster(refreshType, refreshParam, monsterWaveInternalTime, hadRefreshRound)
    if isRefreshMonster and refreshType ~= MonsterWaveInternalRefreshType.None then
      local roundCount = self:_GetBattleStatComponent():GetCurWaveTotalRoundCount()
      refreshConfigData:AddRefreshRound(refreshType, roundCount)
      local newGapTiles = refreshConfigData:GetGapTiles()
      if newGapTiles then
        self:_DoRefreshBoardGapTiles(newGapTiles)
      end
      local _, eTraps = entityService:CreateWaveRefreshTraps(refreshConfigData:GetInternalTrapIDDic())
      table.appendArray(eTrapList, eTraps)
      local monsterPosList = self:_CalcInternalRefreshMonsterPos(refreshConfigData)
      local eMonsters, monsterIds = self:CreateMonsters(monsterPosList)
      table.appendArray(eMonsterList, eMonsters)
    end
  end
  return eTrapList, eMonsterList
end

function MonsterCreationServiceLogic:_GetInternalRefreshConfigData()
  local levelConfigData = self._configService:GetLevelConfigData()
  local waveNum = self:_GetBattleStatComponent():GetCurWaveIndex()
  local monsterConfigDataArray = levelConfigData:GetLevelWaveInternalRefreshData(waveNum)
  return monsterConfigDataArray
end

function MonsterCreationServiceLogic:_CalcInternalRefreshMonsterPos(refreshConfigData)
  local monsterRefreshParam = refreshConfigData:GetMonsterRefreshParam()
  local createMonsterPosService = self._world:GetService("CreateMonsterPos")
  local monsterRefreshPosType = monsterRefreshParam:GetMonsterRefreshPosType()
  local monsterArray = createMonsterPosService:GetMonsterRefreshPos(monsterRefreshPosType, monsterRefreshParam)
  return monsterArray
end

function MonsterCreationServiceLogic:CreateMonsters(monsterArray)
  local eMonsters = {}
  local monsterIds = {}
  for _, v in ipairs(monsterArray) do
    local eMonster, monsterId = self:CreateMonster(v)
    table.insert(eMonsters, eMonster)
    table.insert(monsterIds, monsterId)
    self._world:GetSyncLogger():Trace({
      key = "CreateInternalMonsters",
      monsterID = monsterId,
      entityID = eMonster:GetID(),
      pos = tostring(v:GetPosition())
    })
  end
  return eMonsters, monsterIds
end

function MonsterCreationServiceLogic:CalcAppearSkill(e)
  local sSkillLogic = self._world:GetService("SkillLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local appearSkillId = utilDataSvc:GetAppearSkillId(e)
  if appearSkillId and 0 < appearSkillId then
    sSkillLogic:CalcSkillEffect(e, appearSkillId)
    sSkillLogic:UpdateRenderSkillRoutine(e)
  end
end

function MonsterCreationServiceLogic:_DoRefreshBoardGapTiles(fillPieceList)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardServiceRender = self._world:GetService("BoardRender")
  local oldGapTiles = boardServiceLogic:GetGapTiles()
  local newGapTiles = {}
  for i = 1, #oldGapTiles do
    local bFind = false
    for j = 1, #fillPieceList do
      if fillPieceList[j][1] == oldGapTiles[i][1] and fillPieceList[j][2] == oldGapTiles[i][2] then
        bFind = true
      end
    end
    if bFind ~= true then
      table.insert(newGapTiles, {
        oldGapTiles[i][1],
        oldGapTiles[i][2]
      })
    end
  end
  boardServiceLogic:ChangeGapTiles(newGapTiles)
  local addPiecePos = {}
  for i = 1, #fillPieceList do
    table.insert(addPiecePos, Vector2(fillPieceList[i][1], fillPieceList[i][2]))
  end
  local boardEntity = self._world:GetBoardEntity()
  local pieceFillTable = boardServiceLogic:SupplyPieceList(addPiecePos)
  local boardCmpt = boardEntity:Board()
  boardCmpt:FillPieces(pieceFillTable)
  for i, grid in ipairs(pieceFillTable) do
    local gridPos = Vector2(grid.x, grid.y)
    boardServiceRender:CreateGridEntity(grid.color, gridPos, false)
  end
end

function MonsterCreationServiceLogic:MakePhantomLogic(result)
  local monsterTransformParam = MonsterTransformParam:New(result:GetTargetID())
  monsterTransformParam:SetPosition(result:GetBornPos())
  monsterTransformParam:SetRotation(result:GetBornRot())
  local phantomEntity, id = self:CreateMonster(monsterTransformParam)
  phantomEntity:AddPhantomComponent(result:GetOwnerID())
  local attributeCmpt = phantomEntity:Attributes()
  local maxHp = attributeCmpt:CalcMaxHp()
  local hp = math.floor(maxHp * result:GetHPPercent())
  attributeCmpt:SetSimpleAttribute("MaxHP", hp)
  attributeCmpt:SetSimpleAttribute("HP", hp)
  return phantomEntity
end

function MonsterCreationServiceLogic:InitWorldBossHPData(entity, monsterID)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local stage = monsterConfigData:GetWorldBossConfig(monsterID)
  local monsterIDCmpt = entity:MonsterID()
  monsterIDCmpt:InitWorldBossStageData(stage)
  monsterIDCmpt:SetWorldBossState(true)
  local newAttrData = monsterIDCmpt:GetWorldBossStageAttrData(monsterIDCmpt:GetCurStage())
  if newAttrData then
    local affixService = self._world:GetService("Affix")
    local attributeCmpt = entity:Attributes()
    local newAtk = newAttrData.atk
    local newDef = newAttrData.def
    if newAtk then
      newAtk = affixService:ChangeMonsterAttr(monsterID, newAtk, AffixAttrType.Attack)
      attributeCmpt:Modify("Attack", newAtk)
    end
    if newDef then
      newDef = affixService:ChangeMonsterAttr(monsterID, newDef, AffixAttrType.Defence)
      attributeCmpt:Modify("Defense", newDef)
    end
  end
end

function MonsterCreationServiceLogic:_RotateBodyArea(oriBodyArea, toDir)
  local rotatedOriBodyArea = {}
  if toDir == Vector2.up then
    for index, pos in ipairs(oriBodyArea) do
      local newPos = Vector2(-pos.x, -pos.y)
      table.insert(rotatedOriBodyArea, newPos)
    end
  elseif toDir == Vector2.right then
    for index, pos in ipairs(oriBodyArea) do
      local newPos = Vector2(-pos.y, pos.x)
      table.insert(rotatedOriBodyArea, newPos)
    end
  elseif toDir == Vector2.left then
    for index, pos in ipairs(oriBodyArea) do
      local newPos = Vector2(pos.y, -pos.x)
      table.insert(rotatedOriBodyArea, newPos)
    end
  elseif toDir == Vector2.down then
    rotatedOriBodyArea = oriBodyArea
  end
  return rotatedOriBodyArea
end

function MonsterCreationServiceLogic:BuildMoveGroup(monsterList, periodType, aiOrder, paralleID)
  local cBattleStat = self._world:BattleStat()
  local monsterMoveGroupID = cBattleStat:GeneMonsterMoveGroupID()
  aiOrder = aiOrder or AILogicOrderType.BaseOrder
  paralleID = paralleID or 1000
  periodType = periodType or AILogicPeriodType.Main
  for i, entity in ipairs(monsterList) do
    local monsterIDCmpt = entity:MonsterID()
    local aiCmpt = entity:AI()
    local logic = aiCmpt:_FindLogic(periodType, aiOrder)
    monsterIDCmpt:SetMoveGroupID(monsterMoveGroupID)
  end
  return monsterMoveGroupID
end
