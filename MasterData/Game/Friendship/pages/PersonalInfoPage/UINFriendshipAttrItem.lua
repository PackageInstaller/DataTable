local UINFriendshipAttrItem = class("UINFriendshipAttrItem", UIBaseNode)
local base = UIBaseNode

function UINFriendshipAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFriendshipAttrItem:InitAttrItem(attrID, num)
  if attrID <= 17 then
    self.ui.img_Icon:SetIndex(attrID)
  end
  self.ui.tex_attrName.text = LanguageUtil.GetLocaleText(ConfigData.attribute[attrID].name)
  self.ui.tex_Num.text = num
end

function UINFriendshipAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipAttrItem
