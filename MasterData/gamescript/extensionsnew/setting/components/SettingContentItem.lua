local Slider = typeof(CS.UnityEngine.UI.Slider)
local DATE_MAX_VAL = 10
local DATE_MIN_VAL = 0
local SettingContentItem, Super = NewViewComponent("SettingContentItem", SettingContentBaseItem)

function SettingContentItem:OnEnterComponent()
  self:_InitBaseUIElement()
  self._sliderVal = nil
  self:SetText(self.ui.Text_Num, "")
  self:SetText(self.ui.Text_Drop_Tips, "")
  local slider = self.ui.Slider_Date:GetComponent(Slider)
  if slider then
    slider.maxValue = DATE_MAX_VAL
    slider.minValue = DATE_MIN_VAL
  end
  self:AddSliderListener(self.ui.Slider_Date, System.fn(self, self._OnSliderValueChanged))
end

function SettingContentItem:_OnSliderValueChanged(value)
  self._sliderVal = value
  if self.data.rtpc then
    AudioManager.Instance:SetRTPCValueByName(self.data.rtpc, value * 10)
  end
  self:SetText(self.ui.Text_Num, math.floor(value))
end

return SettingContentItem
