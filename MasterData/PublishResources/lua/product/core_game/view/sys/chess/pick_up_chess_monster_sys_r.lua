_class("PickUpChessMonsterSystem_Render", ReactiveSystem)
PickUpChessMonsterSystem_Render = PickUpChessMonsterSystem_Render

function PickUpChessMonsterSystem_Render:Constructor(world)
  self._world = world
end

function PickUpChessMonsterSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpChessResult)
  }, {"Added"})
  return c
end

function PickUpChessMonsterSystem_Render:Filter(entity)
  local resCmpt = entity:PickUpChessResult()
  local resType = resCmpt:GetChessPickUpResultType()
  if resType == ChessPickUpTargetType.Monster then
    return true
  end
  return false
end

function PickUpChessMonsterSystem_Render:ExecuteEntities(entities)
  self:InitServices()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local pickUpPos = resCmpt:GetCurChessPickUpPos()
  local attackRange = resCmpt:GetChessPetAttackRange()
  local isRecover = resCmpt:GetSkillIsRecover()
  local entityID = resCmpt:GetPickUpMonsterEntityID()
  if not entityID then
    Log.exception("点战棋的敌方单位，没有目标ID")
    return
  end
  local changed = resCmpt:IsChessPickUpTargetChanged()
  if not changed then
    return
  end
  local stateId = self._utilDataSvc:GetCurMainStateID()
  if stateId == GameStateID.PreviewChessPet then
    self:_HandleInPreviewChessPetState(attackRange, pickUpPos, isRecover)
  elseif stateId == GameStateID.PickUpChessPet then
    self:_HandleInPickUpChessPetState(attackRange, pickUpPos, isRecover)
  else
    self._chessSvcRender:ClearChessPetPreview()
    self._chessSvcRender:ClearChessMonsterPreview()
    self:ShowChessMonsterPreview(entityID)
  end
end

function PickUpChessMonsterSystem_Render:_HandleInPreviewChessPetState(attackRange, pickUpPos, isRecover)
  local inAttackRange = self:_CheckPickWalkRange(attackRange, pickUpPos)
  if inAttackRange then
    Log.notice("在攻击范围内，显示效果")
    self._chessSvcRender:OnPickUpChessPetAttackRange(pickUpPos)
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 1)
    if isRecover then
      self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Recover)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Attack)
    end
  else
    self._chessSvcRender:ClearChessPetPreview()
    local prvwSvc = self._world:GetService("PreviewMonsterTrap")
    prvwSvc:HideHideInUIBar()
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
    pickUpResCmpt:SetPickUpChessPetEntityID(nil)
    pickUpResCmpt:SetPickUpMonsterEntityID(nil)
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 3)
  end
end

function PickUpChessMonsterSystem_Render:_HandleInPickUpChessPetState(attackRange, pickUpPos, isRecover)
  local inAttackRange = self:_CheckPickWalkRange(attackRange, pickUpPos)
  if inAttackRange then
    Log.fatal("在攻击范围内，显示效果")
    self._chessSvcRender:OnPickUpChessPetAttackRange(pickUpPos)
    if isRecover then
      self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Recover)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Attack)
    end
  else
    self._chessSvcRender:ClearChessPetPreview()
    local prvwSvc = self._world:GetService("PreviewMonsterTrap")
    prvwSvc:HideHideInUIBar()
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
    pickUpResCmpt:SetPickUpChessPetEntityID(nil)
    pickUpResCmpt:SetPickUpMonsterEntityID(nil)
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 5)
  end
end

function PickUpChessMonsterSystem_Render:InitServices()
  if not self._utilDataSvc then
    self._utilDataSvc = self._world:GetService("UtilData")
  end
  if not self._configService then
    self._configService = self._world:GetService("Config")
  end
  if not self._chessSvcRender then
    self._chessSvcRender = self._world:GetService("ChessRender")
  end
  if not self._utilCalcSvc then
    self._utilCalcSvc = self._world:GetService("UtilCalc")
  end
  if not self._utilScopeCalc then
    self._utilScopeCalc = self._world:GetService("UtilScopeCalc")
  end
end

function PickUpChessMonsterSystem_Render:ShowChessMonsterPreview(entityID)
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:ShowInUIBar(entityID)
  local previewEntity = self._world:GetEntityByID(entityID)
  local element = previewEntity:Element():GetPrimaryType()
  local monsterSkillID = self._utilDataSvc:GetAIPreviewSkillID(previewEntity)
  if monsterSkillID == 0 then
    return
  end
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local skillConfigData = self._configService:GetSkillConfigData(monsterSkillID, previewEntity)
  local previewType = skillConfigData:GetSkillPreviewType()
  if previewType == SkillPreviewType.N15MonsterChessSp then
    self:_PreviewSkillType28(previewEntity, monsterSkillID, skillConfigData, element)
  elseif previewType == SkillPreviewType.N15MonsterInstruction then
    self:_PreviewSkillType29(previewEntity, monsterSkillID, skillConfigData, element)
  elseif previewType == SkillPreviewType.Tips then
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  end
end

