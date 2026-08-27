local UIShop = class("UIShop", UIBaseWindow)
local base = UIBaseWindow
local cs_Resloader = CS.ResLoader
local ShopEnum = require("Game.Shop.ShopEnum")
local UINShopPageButtonList = require("Game.Shop.UI.UINShopPageButtonList")
local UINShopTogs = require("Game.Shop.UI.UINShopTogs")
local UINShopNormalGoodsList = require("Game.Shop.UINShopNormalGoodsList")
local UINShopHeroGoodsList = require("Game.Shop.UINShopHeroGoodsList")
local UINPeriodicCardHolder = require("Game.ShopMain.UINPeriodicCards.UINPeriodicCardHolder")
local UINRecommeShop = require("Game.ShopMain.UINRecommeShop")
local UINShopNormalGiftList = require("Game.Shop.UINShopNormalGiftList")
local UINShopNormalRechargeList = require("Game.Shop.UINShopNormalRechargeList")
local UINShopFntItemList = require("Game.Shop.Dorm.UINShopFntItemList")
local UINShopThemeSkinList = require("Game.Shop.UINShopThemeSkinList")
local UINShopRefreshNode = require("Game.Shop.UINShopRefreshNode")
local UINSupportShopBar = require("Game.ShopMain.UINSupportShopBar")
local UINTimeLimitShopBar = require("Game.ShopMain.UINTimeLimitShopBar")
local UINRuleTouchShopBar = require("Game.ShopMain.UINRuleTouchShopBar")
local UINHeroFragOverFlowShopBar = require("Game.ShopMain.UINHeroFragOverFlowShopBar")

function UIShop:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.OnReturnClicked):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.resloader = cs_Resloader.Create()
  self.curSelectShopId = nil
  self.curSelectShopPageId = nil
  self.shopGoodsNodeDic = {}
  self.__curGoodsNodeType = nil
  self.shopHeadBarNodeDic = {}
  self._refreshTime = math.maxinteger
  self.__OnClickPage = BindCallback(self, self.OnClickPage)
  self.__RefreshGoodsNode = BindCallback(self, self.RefreshGoodsNode)
  self.__OnClickRefreshShop = BindCallback(self, self.InitShop)
  self.__JudgeAndRefreshShopUI = BindCallback(self, self.JudgeAndRefreshShopUI)
  self.pageBtnListNode = UINShopPageButtonList.New()
  self.pageBtnListNode:Init(self.ui.obj_pageButtonList)
  self.pageBtnListNode:InitPageBtnList(self.shopCtrl, self.resloader, self.__OnClickPage, self)
  self.shopTogsNode = UINShopTogs.New()
  self.shopTogsNode:Init(self.ui.obj_shopTogs)
  self.shopTogsNode:InitShopTogs(self.shopCtrl, self.resloader, self.__RefreshGoodsNode)
  self.shopTogsNode:Hide()
  self.shopGoodsNodes = {
    [ShopEnum.eGoodsShowType.normal] = {
      class = UINShopNormalGoodsList,
      ui = self.ui.shopItemList
    },
    [ShopEnum.eGoodsShowType.heroGoods] = {
      class = UINShopHeroGoodsList,
      ui = self.ui.heroItemList
    },
    [ShopEnum.eGoodsShowType.monthcard] = {
      class = UINPeriodicCardHolder,
      ui = self.ui.uI_PeriodicCardHolder
    },
    [ShopEnum.eGoodsShowType.recommend] = {
      class = UINRecommeShop,
      ui = self.ui.uI_ShopRecommend
    },
    [ShopEnum.eGoodsShowType.giftBag] = {
      class = UINShopNormalGiftList,
      ui = self.ui.giftBagList
    },
    [ShopEnum.eGoodsShowType.recharge] = {
      class = UINShopNormalRechargeList,
      ui = self.ui.quartzBagList
    },
    [ShopEnum.eGoodsShowType.dormfnt] = {
      class = UINShopFntItemList,
      ui = self.ui.furnitureList
    },
    [ShopEnum.eGoodsShowType.themeSkin] = {
      class = UINShopThemeSkinList,
      ui = self.ui.skinThemeList
    }
  }
  self.shopHeadBar = {
    [ShopEnum.eHeadBarType.advTouchBar] = {
      class = UINShopRefreshNode,
      ui = self.ui.advBar
    },
    [ShopEnum.eHeadBarType.pointTouchBar] = {
      class = UINSupportShopBar,
      ui = self.ui.pointTouchBar
    },
    [ShopEnum.eHeadBarType.limitTimeBar] = {
      class = UINTimeLimitShopBar,
      ui = self.ui.limitTimeShopBar
    },
    [ShopEnum.eHeadBarType.ruleTouchBar] = {
      class = UINRuleTouchShopBar,
      ui = self.ui.ruleTouchBar
    },
    [ShopEnum.eHeadBarType.heroFrageBar] = {
      class = UINHeroFragOverFlowShopBar,
      ui = self.ui.heroChipOverflowBar
    }
  }
  self.shopCtrl:AddShopTimerCallback(self.__JudgeAndRefreshShopUI, "uiMian")
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:ResetShowHeroVoiceImme()
  end
