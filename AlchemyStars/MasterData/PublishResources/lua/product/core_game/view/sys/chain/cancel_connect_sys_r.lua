require("reactive_system")
_class("CancelConnectSystem_Render", ReactiveSystem)
CancelConnectSystem_Render = CancelConnectSystem_Render

function CancelConnectSystem_Render:Constructor(world)
  self.world = world
end

function CancelConnectSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {"Added"})
  return c
end

function CancelConnectSystem_Render:Filter(entity)
  if self.world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return false
  end
  return true
end

function CancelConnectSystem_Render:ExecuteEntities(entities)
  local renderBoardEntity = self.world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local linkLineService = self.world:GetService("LinkLine")
  for _, e in ipairs(entities) do
    local previewChainPathCmpt = e:PreviewChainPath()
    local chain_path = previewChainPathCmpt:GetPreviewChainPath()
    if not chain_path or #chain_path == 1 then
      linkLineService:ShowChainPathCancelArea(false)
    elseif 2 <= #chain_path and not renderBoardCmpt:GetChainPathCancelAreaActive() and self.world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      linkLineService:ShowChainPathCancelArea(true)
      local guideService = self.world:GetService("Guide")
      local guideTaskId = guideService:Trigger(GameEventType.ShowGuideCancelArea)
    end
  end
end
