local UIMultiSwitchTogItem = class("UIMultiSwitchTogItem", UIBaseNode)
local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
local UIPerformanceLevelTogItem = require("Game.Setting.UI.UIPerformanceLevelTogItem")

function UIMultiSwitchTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.toggleGroup = self.transform:FindComponent(eUnityComponentID.ToggleGroup)
  self.ui.toggleGroup:SetAllTogglesOff()
  self.ui.togItemList = {}
  self.ui.multiTogItem.gameObject:SetActive(false)
end

function UIMultiSwitchTogItem:InitUIMultiSwitchTogItem(currentValueeEvent, nameList, isReverse, multiValueEvent, eventSelf)
  local s = 1
  local e = #nameList
  local a = 1
  if isReverse then
    s, e = e, s
    a = -1
  end
  self.ui.togItemList = {}
  self.currentValueeEvent = currentValueeEvent
  local selectIndex = self.currentValueeEvent()
  for i = s, e, a do
    local toggleItemObj = self.ui.multiTogItem:Instantiate(self.transform)
    toggleItemObj.gameObject:SetActive(true)
    local index = i - 1
    local dTogItem = UINDisplayTogItem.New()
    dTogItem:Init(toggleItemObj)
    dTogItem:InitDisplayTogItem(index, index == selectIndex, self.ui.toggleGroup, LanguageUtil.GetLocaleText(nameList[i]), nil, self.ui)
    dTogItem.gameObject.name = "tog_" .. tostring(i)
    self.ui.togItemList[index] = dTogItem
    UIUtil.AddValueChangedListener(self.ui.togItemList[index].ui.togItem, self, self.OnSwitchTogChanged, index)
  end
  self.selectIndex = selectIndex
  self.multiValueEvent = multiValueEvent
  self.eventSelf = eventSelf
end

function UIMultiSwitchTogItem:InitUIMultiSwitchPerformanceLevelTogItem(currentValueeEvent, nameList, recommendIndex, multiValueEvent, eventSelf)
  self.ui.togItemList = {}
  local selectIndex = currentValueeEvent()
  self.currentValueeEvent = currentValueeEvent
  for i = 1, #nameList do
    local toggleItemObj = self.ui.multiTogItem:Instantiate(self.transform)
    toggleItemObj.gameObject:SetActive(true)
    local index = i
    local PerformanceLevelTogItem = UIPerformanceLevelTogItem.New()
    PerformanceLevelTogItem:Init(toggleItemObj)
    PerformanceLevelTogItem:InitDisplayTogItem(index, index == selectIndex, index == recommendIndex, self.ui.toggleGroup, LanguageUtil.GetLocaleText(nameList[i]), nil, self.ui)
    self.ui.togItemList[index] = PerformanceLevelTogItem
    if i ~= #nameList then
      UIUtil.AddValueChangedListener(self.ui.togItemList[index].ui.togItem, self, self.OnSwitchTogChanged, index)
    end
  end
  self.selectIndex = selectIndex
  self.multiValueEvent = multiValueEvent
  self.eventSelf = eventSelf
end

function UIMultiSwitchTogItem:OnSwitchTogChanged(index, value)
  if self.multiValueEvent ~= nil then
    self.multiValueEvent(value, self.ui.togItemList[index])
  end
end

function UIMultiSwitchTogItem:SelectCurrentValue()
  if self.currentValueeEvent ~= nil then
    local currentValue = self.currentValueeEvent()
    local togItem = self.ui.togItemList[currentValue]
    if togItem ~= nil and self.ui ~= nil and self.ui.toggleGroup ~= nil then
      for key, tog in pairs(self.ui.togItemList) do
        tog.ui.togItem.isOn = currentValue == key
      end
    end
  end
end

return UIMultiSwitchTogItem