function PickUpChessMonsterSystem_Render:_PreviewSkillType29(entity, skillID, skillConfigData, element)
  self:_ShowChessMonsterTips(skillID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local previewType = skillConfigData:GetSkillPreviewType()
  local previewParam = skillConfigData:GetSkillPreviewParam()
  local setID = previewParam[1]
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.CommonSkillPreview, previewActiveSkillService, entity, skillID, setID)
end

function PickUpChessMonsterSystem_Render:_PreviewSkillType28(entity, skillID, skillConfigData, element)
  local previewEntity = entity
  local previewCasterPos = previewEntity:GetGridPosition()
  local previewCasterDir = previewEntity:GetGridDirection()
  local targetEntityIDList = self._utilScopeCalc:GetSortChessPetByMonsterPos(previewCasterPos)
  local targetID = targetEntityIDList[1]
  local moveFinalPos = previewCasterPos
  local hasMove = false
  if self._utilCalcSvc:CheckChessMonsterCanMove(previewEntity, element) and self:_IsNoMoveCanAttack(entity, skillID, skillConfigData) then
    local movePath = self._utilCalcSvc:GetMonster2TargetNearestPathByElement(previewEntity, targetID, element)
    if 0 < #movePath then
      moveFinalPos = movePath[#movePath]
      hasMove = true
    end
  end
  local rangResult = self._utilScopeCalc:CalcSkillScope(skillConfigData, moveFinalPos, previewEntity, previewCasterDir)
  local attackRange = rangResult:GetAttackRange()
  for i, targetEntityID in ipairs(targetEntityIDList) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local targetPos = targetEntity:GetGridPosition()
    if table.intable(attackRange, targetPos) then
      targetID = targetEntityID
      break
    end
  end
  self:_ShowChessMonsterTips(skillID)
  local renderEntitySvc = self._world:GetService("RenderEntity")
  if hasMove then
    local ghostEntity = renderEntitySvc:CreateGhost(moveFinalPos, previewEntity)
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local effectSrv = self._world:GetService("Effect")
  local renderBattleService = self._world:GetService("RenderBattle")
  local effectEntityList = {}
  local entity = self._world:GetEntityByID(targetID)
  if entity then
    local effectEntity = effectSrv:CreateEffect(BattleConst.ChainSkillSnipeEffectID, entity, true)
    renderBattleService:PlaySnipeEffectAnimation(effectEntity, element)
    resCmpt:AddMonsterChessTargetEffectEntity(effectEntity:GetID())
    table.insert(effectEntityList, effectEntity)
  end
  entity:NewEnableFlashAlpha()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  GameGlobal.TaskManager():CoreGameStartTask(self._ShowTargetSnipeEffect, self, previewActiveSkillService:GetPreviewIndex(), effectEntityList, element)
  self:_HandleNotInChessMonsterAttackRange({})
end

function PickUpChessMonsterSystem_Render:_ShowTargetSnipeEffect(TT, previewIndex, effectList, element)
  local renderBattleService = self._world:GetService("RenderBattle")
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  while true do
    YIELD(TT, 1000)
    local newPreviewIndex = previewActiveSkillService:GetPreviewIndex()
    if newPreviewIndex ~= previewIndex then
      return
    end
    for i, effectEntity in ipairs(effectList) do
      renderBattleService:PlaySnipeEffectAnimation(effectEntity, element)
    end
  end
end

function PickUpChessMonsterSystem_Render:_ShowChessMonsterTips(monsterSkillID)
  local skillConfigData = self._configService:GetSkillConfigData(monsterSkillID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:_ShowSkillTips(skillConfigData)
end

function PickUpChessMonsterSystem_Render:_HandleNotInChessMonsterAttackRange(attackRange)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, e in ipairs(pieceGroup:GetEntities()) do
    local pos = e:GetGridPosition()
    if not table.icontains(attackRange, pos) then
      pieceService:SetPieceAnimDown(pos)
    end
  end
end

function PickUpChessMonsterSystem_Render:_CheckPickWalkRange(walkRange, gridPos)
  for k, pos in ipairs(walkRange) do
    if pos == gridPos then
      return true
    end
  end
  return false
end

function PickUpChessMonsterSystem_Render:_FinishMonsterPreview()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillSvc:_RevertAllConvertElement(true)
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearChessMonsterPreview()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  resCmpt:ResetChessPickUp()
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId ~= GameStateID.WaitInput then
    Log.exception("only handle waitinput")
  end
end

function PickUpChessMonsterSystem_Render:_IsNoMoveCanAttack(entity, skillID, skillConfigData)
  local previewEntity = entity
  local previewCasterPos = previewEntity:GetGridPosition()
  local previewCasterDir = previewEntity:GetGridDirection()
  local rangResult = self._utilScopeCalc:CalcSkillScope(skillConfigData, previewCasterPos, previewEntity, previewCasterDir)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local targetType = SkillTargetType.ChessPet
  local targetEntityIDArray = utilScopeSvc:SelectSkillTarget(entity, targetType, rangResult, skillID)
  return #targetEntityIDArray == 0
end
