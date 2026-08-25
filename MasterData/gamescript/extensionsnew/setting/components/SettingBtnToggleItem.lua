local SettingBtnToggleItem, Super = NewViewComponent("SettingBtnToggleItem", SettingContentBaseItem)

function SettingBtnToggleItem:OnEnterComponent()
  self:_InitBaseUIElement()
  self._toggleState = SettingModel.Instance:GetToggleInitState(self.data)
  self:BindEvent(EventMgr.Instance.GraphicSetting, System.fn(self, self._OnGraphicSetting))
  self:SetText(self.ui.Text_Right_Btn_Dis, LT.Text("SettingToggleOpen"))
  self:SetText(self.ui.Text_Left_Btn_Dis, LT.Text("SettingToggleClose"))
  self:AddZ1ToggleValueChangedListener(self.ui.Group_Right_Btn, function(isOn)
    if isOn then
      self:_OnToggleClick(true)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Group_Left_Btn, function(isOn)
    if isOn then
      self:_OnToggleClick(false)
    end
  end)
  self:_RefreshToggleState()
  self:_ResetTextColorBySetVal(self._toggleState == "Open")
end

function SettingBtnToggleItem:_RefreshToggleState()
  if self._toggleState == "Open" then
    self:SetZ1Toggle(self.ui.Group_Right_Btn, true, true)
  elseif self._toggleState == "Close" then
    self:SetZ1Toggle(self.ui.Group_Left_Btn, true, true)
  end
end

function SettingBtnToggleItem:_OnGraphicSetting()
  self._toggleState = SettingModel.Instance:GetToggleInitState(self.data)
  self:_RefreshToggleState()
end

function SettingBtnToggleItem:_OnToggleClick(val)
  self._toggleState = val and "Open" or "Close"
  self:_ResetTextColorBySetVal(val)
  local audioEvent = val and "UI_SET_BTN_ON_CLICK" or "UI_SET_BTN_OFF_CLICK"
  AudioManager.Instance:PostSoundEvent(audioEvent)
  local serverVal = val and 1 or 0
  SettingManager.Instance:SetSettingData(self.data.setUpUid, serverVal)
  SettingManager.Instance:EnableSetting(self.data.tid, nil, true)
end

function SettingBtnToggleItem:_ResetTextColorBySetVal(val)
  self:SetTextColorType(self.ui.Text_Right_Btn_Dis, val and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  self:SetTextColorType(self.ui.Text_Left_Btn_Dis, val and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light)
end

return SettingBtnToggleItem
