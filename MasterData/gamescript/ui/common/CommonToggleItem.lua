local CommonToggleItem, Super = System.NewComponent("CommonToggleItem")

function CommonToggleItem:ctor(uiNode, data)
  Super.ctor(self)
  self.rootUINode = uiNode
  self.ui = UI_Common_Item_ToggleResource(uiNode)
  self.name = data.name
  self.clickFunc = data.clickFunc
  self.expOrFn = data.expOrFn
  self.redFunc = data.redFunc
end

function CommonToggleItem:OnBind(binder)
  binder:BindToZ1Toggle(self.ui.uiNode, nil, function(isOn)
    if isOn and self.clickFunc then
      self.clickFunc()
    end
  end, self.expOrFn)
  binder:BindToText(self.ui.Text_Toggle_Normal, function()
    do return LT.Text end
    return LT.Text, self.name
  end)
  binder:BindToText(self.ui.Text_Toggle_Select, function()
    do return LT.Text end
    return LT.Text, self.name
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Normal, CommonDefine.RedDotType.Dot, self.redFunc))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_Select, CommonDefine.RedDotType.Dot, self.redFunc))
end

return CommonToggleItem
