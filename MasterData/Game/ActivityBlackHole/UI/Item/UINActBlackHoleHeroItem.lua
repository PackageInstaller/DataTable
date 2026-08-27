local base = UIBaseNode
local UINActBlackHoleHeroItem = class("UINActBlackHoleHeroItem", base)
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")

function UINActBlackHoleHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroItem = UINCommonRankItemHeroHead.New()
  self.heroItem:Init(self.ui.uINHeroHeadWithStar)
end

function UINActBlackHoleHeroItem:InitActBlackHoleHeroItem(heroId, level, rank)
  self.heroItem:InitHead(heroId, level, rank)
  self.heroItem:SetHeroHeadItemAtive(true)
end

function UINActBlackHoleHeroItem:InitActBlackHoleHeroItemEmpty()
  self.heroItem:SetHeroHeadItemAtive(false)
end

function UINActBlackHoleHeroItem:OnDelete()
  self.heroItem:Delete()
end

return UINActBlackHoleHeroItem
