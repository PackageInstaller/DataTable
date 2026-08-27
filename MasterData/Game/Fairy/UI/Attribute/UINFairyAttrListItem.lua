local UINFairyAttrListItem = class("UINFairyAttrListItem", UIBaseNode)
local base = UIBaseNode

function UINFairyAttrListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyAttrListItem:InitFairyAttrListItem(attrId, attrValue)
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_AttriName.text = name
  self.ui.tex_AttrNum.text = valueStr
end

function UINFairyAttrListItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyAttrListItem
