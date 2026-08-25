local RuneComponent, Super = System.NewComponent("RuneComponent")

function RuneComponent:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_GainRuneResource(uiNode)
  self.name = data.name or ""
  self.desc = data.desc or ""
  self.icon = data.icon or ""
  self.showNewIcon = data.isNew
  self.callback = data.callback
end

function RuneComponent:OnBind(binder)
  binder:SetText(self.ui.Text_Name, self.name)
  binder:SetText(self.ui.Text_Desc, self.desc)
  binder:SetImage(self.ui.Image_Rune, self.icon)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

function RuneComponent:OnClick()
  if self.callback then
    self.callback()
  end
end

return RuneComponent
