_class("TrapServiceLogic", BaseService)
TrapServiceLogic = TrapServiceLogic

function TrapServiceLogic:Constructor(world)
  self._trapTargetSelector = TrapTargetSelector:New(world)
  self._triggerTraps = {}
  self._flushLayer = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true
  }
  self._onlyViewTrapLayer = -1
end

function TrapServiceLogic:GetTrapGroup()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  return trapGroup
end

local function Filter_CanSummonTrapOnPos(e, trapData, onlyViewTrap, ignoreAbyss, hasSticker)
  if e:HasTrap() then
    if e:Trap():GetTrapLevel() == 0 and not e:HasDeadMark() then
      if onlyViewTrap then
        return false
      end
      if e:Trap():GetTrapType() == TrapType.TerrainAbyss and (ignoreAbyss or hasSticker) then
        return false
      end
      return true
    end
    if not e:HasDeadMark() and e:Trap():GetTrapLevel() == trapData.TrapLevel and not onlyViewTrap and e:Trap():GetReplaceLevel() > trapData.ReplaceLevel then
      return true
    end
    return false
  end
end

function TrapServiceLogic:CanSummonTrapOnPos(pos, trapId, blockFlag, ignoreAbyss)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsValidPiecePos(pos) then
    return false
  end
  blockFlag = blockFlag or BlockFlag.SummonTrap
  if utilDataSvc:IsPosBlock(pos, blockFlag) then
    return false
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapId)
  local sticker = boardCmpt:GetPieceEntities(pos, function(e)
    return e:HasTrap() and e:Trap():IsSticker() and not e:HasDeadMark()
  end)
  local hasSticker = 0 < #sticker
  local onlyViewTrap = self:IsViewTrapLevel(trapData.TrapLevel)
  local es = boardCmpt:GetPieceEntities(pos, Filter_CanSummonTrapOnPos, trapData, onlyViewTrap, ignoreAbyss, hasSticker)
  return #es == 0
end

function TrapServiceLogic:_GetTransferTrapAtPos(trapID, pos)
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local transferTrapIDs = trapData.TransferTrapIDs
  if not transferTrapIDs then
    return
  end
  local transferTrapIndex = {}
  for k, v in ipairs(transferTrapIDs) do
    transferTrapIndex[v] = k
  end
  local utilSvc = self._world:GetService("UtilData")
  local samePosTraps = utilSvc:GetTrapsAtPos(pos)
  local replaceTrap
  for _, e in ipairs(samePosTraps) do
    local trapCmpt = e:Trap()
    if transferTrapIndex[trapCmpt:GetTrapID()] then
      local idx = transferTrapIndex[trapCmpt:GetTrapID()] + 1
      return transferTrapIDs[idx], e
    end
  end
end

