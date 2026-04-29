_class("LinkRendererDataComponent", Object)
LinkRendererDataComponent = LinkRendererDataComponent

function LinkRendererDataComponent:Constructor()
  self._linkageNumEntityList = {}
  self._linkLineEntityList = {}
end

function LinkRendererDataComponent:GetLinkageNumEntityList()
  return self._linkageNumEntityList
end

function LinkRendererDataComponent:AddLinkageNumEntity(entity)
  if self._linkageNumEntityList == nil then
    self._linkageNumEntityList = {}
  end
  self._linkageNumEntityList[#self._linkageNumEntityList + 1] = entity
end

function LinkRendererDataComponent:RemoveLinkageNumEntity(entity)
  if not self._linkageNumEntityList then
    return
  end
  for i = 1, #self._linkageNumEntityList do
    if self._linkageNumEntityList[i] == entity then
      table.remove(self._linkageNumEntityList, i)
      return
    end
  end
end

function LinkRendererDataComponent:GetLinkLineEntityList()
  return self._linkLineEntityList
end

function LinkRendererDataComponent:AddLinkLineEntity(entity)
  if self._linkLineEntityList == nil then
    self._linkLineEntityList = {}
  end
  self._linkLineEntityList[#self._linkLineEntityList + 1] = entity
end

function LinkRendererDataComponent:RemoveLinkLineEntity(entity)
  if not self._linkLineEntityList then
    return
  end
  for i = 1, #self._linkLineEntityList do
    if self._linkLineEntityList[i]:GetID() == entity:GetID() then
      table.remove(self._linkLineEntityList, i)
      return
    end
  end
end

function Entity:LinkRendererData()
  return self:GetComponent(self.WEComponentsEnum.LinkRendererData)
end

function Entity:HasLinkRendererData()
  return self:HasComponent(self.WEComponentsEnum.LinkRendererData)
end

function Entity:AddLinkRendererData()
  local index = self.WEComponentsEnum.LinkRendererData
  local component = LinkRendererDataComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLinkRendererData()
  local index = self.WEComponentsEnum.LinkRendererData
  local component = LinkRendererDataComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLinkRendererData()
  if self:HasLinkRendererData() then
    self:RemoveComponent(self.WEComponentsEnum.LinkRendererData)
  end
end
