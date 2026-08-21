_class("LinkLineRenderComponent", Object)
LinkLineRenderComponent = LinkLineRenderComponent

function LinkLineRenderComponent:Constructor(pos, dir)
  self._head_pos = pos or Vector3(-1, -1, 0)
  self._end_pos = dir or Vector3(0, 0, 0)
end

function LinkLineRenderComponent:GetHeadPos()
  return self._head_pos
end

function LinkLineRenderComponent:GetEndPos()
  return self._end_pos
end

function LinkLineRenderComponent:Destructor()
  self._head_pos = nil
  self._end_pos = nil
end

function LinkLineRenderComponent:Dispose()
  self._head_pos = nil
  self._end_pos = nil
end

function Entity:LinkLineRender()
  return self:GetComponent(self.WEComponentsEnum.LinkLineRender)
end

function Entity:HasLinkLineRender()
  return self:HasComponent(self.WEComponentsEnum.LinkLineRender)
end

function Entity:AddLinkLineRender()
  local index = self.WEComponentsEnum.LinkLineRender
  local component = LinkLineRenderComponent:New(nil, nil)
  self:AddComponent(index, component)
  local world = self:GetOwnerWorld()
  local linkRenderSvc = world:GetService("LinkageRender")
  linkRenderSvc:AssembleChainPath(self)
end

function Entity:ReplaceLinkLineRender(headPos, endPos)
  local index = self.WEComponentsEnum.LinkLineRender
  local component = self:LinkLineRender()
  component._head_pos = headPos
  component._end_pos = endPos
  local world = self:GetOwnerWorld()
  local linkRenderSvc = world:GetService("LinkageRender")
  linkRenderSvc:AssembleChainPath(self)
end

function Entity:RemoveLinkLineRender()
  if self:HasLinkLine() then
    self:RemoveComponent(self.WEComponentsEnum.LinkLineRender)
  end
end
