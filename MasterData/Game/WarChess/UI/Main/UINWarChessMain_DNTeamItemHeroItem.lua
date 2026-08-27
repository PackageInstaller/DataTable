local base = UIBaseNode
local UINWarChessMain_DNTeamItemHeroItem = class("UINWarChessMain_DNTeamItemHeroItem", UIBaseNode)
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINWarChessMain_DNTeamItemHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroHeadItem = UINHeroHeadItem.New()
  self.heroHeadItem:Init(self.ui.obj_heroHeadItem)
end

function UINWarChessMain_DNTeamItemHeroItem:InitWCHeroHeadItem(heroData, isCaptain)
  self.heroHeadItem:InitHeroHeadItem(heroData)
  self.ui.obj_captain:SetActive(isCaptain or false)
end

function UINWarChessMain_DNTeamItemHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessMain_DNTeamItemHeroItem