function TrapServiceLogic:CreateTrap(trapID, pos, dir, isHideOnBegin, inheritAttrParam, ownerEntity, transferDisabled, aiOrder, dataTab)
  local newTrapID, transferOldEntity
  if not transferDisabled then
    newTrapID, transferOldEntity = self:_GetTransferTrapAtPos(trapID, pos)
    if transferOldEntity then
      self:LogWarn("transfer trap: formerID=", trapID, "<nullable>newID=", newTrapID, "pos=", tostring(pos), "oldTrapEntityID=", transferOldEntity:GetID())
      if newTrapID then
        trapID = newTrapID
      end
      transferOldEntity:Attributes():Modify("HP", 0)
      self:AddTrapDeadMark(transferOldEntity)
      self:LogWarn("transfer group trap: ", pos)
    end
  end
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local isOnlyViewTrap = self:IsViewTrapLevel(trapData.TrapLevel)
  local utilSvc = self._world:GetService("UtilData")
  local samePosTraps = utilSvc:GetTrapsAtPos(pos)
  local replaceTrap
  if 0 < #samePosTraps then
    for _, e in ipairs(samePosTraps) do
      local trapCmpt = e:Trap()
      if trapCmpt:GetTrapType() == TrapType.GapTileTrap then
        return
      end
      if trapCmpt:GetTrapLevel() == trapData.TrapLevel and not isOnlyViewTrap then
        if trapCmpt:GetReplaceLevel() <= trapData.ReplaceLevel then
          if not e:HasDeadMark() then
            e:Attributes():Modify("HP", 0)
            self:AddTrapDeadMark(e)
            replaceTrap = e
            self:LogWarn("Replace trap at: ", pos)
            break
          end
        else
          self:LogWarn("该位置有相同层但更高优先级的机关，所以不创建。pos:", pos, " NewTrap:", trapID, " OldTrap:", trapCmpt:GetTrapID())
          return
        end
      end
    end
  end
  local entityService = self._world:GetService("LogicEntity")
  local trapEntity = entityService:CreateLogicEntity(EntityConfigIDConst.Trap)
  trapEntity:ReplaceTrapID(trapID)
  Log.debug("CreateTrap entityID=", trapEntity:GetID(), " trapID=", trapID, " pos=", pos)
  if replaceTrap then
    local deadMarkCmpt = replaceTrap:DeadMark()
    deadMarkCmpt:SetDeadCasterID(trapEntity:GetID())
  end
  if ownerEntity then
    trapEntity:ReplaceAlignment(ownerEntity:Alignment():GetAlignmentType())
    trapEntity:ReplaceGameTurn(ownerEntity:GameTurn():GetGameTurn())
    trapEntity:AddSummoner(ownerEntity:GetID())
  end
  local areaArray = {}
  if dataTab and dataTab.BodyArea then
    areaArray = dataTab.BodyArea
  elseif trapData.Area then
    for i, str in ipairs(trapData.Area) do
      local numStr = string.split(str, ",")
      local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
      table.insert(areaArray, vec2)
    end
  else
    table.insert(areaArray, Vector2.zero)
  end
  trapEntity:ReplaceBodyArea(areaArray)
  local trapRotation = dir
  trapEntity:SetGridLocation(pos, trapRotation)
  if trapData.PositionOffset then
    local strArraypositionOffset = string.split(trapData.PositionOffset, ",")
    local positionOffset = Vector2(tonumber(strArraypositionOffset[1]), tonumber(strArraypositionOffset[2]))
    trapEntity:SetGridOffset(positionOffset)
  end
  if trapData.AIID then
    if aiOrder and 1 < table.count(trapData.AIID) then
      self:ThrowException("该机关创建时使用的是召唤顺序作为AI顺序，配置的AI数量不能超过1，TrapID:", trapID)
    end
    trapEntity:InitAI(self._world, trapID, 1, trapData.AITargetType)
    trapEntity:AddNewAIByConfig(trapID, trapData.AIID, aiOrder)
  end
  if trapData.TrapType == TrapType.CurseTower then
    trapEntity:AddCurseTower()
  end
  if trapData.TrapType == TrapType.TrapExtendSkillScope then
    trapEntity:AddTrapExtendSkillScope(trapData.TrapTypeComponentParam)
  end
  local cTrap = trapEntity:Trap()
  cTrap:SetTrapID(trapID)
  cTrap:SetTrapType(trapData.TrapType)
  cTrap:SetTypeParam(trapData.TypeParam)
  cTrap:SetTrapEffect(trapData.TrapEffectType, trapData.TrapEffectParam)
  cTrap:SetTrapRaceType(trapData.RaceType, trapData.RaceParams)
  cTrap:SetTrapDestroy(trapData.DestroyType, trapData.DestroyParam)
  cTrap:SetOrgDir(trapRotation)
  cTrap:SetTrapLevel(trapData.TrapLevel)
  cTrap:SetReplaceLevel(trapData.ReplaceLevel)
  cTrap:SetSkillType(trapData.SkillType)
  cTrap:SetTriggerByRace(trapData.TriggerByRace)
  cTrap:SetGroupID(trapData.GroupID)
  cTrap:SetGroupTriggerTrapID(trapData.GroupTriggerTrapID)
  cTrap:SetCanBePurified(trapData.CanBePurified)
  cTrap:SetSpecialDestroy(trapData.SpecialDestroy)
  cTrap:SetFallWithGrid(trapData.FallWithGrid)
  cTrap:SetTrapBornRound(self._world:BattleStat():GetLevelTotalRoundCount())
  cTrap:SetCantAutoSkill(trapData.CantAutoSkill)
  local affixService = self._world:GetService("Affix")
  local trapDataSkillID = trapData.SkillID
  if trapDataSkillID then
    local newTrapDataSkillID = {}
    for k, v in pairs(trapDataSkillID) do
      local value = affixService:ChangeTrapSkill(trapID, v, k)
      newTrapDataSkillID[k] = value
    end
    cTrap:SetSkillID(newTrapDataSkillID)
  end
  local boardServiceL = self._world:GetService("BoardLogic")
  local oldPieceType = boardServiceL:GetPieceType(pos)
  cTrap:SetRecordPieceType(oldPieceType)
  if trapData.GridPieceElement then
    for _, areaPos in ipairs(areaArray) do
      local workPos = pos + areaPos
      if utilSvc:IsValidPiecePos(workPos) then
        boardServiceL:SetPieceTypeLogic(trapData.GridPieceElement, workPos)
      end
    end
  end
  cTrap:SetBlockByRaceType(trapData.BlockByRace)
  local block = trapData.Block or 0
  local blockFlag = boardServiceL:GetBlockFlagByBlockId(block)
  trapEntity:ReplaceBlockFlag(blockFlag)
  boardServiceL:UpdateEntityBlockFlag(trapEntity, pos, pos)
  local round = 1
  if trapData.ShowParam then
    round = trapData.ShowParam.roundTotal or 1
  end
  if trapData.DestroyType == TrapDestroyType.DestroyByRound then
    local trapCmpt = trapEntity:Trap()
    round = trapCmpt:GetTrapDestroyParam():GetNum()
  end
  trapEntity:Attributes():Modify("TotalRound", round)
  local currentRound = 1
  if trapData.TrapEffectType == TrapEffectType.RuneChange or trapData.TrapEffectType == TrapEffectType.ShowCountDownType then
    if trapData.TrapEffectType == TrapEffectType.RuneChange then
      if trapData.DestroyParam and trapData.DestroyParam[2] then
        currentRound = tonumber(trapData.DestroyParam[2])
      else
        currentRound = 0
      end
    end
    trapEntity:Attributes():Modify("CurrentRound", currentRound)
  end
  local res = DataAttributeResult:New(trapEntity:GetID(), "CurrentRound", currentRound)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  res = DataAttributeResult:New(trapEntity:GetID(), "TotalRound", round)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  local attr = trapEntity:Attributes()
  local attrParam = trapData.Attributes
  if attrParam then
    for k, v in pairs(attrParam) do
      local value = affixService:ChangeTrapAttr(trapID, v, k)
      if inheritAttrParam and inheritAttrParam[k] then
        value = inheritAttrParam[k]
      end
      attr:Modify(k, value)
      if k == "OpenState" then
        res = DataAttributeResult:New(trapEntity:GetID(), "OpenState", value)
        self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
      end
    end
  end
  attr:Modify("Mobility", 1, 1, MultModifyOperator.PLUS)
  attr:Modify("MaxMobility", 99)
  if trapData.CanBeAttack then
    attr:Modify("CanBeAttacked", 1)
  end
  attr:Modify("CastSkillRound", {})
  if trapData.TrapElement then
    local elementType = trapData.TrapElement
    if inheritAttrParam and inheritAttrParam.Element then
      elementType = inheritAttrParam.Element
    end
    trapEntity:AddElement(elementType, nil)
    attr:SetSimpleAttribute("Element", elementType)
  end
  if cTrap:GetTrapType() == TrapType.Auras then
    local skillID = trapData.TypeParam.rangeSkillID
    local skillConfigData = self._configService:GetSkillConfigData(skillID)
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local skillScopeRes = utilScopeSvc:CalcSkillScope(skillConfigData, pos, trapEntity, dir)
    cTrap:SetAuraRange(skillScopeRes:GetAttackRange())
    self:AddAuraRange(cTrap:GetAuraGroupID(), skillScopeRes:GetAttackRange())
  end
  self:_CalcTrapAppearSkill({trapEntity})
  self:_CalcTrapAddBuff(trapEntity, trapData.BuffID, trapID)
  local groupId = cTrap:GetScopeCenterGroupId()
  if 0 < groupId then
    trapEntity:AddScopeCenter(groupId)
  end
  self._world:GetSyncLogger():Trace({
    key = "CreateTrap",
    trapID = trapID,
    entityID = trapEntity:GetID(),
    pos = pos
  })
  self:AddTrapToBoardComponent(pos, trapEntity)
  if cTrap:GetTrapType() == TrapType.Protected then
    self._world:BattleStat():SaveProtectTrap(trapID, pos, dir)
  end
  if cTrap:GetTrapType() == TrapType.Wall then
    self:_CalcTrapWall(trapEntity, trapData.TypeParam)
  end
  local data = DataTrapCreationResult:New()
  data:SetTrapCreationResult_TrapID(trapID)
  data:SetTrapEntityID(trapEntity:GetID())
  data:SetTrapHP(trapEntity:Attributes():GetCurrentHP())
  data:SetTrapHPMax(trapEntity:Attributes():CalcMaxHp())
  if replaceTrap then
    data:SetReplaceTrapID(replaceTrap:GetID())
  end
  if transferOldEntity then
    data:SetTransferTrapID(transferOldEntity:GetID())
  end
  if cTrap:GetTrapType() == TrapType.Wall then
    local trapWallPosList = self:_GetTrapWallPosListByEntityID(trapEntity:GetID())
    data:SetTrapWallPosList(trapWallPosList)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
  local triggerSvc = self._world:GetService("Trigger")
  local nt = NTTrapShow:New(trapEntity, ownerEntity)
  local cBattleStat = self._world:BattleStat()
  if ownerEntity then
    nt:SetIsFirstSummon(not cBattleStat:IsTrapSummonedByCasterBefore(trapID, ownerEntity:GetID()))
  end
  triggerSvc:Notify(nt)
  local resultContainer = trapEntity:SkillRoutine():GetResultContainer()
  local dataTrapAppearSkill = DataTrapAppearSkill:New()
  dataTrapAppearSkill:SetTrapEntity(trapEntity):SetResultContainer(resultContainer)
  self._world:EventDispatcher():Dispatch(GameEventType.DataTrapAppearSkill, dataTrapAppearSkill)
  if trapData.TriggerWhileSpawn then
    self:DoTriggerWhileSpawn(trapEntity, pos)
  end
  local cfgTrapScan = Cfg.cfg_trap_scan[trapID]
  if cfgTrapScan then
    local eLocalTeam = self._world:Player():GetLocalTeamEntity()
    if not cfgTrapScan.PetID or ownerEntity and ownerEntity:HasPet() and eLocalTeam:GetID() == ownerEntity:Pet():GetOwnerTeamEntity():GetID() then
      cBattleStat:AddScanTrapIDInMatch(trapID)
    end
  end
  if ownerEntity then
    cBattleStat:AddTrapIDByCasterEntityID(trapID, ownerEntity:GetID())
  end
  local ntTrapShowEnd = NTTrapShowEnd:New(trapEntity, ownerEntity, pos, areaArray)
  if ownerEntity then
    ntTrapShowEnd:SetIsFirstSummon(not cBattleStat:IsTrapSummonedByCasterBefore(trapID, ownerEntity:GetID()))
  end
  triggerSvc:Notify(ntTrapShowEnd)
  return trapEntity
