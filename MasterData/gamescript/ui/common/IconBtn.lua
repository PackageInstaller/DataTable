local IconBtn, Super = System.NewComponent("IconBtn")

function IconBtn:ctor(obj, data)
  Super.ctor(self)
  self.ui = Btn_MainSceneResource(obj)
  self.data = data
end

function IconBtn:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Title, self.data.name)
  binder:SetImage(self.ui.Image_Icon, self.data.iconPath)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, self.data.redType, self.data.redFunc))
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnClick))
end

function IconBtn:OnClick()
  if not self.data or not self.data.clickCb then
    return
  end
  self.data.clickCb()
end

function IconBtn:SetText(nameText)
  self.binder:SetText(self.ui.Text_Title, nameText)
end

function IconBtn:SetIcon(iconPath)
  self.binder:SetImage(self.ui.Image_Icon, iconPath)
end

return IconBtn
