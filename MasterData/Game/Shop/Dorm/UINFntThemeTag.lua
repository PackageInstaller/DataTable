local UINFntThemeTag = class("UINFntThemeTag", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINFntThemeTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFntThemeTag:SetIndex(tagIndex)
  self.ui.img_bottom.color = ShopEnum.ColorShowFntThemeTags[tagIndex + 1]
  self.ui.tex_Text:SetIndex(tagIndex)
  self.ui.img_Icon:SetIndex(tagIndex)
end

return UINFntThemeTag
