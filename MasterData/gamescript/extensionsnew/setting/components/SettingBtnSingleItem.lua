local SettingBtnSingleItem, Super = NewViewComponent("SettingBtnSingleItem", SettingContentBaseItem)

function SettingBtnSingleItem:OnEnterComponent()
  self:_InitBaseUIElement()
  self:AddButtonClickListener(self.ui.Btn_Jump, function()
    SettingManager.Instance:EnableSetting(self.data.tid)
  end)
  self:SetText(self.ui.Text_JumpName, LT.Text(DT.CommonID[self.data.range].Desc))
  local tid = self.data.tid
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return SettingManager.Instance.EnableRed, SettingManager.Instance end
    return SettingManager.Instance.EnableRed, SettingManager.Instance, tid
  end)
end

function SettingBtnSingleItem:OnExitComponent()
  self:RemoveViewComponentOnce(self.ui.Com_RedDot, UICompRedDot)
  Super.OnExitComponent(self)
end

return SettingBtnSingleItem
