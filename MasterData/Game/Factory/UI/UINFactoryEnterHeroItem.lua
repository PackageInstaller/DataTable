local UINFactoryEnterHeroItem = class("UINFactoryEnterHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINFactoryEnterHeroItem:OnInit()
  self.heroHeadItem = nil
  self.clickCallback = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_enterItem, self, self.OnClickItem)
end

function UINFactoryEnterHeroItem:InitHeroItem(heroId, resloader, clickCallback)
  self.clickCallback = clickCallback
  if heroId == nil then
    self.ui.obj_img_Add:SetActive(true)
    self.ui.obj_heroHeadItem:SetActive(false)
    return
  else
    self.ui.obj_img_Add:SetActive(false)
    self.ui.obj_heroHeadItem:SetActive(true)
  end
  if self.heroHeadItem == nil then
    self.heroHeadItem = UINHeroHeadItem.New()
    self.heroHeadItem:Init(self.ui.obj_heroHeadItem)
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  self.heroHeadItem:InitHeroHeadItem(heroData, resloader)
end

function UINFactoryEnterHeroItem:OnClickItem()
  if self.clickCallback ~= nil then
    self.clickCallback()
  end
end

function UINFactoryEnterHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINFactoryEnterHeroItem
