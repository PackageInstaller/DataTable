local UINLineupHeroItem = class("UINLineupHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local SpecialRuleGenerator = require("Game.PlayerData.SpecialRuleGenerator")

function UINLineupHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroCardItem = UINHeroCardItem.New()
  self.heroCardItem:Init(self.ui.uINHeroItem)
  self.__selectHeroFunc = BindCallback(self, self.__OnHeroItemClicked)
  self.__onLockedHeroItemClicked = BindCallback(self, self.__OnLockedHeroItemClicked)
  self.__onHeroInfoCloseCallback = BindCallback(self, self.__OnHeroInfoCloseCallback)
end

function UINLineupHeroItem:InitLineupHeroItem(heroCfg, resLoader)
  local heroId = heroCfg.hero_id
  self.heroId = heroId
  self.resloader = resLoader
  local heroData = PlayerDataCenter.heroDic[self.heroId]
  local isSelect = false
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl ~= nil then
    local fmtData = fmtCtrl:GetFmtCtrlFmtData()
    local heroDic = fmtData:GetFormationHeroDic()
    if heroDic ~= nil and table.contain(heroDic, heroId) then
      isSelect = true
    end
  end
  if heroData ~= nil then
    self.heroCardItem:InitHeroCardItem(heroData, resLoader, self.__selectHeroFunc)
    self.heroCardItem:SetEfficiencyActive(true)
  else
    local hero_dataCfg = ConfigData.hero_data[heroId]
    local specificHeroDataRuler = SpecificHeroDataRuler.New(1, hero_dataCfg.rank, 0)
    heroData = SpecialRuleGenerator.CreateSpecificHeroData(heroId, specificHeroDataRuler)
    heroData.isLockedHero = true
    self.heroCardItem:InitHeroCardItem(heroData, resLoader, self.__onLockedHeroItemClicked)
  end
  self.ui.obj_Selected:SetActive(isSelect)
  self.ui.tex_HeroPos.text = LanguageUtil.GetLocaleText(heroCfg.hero_label)
  self.ui.tex_Career:SetIndex(heroCfg.hero_attribute - 1)
end

function UINLineupHeroItem:__OnLockedHeroItemClicked(heroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    if window ~= nil then
      window:InitHeroInformation(heroData, self.__onHeroInfoCloseCallback)
    end
  end)
end

function UINLineupHeroItem:__OnHeroInfoCloseCallback()
  local heroData = PlayerDataCenter.heroDic[self.heroId]
  if heroData ~= nil then
    self.heroCardItem:InitHeroCardItem(heroData, self.resloader, self.__selectHeroFunc)
    self.heroCardItem:SetEfficiencyActive(true)
  end
end

function UINLineupHeroItem:__OnHeroItemClicked(heroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(windows)
    if windows == nil then
      error(LanguageUtil.GetLocaleText(heroData.name) .. "Click can't show state")
      return
    end
    windows:InitHeroState(heroData, {}, self.__onHeroInfoCloseCallback)
  end)
end

function UINLineupHeroItem:OnDelete()
  self.heroCardItem:Delete()
  self.heroCardItem = nil
  self.resloader = nil
  base.OnDelete(self)
end

return UINLineupHeroItem
