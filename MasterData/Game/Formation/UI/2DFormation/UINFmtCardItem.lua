local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtCardItemTag = require("Game.Formation.UI.2DFormation.UINFmtCardItemTag")
local UINFmtCardItem = class("UINFmtCardItem", UINHeroCardItem)
local base = UINHeroCardItem

function UINFmtCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.LuaUIBindingTable(self.ui.heroItem, self.ui)
  base.OnInit(self)
  self.tagPool = UIItemPool.New(UINFmtCardItemTag, self.ui.syncItem)
  self.ui.syncItem:SetActive(false)
  self.color_ori_level = self.ui.tex_Level.color
  self.color_ori_rank = self.ui.img_star.image.color
end

function UINFmtCardItem:InitHeroCardItem(heroData, resloader, clickedAction)
  self.heroData = heroData
  self.resloader = resloader
  self.onClickedAction = clickedAction
  base.InitHeroCardItem(self, heroData, resloader, clickedAction)
  local selfHeroData
  if self.isForceSupport then
    selfHeroData = nil
  else
    selfHeroData = PlayerDataCenter.heroDic[heroData.dataId]
  end
  local isNeedBan = self.isBanNotSelfHero == true and selfHeroData == nil
  if self.ui.obj_NoHero ~= nil then
    self.ui.obj_NoHero:SetActive(isNeedBan)
  end
  if self.ui.btn_HeroItem ~= nil then
    self.ui.btn_HeroItem.interactable = not isNeedBan
  end
  self.ui.obj_isSupport:SetActive(not isNeedBan and selfHeroData == nil)
  self.tagPool:HideAll()
  if selfHeroData ~= nil then
    if selfHeroData.level ~= heroData.level then
      local item = self.tagPool:GetOne(true)
      item:InitTag(selfHeroData.level, heroData.level, 0)
      item.transform:SetParent(self.ui.obj_syncList.transform)
      self.ui.tex_Level.color = self.ui.color_sync
    else
      self.ui.tex_Level.color = self.color_ori_level
    end
    if selfHeroData.rank ~= heroData.rank then
      local item = self.tagPool:GetOne(true)
      item:InitTag(selfHeroData.rank, heroData.rank, 1)
      item.transform:SetParent(self.ui.obj_syncList.transform)
      for i, v in ipairs(self.ui.starArr) do
        v.image.color = self.ui.color_sync
      end
    else
      for i, v in ipairs(self.ui.starArr) do
        v.image.color = self.color_ori_rank
      end
    end
  end
end

function UINFmtCardItem:SetIsBanNotSelfHero(isBanNotSelfHero)
  self.isBanNotSelfHero = isBanNotSelfHero
end

function UINFmtCardItem:SetIsForceSupport(bool)
  self.isForceSupport = bool
end

function UINFmtCardItem:UpdateSkin()
  local realHeroData = PlayerDataCenter.heroDic[self.heroData.dataId]
  if realHeroData == nil or self.isForceSupport then
    base.UpdateSkin(self)
    return
  end
  self.heroData:UpdateSkin(realHeroData.skinId)
  base.UpdateSkin(self)
end

function UINFmtCardItem:SetSelectActive(active, isbench)
  base.SetSelectActive(self, active, isbench)
  if self.ui.obj_syncList.activeInHierarchy == active then
    self.ui.obj_syncList:SetActive(not active)
  end
end

return UINFmtCardItem
