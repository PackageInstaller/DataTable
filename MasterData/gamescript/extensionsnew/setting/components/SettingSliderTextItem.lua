local Slider = typeof(CS.UnityEngine.UI.Slider)
local VOICE_REALVAL_PER_SETVAL = 10
local VOICE_MAX_VAL = 10
local VOICE_MIN_VAL = 0
local rtpcWwiseName2PostSoundMap = {
  [CommonDefine.rtpcWwiseName.Voc] = "Play_UI_Set_VolFader_VO",
  [CommonDefine.rtpcWwiseName.Sfx] = "Play_UI_Set_VolFader_SE"
}
local SettingSliderTextItem, Super = NewViewComponent("SettingSliderTextItem", SettingContentBaseItem)

function SettingSliderTextItem:OnEnterComponent()
  self:_InitBaseUIElement()
  self._sliderVal = SettingModel.Instance:GetSliderInitVal(self.data)
  local slider = self.ui.Slider_Date:GetComponent(Slider)
  if slider then
    slider.maxValue = VOICE_MAX_VAL
    slider.minValue = VOICE_MIN_VAL
  end
  self:SetSliderValue(self.ui.Slider_Date, self._sliderVal or VOICE_MIN_VAL)
  self:SetText(self.ui.Text_Num, self._sliderVal and math.floor(self._sliderVal) or "")
  self:AddSliderListener(self.ui.Slider_Date, System.fn(self, self._OnSliderValueChanged))
end

function SettingSliderTextItem:_OnSliderValueChanged(value)
  local data = self.data
  self._sliderVal = value
  if data.rtpc then
    if rtpcWwiseName2PostSoundMap[data.rtpc] then
      AudioManager.Instance:PostSoundEvent(rtpcWwiseName2PostSoundMap[data.rtpc])
    end
    AudioManager.Instance:SetRTPCValueByName(data.rtpc, value * VOICE_REALVAL_PER_SETVAL)
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. data.rtpc .. "_val", value, true)
  else
    SettingManager.Instance:SetSettingData(data.setUpUid, value)
  end
  self:SetText(self.ui.Text_Num, math.floor(value))
end

return SettingSliderTextItem
