local SettingItemType = CommonDefine.SettingItemType
local Slider = typeof(CS.UnityEngine.UI.Slider)
local SettingContentItem, Super = System.NewComponent("SettingContentItem", SettingBaseItem)

function SettingContentItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
end

function SettingContentItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  self:InitBaseUIElement()
  binder:BindToText(self.ui.Text_Num, function()
    do return LT.Text end
    return LT.Text, ""
  end)
  binder:BindToText(self.ui.Text_Drop_Tips, function()
    do return LT.Text end
    return LT.Text, ""
  end)
  binder:BindToSliderMaxValue(self.ui.Slider_Date, function()
    return 10
  end)
  binder:BindToSliderMinValue(self.ui.Slider_Date, function()
    return 0
  end)
  binder:BindToSliderValueChange(self.ui.Slider_Date, function()
    model:SetSliderVal(self.ui.Slider_Date:GetComponent(Slider).value)
    if model.rtpc then
      AudioManager.Instance:SetRTPCValueByName(model.rtpc, model.sliderVal * 10)
    end
  end)
  binder:BindToText(self.ui.Text_Num, function()
    return model.sliderVal and math.floor(model.sliderVal) or ""
  end)
end

return SettingContentItem
