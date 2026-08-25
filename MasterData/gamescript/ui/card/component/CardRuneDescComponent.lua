local CardRuneDescComponent, Super = System.NewComponent("CardRuneDescComponent")

function CardRuneDescComponent:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_CardChange_TipsResource(uiNode)
  self.name = data.name or ""
  self.desc = data.desc or ""
  self.icon = data.icon or ""
  self.showNewIcon = data.isNew
end

function CardRuneDescComponent:OnBind(binder)
  binder:SetActive(self.ui.Text_Name, self.name ~= "")
  binder:SetText(self.ui.Text_Name, self.name)
  binder:SetActive(self.ui.Text_Description, self.name ~= "")
  binder:SetText(self.ui.Text_Description, self.desc)
  binder:SetActive(self.ui.Image_Icon, "" ~= self.icon)
  binder:SetImage(self.ui.Image_Icon, self.icon)
  binder:SetActive(self.ui.Image_New, self.showNewIcon)
end

return CardRuneDescComponent
