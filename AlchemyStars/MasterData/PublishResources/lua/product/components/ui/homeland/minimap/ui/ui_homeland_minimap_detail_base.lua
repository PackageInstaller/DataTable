_class("UIHomelandMinimapDetailBase", UICustomWidget)
UIHomelandMinimapDetailBase = UIHomelandMinimapDetailBase

function UIHomelandMinimapDetailBase:InternalInitialize(iconData)
  self.anim = self:GetUIComponent("Animation", "Anim")
  self._iconData = iconData
  self:OnInitDone()
end

function UIHomelandMinimapDetailBase:GetIconData()
  return self._iconData
end

function UIHomelandMinimapDetailBase:OnInitDone()
end

function UIHomelandMinimapDetailBase:OnClose()
  local animation = self:GetAnimation()
  if not animation then
    self:GetGameObject():SetActive(false)
  else
    local animName = self:GetCloseAnimtionName()
    if animName ~= nil and animName ~= "" then
      animation:Play(animName)
    else
      self:GetGameObject():SetActive(false)
    end
  end
end

function UIHomelandMinimapDetailBase:GetAnimation()
  return self.anim
end

function UIHomelandMinimapDetailBase:GetCloseAnimtionName()
  return ""
end
