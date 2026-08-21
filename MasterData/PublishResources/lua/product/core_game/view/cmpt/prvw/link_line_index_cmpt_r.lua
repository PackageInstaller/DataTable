_class("LinkLineIndexComponent", Object)
LinkLineIndexComponent = LinkLineIndexComponent

function LinkLineIndexComponent:Constructor(idx)
  self._path_index = idx or 0
  self._entityConfigId = 0
end

function LinkLineIndexComponent:GetPathIndex()
  return self._path_index
end

function LinkLineIndexComponent:SetEntityConfigId(configId)
  self._entityConfigId = configId
end

function LinkLineIndexComponent:GetEntityConfigId()
  return self._entityConfigId
end

function Entity:LinkLineIndex()
  return self:GetComponent(self.WEComponentsEnum.LinkLineIndex)
end

function Entity:HasLinkLineIndex()
  return self:HasComponent(self.WEComponentsEnum.LinkLineIndex)
end

function Entity:AddLinkLineIndex(pathindex)
  local index = self.WEComponentsEnum.LinkLineIndex
  local component = LinkLineIndexComponent:New(pathindex)
  self:AddComponent(index, component)
end

function Entity:ReplaceLinkLineIndex(pathindex)
  local index = self.WEComponentsEnum.LinkLineIndex
  local component = LinkLineIndexComponent:New(pathindex)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLinkLineIndex()
  if self:HasLinkLineIndex() then
    self:RemoveComponent(self.WEComponentsEnum.LinkLineIndex)
  end
end
