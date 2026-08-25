local UICompCommonToggleItem, Super = NewViewComponent("UICompCommonToggleItem")

function UICompCommonToggleItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_ToggleResource(uiNode)
  self.name = data.name
  self.clickFunc = data.clickFunc
  self.expOrFn = data.expOrFn
  self.redFunc = data.redFunc
end

function UICompCommonToggleItem:OnEnterComponent()
  self:SetText(self.ui.Text_Toggle_Normal, LT.Text(self.name))
  self:SetText(self.ui.Text_Toggle_Select, LT.Text(self.name))
  self:AddViewComponentOnce(self.ui.Com_RedDot_Normal, UICompRedDot, CommonDefine.RedDotType.Dot, self.redFunc)
  self:AddViewComponentOnce(self.ui.Com_RedDot_Select, UICompRedDot, CommonDefine.RedDotType.Dot, self.redFunc)
  self:AddZ1ToggleValueChangedListener(self.ui.uiNode, function(isOn)
    if isOn and self.clickFunc then
      self.clickFunc()
    end
  end)
  self:SetZ1Toggle(self.ui.uiNode, self.expOrFn(), true)
end

return UICompCommonToggleItem
