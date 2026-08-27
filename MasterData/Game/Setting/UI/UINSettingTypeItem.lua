local UINSettingTypeItem = class("UINSettingTypeItem", UIBaseNode)

function UINSettingTypeItem:OnInit()
  self.ui.img_Bg = self.transform:FindComponent("Img_Buttom", eUnityComponentID.Image)
  self.ui.img_Icon = self.transform:FindComponent("Img_Icon", eUnityComponentID.Image)
  self.ui.tex_Name = self.transform:FindComponent("Tex_Name", eUnityComponentID.ExText)
end

function UINSettingTypeItem:SetSettingTypeItemActive(active, bind)
  if active then
    self.ui.img_Bg.color = bind.color_typeBG
    self.ui.img_Icon.color = Color.black
    self.ui.tex_Name.color = bind.color_typeNameActive
  else
    self.ui.img_Bg.color = Color.New(0, 0, 0, 0)
    self.ui.img_Icon.color = Color.white
    self.ui.tex_Name.color = bind.color_typeNameDeActive
  end
end

return UINSettingTypeItem
