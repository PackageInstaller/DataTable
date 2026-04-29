_class("PickUpChessPetSystem_Render", ReactiveSystem)
PickUpChessPetSystem_Render = PickUpChessPetSystem_Render

function PickUpChessPetSystem_Render:Constructor(world)
  self._world = world
end

function PickUpChessPetSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpChessResult)
  }, {"Added"})
  return c
end

function PickUpChessPetSystem_Render:Filter(entity)
  local resCmpt = entity:PickUpChessResult()
  local resType = resCmpt:GetChessPickUpResultType()
  if resType == ChessPickUpTargetType.ChessPet then
    return true
  end
  return false
end

function PickUpChessPetSystem_Render:ExecuteEntities(entities)
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearChessMonsterPreview()
  chessSvcRender:ClearChessPetPreview()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local changed = resCmpt:IsChessPickUpTargetChanged()
  if not changed then
    self:_FinishChessPetPreview()
    return
  end
  local entityID = resCmpt:GetPickUpChessPetEntityID()
  if not entityID then
    Log.fatal("not find pick chess pet id")
    return
  end
  local chessPetEntity = self._world:GetEntityByID(entityID)
  self:_ShowChessPetUIHP(chessPetEntity)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local finishTurn = chessPetCmpt:IsChessPetFinishTurn()
  if finishTurn then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 6)
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
    return
  end
  local walkRange, attackRange, isRecover = self:_CalcChessPetWalkRange(entityID)
  resCmpt:SetChessPetWalkRange(walkRange)
  resCmpt:SetChessPetAttackRange(attackRange)
  resCmpt:SetSkillIsRecover(isRecover)
  chessSvcRender:ShowChessPetPreviewRange(walkRange, attackRange, {}, {}, isRecover)
  chessSvcRender:RefreshChessPetSelectStateRender(chessPetEntity, true)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 6)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Skip)
end

function PickUpChessPetSystem_Render:_FinishChessPetPreview()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearAllChessUnitPreview()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  resCmpt:ResetChessPickUp()
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId == GameStateID.PreviewChessPet then
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 3)
  elseif stateId == GameStateID.PickUpChessPet then
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 5)
  end
end

function PickUpChessPetSystem_Render:_CalcChessPetWalkRange(entityID)
  local entity = self._world:GetEntityByID(entityID)
  local gridLocCmpt = entity:GridLocation()
  local curPos = gridLocCmpt:GetGridPos()
  local chessPetCmpt = entity:ChessPet()
  local chessPetID = chessPetCmpt:GetChessPetID()
  local blockData = chessPetCmpt:GetChessPetBlockData()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local chessPetList, chessPetPosList = utilScopeSvc:SelectAllChessPet()
  local cfgSvc = self._world:GetService("Config")
  local chessPetConfigData = cfgSvc:GetChessPetConfigData()
  local bodyArea = chessPetConfigData:GetChessPetArea(chessPetID)
  local walkStep = chessPetConfigData:GetChessPetWalkStep(chessPetID)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  local eachMovePosList = {}
  local walkRange = {}
  local walkRangeCalc = {}
  for i, area in ipairs(bodyArea) do
    local posWork = curPos + area
    table.insert(walkRange, posWork)
  end
  table.insert(walkRangeCalc, curPos)
  for i = 1, walkStep do
    eachMovePosList[i] = {}
    local curMovePosList = {}
    local lastMovePosList = {}
    if i == 1 then
      lastMovePosList = {curPos}
    else
      lastMovePosList = eachMovePosList[i - 1]
    end
    for _, pos in ipairs(lastMovePosList) do
      for _, dir in ipairs(dirs) do
        local moveTargetPos = pos + dir
        self:_OnCalcWalkRangeBodyArea(bodyArea, moveTargetPos, blockData, curMovePosList, walkRange, walkRangeCalc, chessPetPosList, entity)
      end
    end
    for _, pos in ipairs(curMovePosList) do
      if not table.intable(walkRange, pos) then
        table.insert(eachMovePosList[i], pos)
        if not table.intable(chessPetPosList, pos) then
          table.insert(walkRange, pos)
        end
      end
    end
  end
  local canMoveCenterPosList = {}
  if table.count(bodyArea) == 1 then
    table.appendArray(canMoveCenterPosList, walkRange)
  else
    table.appendArray(canMoveCenterPosList, walkRangeCalc)
  end
  local hasTargetAttackRange, isRecover = self:_OnCalcAttackRange(entity, canMoveCenterPosList)
  return walkRange, hasTargetAttackRange, isRecover
end

