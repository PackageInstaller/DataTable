local UINHeroAttrItem = class("UINHeroAttrItem", UIBaseNode)
local base = UIBaseNode

function UINHeroAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.color_ori = self.ui.tex_Num.color
end

function UINHeroAttrItem:InitHeroAttrItem(attrId, attrValue, overriodColor)
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_attrName.text = name
  self.ui.tex_Num.color = overriodColor or self.color_ori
  self.ui.tex_Num.text = valueStr
end

function UINHeroAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroAttrItem
