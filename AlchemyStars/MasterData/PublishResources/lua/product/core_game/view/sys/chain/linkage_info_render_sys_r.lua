_class("LinkageInfoRenderSystem_Render", ReactiveSystem)
LinkageInfoRenderSystem_Render = LinkageInfoRenderSystem_Render

function LinkageInfoRenderSystem_Render:Constructor(world)
  self._world = world
end

function LinkageInfoRenderSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {"Added"})
  return c
end

function LinkageInfoRenderSystem_Render:Filter(entity)
  return false
end

function LinkageInfoRenderSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:RenderChainPath(entities[i])
  end
end

function LinkageInfoRenderSystem_Render:RenderChainPath(e)
  local chain_path_cmpt = e:PreviewChainPath()
  local chain_path = chain_path_cmpt:GetPreviewChainPath()
  if chain_path == nil then
    return
  end
  local linkageRenderService = self.world:GetService("LinkageRender")
  linkageRenderService:ShowLinkageInfo(chain_path, chain_path_cmpt:GetPreviewPieceType())
end
