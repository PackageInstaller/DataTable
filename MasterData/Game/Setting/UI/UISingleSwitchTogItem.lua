local UISingleSwitchTogItem = class("UISingleSwitchTogItem", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")

function UISingleSwitchTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.toggleGroup = self.transform:FindComponent(eUnityComponentID.ToggleGroup)
  self.ui.backGroundImage = self.transform:FindComponent(eUnityComponentID.Image)
  self.ui.togItemList = {}
end

function UISingleSwitchTogItem:InitSingleSwitchTogItem(currentValueeEvent, nameList, singleValueEvent, eventSelf)
  self.ui.backGroundImage.rectTransform.rect.width = self.ui.backGroundImage.rectTransform.rect.width * 2
  self.ui.togItemList = {}
  if type(currentValueeEvent) == "function" then
    self.currentValueeEvent = currentValueeEvent
  else
    function self.currentValueeEvent()
      return currentValueeEvent
    end
  end
  local isOn = self.currentValueeEvent()
  for i = 1, 2 do
    local dTogItem = UINDisplayTogItem.New()
    local index = i - 1
    dTogItem:Init(self.transform:GetChild(index))
    dTogItem:InitDisplayTogItem(i, i == 2 == isOn, self.ui.toggleGroup, LanguageUtil.GetLocaleText(nameList[i]), nil, self.ui)
    self.ui.togItemList[i] = dTogItem
    UIUtil.AddValueChangedListener(self.ui.togItemList[i].ui.togItem, self, self.OnSwitchTogChanged, i)
  end
  self.isOn = isOn
  self.SingleValueEvent = singleValueEvent
  self.eventSelf = eventSelf
end

function UISingleSwitchTogItem:OnSwitchTogChanged(index, value)
  if self.SingleValueEvent ~= nil then
    if index == 1 and value then
      self.isOn = false
      self.SingleValueEvent(self.eventSelf, self.isOn, self)
    end
    if index == 2 and value then
      self.isOn = true
      self.SingleValueEvent(self.eventSelf, self.isOn, self)
    end
  end
end

function UISingleSwitchTogItem:SelectCurrentValue()
  if self.currentValueeEvent ~= nil then
    local currentValue = self.currentValueeEvent()
    self.isOn = currentValue
    local togItem = self.ui.togItemList[self.isOn and 2 or 1]
    if togItem ~= nil and self.ui ~= nil and self.ui.toggleGroup ~= nil then
      togItem.ui.togItem.isOn = true
      self.ui.toggleGroup:NotifyToggleOn(togItem.ui.togItem)
      self.SingleValueEvent(self.eventSelf, self.isOn, self)
    end
  end
end

return UISingleSwitchTogItem
