local base = require("Game.ActivitySummer.Year22.Shop.UIActSum22Shop")
local UI23SteinsGateGachaponShop = class("UI23SteinsGateGachaponShop", base)
local UI23SteinsGateGachaShopPageItem = require("Game.Activity23SteinsGate.UI.Shop.UI23SteinsGateGachaShopPageItem")
local UI23SteinsGateGachaGoodItem = require("Game.Activity23SteinsGate.UI.Shop.UI23SteinsGateGachaGoodItem")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_ResLoader = CS.ResLoader
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon

function UI23SteinsGateGachaponShop:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickShopClose)
  self._itemDic = {}
  self._shopSelectItemPool = UIItemPool.New(UI23SteinsGateGachaShopPageItem, self.ui.pageItem)
  self._gachaGoodsItemPool = UIItemPool.New(UI23SteinsGateGachaGoodItem, self.ui.gachaItem)
  self.ui.pageItem:SetActive(false)
  self.ui.gachaItem:SetActive(false)
  self._resloader = cs_ResLoader.Create()
  self.__OnSwitchShopPageCallback = BindCallback(self, self.__OnSwitchShopPage)
  self.__OnBuyGoodsDataCallback = BindCallback(self, self.__OnBuyGoodsData)
end

function UI23SteinsGateGachaponShop:InitUI23SteinsGateGachaponShop(activityBase, shopList, showToken, closeCallback)
  self._OnCloseCallback = closeCallback
  self._shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  self._activityBase = activityBase
  self:UpdatePageToggleGroup(shopList)
  self:__OnSwitchShopPage(shopList[1])
  self:InitTime()
  self:InitTopResNode(showToken)
  CommonUIUtil.SetCommonItemRewardAudioId(1297)
end

function UI23SteinsGateGachaponShop:UpdatePageToggleGroup(shopList)
  self._shopSelectItemPool:HideAll()
  if self._shopPageDic == nil then
    self._shopPageDic = {}
  else
    table.removeall(self._shopPageDic)
  end
  for i, shopId in ipairs(shopList) do
    local item = self._shopSelectItemPool:GetOne()
    item:InitSum22ShopPage(shopId, self.__OnSwitchShopPageCallback)
    self._shopPageDic[shopId] = item
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.pageItem.transform.parent)
end

function UI23SteinsGateGachaponShop:__OnSwitchShopPage(shopId, item)
  if self._isReqing then
    return
  end
  if self._curSelectShop == shopId then
    return
  end
  for i, item in ipairs(self._shopSelectItemPool.listItem) do
    item:RefreshSum22ShopPageState(shopId)
  end
  self._curSelectShop = shopId
  self._isReqing = true
  self._shopCtrl:GetShopData(self._curSelectShop, function(shopData)
    if IsNull(self.transform) then
      return
    end
    self._isReqing = false
    self._shopData = shopData
    self:UpdateGachaItemList()
  end)
end

function UI23SteinsGateGachaponShop:UpdateGachaItemList()
  if self._shopData == nil then
    if isGameDev then
      error("商店内容是空")
    end
    return
  end
  if self._shopGoodsDatas == nil then
    self._shopGoodsDatas = {}
  else
    table.removeall(self._shopGoodsDatas)
  end
  for _, goodsDatas in ipairs(self._shopData.shopGoodsDic) do
    table.insert(self._shopGoodsDatas, goodsDatas)
  end
  if self._shopGachaItemDic == nil then
    self._shopGachaItemDic = {}
  else
    table.removeall(self._shopGachaItemDic)
  end
  self:SortShopGoods()
  self._gachaGoodsItemPool:HideAll()
  for index = 1, math.max(#self._shopGoodsDatas, 15) do
    local item = self._gachaGoodsItemPool:GetOne()
    local goodsData = self._shopGoodsDatas[index]
    self._shopGachaItemDic[index] = item
    item:InitUI23SteinsGateGachaGoodItem(goodsData, index, self.__OnBuyGoodsDataCallback)
    item:PlaySteinsGateGachaGoodsItemAnim()
  end
end

function UI23SteinsGateGachaponShop:InitTime()
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, self.__RefreshTime, self)
    self:__RefreshTime()
  end
end

function UI23SteinsGateGachaponShop:InitTopResNode(topItemIds)
  if self.gameObject.activeInHierarchy then
    UIUtil.RefreshTopResId(topItemIds)
  end
end

function UI23SteinsGateGachaponShop:__OnBuyGoodsData(index)
  local goodData = self._shopGoodsDatas[index]
  
  local function Local_Buy()
    if IsNull(self.transform) then
      return
    end
    local isRecharge = goodData.shopType == ShopEnum.eShopType.Recharge
    if isRecharge then
      ControllerManager:GetController(ControllerTypeId.Shop, true):ReqShopRecharge(goodData.goodCfg.pay_id)
      return
    end
    local isOverflow = false
    if goodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
      local num = PlayerDataCenter:GetItemOverflowNum(goodData.itemId, 1)
      if num ~= 0 then
        isOverflow = true
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      if win == nil then
        error("can't open QuickBuy win")
        return
      end
      local resIds = {}
      table.insert(resIds, goodData.currencyId)
      if goodData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(resIds, ConstGlobalItem.PaidItem) then
        table.insert(resIds, 1, ConstGlobalItem.PaidItem)
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, function()
        if IsNull(self.transform) then
          return
        end
        self:__RefreshShop()
      end, true, resIds, nil, isOverflow)
      win:OnClickAdd(true)
      win:SetQuickPurchaseBoxCloseCallback(function()
        if IsNull(self.transform) then
          return
        end
        self:__RefreshShop()
        if goodData.isSoldOut then
          for i, shopGachaItem in pairs(self._shopGachaItemDic) do
            if shopGachaItem:GetDungeonShopItemData() == goodData then
              shopGachaItem:PlaySteinsGateGachaGoodsItemSellOutAnim()
            end
          end
        end
      end)
    end)
  end
  
  if goodData.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[goodData.itemCfg.arg[1]]
    if heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0 then
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(3010), Local_Buy, nil)
      return
    end
  end
  Local_Buy()
end

function UI23SteinsGateGachaponShop:__RefreshShop()
  self:UpdateGachaItemList()
end

function UI23SteinsGateGachaponShop:SortShopGoods()
  if self._shopGoodsDatas == nil then
    return
  end
  table.sort(self._shopGoodsDatas, function(a, b)
    return a.order < b.order
  end)
end

function UI23SteinsGateGachaponShop:__SetCoin()
end

function UI23SteinsGateGachaponShop:__CancleCoin()
end

function UI23SteinsGateGachaponShop:__CoinRefresh()
end

function UI23SteinsGateGachaponShop:OnClickShopClose()
  self:Delete()
  if self._OnCloseCallback ~= nil then
    self._OnCloseCallback()
  end
end

function UI23SteinsGateGachaponShop:OnDelete()
  if self._shopSelectItemPool ~= nil then
    self._shopSelectItemPool:DeleteAll()
  end
  if self._gachaGoodsItemPool ~= nil then
    self._gachaGoodsItemPool:DeleteAll()
  end
  CommonUIUtil.SetCommonItemRewardAudioId(nil)
  base.OnDelete(self)
end

return UI23SteinsGateGachaponShop
