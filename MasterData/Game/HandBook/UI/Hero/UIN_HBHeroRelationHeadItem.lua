local base = require("Game.HandBook.UI.Hero.UIN_HBHeroHeroListHeroItem")
local UIN_HBHeroRelationHeadItem = class("UIN_HBHeroRelationHeadItem", base)

function UIN_HBHeroRelationHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroItem, self, self.__OnClick)
end

function UIN_HBHeroRelationHeadItem:InitHBRelationHeroHeadItem(isMain, onClickHeroItem)
  self.isMain = isMain
  self.onClickHeroItem = onClickHeroItem
end

function UIN_HBHeroRelationHeadItem:RefreshHBRelationHeroHeadItem(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  local campCfg = ConfigData.camp[heroCfg.camp]
  self.ui.img_CampIcon.sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  return self:RefreshHBHeroHeadItem(heroId)
end

function UIN_HBHeroRelationHeadItem:__OnClick()
  if self.onClickHeroItem ~= nil then
    self.onClickHeroItem(self.heroId, self)
  end
end

function UIN_HBHeroRelationHeadItem:HBHRHeadPlayEnterTween(delay)
  self:ClearHBHeroItemTween()
  self.ui.rect_head:DOLocalMoveY(-50, 0.3):From():SetRelative(true):SetDelay(delay)
  self.ui.cg_head:DOFade(0, 0.25):From():SetDelay(delay)
  self.ui.img_CampIcon:DOFade(0, 0.5):From():SetDelay(delay + 0.1)
  self.ui.img_CampIcon.transform:DOScale(1.2, 0.5):From():SetDelay(delay + 0.1)
end

function UIN_HBHeroRelationHeadItem:ClearHBHeroItemTween()
  self.ui.rect_head:DOComplete()
  self.ui.cg_head:DOComplete()
  self.ui.img_CampIcon:DOComplete()
  self.ui.img_CampIcon.transform:DOComplete()
end

function UIN_HBHeroRelationHeadItem:OnDelete()
  base.OnDelete(self)
end

return UIN_HBHeroRelationHeadItem