end

function TrapServiceLogic:DoTriggerWhileSpawn(trapEntity, pos)
  local potentialTriggerEntity
  local globalMonsterGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    globalMonsterGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Team)
  end
  for _, e in ipairs(globalMonsterGroupEntities) do
    local bodyArea, gridPos, isRightPos
    if not e:HasDeadMark() then
      gridPos = e:GetGridPosition()
      bodyArea = e:BodyArea():GetArea()
      for _, v2Relative in ipairs(bodyArea) do
        local v2 = gridPos + v2Relative
        if v2 == pos then
          isRightPos = true
          break
        end
      end
      if isRightPos and self:CanPlayTriggerSkill(trapEntity, e) then
        potentialTriggerEntity = e
        if e:HasRide() and e:Ride():GetMountID() ~= e:GetID() then
          potentialTriggerEntity = self._world:GetEntityByID(e:Ride():GetRiderID())
        end
        break
      end
    end
  end
  if potentialTriggerEntity then
    self:CalcTrapTriggerSkill(trapEntity, potentialTriggerEntity)
  end
end

function TrapServiceLogic:CalcTrapState(destoryType)
  local trapGroup = self:GetTrapGroup()
  local taskIDList = {}
  local trapEntityIDList = {}
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    if self._world:MatchType() == MatchType.MT_BlackFist then
      if trapEntity:GameTurn():GetGameTurn() == self._world:GetGameTurn() then
        trapEntityIDList[#trapEntityIDList + 1] = trapEntity:GetID()
      end
    else
      trapEntityIDList[#trapEntityIDList + 1] = trapEntity:GetID()
    end
  end
  table.sort(trapEntityIDList, table.ACS)
  local calcStateTraps = {}
  for _, trapEntityID in ipairs(trapEntityIDList) do
    local e = self._world:GetEntityByID(trapEntityID)
    if not e:HasDeadMark() then
      local trapCmpt = e:Trap()
      local trapDestroyType = trapCmpt:GetTrapDestroyType()
      local trapType = trapCmpt:GetTrapType()
      if trapDestroyType == destoryType then
        local trapDestroyParam = trapCmpt:GetTrapDestroyParam()
        if trapDestroyParam ~= nil then
          trapDestroyParam:NextNum()
          if not trapCmpt:IsRuneChange() then
            local curTrapRoundNum = trapDestroyParam:GetNum()
            if curTrapRoundNum <= 0 then
              trapCmpt:SetNeedDestory(true)
              self:_CalcTrapDisappearSkill({e})
              table.insert(calcStateTraps, e)
              e:Attributes():Modify("HP", 0)
              self:AddTrapDeadMark(e)
            end
          end
        end
      end
    end
  end
  return calcStateTraps
end

function TrapServiceLogic:AddTrapToBoardComponent(pos, entity)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  local cTrap = entity:Trap()
  if cTrap:IsDimensionDoor() then
    cBoard:AddDimensionDoor(pos, entity)
  elseif cTrap:IsExit() then
    cBoard:AddExit(pos, entity)
  elseif cTrap:IsBenumbTrigger() then
    cBoard:AddBenumbTrigger(pos, entity)
  end
end

function TrapServiceLogic:RemoveTrapFromBoardComponent(pos, entity)
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  local cTrap = entity:Trap()
  if cTrap:IsDimensionDoor() then
    cBoard:RemoveDimensionDoor(pos)
  elseif cTrap:IsExit() then
    cBoard:RemoveExit(pos)
  end
end

function TrapServiceLogic:CalcTrapTriggerSkill(trapEntity, triggerEntity)
  local canTrigger, cTrap, triggerSkillId, isFakeSkill = self:CanPlayTriggerSkill(trapEntity, triggerEntity)
  if not canTrigger then
    return
  end
  local maxTriggerCount = cTrap:GetTriggerMaxCount()
  if 0 < maxTriggerCount and maxTriggerCount <= cTrap:GetCurrentTriggerCount() then
    return
  end
  if trapEntity:HasDeadMark() then
    return
  end
  local isSuperGrid = cTrap:IsSuperGrid()
  local isPoorGrid = cTrap:IsPoorGrid()
  local pos = trapEntity:GetGridPosition()
  local utilSvc = self._world:GetService("UtilData")
  local triggerTraps = {}
  local triggerResults = {}
  triggerTraps[#triggerTraps + 1] = trapEntity
  local res = self:_DoTrapSkill(trapEntity, triggerEntity, triggerSkillId, isFakeSkill)
  triggerResults[#triggerResults + 1] = res
  cTrap:AddCurrentTriggerCount()
  local traps = utilSvc:GetGroupTrap(trapEntity)
  if traps and 0 < table.count(traps) then
    for _, e in ipairs(traps) do
      local cTriggeredTrap = e:Trap()
      local skillId = cTriggeredTrap:GetTriggerSkillID()
      if skillId then
        triggerTraps[#triggerTraps + 1] = e
        res = self:_DoTrapSkill(e, triggerEntity, skillId)
        triggerResults[#triggerResults + 1] = res
        cTriggeredTrap:AddCurrentTriggerCount()
      end
    end
  end
  if isSuperGrid then
    local nt = NTSuperGridTriggerEnd:New(pos)
    self._world:GetService("Trigger"):Notify(nt)
  end
  if isPoorGrid then
    local nt = NTPoorGridTriggerEnd:New(pos)
    self._world:GetService("Trigger"):Notify(nt)
  end
  local resultContainer = trapEntity:SkillRoutine():GetResultContainer()
  local dataTrapTriggerSkill = DataTrapTriggerSkill:New()
  dataTrapTriggerSkill:SetTrapEntity(trapEntity):SetTriggerEntity(triggerEntity):SetResultContainer(resultContainer)
  self._world:EventDispatcher():Dispatch(GameEventType.DataTrapTriggerSkill, dataTrapTriggerSkill)
  return triggerTraps, triggerResults
end

function TrapServiceLogic:_DoTrapSkill(trapEntity, triggerEntity, skillId, isFakeSkill)
  local skillLogicService = self._world:GetService("SkillLogic")
  local triggerService = self._world:GetService("Trigger")
  local battlesvc = self._world:GetService("Battle")
  local ntSkillID = skillId
  if isFakeSkill then
    local cTrap = trapEntity:Trap()
    ntSkillID = cTrap:GetFakeTriggerSkillID()
  end
  triggerService:Notify(NTTrapSkillStart:New(trapEntity, ntSkillID, triggerEntity))
  local resultContainer = trapEntity:SkillContext():GetResultContainer()
  if skillId then
    local isFinalAttackBeforeSkill = battlesvc:IsPlayerTurnFinalAttack()
    skillLogicService:CalcSkillEffect(trapEntity, skillId)
    local isFinalAttackAfterSkill = battlesvc:IsPlayerTurnFinalAttack()
    resultContainer:SetSkillID(skillId)
    if not isFinalAttackBeforeSkill and isFinalAttackAfterSkill and table.icontains(BattleConst.FinalAttackSkillIdListOfTriggerTrap, skillId) then
      resultContainer:SetFinalAttack(true)
    end
  end
  local triggerEntityID
  if triggerEntity then
    triggerEntityID = triggerEntity:GetID()
  end
  self:LogNotice("CalcTrapTriggerSkill：TrapEntityID = ", trapEntity:GetID(), ", TrapSkillID = ", skillId, " TriggerEntityID=", triggerEntityID)
  triggerService:Notify(NTTrapSkillEnd:New(trapEntity, ntSkillID, triggerEntity))
  if trapEntity:Trap():IsDimensionDoor() then
    self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, true)
  end
  skillLogicService:UpdateRenderSkillRoutine(trapEntity)
  return resultContainer
end

function TrapServiceLogic:_CalcTrapAddBuff(entity, buffIDs, trapID)
  local affixSvc = self:GetService("Affix")
  buffIDs = affixSvc:ReplaceTrapBuff(trapID, buffIDs)
  buffIDs = affixSvc:AddTrapBuff(trapID, buffIDs)
  if not buffIDs then
    return
  end
  local svcBuffLogic = self:GetService("BuffLogic")
  for i, buffID in ipairs(buffIDs) do
    svcBuffLogic:AddBuff(buffID, entity)
  end
end

function TrapServiceLogic:CanSelectByRaceType(trap, target)
  if trap:Trap():GetTrapType() == TrapType.BombByHitBack then
    return true
  end
  return self._trapTargetSelector:CanSelectTarget(trap, target)
end

function TrapServiceLogic:CanPlayTriggerSkill(e, triggerEntity)
  local canTrigger = false
  local triggerSkillId = 0
  local cTrap = e:Trap()
  if not cTrap then
    return false
  end
  local autofight = self._world:BattleStat():GetAutoFight()
  if autofight and cTrap:IsDimensionDoor() then
    return false
  end
  local raceType = cTrap:GetTrapRaceType()
  if not self:CanSelectByRaceType(e, triggerEntity) then
    return false
  end
  local utilSvc = self._world:GetService("UtilData")
  local isFakeSkill = false
  triggerSkillId, isFakeSkill = utilSvc:GetTrapTriggerSkillIDByTriggerEntity(e, triggerEntity)
  if triggerSkillId and 0 < triggerSkillId then
    return true, cTrap, triggerSkillId, isFakeSkill
  end
  triggerSkillId = cTrap:GetTriggerSkillID()
  if triggerSkillId and 0 < triggerSkillId then
    canTrigger = true
  end
  if cTrap:GetFakeTriggerSkillID() then
    isFakeSkill = true
  end
  if not canTrigger then
    self:LogNotice("机关无触发技能，无法执行机关触发表现, ID =", e:GetID(), "SkillID =", triggerSkillId)
  end
  return canTrigger, cTrap, triggerSkillId, isFakeSkill
end

function TrapServiceLogic:_CalcTrapAppearSkill(traps)
  if not traps or table.count(traps) <= 0 then
    return
  end
  local skillLogicService = self._world:GetService("SkillLogic")
  for _, e in ipairs(traps) do
    local cTrap = e:Trap()
    local skillId = cTrap:GetAppearSkillID()
    if skillId and 0 < skillId and not cTrap:IsSkillHadCalc(skillId) then
      skillLogicService:CalcSkillEffect(e, skillId)
      skillLogicService:UpdateRenderSkillRoutine(e)
      cTrap:SetHadCalcSkill(skillId)
    end
  end
end

function TrapServiceLogic:_CalcTrapDisappearSkill(traps)
  local skillLogicService = self._world:GetService("SkillLogic")
  for _, e in ipairs(traps) do
    local cTrap = e:Trap()
    local skillId = cTrap:GetDisappearSkillID()
    local deadMarkCmpt = e:DeadMark()
    local deadNotPlayDisappear = cTrap:GetDeadNotPlayDisappear()
    local canPlayDisappear = true
    if deadNotPlayDisappear == 1 and deadMarkCmpt and deadMarkCmpt:GetDeadCasterID() ~= nil then
      canPlayDisappear = false
    end
    if skillId and 0 < skillId and canPlayDisappear then
      skillLogicService:CalcSkillEffect(e, skillId)
      skillLogicService:UpdateRenderSkillRoutine(e)
    end
  end
end

function TrapServiceLogic:CalcTrapDieSkill(traps)
  local skillLogicService = self._world:GetService("SkillLogic")
  for _, e in ipairs(traps) do
    local cTrap = e:Trap()
    local skillId = cTrap:GetDieSkillID()
    if skillId and 0 < skillId and not cTrap:IsHadCalcDead() then
      cTrap:SetHadCalcDead()
      skillLogicService:CalcSkillEffect(e, skillId)
      skillLogicService:UpdateRenderSkillRoutine(e, "TrapDieSkill")
    end
  end
end

function TrapServiceLogic:CalcTrapPreChainSkill()
  local sSkillLogic = self._world:GetService("SkillLogic")
  local trapIds = {}
  local g = self:GetTrapGroup()
  for i, e in ipairs(g:GetEntities()) do
    local cTrap = e:Trap()
    local preChainSkillId = cTrap:GetPreChainSkillID()
    if preChainSkillId and 0 < preChainSkillId then
      table.insert(trapIds, e:GetID())
      sSkillLogic:CalcSkillEffect(e, preChainSkillId)
      sSkillLogic:UpdateRenderSkillRoutine(e)
    end
  end
  return trapIds
end

function TrapServiceLogic:DestroyTrapAtOnce(targetID, casterEntity, isDieSkillDisabled)
  local eTarget = self._world:GetEntityByID(targetID)
  if self:CanDestroyAtOnce(eTarget) then
    self:AddTrapDeadMark(eTarget, isDieSkillDisabled)
    if casterEntity:HasPetPstID() then
      local battleStatComponent = self._world:BattleStat()
      local cTrap = eTarget:Trap()
      local trapId = cTrap:GetTrapID()
      battleStatComponent:AddSmashTrapCount(trapId, 1)
    end
  end
end

function TrapServiceLogic:CalcActiveSkillDeadTrapDeadSkill()
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for i, entity in ipairs(entityList) do
    local trapComponent = entity:Trap()
    if trapComponent and entity:HasDeadMark() and not trapComponent:IsHadCalcDead() then
      self:CalcTrapDieSkill({entity})
    end
  end
end

function TrapServiceLogic:CanDestroyAtOnce(e)
  local cTrap = e:Trap()
  if not cTrap then
    return false
  end
  if cTrap:GetTrapType() == TrapType.Protected then
    return false
  end
  local cAttributes = e:Attributes()
  local hp = cAttributes:GetCurrentHP()
  if hp and hp <= 0 then
    return true
  end
  return false
end

function TrapServiceLogic:StartBeforeMainAI()
  local aiService = self._world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.BeforeMain)
end

function TrapServiceLogic:TrapActionRoundResult()
  local aiService = self._world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.RoundResult)
end

function TrapServiceLogic:TrapActionAfterAI()
  local aiService = self._world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.AfterMain)
end

function TrapServiceLogic:TrapActionBeforePlayer()
  local aiService = self._world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.RoundEnterBeforePlayer)
end

function TrapServiceLogic:_InitAIOnceLogic(aiLogicPeriodType)
  local aliveTraps = self:_FindAliveTraps()
  if table.count(aliveTraps) <= 0 then
    return
  end
  local aiService = self._world:GetService("AI")
  for i, v in ipairs(aliveTraps) do
    v:AI():InitAiLogic(AINewNodeStatus.Ready, v, aiLogicPeriodType, 1000)
  end
  return aiService, aliveTraps
end

function TrapServiceLogic:_FindAliveTraps()
  local curGameTurn = self._world:GetGameTurn()
  local trapGroup = self:GetTrapGroup()
  local allTrapList = trapGroup:GetEntities()
  local aliveTraps = {}
  for i = 1, #allTrapList do
    local trapCmpt = allTrapList[i]:Trap()
    local trapTurn = allTrapList[i]:GameTurn():GetGameTurn()
    if allTrapList[i]:HasAI() and trapCmpt:GetNeedDestory() == false and trapTurn == curGameTurn then
      table.insert(aliveTraps, allTrapList[i])
    end
  end
  return aliveTraps
end

function TrapServiceLogic:AddTrapDeadMark(entity, isDieSkillDisabled)
  local trapCmpt = entity:Trap()
  if not trapCmpt then
    return
  end
  local cAttributes = entity:Attributes()
  local curHp = cAttributes:GetCurrentHP()
  if 0 < curHp then
    return
  end
  if entity:HasDeadMark() then
    return
  end
  local triggerService = self._world:GetService("Trigger")
  local ntTrapDeadStart = NTTrapDeadStart:New(entity)
  local ownEntity = entity:GetSummonerEntity()
  if ownEntity then
    ntTrapDeadStart:SetOwnerEntity(ownEntity)
  end
  triggerService:Notify(ntTrapDeadStart)
  entity:AddDeadMark()
  local gameFsmCmpt = self._world:GameFSM()
  local curStateID = gameFsmCmpt:CurStateID()
  local deadMarkCmpt = entity:DeadMark()
  deadMarkCmpt:SetDeadStateID(curStateID)
  if trapCmpt:GetTrapType() == TrapType.Auras then
    self:RemoveAuraRange(trapCmpt:GetAuraGroupID(), trapCmpt:GetAuraRange())
  end
  local battleFlags = self._world:BattleFlags()
  local entityIDList = battleFlags:GetSummonMeantimeLimitEntityID(trapCmpt:GetTrapID())
  if table.intable(entityIDList, entity:GetID()) then
    table.removev(entityIDList, entity:GetID())
    battleFlags:SetSummonMeantimeLimitEntityID(trapCmpt:GetTrapID(), entityIDList)
  end
  local trapIDList = battleFlags:GetSummonOnFixPosLimitEntityID(trapCmpt:GetTrapID())
  if table.intable(trapIDList, entity:GetID()) then
    table.removev(trapIDList, entity:GetID())
    battleFlags:SetSummonOnFixPosLimitEntityID(trapCmpt:GetTrapID(), trapIDList)
  end
  local boardService = self._world:GetService("BoardLogic")
  local pos = entity:GetGridPosition()
  boardService:RemoveEntityBlockFlag(entity, pos)
  local needCalcTrapDieSkill = false
  if trapCmpt:IsPrismGrid() then
    needCalcTrapDieSkill = true
  end
  if not isDieSkillDisabled or needCalcTrapDieSkill then
    self:CalcTrapDieSkill({entity})
  end
  local nt = NTTrapDead:New(entity, trapCmpt:GetTrapID())
  if ownEntity then
    nt:SetOwnerEntity(ownEntity)
  end
  triggerService:Notify(nt)
  entity:BuffComponent():SetActive(false)
  self:RemoveTrapFromBoardComponent(pos, entity)
  return entity:DeadMark()
end

function TrapServiceLogic:CalcAllTrapDeadMark()
  local gTrap = self:GetTrapGroup()
  if not gTrap then
    return
  end
  for _, e in ipairs(gTrap:GetEntities()) do
    self:AddTrapDeadMark(e)
  end
end

function TrapServiceLogic:ClearTrapDeadEntity()
  local toDestroyList = {}
  local trapGroup = self:GetTrapGroup()
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    if trapEntity:HasDeadMark() then
      toDestroyList[#toDestroyList + 1] = trapEntity
    end
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  for _, entity in ipairs(toDestroyList) do
    buffLogicService:RemoveAllBuffInstance(entity)
    self._world:DestroyEntity(entity)
  end
end

local TrapTriggerOrigin = {
  Move = 1,
  Teleport = 2,
  Hitback = 3,
  Eddy = 4,
  MonsterGridMove = 5,
  ChessMonsterGridMoveByElement = 6
}
_enum("TrapTriggerOrigin", TrapTriggerOrigin)

function TrapServiceLogic:TriggerTrapByTeleport(entityWork, bEnableEddy)
  local listTrapTrigger
  if bEnableEddy then
    listTrapTrigger = self:TriggerTrapByEntity(entityWork, TrapTriggerOrigin.Teleport)
  else
    listTrapTrigger = self:TriggerTrapByEntity(entityWork, TrapTriggerOrigin.Eddy)
  end
  return listTrapTrigger
end

function TrapServiceLogic:TriggerTrapByEntity(entityObject, triggerOrigin)
  local areas = entityObject:BodyArea():GetArea()
  local pos = entityObject:GetGridPosition()
  local listTrapAll_Work = {}
  local listTrapSkillResult = {}
  for _, area in ipairs(areas) do
    local listWork, listResult = self:_TriggerTrapAtPos(pos + area, entityObject, triggerOrigin)
    table.appendArray(listTrapAll_Work, listWork)
    table.appendArray(listTrapSkillResult, listResult)
  end
  return listTrapAll_Work, listTrapSkillResult
end

function TrapServiceLogic:TriggerTrapOnPosByEntity(pos, entityObject, triggerOrigin)
  local areas = entityObject:BodyArea():GetArea()
  local listTrapAll_Work = {}
  local listTrapSkillResult = {}
  for _, area in ipairs(areas) do
    local listWork, listResult = self:_TriggerTrapAtPos(pos + area, entityObject, triggerOrigin)
    table.appendArray(listTrapAll_Work, listWork)
    table.appendArray(listTrapSkillResult, listResult)
  end
  return listTrapAll_Work, listTrapSkillResult
end

function TrapServiceLogic:_TriggerTrapAtPos(position, target, triggerOrigin)
  local sortLevel = SortedArray:New(Algorithm.COMPARE_GREATER, nil)
  local listTrapFind = {}
  local utilSvc = self._world:GetService("UtilData")
  local listTrap = utilSvc:GetTrapsAtPos(position)
  for _, value in ipairs(listTrap) do
    local entityTrap = value
    local trapCmp = entityTrap:Trap()
    local triggerException = trapCmp:GetTriggerException()
    local isException = table.icontains(triggerException, triggerOrigin)
    local nTrapType = trapCmp:GetTrapType()
    local nCanSelect = self._trapTargetSelector:CanSelectTarget(entityTrap, target)
    local bSelect = false
    if not isException and nCanSelect and nTrapType == TrapType.GroudTrigger then
      bSelect = true
    end
    if triggerOrigin == TrapTriggerOrigin.MonsterGridMove and trapCmp:GetTriggerSkillType() and trapCmp:GetTriggerSkillType() ~= TrapSkillType.Attack then
      bSelect = false
    end
    local onlyViewTrap = self:IsViewTrapLevel(trapCmp:GetTrapLevel())
    if onlyViewTrap then
      bSelect = false
    end
    if bSelect then
      local level = trapCmp:GetTrapLevel()
      sortLevel:Insert(level)
      listTrapFind[level] = entityTrap
    end
  end
  local trapListWork = {}
  local trapSkillResults = {}
  for i = 1, sortLevel:Size() do
    local entityTrap = listTrapFind[sortLevel:GetAt(i)]
    if entityTrap and not entityTrap:HasDeadMark() then
      local triggerTraps, triggerResults = self:CalcTrapTriggerSkill(entityTrap, target)
      if triggerTraps then
        for _, e in ipairs(triggerTraps) do
          trapListWork[#trapListWork + 1] = e
        end
        for i, v in ipairs(triggerResults) do
          trapSkillResults[#trapSkillResults + 1] = v
        end
      end
    end
  end
  return trapListWork, trapSkillResults
end

function TrapServiceLogic:TriggerBomb(pos, defender)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local trapEntities = trapGroup:GetEntities()
  for _, e in ipairs(trapEntities) do
    local trapEntity = e
    if not trapEntity:HasDeadMark() then
      local trapCmpt = trapEntity:Trap()
      if trapCmpt:GetTrapType() == TrapType.BombByHitBack and trapEntity:GetGridPosition() == pos then
        self:CalcTrapTriggerSkill(trapEntity, defender)
        return trapEntity
      end
    end
  end
end

function TrapServiceLogic:IsTrapFlushable(layer)
  return self._flushLayer[layer]
end

function TrapServiceLogic:DamageTrap(curHP, targetID)
end

function TrapServiceLogic:HasLiveBomb(pos)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local trapEntities = trapGroup:GetEntities()
  for _, e in ipairs(trapEntities) do
    local trapEntity = e
    if not trapEntity:HasDeadMark() then
      local trapCmpt = trapEntity:Trap()
      if trapCmpt:GetTrapType() == TrapType.BombByHitBack then
        if pos then
          if trapEntity:GetGridPosition() == pos then
            return true
          end
        else
          return true
        end
      end
    end
  end
  return false
end

function TrapServiceLogic:CanCastTrapSkill(trapEntity)
  local attributesComponent = trapEntity:Attributes()
  local power = attributesComponent:GetAttribute("TrapPower")
  local skillCount = attributesComponent:GetAttribute("SkillCount")
  return 0 < power and 0 < skillCount
end

function TrapServiceLogic:GetTrapActiveSkillList(trapEntity)
  local trapCmpt = trapEntity:Trap()
  local skillList = trapCmpt:GetActiveSkillID()
  return skillList
end

function TrapServiceLogic:FindTrapByType(nTrapType, nGroupID)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listReturn = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapType() == nTrapType then
        local bFind = true
        if nGroupID and trapComponent:GetGroupID() ~= nGroupID then
          bFind = false
        end
        if bFind then
          table.insert(listReturn, trap)
        end
      end
    end
  end
  return listReturn
end

function TrapServiceLogic:FindTrapIDByPos(findPos)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listIDRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local pos = trap:GetGridPosition()
      local bodyArea = trap:BodyArea()
      local bodyAreaList = bodyArea:GetArea()
      for _, area in ipairs(bodyAreaList) do
        if area.x + pos.x == findPos.x and area.y + pos.y == findPos.y then
          local trapComponent = trap:Trap()
          if trapComponent and trapComponent:GetTrapID() then
            table.insert(listIDRet, trapComponent:GetTrapID())
          end
        end
      end
    end
  end
  return listIDRet
end

function TrapServiceLogic:FindTrapByPos(findPos)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listIDRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local pos = trap:GetGridPosition()
      local bodyArea = trap:BodyArea()
      local bodyAreaList = bodyArea:GetArea()
      for _, area in ipairs(bodyAreaList) do
        if area.x + pos.x == findPos.x and area.y + pos.y == findPos.y then
          local trapComponent = trap:Trap()
          if trapComponent and trapComponent:GetTrapID() then
            table.insert(listIDRet, trap:GetID())
          end
        end
      end
    end
  end
  return listIDRet
end

function TrapServiceLogic:FindTrapPosByTrapID(trapID, canMove, monsterEntity)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local utilDataSvc = self._world:GetService("UtilData")
  local listPosRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapID() == trapID then
        local pos = trap:GetGridPosition()
        local bodyArea = trap:BodyArea()
        local bodyAreaList = bodyArea:GetArea()
        for _, area in ipairs(bodyAreaList) do
          local pos = Vector2(pos.x + area.x, pos.y + area.y)
          if canMove then
            if utilDataSvc:IsMonsterCanTel2TargetPos(monsterEntity, pos) then
              table.insert(listPosRet, pos)
            end
          else
            table.insert(listPosRet, pos)
          end
        end
      end
    end
  end
  return listPosRet
end

function TrapServiceLogic:FindTrapByTrapID(trapID)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapID() == trapID then
        table.insert(listRet, trap:GetID())
      end
    end
  end
  return listRet
end

function TrapServiceLogic:FindTrapByTrapIDAndRange(trapID, range)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local listRet = {}
  local listTraps = trapGroup:GetEntities()
  for i = 1, #listTraps do
    local trap = listTraps[i]
    if trap and not trap:HasDeadMark() then
      local trapComponent = trap:Trap()
      if trapComponent and trapComponent:GetTrapID() == trapID then
        local pos = trap:GetGridPosition()
        local bodyArea = trap:BodyArea()
        local bodyAreaList = bodyArea:GetArea()
        for _, area in ipairs(bodyAreaList) do
          local newPos = Vector2(pos.x + area.x, pos.y + area.y)
          if table.Vector2Include(range, newPos) then
            table.insert(listRet, trap:GetID())
          end
        end
      end
    end
  end
  return listRet
end

function TrapServiceLogic:IsTrapCovered(trapID, petPstId)
  local ownerEntityID
  if petPstId then
    local petEntity = self._world:Player():GetPetEntityByPetPstID(petPstId)
    if petEntity then
      ownerEntityID = petEntity:GetID()
    end
  end
  local trapEntitys = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID then
      if not ownerEntityID then
        table.insert(trapEntitys, e)
      elseif e:HasSummoner() then
        local summonEntityID = e:Summoner():GetSummonerEntityID()
        local summonEntity = e:GetSummonerEntity()
        if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
          summonEntityID = summonEntity:GetSuperEntity():GetID()
        end
        if summonEntityID == ownerEntityID then
          table.insert(trapEntitys, e)
        end
      end
    end
  end
  if #trapEntitys == 0 then
    return true
  end
  local trapEntity = trapEntitys[1]
  local pos = trapEntity:GetGridPosition()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return e:HasTeam() or e:HasMonsterID()
  end)
  if #es == 0 then
    return false
  end
  return true
end

function TrapServiceLogic:DoTrapFeatureDead(entity)
  local trapCmpt = entity:Trap()
  if not trapCmpt then
    return
  end
  if entity:HasDeadMark() then
    return
  end
  entity:AddDeadMark()
  local boardService = self._world:GetService("BoardLogic")
  local pos = entity:GetGridPosition()
  boardService:RemoveEntityBlockFlag(entity, pos)
  entity:BuffComponent():SetActive(false)
  self:RemoveTrapFromBoardComponent(pos, entity)
  return entity:DeadMark()
end

function TrapServiceLogic:GetOnlyViewTrapLayer()
  return self._onlyViewTrapLayer
end

function TrapServiceLogic:IsViewTrapLevel(level)
  return self._onlyViewTrapLayer == level
end

function TrapServiceLogic:GetTotalAuraRangeByGroupID(auraGroupID)
  local totalRange = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local trapEntities = trapGroup:GetEntities()
  for _, e in ipairs(trapEntities) do
    local trapEntity = e
    if not trapEntity:HasDeadMark() then
      local trapCmpt = trapEntity:Trap()
      if trapCmpt:GetTrapType() == TrapType.Auras and auraGroupID == trapCmpt:GetAuraGroupID() then
        local auraRange = trapCmpt:GetAuraRange()
        for _, pos in ipairs(auraRange) do
          if not table.Vector2Include(totalRange, pos) then
            table.insert(totalRange, pos)
          end
        end
      end
    end
  end
  return totalRange
end

function TrapServiceLogic:AddAuraRange(groupID, range)
  local battleSvc = self._world:GetService("Battle")
  battleSvc:AddAuraRange(groupID, range)
end

function TrapServiceLogic:RemoveAuraRange(groupID, range)
  local battleSvc = self._world:GetService("Battle")
  battleSvc:RemoveAuraRange(groupID, range)
end

function TrapServiceLogic:GetSummonTrapCount(entity)
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local count = 0
  for _, trap in ipairs(trapGroup:GetEntities()) do
    if trap and not trap:HasDeadMark() then
      local summonerCmpt = trap:Summoner()
      if summonerCmpt and summonerCmpt:GetSummonerEntityID() == entity:GetID() then
        count = count + 1
      end
    end
  end
  return count
end

function TrapServiceLogic:IsSummonCountLimit(entity)
  local attributesComponent = entity:Attributes()
  local limitCount = attributesComponent:GetAttribute("SummonTrapLimit")
  if not limitCount or limitCount == 0 then
    return false
  end
  local curCount = self:GetSummonTrapCount(entity)
  if limitCount > curCount then
    return false
  end
  return true
end

function TrapServiceLogic:HasPrismEffectTrap(pos)
  local utilSvc = self._world:GetService("UtilData")
  local trapEntities = utilSvc:GetTrapsAtPos(pos)
  for _, e in ipairs(trapEntities) do
    local trapEntity = e
    local trapCmpt = trapEntity:Trap()
    if trapCmpt:IsPrismGrid() and trapCmpt:GetCustomPrismGridScopeType() and trapEntity:GetGridPosition() == pos then
      return true
    end
  end
  return false
end

function TrapServiceLogic:_CalcTrapWall(trapEntity, typeParam)
  local boardEntity = self._world:GetBoardEntity()
  local hasLogicTrapWall = boardEntity:HasLogicTrapWall()
  if not hasLogicTrapWall then
    boardEntity:AddLogicTrapWall()
  end
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  local trapEntityID = trapEntity:GetID()
  local type = typeParam.type
  local posList = typeParam.pos
  local dirList = typeParam.dir or {}
  local boardSvc = self._world:GetService("BoardLogic")
  local posCenter = trapEntity:GetGridPosition()
  local area = trapEntity:BodyArea():GetArea()
  local utilData = self._world:GetService("UtilData")
  local invalidPosList = utilData:OnGetInvalidCreateTrapWallPosList()
  if type == 1 then
    posList = {}
    for _, v in ipairs(area) do
      local posWork = posCenter + v
      table.insert(posList, posWork)
    end
    local dir = Vector2(0, 0)
    local trapWallPosEdgeOutPosList = utilData:CalcTrapWallPosEdgeOut(posList)
    for _, pos in ipairs(trapWallPosEdgeOutPosList) do
      if not table.icontains(invalidPosList, pos) then
        logicTrapWallComponent:AddTrapWall(trapEntityID, pos, dir)
      end
    end
  elseif type == 2 then
    for i, pos in ipairs(posList) do
      local posWork = Vector2(pos[1], pos[2])
      local dir = Vector2(0, 0)
      if dirList[i] then
        dir = Vector2(dirList[i][1], dirList[i][2])
      end
      local posInteger = Vector2(math.ceil(posWork.x), math.ceil(posWork.y))
      local posWallCheck = posCenter + posInteger
      local posWall = posCenter + posWork
      if boardSvc:IsValidPiecePos(posWallCheck) and not table.icontains(invalidPosList, pos) then
        logicTrapWallComponent:AddTrapWall(trapEntityID, posWall, dir)
      end
    end
  end
end

function TrapServiceLogic:_GetTrapWallPosListByEntityID(trapEntityID)
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  local trapWallPosList = logicTrapWallComponent:GetTrapWallPosListByEntityID(trapEntityID)
  return trapWallPosList
end
