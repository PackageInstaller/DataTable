local UIActSum22Shop = class("UIActSum22Shop", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UIActSum22Shop:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickShopClose)
  self:__SetNewClassNode()
  self.ui.shopList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.shopList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._itemDic = {}
  self._shopSelectItemPool = UIItemPool.New(self.class_ShopPage, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.__OnSelectShopCallback = BindCallback(self, self.__OnSelectShop)
  self.__OnBuyGoodsDataCallback = BindCallback(self, self.__OnBuyGoodsData)
end

function UIActSum22Shop:__SetCoin()
  UIUtil.AddButtonListener(self.ui.resNode, self, self.__OnClickResIcon)
  self.__CoinRefreshCallback = BindCallback(self, self.__CoinRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__CoinRefreshCallback)
  self.ui.img_Token.sprite = CRH:GetSpriteByItemId(self._showToken, true)
end

function UIActSum22Shop:__CancleCoin()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__CoinRefreshCallback)
end

function UIActSum22Shop:__CoinRefresh()
  self.ui.tex_Token.text = tostring(PlayerDataCenter:GetItemCount(self._showToken))
end

function UIActSum22Shop:__SetNewClassNode()
  self.class_ShopGoodsItem = require("Game.ActivitySummer.Year22.Shop.UINActSum22ShopGoodsItem")
  self.class_ShopPage = require("Game.ActivitySummer.Year22.Shop.UINActSum22ShopPage")
  self.isTimeShotTitle = false
end

function UIActSum22Shop:InitSum22Shop(sum22Data, callback)
  local mainCfg = sum22Data:GetSectorIIIMainCfg()
  local shopList = mainCfg.shop_list
  if #shopList == 0 then
    if isGameDev then
      error("商店列表是空")
    end
    return
  end
  self:InitSum22ShopByShopList(sum22Data, shopList, mainCfg.token_item, callback)
end

function UIActSum22Shop:InitSum22ShopByShopList(activityBase, shopList, showToken, callback)
  self._activityBase = activityBase
  self._showToken = showToken
  self._callback = callback
  self._shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  self._shopSelectItemPool:HideAll()
  self._shopPageDic = {}
  for i, shopId in ipairs(shopList) do
    local item = self._shopSelectItemPool:GetOne()
    item:InitSum22ShopPage(shopId, self.__OnSelectShopCallback)
    self._shopPageDic[shopId] = item
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.pageItem.transform.parent)
  self:__OpenFirstShopNotSoldOut(shopList, function(shopId)
    local shopPage = self._shopPageDic[shopId]
    if shopPage ~= nil then
      shopPage:OnClickPage()
    end
  end, function()
    local shopListCount = #self._shopSelectItemPool.listItem
    self._shopSelectItemPool.listItem[shopListCount]:OnClickPage()
  end)
  if not IsNull(self.ui.tex_Des) then
    if self:GetIsRemaster() then
      self.ui.tex_Des.gameObject:SetActive(true)
      self.ui.tex_Des.text = ConfigData:GetTipContent(15004)
    else
      self.ui.tex_Des.gameObject:SetActive(false)
    end
  end
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, self.__RefreshTime, self)
    self:__RefreshTime()
  end
  self:__SetCoin()
  self:__CoinRefresh()
end

function UIActSum22Shop:GetIsRemaster()
  return self._activityBase:GetSectorIIIActivityIsRemaster()
end

function UIActSum22Shop:__RefreshShop()
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
  self:__RefreShopTitle()
  for _, goodsDatas in ipairs(self._shopData.shopGoodsDic) do
    table.insert(self._shopGoodsDatas, goodsDatas)
  end
  self:SortShopGoods()
  self.ui.shopList.totalCount = #self._shopGoodsDatas
  self._refillTimer = TimerManager:StartTimer(1, function()
    self.ui.shopList:RefillCells(0, -50)
  end, self, true, true, true)
end

function UIActSum22Shop:SortShopGoods()
  if self._shopGoodsDatas == nil then
    return
  end
  table.sort(self._shopGoodsDatas, function(a, b)
    if a.isSoldOut ~= b.isSoldOut then
      return not a.isSoldOut
    end
    return a.order < b.order
  end)
end

function UIActSum22Shop:__RefreShopTitle()
  if self.ui.title ~= nil then
    self.ui.title:SetActive(self._shopData.shopCfg.is_recommended)
  end
end

function UIActSum22Shop:__OnInstantiateItem(go)
  local item = self.class_ShopGoodsItem.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UIActSum22Shop:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  local data = self._shopGoodsDatas[index + 1]
  item:InitCharDungeonShopItem(data, index + 1, self.__OnBuyGoodsDataCallback)
end

function UIActSum22Shop:__RefreshTime()
  if (self._expireTime or 0) == 0 then
    self._expireTime = self._activityBase:GetActivityDestroyTime()
    local date = TimeUtil:TimestampToDate(self._expireTime, false, true)
    self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  end
  local timeStr, time = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime, self.isTimeShotTitle)
  if time <= 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.ui.tex_countdown.text = timeStr
end

function UIActSum22Shop:__OnSelectShop(shopId, item)
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
    self:__RefreshShop()
  end)
end

function UIActSum22Shop:__OpenFirstShopNotSoldOut(shopIdList, notSoldOutCallback, allShopSoldOutCallback)
  local currentShopIdIndex = 1
  local soldOutCallback
  
  function soldOutCallback()
    currentShopIdIndex = currentShopIdIndex + 1
    if shopIdList[currentShopIdIndex] == nil then
      if allShopSoldOutCallback ~= nil then
        allShopSoldOutCallback()
      end
    else
      self:__ReqIsShopAllSoldOut(shopIdList[currentShopIdIndex], soldOutCallback, notSoldOutCallback)
    end
  end
  
  self:__ReqIsShopAllSoldOut(shopIdList[currentShopIdIndex], soldOutCallback, notSoldOutCallback)
end

function UIActSum22Shop:__ReqIsShopAllSoldOut(shopId, soldOutCallback, notSoldOutCallback)
  if shopId == nil then
    return
  end
  if self._isReqing then
    error("req ShopData fail! can only req 1 shopData at a time!")
    return
  end
  self._isReqing = true
  self._shopCtrl:GetShopData(shopId, function(shopData)
    if IsNull(self.transform) then
      return
    end
    self._isReqing = false
    for _, shopGood in pairs(shopData.shopGoodsDic) do
      if not shopGood.isSoldOut and notSoldOutCallback then
        notSoldOutCallback(shopId)
        return
      end
    end
    if soldOutCallback then
      soldOutCallback(shopId)
    end
  end)
end

function UIActSum22Shop:__OnBuyGoodsData(index)
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
      local num = PlayerDataCenter:GetItemOverflowNum(goodData.itemId, goodData.itemNum)
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

function UIActSum22Shop:__OnClickResIcon()
  local itemCfg = ConfigData.item[self._showToken]
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win == nil then
      return
    end
    win:InitCommonItemDetail(itemCfg)
  end)
end

function UIActSum22Shop:OnClickShopClose()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIActSum22Shop:OnDelete()
  TimerManager:StopTimer(self._refillTimer)
  self:__CancleCoin()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnDelete(self)
end

return UIActSum22Shop
