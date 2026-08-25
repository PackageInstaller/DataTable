local ScrollDropDownItem, Super = System.NewComponent("ScrollDropDownItem")

function ScrollDropDownItem:ctor(res, data, clickCb)
  Super.ctor(self)
  self.ui = Item_Dropdown_ElementResource(res)
  self.data = data
  self.clickCb = clickCb
end

function ScrollDropDownItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:SetText(self.ui.Text_Name, self.data.text)
  binder:SetActive(self.ui.Image_Icon, self.data.iconPath ~= nil)
  if self.data.iconPath then
    binder:SetImage(self.ui.Image_Icon, self.data.iconPath)
  end
end

function ScrollDropDownItem:OnClick()
  if self.clickCb then
    self.clickCb(self.data.index)
  end
end

return ScrollDropDownItem
