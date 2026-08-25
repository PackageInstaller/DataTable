local SettingItemType = CommonDefine.SettingItemType
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local SettingBaseItem, Super = System.NewComponent("SettingBaseItem")

function SettingBaseItem:InitBaseUIElement()
  local model = self.model
  local binder = self.binder
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, function()
    local setCfg = model:GetSettingCfg()
    return setCfg.Rules
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    local setCfg = model:GetSettingCfg()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text(setCfg.Rules or ""))
  end)
  local titleComp = self.ui.Text_Title:GetComponent(TYPEOF_TMP_Text)
  binder:BindToRaw(function(_, text)
    binder:SetText(self.ui.Text_Title, text)
    local maxTextWidth = 800
    local defaultFontSize = 34
    if maxTextWidth < titleComp.preferredWidth then
      titleComp.fontSize = maxTextWidth / titleComp.preferredWidth * defaultFontSize
    else
      titleComp.fontSize = defaultFontSize
    end
  end, function()
    do return LT.Text end
    return LT.Text, model.titleText
  end)
  binder:BindToText(self.ui.Text_Tips, function()
    do return LT.Text end
    return LT.Text, model.tipsText
  end)
  binder:BindToVisible(self.ui.Text_Tips, function()
    return model.tipsText ~= ""
  end)
  binder:BindToVisible(self.ui.Group_Slider1, function()
    do return self.IsSettingItemType, self end
    return self.IsSettingItemType, self, SettingItemType.SliderNoText
  end)
  binder:BindToVisible(self.ui.Group_Slider2, function()
    do return self.IsSettingItemType, self end
    return self.IsSettingItemType, self, SettingItemType.SliderText
  end)
  binder:BindToVisible(self.ui.Group_Btn1, function()
    do return self.IsSettingItemType, self end
    return self.IsSettingItemType, self, SettingItemType.BtnToggle
  end)
  binder:BindToVisible(self.ui.Group_Btn2, function()
    do return self.IsSettingItemType, self end
    return self.IsSettingItemType, self, SettingItemType.BtnSingle
  end)
  binder:BindToVisible(self.ui.Group_Drop, function()
    do return self.IsSettingItemType, self end
    return self.IsSettingItemType, self, SettingItemType.BtnDrop
  end)
end

function SettingBaseItem:IsSettingItemType(settingItemType)
  return self.model.itemType == settingItemType
end

return SettingBaseItem
