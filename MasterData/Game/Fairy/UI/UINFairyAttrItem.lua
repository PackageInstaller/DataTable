local UINFairyAttrItem = class("UINFairyAttrItem", UIBaseNode)
local base = UIBaseNode

function UINFairyAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyAttrItem:InitHeroAttrItem(attrId, attrValue)
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  if self.ui.tex_attrName ~= nil then
    self.ui.tex_attrName.text = name
  end
  self.ui.tex_Num:SetIndex(0, valueStr)
end

function UINFairyAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyAttrItem
