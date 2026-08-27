local UINDisplayTogItem = require("Game.Setting.UI.UINDisplayTogItem")
local UIPerformanceLevelTogItem = class("UIPerformanceLevelTogItem", UINDisplayTogItem)

function UIPerformanceLevelTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.togItem = self.transform:FindComponent(eUnityComponentID.ExToggle)
  UIUtil.AddValueChangedListener(self.ui.togItem, self, self.OnDisplayTogChanged)
end

function UIPerformanceLevelTogItem:InitDisplayTogItem(index, isOn, isRecommend, togGroup, name, valueEvent)
  self.index = index
  self.ui.togItem.group = togGroup
  self.ui.togItem.isOn = isOn
  self:SetIsOn(isOn)
  self.ui.textName.text = name
  self.valueEvent = valueEvent
  self.ui.img_Recommend:SetActive(isRecommend)
end

function UIPerformanceLevelTogItem:SetIsOn(value)
  self.ui.img_Select:SetActive(value)
  self.ui.imgInfo_Setting:SetIndex(value and 0 or 1)
end

function UIPerformanceLevelTogItem:OnDisplayTogChanged(value)
  if self.valueEvent ~= nil then
    print(tostring(self.ui.togItem.isOn))
    self.valueEvent(value, self)
  end
  self:SetIsOn(value)
end

return UIPerformanceLevelTogItem
