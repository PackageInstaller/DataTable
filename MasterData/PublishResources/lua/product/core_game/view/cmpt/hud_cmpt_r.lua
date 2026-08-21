_class("HUDComponent", Object)
HUDComponent = HUDComponent

function HUDComponent:Constructor()
end

function Entity:HUD()
  return self:GetComponent(self.WEComponentsEnum.HUD)
end

function Entity:HasHUD()
  return self:HasComponent(self.WEComponentsEnum.HUD)
end

function Entity:AddHUD()
  local index = self.WEComponentsEnum.HUD
  local component = HUDComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceHUD()
  local index = self.WEComponentsEnum.HUD
  local component = HUDComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveHUD()
  if self:HasHUD() then
    self:RemoveComponent(self.WEComponentsEnum.HUD)
  end
end
