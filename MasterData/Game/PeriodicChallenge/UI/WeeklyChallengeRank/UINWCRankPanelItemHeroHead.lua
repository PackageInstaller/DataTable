local UINWCRankPanelItemHeroHead = class("UINWCRankPanelItemHeroHead", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINWCRankPanelItemHeroHead:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroItem = UINHeroHeadItem:New()
  self.heroItem:Init(self.ui.heroHeadItem)
end

function UINWCRankPanelItemHeroHead:InitHead(heroId, level, rank, clickCallback)
  self.ui.tex_Level.text = "LV" .. tostring(level)
  self.heroItem:InitHeroHeadItemWithId(heroId, clickCallback)
  local half = rank % 2
  local rankImgIndex = (rank - half) / 2 - 1
  if 0 <= rankImgIndex then
    self.ui.img_Star.gameObject:SetActive(true)
    self.ui.img_Star:SetIndex(rankImgIndex)
    local vec = self.ui.img_Star.image.rectTransform.sizeDelta
    vec.x = self.ui.img_Star.image.sprite.rect.width
    self.ui.img_Star.image.rectTransform.sizeDelta = vec
  else
    self.ui.img_Star.gameObject:SetActive(false)
  end
  self.ui.img_Half.gameObject:SetActive(half == 1)
  self.ui.obj_vowFrame:SetActive(false)
end

function UINWCRankPanelItemHeroHead:SetVowFrame(bool)
  self.ui.obj_vowFrame:SetActive(bool)
end

return UINWCRankPanelItemHeroHead
