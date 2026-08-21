_class("DropAssetComponent", Object)

function DropAssetComponent:Constructor()
  self._hasDoDrop = false
  self._dropAsset = nil
end

function DropAssetComponent:SetDoDrop(doDrop)
  self._hasDoDrop = doDrop
end

function DropAssetComponent:SetDropAsset(dropAsset)
  self._dropAsset = dropAsset
end

function DropAssetComponent:GetDropAsset()
  return self._dropAsset
end

function DropAssetComponent:HasDoDrop()
  return self._hasDoDrop
end

function Entity:DropAsset()
  return self:GetComponent(self.WEComponentsEnum.DropAsset)
end

function Entity:HasDropAsset()
  return self:HasComponent(self.WEComponentsEnum.DropAsset)
end

function Entity:AddDropAsset()
  local index = self.WEComponentsEnum.DropAsset
  local component = DropAssetComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceDropAsset()
  local index = self.WEComponentsEnum.DropAsset
  local component = DropAssetComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveDropAsset()
  if self:HasDropAsset() then
    self:RemoveComponent(self.WEComponentsEnum.DropAsset)
  end
end
