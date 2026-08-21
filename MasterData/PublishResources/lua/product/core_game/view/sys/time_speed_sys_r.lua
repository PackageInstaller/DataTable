_class("TimeSpeedSystemRender_Render", ReactiveSystem)
TimeSpeedSystemRender_Render = TimeSpeedSystemRender_Render

function TimeSpeedSystemRender_Render:Constructor(world)
  self._world = world
end

function TimeSpeedSystemRender_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {
    "AddedOrRemoved"
  })
  return c
end

function TimeSpeedSystemRender_Render:Filter(entity)
  if self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
    return false
  end
  local utilStatSvc = self._world:GetService("UtilData")
  return not utilStatSvc:GetStatAutoFight()
end

function TimeSpeedSystemRender_Render:ExecuteEntities(entities)
  local e = self._world:Player():GetLocalTeamEntity()
  if not e then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
    return
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if not chainPath then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
    return
  end
  if 0 < #chainPath then
    local utilDataSvc = self._world:GetService("UtilData")
    local curMainStateID = utilDataSvc:GetCurMainStateID()
    if curMainStateID == GameStateID.WaitInput then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, false, true)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, false)
    end
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  end
end
