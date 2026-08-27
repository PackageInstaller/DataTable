local base = UIBaseNode
local UINFmtSaveHeroItem = class("UINFmtSaveHeroItem", base)
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINFmtSaveHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._heroHeadItem = UINHeroHeadItem.New()
  self._heroHeadItem:Init(self.ui.heroHeadItem)
end

function UINFmtSaveHeroItem:InitFmtSaveHeroItem(heroData, resloader)
  if heroData then
    self._heroHeadItem:InitHeroHeadItem(heroData, resloader)
    self._heroHeadItem:Show()
  else
    self._heroHeadItem:Hide()
  end
end

function UINFmtSaveHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtSaveHeroItem
