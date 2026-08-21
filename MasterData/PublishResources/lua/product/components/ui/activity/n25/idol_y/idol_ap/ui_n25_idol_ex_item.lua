_class("UIN25IdolExItem", UICustomWidget)
UIN25IdolExItem = UIN25IdolExItem

function UIN25IdolExItem:Constructor()
end

function UIN25IdolExItem:OnShow(uiParams)
  self:GetComponents()
end

function UIN25IdolExItem:SetData(data)
  self.data = data
  self:OnValue()
end

function UIN25IdolExItem:OnHide()
end

function UIN25IdolExItem:GetComponents()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
end

function UIN25IdolExItem:OnValue()
  local id = self.data.id
  local cfg = Cfg.cfg_component_idol_event[id]
  if cfg then
    local icon = cfg.Icon
    self.icon:LoadImage(icon)
  end
end
