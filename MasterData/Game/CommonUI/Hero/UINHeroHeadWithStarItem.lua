local UINHeroHeadWithStarItem = class("UINHeroHeadWithStarItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINHeroHeadWithStarItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroData = nil
  self.heroItem = UINHeroHeadItem:New()
  self.heroItem:Init(self.ui.heroHeadItem)
end

function UINHeroHeadWithStarItem:InitHead(heroData, isHas, isMvp, clickCallback)
  self.heroData = heroData
  if not IsNull(self.ui.obj_NotGet) then
    self.ui.obj_NotGet:SetActive(not isHas)
  end
  if not IsNull(self.ui.obj_MVP) then
    self.ui.obj_MVP:SetActive(isMvp)
  end
  self.ui.tex_Level.text = "LV" .. heroData.level
  self.heroItem:InitHeroHeadItem(heroData, nil, clickCallback)
  local half = heroData.rank % 2
  local rankImgIndex = (heroData.rank - half) / 2 - 1
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
  if not IsNull(self.ui.obj_vowFrame) then
    self.ui.obj_vowFrame:SetActive(heroData:GetHeroIsVowed())
  end
end

function UINHeroHeadWithStarItem:InitHeadByNotHaveData(heroId, isHas, clickCallback)
  self.heroItem:InitHeroHeadItemWithId(heroId, clickCallback)
  if self.ui.obj_NotGet ~= nil then
    self.ui.obj_NotGet:SetActive(not isHas)
  end
  self.ui.obj_MVP:SetActive(false)
  self.ui.img_Star.gameObject:SetActive(false)
  self.ui.tex_Level.gameObject:SetActive(false)
  self.ui.img_Half.gameObject:SetActive(false)
end

return UINHeroHeadWithStarItem
