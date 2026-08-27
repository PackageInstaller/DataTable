local UINLineupHeroHeadItem = class("UINLineupHeroItem", UIBaseNode)
local base = UIBaseNode
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")

function UINLineupHeroHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroHeadItem = UINCommonRankItemHeroHead:New()
  self.heroHeadItem:Init(self.ui.obj_head)
end

function UINLineupHeroHeadItem:InitHeadItem(heroData, isBench, isBan)
  local isShow = false
  if heroData ~= nil and not isBan then
    isShow = true
    self.heroHeadItem:InitHead(heroData.dataId, heroData.level, heroData.rank)
  else
    isShow = false
  end
  self.ui.obj_head:SetActive(isShow)
  self.ui.obj_empty:SetActive(not isShow)
end

function UINLineupHeroHeadItem:OnDelete()
  self.heroHeadItem:Delete()
  self.heroHeadItem = nil
  base.OnDelete(self)
end

return UINLineupHeroHeadItem
