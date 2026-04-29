_class("PickUpChessGridSystem_Render", ReactiveSystem)
PickUpChessGridSystem_Render = PickUpChessGridSystem_Render

function PickUpChessGridSystem_Render:Constructor(world)
  self._world = world
end

function PickUpChessGridSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpChessResult)
  }, {"Added"})
  return c
end

function PickUpChessGridSystem_Render:Filter(entity)
  local resCmpt = entity:PickUpChessResult()
  local resType = resCmpt:GetChessPickUpResultType()
  if resType == ChessPickUpTargetType.Grid then
    return true
  end
  return false
end

function PickUpChessGridSystem_Render:ExecuteEntities(entities)
  local chessSvcRender = self._world:GetService("ChessRender")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local resCmpt = renderBoardEntity:PickUpChessResult()
  local gridPos = resCmpt:GetCurChessPickUpPos()
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  local walkRange = resCmpt:GetChessPetWalkRange()
  if stateId == GameStateID.WaitInput then
    chessSvcRender:ClearChessMonsterPreview()
    chessSvcRender:ClearChessPetPreview()
  elseif stateId == GameStateID.PreviewChessPet then
    self:_PreviewChessPet(walkRange, gridPos)
  elseif stateId == GameStateID.PickUpChessPet then
    self:_PickUpChessPet(walkRange, gridPos)
  end
end

function PickUpChessGridSystem_Render:_PreviewChessPet(walkRange, gridPos)
  local chessSvcRender = self._world:GetService("ChessRender")
  local inRange = self:_CheckPickWalkRange(walkRange, gridPos)
  if inRange then
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 1)
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Move)
    chessSvcRender:ShowChessPetPreviewGhost(gridPos)
    chessSvcRender:HideChessPetSkillTips()
  else
    chessSvcRender:ClearAllChessUnitPreview()
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 3)
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
  end
end

function PickUpChessGridSystem_Render:_PickUpChessPet(walkRange, gridPos)
  local chessSvcRender = self._world:GetService("ChessRender")
  local inRange = self:_CheckPickWalkRange(walkRange, gridPos)
  if not inRange then
    chessSvcRender:ClearAllChessUnitPreview()
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 5)
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
  else
    chessSvcRender:ShowChessPetPreviewGhost(gridPos)
    chessSvcRender:HideChessPetSkillTips()
    chessSvcRender:RestartChessPetPreviewAttackRange()
    self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.Move)
  end
end

function PickUpChessGridSystem_Render:_CheckPickWalkRange(walkRange, gridPos)
  for k, pos in ipairs(walkRange) do
    if pos == gridPos then
      return true
    end
  end
  return false
end
