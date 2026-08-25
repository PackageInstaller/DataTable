local SettingItemType = CommonDefine.SettingItemType
local Slider = typeof(CS.UnityEngine.UI.Slider)
local SettingBtnToggleItem, Super = System.NewComponent("SettingBtnToggleItem", SettingBaseItem)

function SettingBtnToggleItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
end

function SettingBtnToggleItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  self:InitBaseUIElement()
  binder:BindEvent(EventMgr.Instance.GraphicSetting, function()
    model:RefreshData()
    if model.toggleState and model.toggleState == "Open" then
      binder:SetZ1Toggle(self.ui.Group_Right_Btn, true, true)
    elseif model.toggleState and model.toggleState == "Close" then
      binder:SetZ1Toggle(self.ui.Group_Left_Btn, true, true)
    end
  end)
  binder:BindToText(self.ui.Text_Right_Btn_Dis, function()
    do return LT.Text end
    return LT.Text, "SettingToggleOpen"
  end)
  binder:BindToZ1Toggle(self.ui.Group_Right_Btn, nil, function(isOn)
    if isOn then
      self:OnToggleClick(true)
    end
  end)
  binder:BindToText(self.ui.Text_Left_Btn_Dis, function()
    do return LT.Text end
    return LT.Text, "SettingToggleClose"
  end)
  binder:BindToZ1Toggle(self.ui.Group_Left_Btn, nil, function(isOn)
    if isOn then
      self:OnToggleClick(false)
    end
  end)
  if model.toggleState and model.toggleState == "Open" then
    binder:SetZ1Toggle(self.ui.Group_Right_Btn, true, true)
  elseif model.toggleState and model.toggleState == "Close" then
    binder:SetZ1Toggle(self.ui.Group_Left_Btn, true, true)
  end
  self:ResetTextColorBySetVal(model.toggleState == "Open")
end

function SettingBtnToggleItem:OnToggleClick(val)
  self:ResetTextColorBySetVal(val)
  local audioEvent = val and "UI_SET_BTN_ON_CLICK" or "UI_SET_BTN_OFF_CLICK"
  AudioManager.Instance:PostSoundEvent(audioEvent)
  local serverVal = val and 1 or 0
  SettingManager.Instance:SetSettingData(self.model.setUpUid, serverVal)
  SettingManager.Instance:EnableSetting(self.model.tid, nil, true)
end

function SettingBtnToggleItem:ResetTextColorBySetVal(val)
  self.binder:SetTextColorType(self.ui.Text_Right_Btn_Dis, val and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark)
  self.binder:SetTextColorType(self.ui.Text_Left_Btn_Dis, val and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light)
end

return SettingBtnToggleItem
