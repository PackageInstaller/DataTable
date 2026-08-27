local UINAthMainAtrrItem = class("UINAthMainAtrrItem", UIBaseNode)
local base = UIBaseNode

function UINAthMainAtrrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthMainAtrrItem:InitAthMainAtrrItem(attrId, attrValue, isRecommend)
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.tex_attrName.text = name
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_Num:SetIndex(0, valueStr)
  self.ui.canvasGroup.alpha = attrValue == 0 and 0.5 or 1
  self.ui.obj_Recommend:SetActive(isRecommend)
end

function UINAthMainAtrrItem:OnDelete()
  base.OnDelete(self)
end

return UINAthMainAtrrItem
