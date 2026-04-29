_class("ReplaceMaterialComponent", Object)
ReplaceMaterialComponent = ReplaceMaterialComponent

function ReplaceMaterialComponent:Constructor(materialAssetName)
  self._materialAssetName = materialAssetName
end

function ReplaceMaterialComponent:GetMaterialAssetName()
  return self._materialAssetName
end

function Entity:ReplaceMaterialComponent()
  return self:GetComponent(self.WEComponentsEnum.ReplaceMaterial)
end

function Entity:HasReplaceMaterialComponent()
  return self:HasComponent(self.WEComponentsEnum.ReplaceMaterial)
end

function Entity:AddReplaceMaterialComponent(materialPath)
  if self:HasReplaceMaterialComponent() then
    self:RemoveReplaceMaterialComponent()
  end
  self:AddComponent(self.WEComponentsEnum.ReplaceMaterial, ReplaceMaterialComponent:New(materialPath))
end

function Entity:RemoveReplaceMaterialComponent()
  self:RemoveComponent(self.WEComponentsEnum.ReplaceMaterial)
end
