local UINAthItemAttr = class("UINAthItemAttr", UIBaseNode)
local base = UIBaseNode
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")

function UINAthItemAttr:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.defaultBgColor = self.ui.img_Bg.color
end

function UINAthItemAttr:InitAthItemAttr(attrId, attrValue, isMain, quality)
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_AddNum.text = valueStr
  if isMain then
    self.ui.img_Bg.color = AthEnum.AthColor[quality]
    self.ui.img_Icon.color = Color.white
    self.ui.tex_AddNum.color = Color.white
    return
  end
  local subAttrColor = AthEnum.AthQualityColor[quality]
  self.ui.img_Bg.color = self.defaultBgColor
  self.ui.img_Icon.color = subAttrColor
  self.ui.tex_AddNum.color = subAttrColor
end

function UINAthItemAttr:OnDelete()
  base.OnDelete(self)
end

return UINAthItemAttr
