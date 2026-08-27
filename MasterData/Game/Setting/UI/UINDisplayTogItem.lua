local UINDisplayTogItem = class("UINDisplayTogItem", UIBaseNode)

function UINDisplayTogItem:OnInit()
  self.ui.togItem = self.transform:FindComponent(eUnityComponentID.ExToggle)
  self.ui.textName = self.transform:FindComponent("Tex_QuailtyName", eUnityComponentID.ExText)
  UIUtil.AddValueChangedListener(self.ui.togItem, self, self.OnDisplayTogChanged)
end

function UINDisplayTogItem:InitDisplayTogItem(index, isOn, togGroup, name, valueEvent, bind)
  self.index = index
  self.ui.togItem.group = togGroup
  self.ui.togItem.isOn = isOn
  self.ui.textName.text = name
  self.valueEvent = valueEvent
  if bind ~= nil then
    self.enableColor = bind.color_enableText
    self.disableColor = bind.color_disableText
    if self.enableColor ~= nil and self.disableColor ~= nil then
      self.ui.textName.color = isOn and self.enableColor or self.disableColor
    end
  end
end

function UINDisplayTogItem:OnDisplayTogChanged(value)
  if self.valueEvent ~= nil then
    self.valueEvent(value, self)
  end
  if self.enableColor ~= nil and self.disableColor ~= nil then
    self.ui.textName.color = value and self.enableColor or self.disableColor
  end
end

return UINDisplayTogItem
