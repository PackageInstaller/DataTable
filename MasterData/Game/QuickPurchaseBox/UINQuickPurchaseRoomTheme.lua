local UINQuickPurchaseRoomTheme = class("UINQuickPurchaseRoomTheme", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINBaseItemMaskWithCount = require("Game.CommonUI.Item.UINBaseItemMaskWithCount")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")

function UINQuickPurchaseRoomTheme:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self._OnClickBuy)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  self.itemMaskPool = UIItemPool.New(UINBaseItemMaskWithCount, self.ui.obj_hadItem, false)
end

function UINQuickPurchaseRoomTheme:OnInitPayGift(shopGoodsDic, themeItem, parentWin)
  self.quickBuyWindow = parentWin
  self.shopGoodsDic = shopGoodsDic
  self.themeItem = themeItem
  self.dormTheme = ConfigData.dorm_theme[self.themeItem.shelfCfg.theme_id]
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = cs_ResLoader.Create()
  self.resloader:LoadABAssetAsync(PathConsts:GetShopFurnitureThemePath(self.dormTheme.theme_pic3), function(texture)
    self.ui.img_GiftBag.texture = texture
  end)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.dormTheme.theme_name)
  if self.dormTheme.only_big then
    self.ui.img_OnlyBig:SetActive(true)
  else
    self.ui.img_OnlyBig:SetActive(false)
  end
  self.itemPool:HideAll()
  self.itemMaskPool:HideAll()
  self.shelf2Cnt = {}
  self.rewardIds = {}
  self.rewardCounts = {}
  local totalCost = 0
  local requiredCost = 0
  for i, itemData in pairs(self.shopGoodsDic) do
    local limitCount = itemData.totallimitTime ~= nil and itemData.totallimitTime or itemData.limitTime
    local tempCost = (limitCount - itemData.purchases) * itemData.newCurrencyNum
    local rTempCost = limitCount * itemData.newCurrencyNum
    totalCost = totalCost + tempCost
    requiredCost = requiredCost + rTempCost
    if limitCount ~= itemData.purchases then
      self.shelf2Cnt[itemData.shelfId] = limitCount - itemData.purchases
      table.insert(self.rewardIds, itemData.itemId)
      table.insert(self.rewardCounts, limitCount - itemData.purchases)
    end
    local itemCfg = itemData.itemCfg
    local item = self.itemPool:GetOne(true)
    local hadItem = self.itemMaskPool:GetOne(true)
    hadItem:InitItemMaskWithCount(itemData.purchases, limitCount)
    item:InitItemWithCount(itemCfg, limitCount)
    hadItem.transform:SetParent(item.transform, false)
  end
  self.totalCost = totalCost
  self.requiredCost = requiredCost
  self:ClearQPRoomThemeTimerId()
  self.timerId = TimerManager:StartTimer(1, self.ShowRoomThemeCutDown, self, false, false, false)
  self:ShowRoomThemeCutDown()
  self:RefreshBtnState()
end

function UINQuickPurchaseRoomTheme:RefreshBtnState()
  local currencyItemCfg = ConfigData.item[self.themeItem.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_money.gameObject:SetActive(true)
  self.ui.img_money.sprite = CRH:GetSprite(smallIcon)
  self.ui.tex_totalcurrPrice.text = tostring(self.totalCost)
  local ownMoney = PlayerDataCenter:GetItemCount(self.themeItem.currencyId)
  if self.totalCost == self.requiredCost then
    self.ui.tex_btnDetail:SetIndex(0)
  else
    self.ui.tex_btnDetail:SetIndex(1)
  end
  if ownMoney >= self.totalCost and self.totalCost > 0 then
    self.canBuy = true
  else
    self.canBuy = false
  end
end

function UINQuickPurchaseRoomTheme:ShowRoomThemeCutDown()
  local hasTimeLimit, inTime, startTime, endTime = self.themeItem:GetStillTime()
  if endTime == nil or endTime == -1 then
    return
  end
  local time = endTime - PlayerDataCenter.timestamp
  if time < 0 or not hasTimeLimit then
    self.quickBuyWindow:TryClosePurchaseBox()
    return
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(time, false, true)
  if 0 < d then
    self.ui.text_time:SetIndex(0, tostring(d), tostring(h))
  elseif 0 < h then
    self.ui.text_time:SetIndex(1, tostring(h), tostring(m))
  elseif 0 < m then
    self.ui.text_time:SetIndex(2, tostring(m))
  else
    self.ui.text_time:SetIndex(2, tostring(1))
  end
end

function UINQuickPurchaseRoomTheme:_OnClickBuy()
  local function buyFunc()
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
    
    if shopCtrl:GetShopIsSouldOut(self.themeItem.shopId) then
      return
    end
    shopCtrl:ReqBuySuitGoods(self.themeItem.shopId, self.shelf2Cnt, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CommonRewardData = require("Game.CommonUI.CommonRewardData")
        local CRData = CommonRewardData.CreateCRDataUseList(self.rewardIds, self.rewardCounts)
        window:AddAndTryShowReward(CRData)
      end)
      self.quickBuyWindow:TryClosePurchaseBox()
    end)
  end
  
  if self.canBuy == false then
    local coinQuickBuyCfg = ShopEnum.eQuickBuy.dormCoin
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not shopCtrl:ShopIsUnlock(coinQuickBuyCfg.shopId) then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
      return
    end
    local ownMoney = PlayerDataCenter:GetItemCount(self.themeItem.currencyId)
    shopCtrl:GetShopData(coinQuickBuyCfg.shopId, function(shopData)
      local exChangeGoodData = shopData.shopGoodsDic[coinQuickBuyCfg.shelfId]
      if exChangeGoodData == nil then
        error("Cant get goodData from normalShop, itemId = " .. self.themeItem.currencyId)
        return
      end
      local needItemNum = math.ceil((self.totalCost - ownMoney) / exChangeGoodData.itemNum)
      local needCurrencyNum = exChangeGoodData.newCurrencyNum * needItemNum
      self.quickBuyWindow:PaidCoinExecute(exChangeGoodData.currencyId, needCurrencyNum, self.themeItem.currencyId, needItemNum * exChangeGoodData.itemNum, function()
        shopCtrl:ReqBuyGoods(exChangeGoodData.shopId, exChangeGoodData.shelfId, needItemNum, function()
          buyFunc()
        end)
      end)
    end)
    return
  end
  buyFunc()
end

function UINQuickPurchaseRoomTheme:ClearQPRoomThemeTimerId()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

function UINQuickPurchaseRoomTheme:OnHide()
  self:ClearQPRoomThemeTimerId()
  base.OnHide(self)
end

function UINQuickPurchaseRoomTheme:OnDelete()
  self.itemPool:DeleteAll()
  self.itemMaskPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UINQuickPurchaseRoomTheme
