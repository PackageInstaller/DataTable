require("reactive_system")
_class("PreviewLinkLineCancelConnectSystem_Render", ReactiveSystem)
PreviewLinkLineCancelConnectSystem_Render = PreviewLinkLineCancelConnectSystem_Render

function PreviewLinkLineCancelConnectSystem_Render:Constructor(world)
  self._world = world
end

function PreviewLinkLineCancelConnectSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewLinkLine)
  }, {"Added"})
  return c
end

function PreviewLinkLineCancelConnectSystem_Render:Filter(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local curMainStateID = utilDataSvc:GetCurMainStateID()
  if curMainStateID == GameStateID.Loading or curMainStateID == GameStateID.BattleEnter then
    return false
  end
  return true
end

function PreviewLinkLineCancelConnectSystem_Render:ExecuteEntities(entities)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local linkLineService = self._world:GetService("PreviewLinkLine")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  for _, e in ipairs(entities) do
    local previewLinkLineCmpt = e:PreviewLinkLine()
    local chain_path = previewLinkLineCmpt:GetPreviewChainPath()
    if not chain_path or #chain_path == 1 then
      linkLineService:ShowChainPathCancelArea(false)
    elseif 2 <= #chain_path and not renderBoardCmpt:GetChainPathCancelAreaActive() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      linkLineService:ShowChainPathCancelArea(true)
    end
  end
end
