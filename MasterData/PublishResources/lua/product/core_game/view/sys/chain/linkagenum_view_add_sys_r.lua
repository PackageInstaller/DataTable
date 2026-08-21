_class("LinkageNumViewAddSystem_Render", ReactiveSystem)
LinkageNumViewAddSystem_Render = LinkageNumViewAddSystem_Render

function LinkageNumViewAddSystem_Render:Constructor(world)
  self._world = world
end

function LinkageNumViewAddSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({group}, {"Added"})
  return c
end

function LinkageNumViewAddSystem_Render:Filter(entity)
  return entity:HasLinkageNum()
end

function LinkageNumViewAddSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnLinkageNumViewAdded(entities[i])
  end
end

function LinkageNumViewAddSystem_Render:OnLinkageNumViewAdded(linknumEntity)
  local viewCmpt = linknumEntity:View()
  if viewCmpt == nil then
    return
  end
  local viewObj = viewCmpt:GetGameObject()
  if viewObj == nil then
    return
  end
  local linkageNumCmpt = linknumEntity:LinkageNum()
  linknumEntity:SetViewVisible(true)
  local viewWrapper = viewCmpt.ViewWrapper
  local viewRoot = viewWrapper.GameObject
  viewRoot.transform.rotation = Quaternion.Euler(90, -90, 0)
  linkageNumCmpt:SetLinkCount(viewRoot)
end
