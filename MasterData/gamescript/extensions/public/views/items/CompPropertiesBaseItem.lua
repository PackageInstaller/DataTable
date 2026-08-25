local CompPropertiesBaseItem, Super = NewViewComponent("CompPropertiesBaseItem")

function CompPropertiesBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Panel_Main_item1Resource(uiNode)
  self.clickFunc = data.clickFunc
  self.icon = data.icon
  self.title = data.title
  self.desc = data.desc
  self.isHideFrame = data.isHideFrame
  self.nameNodeLength = data.nameNodeLength
end

function CompPropertiesBaseItem:OnEnterComponent()
  self.ui.Btn_Icon:SetActive(self.clickFunc ~= nil)
  if self.clickFunc then
    self:AddButtonClickListener(self.ui.Btn_Icon, self.clickFunc)
  end
  self.ui.Image_Icon:SetActive(nil ~= self.icon)
  if self.icon then
    self:SetImage(self.ui.Image_Icon, self.icon)
  end
  self.ui.Text_Name:SetActive(nil ~= self.title)
  if self.title then
    self:SetText(self.ui.Text_Name, self.title)
  end
  self.ui.Text_Count:SetActive(nil ~= self.desc)
  if self.desc then
    self:SetText(self.ui.Text_Count, self.desc)
  end
  self.ui.frame:SetActive(not self.isHideFrame)
  if self.nameNodeLength then
    CS.Framework.TransformUtil.SetWidth(self.ui.Text_Name.transform, self.nameNodeLength)
  end
end

return CompPropertiesBaseItem
