local UINGuidePicture_0623NewDesItem = class("UINGuidePicture_0623NewDesItem", UIBaseNode)

function UINGuidePicture_0623NewDesItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINGuidePicture_0623NewDesItem:InitGPNewDesItem(desCfg)
  self.ui.tex_Number.text = tostring(desCfg.order)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(desCfg.describe)
end

return UINGuidePicture_0623NewDesItem
