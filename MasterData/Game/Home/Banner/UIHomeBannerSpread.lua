local UIHomeBannerSpread = class("UIHomeBannerSpread", UIBaseWindow)
local base = UIBaseWindow
local UINHomeBannerPicItem = require("Game.Home.Banner.UINHomeBannerPicItem")
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")

function UIHomeBannerSpread:OnInit()
  self.advItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnClickBackground)
  self.ui.scroll_advList.onInstantiateItem = BindCallback(self, self.__OnInstantiateAdvItem)
  self.ui.scroll_advList.onChangeItem = BindCallback(self, self.__OnChangeAdvItem)
end

function UIHomeBannerSpread:SetSpreadBannerProperty(bannerLoopList, bannerDataList)
  self.bannerLoopList = bannerLoopList
  self.bannerDataList = bannerDataList
  self:UpdateAdvItemShow()
end

function UIHomeBannerSpread:UpdateAdvItemShow()
  self.ui.scroll_advList.totalCount = #self.bannerDataList
  self.ui.scroll_advList:RefillCells()
end

function UIHomeBannerSpread:__OnClickBackground()
  self:Delete()
end

function UIHomeBannerSpread:__OnChangeAdvItem(go, index)
  local advItem = self.advItemDic[go]
  advItem:InitHomeBannerPicItem(self.bannerDataList[index + 1])
  UIUtil.AddButtonListener(advItem.ui.button, self, self.__OnClickBackground)
end

function UIHomeBannerSpread:__OnInstantiateAdvItem(go)
  local advItem = UINHomeBannerPicItem.New()
  advItem:Init(go)
  self.advItemDic[go] = advItem
end

function UIHomeBannerSpread:OnHide()
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and homeWin.homeLeftNode.bannerUI ~= nil then
    homeWin.homeLeftNode.bannerUI:Show()
  elseif homeWin ~= nil then
    homeWin.homeLeftNode:RefreshBannerWidget()
  end
  if self.bannerLoopList ~= nil then
    self.bannerLoopList.__isAutoPlay = true
  end
end

function UIHomeBannerSpread:OnDelete()
  if self.advItemDic ~= nil then
    for i, v in pairs(self.advItemDic) do
      v:Delete()
    end
    self.advItemDic = nil
  end
  base.OnDelete(self)
end

return UIHomeBannerSpread
