local UINRecommeShopLoopPicItem = class("UINRecommeShopLoopPicItem", UIBaseNode)
local base = UIBaseNode
local UINRecommeShopPicItem = require("Game.ShopMain.UINRecommeShopPicItem")
local JumpManager = require("Game.Jump.JumpManager")

function UINRecommeShopLoopPicItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.scrollRect = self.ui.bannerScroll.gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  self.countSizeX = self.ui.tr_count.sizeDelta.x
  self.picPool = UIItemPool.New(UINRecommeShopPicItem, self.ui.bannerItem)
  self.ui.bannerItem:SetActive(false)
  self.__LoopBanner = BindCallback(self, self.LoopBanner)
  self.ui.bannerScroll:onPageIndexChanged("+", self.__LoopBanner)
end

function UINRecommeShopLoopPicItem:RecShopLoopPicInit(resloader)
  self.resloader = resloader
end

function UINRecommeShopLoopPicItem:RefreshRecShopLoopPicItem(bannerCfgList)
  local bannerCount = #bannerCfgList
  self.picPool:HideAll()
  for i, v in ipairs(bannerCfgList) do
    local item = self.picPool:GetOne()
    item:InitRecommeShopPic(v, self.resloader)
  end
  if bannerCount < 2 then
    self.ui.tr_count.gameObject:SetActive(false)
    self.countDefaultPos = nil
  else
    if self.scrollRect ~= nil then
      self.scrollRect.horizontal = true
    end
    self.ui.tr_count.sizeDelta = Vector2.New(self.countSizeX * bannerCount, self.ui.tr_count.sizeDelta.y)
    self.countDefaultPos = Vector2.New(0, self.ui.tr_CurrNum.localPosition.y)
    self.countDefaultPos.x = -self.ui.tr_count.sizeDelta.x / 2
    self.ui.tr_CurrNum.localPosition = self.countDefaultPos
  end
  self.ui.bannerScroll:InitPosList(bannerCount)
  self.ui.bannerScroll:SetPageIndexImmediate(0)
  self.ui.bannerScroll:SetInterval(ConfigData.game_config.shopBannerTime)
end

function UINRecommeShopLoopPicItem:LoopBanner(index)
  if self.countDefaultPos ~= nil then
    self.ui.tr_CurrNum.localPosition = Vector2.New(self.countDefaultPos.x + self.countSizeX * index, self.countDefaultPos.y)
  end
end

function UINRecommeShopLoopPicItem:InitRecommeShopPic()
end

return UINRecommeShopLoopPicItem