function PickUpChessPetSystem_Render:_OnCalcWalkRangeBodyArea(bodyArea, moveTargetPos, blockData, curMovePosList, walkRange, walkRangeCalc, chessPetPosList, entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local isBlocked = false
  if table.count(bodyArea) == 1 then
    isBlocked = utilDataSvc:IsPosBlock(moveTargetPos, blockData)
    if (isBlocked or isPosBlockWithEntityRace) and table.intable(chessPetPosList, moveTargetPos) then
      isBlocked = false
    end
    if isBlocked == false then
      table.insert(curMovePosList, moveTargetPos)
      if not table.intable(walkRangeCalc, moveTargetPos) then
        table.insert(walkRangeCalc, moveTargetPos)
      end
    end
  elseif table.count(bodyArea) > 1 then
    local moveAreaPosList = {}
    for _, area in ipairs(bodyArea) do
      local posWork = area + moveTargetPos
      isBlocked = utilDataSvc:IsPosBlock(posWork, blockData)
      local isPosBlockWithEntityRace = utilDataSvc:IsPosBlockWithEntityRace(moveTargetPos, blockData, entity)
      if not table.intable(walkRange, posWork) and (isBlocked or isPosBlockWithEntityRace) then
        break
      end
      isBlocked = false
      table.insert(moveAreaPosList, posWork)
    end
    if isBlocked == false then
      table.appendArray(curMovePosList, moveAreaPosList)
      if not table.intable(walkRangeCalc, moveTargetPos) then
        table.insert(walkRangeCalc, moveTargetPos)
      end
    end
  end
end

function PickUpChessPetSystem_Render:_OnCalcAttackRange(entity, walkRange)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local chessPetCmpt = entity:ChessPet()
  local attackSkill = chessPetCmpt:GetPreviewSkillID()
  local cfgSvc = self._world:GetService("Config")
  local skillConfigData = cfgSvc:GetSkillConfigData(attackSkill, entity)
  local isRecover = false
  local skillEffectArray = skillConfigData:GetSkillEffect()
  for _, skillEffect in ipairs(skillEffectArray) do
    if skillEffect:GetEffectType() == SkillEffectType.AddBlood then
      isRecover = true
      break
    end
  end
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local skillTargetTypeParam = skillConfigData:GetSkillTargetTypeParam()
  local selector = SkillScopeTargetSelector:New(self._world)
  local attackRange = {}
  local skillTargetIDs = {}
  for _, walkPos in ipairs(walkRange) do
    local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, walkPos, entity)
    local scopeList = scopeResult:GetAttackRange()
    local targetIDs = selector:DoSelectSkillTarget(entity, skillTargetType, scopeResult, attackSkill, skillTargetTypeParam)
    for _, pos in ipairs(scopeList) do
      if not table.intable(attackRange, pos) then
        table.insert(attackRange, pos)
      end
    end
    for _, targetID in ipairs(targetIDs) do
      if not table.intable(skillTargetIDs, targetID) and targetID ~= entity:GetID() then
        table.insert(skillTargetIDs, targetID)
      end
    end
  end
  local hasTargetAttackRange = {}
  for _, targetID in ipairs(skillTargetIDs) do
    local targetEntity = self._world:GetEntityByID(targetID)
    local bodyAreaList = targetEntity:BodyArea():GetArea()
    local gridPos = targetEntity:GridLocation():GetGridPos()
    for _, bodyArea in ipairs(bodyAreaList) do
      local workPos = gridPos + bodyArea
      if table.intable(attackRange, workPos) then
        table.insert(hasTargetAttackRange, workPos)
      end
    end
  end
  return hasTargetAttackRange, isRecover
end

function PickUpChessPetSystem_Render:_ShowChessPetUIHP(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local HPCmpt = entity:HP()
  local maxHP = HPCmpt:GetMaxHP()
  local HP = HPCmpt:GetRedHP()
  local hpPercent = HP / maxHP
  local shieldValue = HPCmpt:GetShieldValue()
  local templateID, hpBarType, elementType
  local sepHPList = entity:HP():GetHPLockSepList()
  if entity:MonsterID() then
    templateID = entity:MonsterID():GetMonsterID()
    if entity:HasBoss() then
      if entity:MonsterID():IsEliteMonster() then
        hpBarType = HPBarType.EliteBoss
      else
        hpBarType = HPBarType.Boss
      end
    elseif entity:MonsterID():IsEliteMonster() then
      hpBarType = HPBarType.EliteMonster
    else
      hpBarType = HPBarType.NormalMonster
    end
    elementType = utilDataSvc:GetEntityAttributeByName(entity, "Element")
  elseif entity:HasChessPet() then
    templateID = entity:ChessPet():GetChessPetID()
    local cfgChessPet = Cfg.cfg_chesspet[templateID]
    elementType = cfgChessPet.ElementType
    hpBarType = HPBarType.ChessPet
  end
  local greyVal = utilDataSvc:GetEntityBuffValue(entity, "GreyHPValue") or 0
  local hpEnergyBuffEffectType = utilDataSvc:GetEntityBuffValue(entity, "HPEnergyBuffEffectType")
  local hpEnergyVal = 0
  if hpEnergyBuffEffectType then
    hpEnergyVal = utilDataSvc:GetBuffLayer(entity, hpEnergyBuffEffectType)
  end
  local info = {
    pstId = entity:GetID(),
    tplId = templateID,
    HPBarType = hpBarType,
    sepHPList = sepHPList,
    entity = entity,
    percent = hpPercent,
    hP = HP,
    HP = HP,
    maxHP = maxHP,
    shieldValue = shieldValue,
    curElement = elementType,
    attack = utilDataSvc:GetEntityAttack(entity) or 0,
    greyVal = greyVal,
    hpEnergyVal = hpEnergyVal
  }
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreviewMonsterReplaceHPBar, info)
end
