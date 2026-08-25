local SettingItemType = CommonDefine.SettingItemType
local SettingContentBaseItem, Super = NewViewComponent("SettingContentBaseItem")
local MAX_TITLE_TEXT_WIDTH = 800
local DEFAULT_TITLE_FONT_SIZE = 34

function SettingContentBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
end

function SettingContentBaseItem:GetSettingCfg()
  do return SettingModel.Instance.GetSettingCfg, SettingModel.Instance end
  return SettingModel.Instance.GetSettingCfg, SettingModel.Instance, self.data.tid
end

function SettingContentBaseItem:IsSettingItemType(settingItemType)
  return self.data.itemType == settingItemType
end

function SettingContentBaseItem:_SafeSetActive(node, isActive)
  if node then
    node.gameObject:SetActive(isActive)
  end
end

function SettingContentBaseItem:_InitBaseUIElement()
  local data = self.data
  local setCfg = self:GetSettingCfg()
  if self.ui.UI_Common_Btn_Question then
    self.ui.UI_Common_Btn_Question.gameObject:SetActive(setCfg.Rules and true or false)
    if setCfg.Rules then
      self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, function()
        local cfg = self:GetSettingCfg()
        UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text(cfg.Rules or ""))
      end)
    end
  end
  if self.ui.Text_Title then
    self:_SetTitleText(LT.Text(data.titleText or ""))
  end
  if self.ui.Text_Tips then
    self:SetText(self.ui.Text_Tips, LT.Text(data.tipsText or ""))
    self.ui.Text_Tips.gameObject:SetActive("" ~= data.tipsText)
  end
  self:_SafeSetActive(self.ui.Group_Slider1, self:IsSettingItemType(SettingItemType.SliderNoText))
  self:_SafeSetActive(self.ui.Group_Slider2, self:IsSettingItemType(SettingItemType.SliderText))
  self:_SafeSetActive(self.ui.Group_Btn1, self:IsSettingItemType(SettingItemType.BtnToggle))
  self:_SafeSetActive(self.ui.Group_Btn2, self:IsSettingItemType(SettingItemType.BtnSingle))
  self:_SafeSetActive(self.ui.Group_Drop, self:IsSettingItemType(SettingItemType.BtnDrop))
end

function SettingContentBaseItem:_SetTitleText(text)
  self:SetText(self.ui.Text_Title, text)
  local titleComp = self:GetTextComp(self.ui.Text_Title)
  if not titleComp then
    return
  end
  if titleComp.preferredWidth > MAX_TITLE_TEXT_WIDTH then
    titleComp.fontSize = MAX_TITLE_TEXT_WIDTH / titleComp.preferredWidth * DEFAULT_TITLE_FONT_SIZE
  else
    titleComp.fontSize = DEFAULT_TITLE_FONT_SIZE
  end
end

return SettingContentBaseItem
