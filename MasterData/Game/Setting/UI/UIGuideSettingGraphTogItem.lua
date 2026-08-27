local UIGuideSettingGraphTogItem = class("UIGuideSettingGraphTogItem", UIBaseNode)

function UIGuideSettingGraphTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.togItem = self.transform:FindComponent(eUnityComponentID.ExToggle)
  UIUtil.AddValueChangedListener(self.ui.togItem, self, self.OnSwitchTogChanged)
end

function UIGuideSettingGraphTogItem:InitGuideSettingGraphTogItem(index, isOn, isRecommend, isHigh, name, image, togGroup, onValueChangeEvent)
  self.index = index
  self.ui.obj_Recommend:SetActive(isRecommend)
  self.ui.tex_ConsumePower.gameObject:SetActive(isHigh)
  self.ui.togItem.group = togGroup
  self.ui.tex_SettingName.text = name
  self.ui.img_SettingImage.texture = image
  self.onValueChangeEvent = onValueChangeEvent
  self.ui.togItem.isOn = isOn
end

function UIGuideSettingGraphTogItem:OnSwitchTogChanged(value)
  if self.onValueChangeEvent ~= nil then
    self.onValueChangeEvent(value, self)
  end
end

return UIGuideSettingGraphTogItem
