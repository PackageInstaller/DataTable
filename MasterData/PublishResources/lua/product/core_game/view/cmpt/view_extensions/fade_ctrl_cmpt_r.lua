_class("FadeControllerComponent", Object)
FadeControllerComponent = FadeControllerComponent

function FadeControllerComponent:Constructor(entity)
  if entity:HasView() and entity:View():GetGameObject() then
    self._fade = entity:View():GetGameObject():GetComponent(typeof(FadeComponent))
  end
  self._transparent = false
  self._transparentValue = 0
  self._flash = false
  self._ghost = false
end

function FadeControllerComponent:Fade()
  return self._fade
end

function FadeControllerComponent:IsGhost()
  return self._ghost
end

function FadeControllerComponent:IsFlash()
  return self._flash
end

function FadeControllerComponent:IsTransparent()
  return self._transparent
end

function FadeControllerComponent:GetTransparentValue()
  return self._transparentValue
end

function Entity:FadeController()
  return self:GetComponent(self.WEComponentsEnum.FadeController)
end

function Entity:HasFadeController()
  return self:HasComponent(self.WEComponentsEnum.FadeController)
end

function Entity:AddFadeController()
  local index = self.WEComponentsEnum.FadeController
  local component = FadeControllerComponent:New(self)
  self:AddComponent(index, component)
end

function Entity:EnableTransparent(enable, transparentValue)
  local index = self.WEComponentsEnum.FadeController
  local component = self:FadeController()
  component = component or FadeControllerComponent:New(self)
  component._transparent = enable
  component._transparentValue = transparentValue or 0.5
  self:ReplaceComponent(index, component)
end

function Entity:EnableFlash(enable)
  local index = self.WEComponentsEnum.FadeController
  local component = self:FadeController()
  if component then
    component._flash = enable
    self:ReplaceComponent(index, component)
  else
    local component = FadeControllerComponent:New(self)
    component._flash = enable
    self:ReplaceComponent(index, component)
  end
end

function Entity:EnableGhost(enable)
  local index = self.WEComponentsEnum.FadeController
  local component = self:FadeController()
  component = component or FadeControllerComponent:New(self)
  component._ghost = enable
  self:ReplaceComponent(index, component)
end

function Entity:SetTransparentValue(val)
  local index = self.WEComponentsEnum.FadeController
  local component = self:FadeController()
  component = component or FadeControllerComponent:New(self)
  component._transparentValue = val
  self:ReplaceComponent(index, component)
end

function Entity:RemoveFadeController()
  if self:HasFadeController() then
    self:RemoveComponent(self.WEComponentsEnum.FadeController)
  end
end
