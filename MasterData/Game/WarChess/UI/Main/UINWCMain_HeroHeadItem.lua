local base = UIBaseNode
local UINWCMain_HeroHeadItem = class("UINWCMain_HeroHeadItem", base)
local heroHpPercent = require("Game.Exploration.ExplorationEnum").eHeroHpPercent
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINWCMain_HeroHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._heroHeadItem = UINHeroHeadItem.New()
  self._heroHeadItem:Init(self.ui.heroHeadItem)
end

function UINWCMain_HeroHeadItem:InitWCHeroHeadItem(dynHero, isCaptain)
  self.dynHeroData = dynHero
  self.ui.obj_captain:SetActive(isCaptain or false)
  self._heroHeadItem:InitHeroHeadItem(dynHero.heroData, self._resloader)
  self._heroHeadItem:Show()
  self:RefreshWCHeroHp()
end

function UINWCMain_HeroHeadItem:RefreshWCHeroHp(setMin)
  local amount = BattleUtil.CalculateBloodDensity(self.dynHeroData.hpPer / heroHpPercent)
  self.ui.img_hP.fillAmount = amount
  if setMin then
    self.ui.img_hPMin.fillAmount = amount
  end
  if amount <= 0.3 then
    self.ui.obj_img_Wound:SetActive(true)
  else
    self.ui.obj_img_Wound:SetActive(false)
  end
end

return UINWCMain_HeroHeadItem
