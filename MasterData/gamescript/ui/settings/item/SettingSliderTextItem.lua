local SettingItemType = CommonDefine.SettingItemType
local Slider = typeof(CS.UnityEngine.UI.Slider)
local VOICE_REALVAL_PER_SETVAL = 10
local VOICE_MAX_VAL = 10
local VOICE_MIN_VAL = 0
local rtpcWwiseName2PostSoundMap = {
  [CommonDefine.rtpcWwiseName.Voc] = "Play_UI_Set_VolFader_VO",
  [CommonDefine.rtpcWwiseName.Sfx] = "Play_UI_Set_VolFader_SE"
}
local SettingSliderTextItem, Super = System.NewComponent("SettingSliderTextItem", SettingBaseItem)

function SettingSliderTextItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
  self.bindFinish = false
end

function SettingSliderTextItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  self:InitBaseUIElement()
  binder:BindToSliderMaxValue(self.ui.Slider_Date, function()
    return VOICE_MAX_VAL
  end)
  binder:BindToSliderMinValue(self.ui.Slider_Date, function()
    return VOICE_MIN_VAL
  end)
  binder:BindToSliderValueChange(self.ui.Slider_Date, function()
    model:SetSliderVal(self.ui.Slider_Date:GetComponent(Slider).value)
    if model.rtpc and self.bindFinish then
      if rtpcWwiseName2PostSoundMap[model.rtpc] then
        AudioManager.Instance:PostSoundEvent(rtpcWwiseName2PostSoundMap[model.rtpc])
      end
      AudioManager.Instance:SetRTPCValueByName(model.rtpc, model.sliderVal * VOICE_REALVAL_PER_SETVAL)
      MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. model.rtpc .. "_val", model.sliderVal, true)
    else
      SettingManager.Instance:SetSettingData(model.setUpUid, model.sliderVal)
    end
  end)
  binder:BindToText(self.ui.Text_Num, function()
    return model.sliderVal and math.floor(model.sliderVal) or ""
  end)
  binder:SetSliderCurValue(self.ui.Slider_Date, model.sliderVal)
  self.bindFinish = true
end

return SettingSliderTextItem