end

function UIShop:InitShop(shopId, shelfId, pageId)
  self.curSelectShopId = nil
  self.curSelectShopPageId = nil
  self.pageBtnListNode:RefreshPageBtns()
  if shopId == nil or not self.shopCtrl:ShopIsUnlock(shopId) then
    shopId = ShopEnum.ShopId.recomme
  end
  if shelfId ~= 0 then
    pageId = nil
  end
  self:OnClickPage(shopId, shelfId, pageId)
end

function UIShop:InitShopMainBeforeUnlock(shopId, shelfId, pageId)
  self.curSelectShopId = nil
  self.curSelectShopPageId = nil
  self.pageBtnListNode:RefreshPageBtns(true)
  if shopId == nil then
    shopId = ShopEnum.ShopId.recomme
  end
  if shelfId ~= 0 then
    pageId = nil
  end
  self:OnClickPage(shopId, shelfId, pageId)
end

function UIShop:OnClickPage(shopId, shelfId, pageId)
  if self.curSelectShopId == shopId then
    return
  end
  self.curSelectShopId = shopId
  self.curSelectShopPageId = nil
  self.pageBtnListNode:SelectShop(shopId)
  self:OpenShopNode(shopId, shelfId, pageId)
end

function UIShop:OpenShopNode(shopId, shelfId, pageId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg.shop_type == ShopEnum.eShopType.Recommend or shopCfg.shop_type == ShopEnum.eShopType.MonthCard or shopCfg.shop_type == ShopEnum.eShopType.PayGift then
    self.shopTogsNode:RefreshShopTogs(shopId, nil, shelfId, pageId)
    return
  end
  self.shopCtrl:GetShopData(shopId, function(shopData)
    self.shopTogsNode:RefreshShopTogs(shopId, shopData, shelfId, pageId)
    self.shopCtrl:OnOpenShopSetShopRedDot(shopId)
  end)
end

function UIShop:RefreshGoodsNode(shopId, pageId, autoSelectShelfId)
  if pageId ~= nil and self.curSelectShopPageId == pageId then
    return
  end
  self.curSelectShopPageId = pageId
  local shopCfg = ConfigData.shop[shopId]
  local goodsNodeType = shopCfg.ui_type
  if shopCfg.shop_type == ShopEnum.eShopType.PayGift then
    local pageCfg = ConfigData.shop_page[pageId]
    if pageCfg == nil then
      error("Cant get shop_page cfg, pageId:" .. tostring(pageId))
      return
    end
    if pageCfg.mark == ShopEnum.ePageMarkType.MonthCard then
      goodsNodeType = ShopEnum.eGoodsShowType.monthcard
    end
  end
  if self.__curGoodsNodeType ~= nil and self.__curGoodsNodeType ~= goodsNodeType then
    local lastNode = self.shopGoodsNodeDic[self.__curGoodsNodeType]
    if lastNode ~= nil then
      lastNode:Hide()
    end
  end
  self.__curGoodsNodeType = goodsNodeType
  local shopNode = self.shopGoodsNodeDic[goodsNodeType]
  if shopNode == nil then
    local shopNodeCfg = self.shopGoodsNodes[goodsNodeType]
    if shopNodeCfg == nil then
      error("can't init shopPage with shopId:" .. tostring(shopId) .. " page:" .. tostring(pageId))
      return
    end
    shopNode = shopNodeCfg.class.New()
    shopNode:Init(shopNodeCfg.ui)
    shopNode:ShopCommonInit(self)
    self.shopGoodsNodeDic[goodsNodeType] = shopNode
  end
  shopNode:Show()
  shopNode:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.ui.pageHolderFade:DOKill(true)
  self.ui.pageHolderFade.alpha = 0.2
  self.ui.pageHolderFade:DOFade(1, 0.45)
end

function UIShop:RefreshHeadBar(shopData, shopCfg)
  local headBarType = ShopEnum.eHeadBarType.advTouchBar
  if shopData ~= nil then
    if shopData.shopId == ShopEnum.ShopId.supportShop then
      headBarType = ShopEnum.eHeadBarType.pointTouchBar
    elseif shopData.shopId == ShopEnum.ShopId.remasterDailyShop or shopData.shopId == ShopEnum.ShopId.photoCommemorate then
      headBarType = ShopEnum.eHeadBarType.ruleTouchBar
    elseif shopData.shopId == ShopEnum.ShopId.fragConvert then
      headBarType = ShopEnum.eHeadBarType.heroFrageBar
    elseif self.shopCtrl:GetIsThisShopHasTimeLimit(shopData.shopId) then
      headBarType = ShopEnum.eHeadBarType.limitTimeBar
    end
  end
  if shopCfg ~= nil and self.shopCtrl:GetIsThisShopHasTimeLimit(shopCfg.id) then
    headBarType = ShopEnum.eHeadBarType.limitTimeBar
  end
  for eHeadBarType, headBarNode in pairs(self.shopHeadBarNodeDic) do
    headBarNode:Hide()
  end
  local headBarNode = self.shopHeadBarNodeDic[headBarType]
  if headBarNode == nil then
    local headBarNodeCfg = self.shopHeadBar[headBarType]
    if headBarNodeCfg == nil then
      error("can't init headBarNode with headBarType:" .. tostring(headBarType))
      return
    end
    headBarNode = headBarNodeCfg.class.New()
    headBarNode:Init(headBarNodeCfg.ui)
    headBarNode:HeadBarCommonInit(self)
    self.shopHeadBarNodeDic[headBarType] = headBarNode
  end
  headBarNode:Show()
  headBarNode:RefreshHeadBarNode(shopData, shopCfg)
end

function UIShop:SetNeedRefreshTm(tm)
  if tm ~= nil and 0 < tm and tm < self._refreshTime then
    self._refreshTime = tm
  end
end

function UIShop:JudgeAndRefreshShopUI()
  if self._refreshTime ~= math.maxinteger and PlayerDataCenter.timestamp > self._refreshTime + 1 then
    self._refreshTime = math.maxinteger
    local isUnlock = self.shopCtrl:ShopIsUnlock(self.curSelectShopId)
    if not isUnlock then
      self:InitShop(nil)
    else
      self:InitShop(self.curSelectShopId)
    end
  end
end

function UIShop:SetShopMainCloseFunc(closeCallback)
  self.closeCallback = closeCallback
end

function UIShop:OnReturnClicked()
  self:OnCloseWin()
  self:Delete()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
end

function UIShop:OnDelete()
  self.shopCtrl:RemoveShopTimerCallback(self.__JudgeAndRefreshShopUI)
  self.ui.pageHolderFade:DOKill()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for eGoodsShowType, shopNode in pairs(self.shopGoodsNodeDic) do
    shopNode:Delete()
  end
  for eHeadBarType, headBarNode in pairs(self.shopHeadBarNodeDic) do
    headBarNode:Delete()
  end
  self.pageBtnListNode:Delete()
  self.shopTogsNode:Delete()
  base.OnDelete(self)
end

return UIShop
