local SettingBtnSingleItem, Super = System.NewComponent("SettingBtnSingleItem", SettingBaseItem)

function SettingBtnSingleItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_DateResource(uiNode)
  self.data = data
end

function SettingBtnSingleItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  self.binder = binder
  self:InitBaseUIElement()
  binder:BindButtonClick(self.ui.Btn_Jump, function()
    SettingManager.Instance:EnableSetting(model.tid)
  end)
  binder:SetText(self.ui.Text_JumpName, LT.Text(DT.CommonID[model.range].Desc))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, function()
    do return SettingManager.Instance.EnableRed, SettingManager.Instance end
    return SettingManager.Instance.EnableRed, SettingManager.Instance, model.tid
  end))
end

return SettingBtnSingleItem
