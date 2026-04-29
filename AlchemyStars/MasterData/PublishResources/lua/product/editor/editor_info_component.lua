_class("EditorInfoComponent", Object)

function EditorInfoComponent:Constructor()
  self.ownerEntityId = 0
end

function EditorInfoComponent:SetOwnerEntityId(entityId)
  self.ownerEntityId = entityId
end

function EditorInfoComponent:GetOwnerEntityId()
  return self.ownerEntityId
end

function Entity:EditorInfo()
  return self:GetComponent(self.WEComponentsEnum.EditorInfo)
end

function Entity:HasEditorInfo()
  return self:HasComponent(self.WEComponentsEnum.EditorInfo)
end

function Entity:AddEditorInfo(newPath)
  local index = self.WEComponentsEnum.EditorInfo
  local component = EditorInfoComponent:New(newPath)
  self:AddComponent(index, component)
end

function Entity:ReplaceEditorInfo()
  local index = self.WEComponentsEnum.EditorInfo
  local cmpt = self:EditorInfo()
  self:ReplaceComponent(index, cmpt)
end

function Entity:RemoveEditorInfo()
  if self:HasEditorInfo() then
    self:RemoveComponent(self.WEComponentsEnum.EditorInfo)
  end
end
