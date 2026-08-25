local MainShopView, Super = NewClass("MainShopView", ShopViewBase)
MainShopView.uiResCls = UI_Recharge_Panel_Main_OptimizedResource
local MainShopTypeTag = CommonDefine.MainShopTypeTag

function MainShopView:ctor(targetShopTypeTid)
  Super.ctor(self, targetShopTypeTid)
  self.monthCardData = nil
  self.updatedBpUIRes = false
  ShopController.Instance:ReqMonthCardInfo(CommonDefine.MonthCardType.Diamond)
end

function MainShopView:OnBuildView()
  Super.OnBuildView(self)
end

function MainShopView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Flushed, System.fn(self, self._OnClickRefresh))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Type1, System.fn(self, self._OnClickRefreshTipsBtn))
  self:AddButtonClickListener(self.ui.Button_Question, System.fn(self, self._OnClickMonthCardTips))
  self:AddButtonClickListener(self.ui.Btn_Buy_Moon_Card, System.fn(self, self._OnClickPurchaseMonthCard))
  self:AddButtonClickListener(self.ui.Btn_To, System.fn(self, self._OnClickBattlePassJumper))
end

function MainShopView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterLocalNotify(NotifyId.OnUpdateMonthCardData, System.fn(self, self._OnMonthCardDataChanged))
  self:RegisterNotify(NotifyId.OnBattlePassDataChanged, System.fn(self, self._RefreshBattlePassUI))
end

function MainShopView:OnEnterView()
  Super.OnEnterView(self)
  self:SetButtonState(self.ui.Btn_Buy_Moon_Card, CommonDefine.BtnType.Normal)
  self:SetButtonText(self.ui.Btn_Buy_Moon_Card, LT.Text("Shop_Buy_Btn"))
end

function MainShopView:_OnSelectShopTypeChanged(shopTypeTid)
  Super._OnSelectShopTypeChanged(self, shopTypeTid)
end

function MainShopView:_GetShopTypeList(reCalcList)
  do return ShopExtModel.Instance.GetMainShopTypeList, ShopExtModel.Instance end
  return ShopExtModel.Instance.GetMainShopTypeList, ShopExtModel.Instance, reCalcList
end

function MainShopView:_RefreshCountdownUI()
  local shopTypeTag = self.curShopTypeTag
  local isGoldShop = shopTypeTag == MainShopTypeTag.GoldShop
  if isGoldShop then
    local shopData = MainShopDataUtils.GetShopData(self.curShopTypeTid)
    local goldShopRefreshPrice = ShopExtModel.Instance:GetGoodsRefreshPrice(self.curShopTypeTid)
    local ownedNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.JuniorMoney)
    local colorType = CommonDefine.ColorType.Light
    local buttonState = CommonDefine.BtnType.High
    if goldShopRefreshPrice > ownedNum then
      colorType = CommonDefine.ColorType.Dark
      buttonState = CommonDefine.BtnType.Unclickable
    end
    self.ui.Image_Flushed:SetActive(isGoldShop)
    self.ui.Group_Cost:SetActive(isGoldShop and 0 ~= goldShopRefreshPrice)
    self.ui.UI_Common_Btn_Type1:SetActive(isGoldShop)
    self.ui.Btn_Flushed:SetActive(isGoldShop)
    self:SetText(self.ui.Text_Cost_Num, goldShopRefreshPrice)
    self:SetImage(self.ui.Image_GoldShop_Refresh, ItemDataUtils.GetIcon(CommonDefine.CurrencyType.JuniorMoney))
    self:SetTextColorType(self.ui.Text_Cost_Num, colorType)
    self:SetButtonState(self.ui.Btn_Flushed, buttonState)
    local nextRefreshTs = shopData.nextRefreshTs or 0
    self:_BindRefreshTimer(nextRefreshTs)
  else
    Super._RefreshCountdownUI(self)
  end
end

function MainShopView:_OnClickRefresh()
  local shopTypeTag = self.curShopTypeTag
  local isGoldShop = shopTypeTag == MainShopTypeTag.GoldShop
  if not isGoldShop then
    return
  end
  local refreshTimes = MainShopDataUtils.GetGoldShopRefreshRemainTimes()
  if refreshTimes <= 0 then
    Alert.ShowStr(LT.Text("GoldShopRefreshTimesOutTips"))
    return
  end
  local ownedNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.JuniorMoney)
  local goldShopRefreshPrice = ShopExtModel.Instance:GetGoodsRefreshPrice(self.curShopTypeTid)
  if ownedNum < goldShopRefreshPrice then
    Alert.ShowStr(LT.Text("Shop_Confirm_Revert_Str_Lack_Money_Tips"))
    return
  end
  local tipId = 20089
  local title = DT.TipsType[tipId].Title
  local desc = LT.Textf(DT.TipsType[tipId].Desc, goldShopRefreshPrice, refreshTimes)
  Alert.SetMaskClickClose(true)
  Alert.Show(tipId, nil, function()
    MainShopDataUtils.ReqShopRefresh(self.curShopTypeTid)
  end, title, desc)
end

function MainShopView:_OnClickRefreshTipsBtn()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("Task_GoldShop_Rules"))
end

function MainShopView:_OnMonthCardDataChanged(monthCardType)
  if monthCardType == CommonDefine.MonthCardType.Diamond then
    self.monthCardData = ShopExtModel.Instance:GetMonthCardData(monthCardType)
    self.monthCardData.itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
    if self.curShopTypeTag ~= CommonDefine.MainShopTypeTag.MoonCard then
      return
    end
    self:_RefreshMonthCardUI()
    return
  end
  if not self.giftBagGoodsList then
    return
  end
  local hasMonthCardGoods = false
  for _, goodsData in ipairs(self.giftBagGoodsList) do
    if goodsData and goodsData.isMonthCardGoods then
      hasMonthCardGoods = true
      break
    end
  end
  if hasMonthCardGoods then
    self:_RefreshGiftBagTableView(true)
  end
end

function MainShopView:_RefreshMonthCardUI()
  local isMonthCardDataValid = self:_IsMonthCardDataValid()
  self.ui.Group_Card:SetActive(isMonthCardDataValid)
  if not isMonthCardDataValid then
    return
  end
  self.ui.Group_Effecting:SetActive(self.monthCardData.state == CommonDefine.MonthCardState.InEffect)
  self.ui.Text_C_Today:SetActive(self.monthCardData.rewardsReceivedState == CommonDefine.RewardState.Received)
  local itemInfo = self.monthCardData.itemInfo
  local itemCfg_1 = ItemDataUtils.GetItemConfig(itemInfo.buyItem.tid)
  local itemCount_1 = itemInfo.buyItem.count
  local itemCfg_2 = ItemDataUtils.GetItemConfig(itemInfo.dailyItem.tid)
  local itemCount_2 = itemInfo.dailyItem.count
  self:SetText(self.ui.Text_Get1_Name, ItemNumUtils.GetNameStr(itemCfg_1.Name))
  self:SetText(self.ui.Text_Get1_Num, ItemNumUtils.GetStr(itemCount_1))
  self:SetImage(self.ui.Image_Get1_Icon, itemCfg_1.Icon)
  self:SetText(self.ui.Text_Get2_Name, ItemNumUtils.GetNameStr(itemCfg_2.Name))
  self:SetText(self.ui.Text_Get2_Num, ItemNumUtils.GetStr(itemCount_2))
  self:SetImage(self.ui.Image_Get2_Icon, itemCfg_2.Icon)
  local priceCfg = DT.Constant.MonthlyCardPrice.Data
  local currencyCfg = ItemDataUtils.GetItemConfig(priceCfg[1])
  self:SetImage(self.ui.Image_Awaker_Icon_2, currencyCfg.Icon)
  local price = priceCfg[2]
  self:SetText(self.ui.Text_Awaker_Ten, ItemNumUtils.GetStr(price))
end

function MainShopView:_BindMonthCardExpiredTimer()
  if not self:_IsMonthCardDataValid() then
    return
  end
  local expiredTime = self.monthCardData.expiredTimestamp
  self:_MonthCardExpiredTimerFixUpdate(expiredTime)
  self:ClearTimer()
  if expiredTime <= 0 then
    return
  end
  self.monthCardTimer = self:BindTimer(1, -1, System.bind(self._MonthCardExpiredTimerFixUpdate, self, expiredTime))
end

function MainShopView:_MonthCardExpiredTimerFixUpdate(expiredTime)
  local remainingDays = 0
  local countdown = expiredTime - TimeUtils.GetServerTime()
  if countdown > 0 then
    remainingDays = TimeUtils.SecsToDays(countdown)
  else
    self:ClearTimer()
  end
  local code = DT.ColorConfig.MonthCard.Light
  local str = string.format("<color=%s>%s</color>", code, remainingDays)
  self:SetText(self.ui.Text_Effecting, LT.Textf("MonthCardLeftDaysText", str))
end

function MainShopView:ClearTimer()
  if self.monthCardTimer then
    self:StopTimer(self.monthCardTimer)
    self.monthCardTimer = nil
  end
end

function MainShopView:_OpenMonthCard()
  self.uiAnimationController:StopPlayableGraph()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_Card_Open")
end

function MainShopView:_OnClickPurchaseMonthCard()
  if not self:_IsMonthCardDataValid() then
    return
  end
  local remainingDays = 0
  local expiredTimestamp = self.monthCardData.expireTime
  local remainingSecs = expiredTimestamp - TimeUtils.GetServerTime()
  if remainingSecs > 0 then
    remainingDays = TimeUtils.SecsToDays(remainingSecs)
  end
  local daysLimit = DT.GetConstant("MonthlyCardBuyLimit")
  if remainingDays >= daysLimit then
    local tipCfg = DT.TipsType[10634]
    local desc = LT.Textf(tipCfg.Desc, daysLimit)
    Alert.Show(10634, nil, nil, nil, desc)
    return
  end
  local priceCfg = DT.Constant.MonthlyCardPrice.Data
  local totalCurrency = ItemDataUtils.GetItemNum(priceCfg[1])
  if totalCurrency < priceCfg[2] then
    Alert.SetMaskClickClose(true)
    Alert.Show(10635, nil, function()
      UIManager.Instance:Reopen(Urls.ChargeMainPanel)
    end)
    return
  end
  local costNum = DT.Constant.MonthlyCardPrice.Data[2]
  Alert.ShowPayMoneyBuyConfirm(costNum, function()
    ShopController.Instance:ReqPurchaseMonthCard(CommonDefine.MonthCardType.Diamond, function()
      local itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
      local buyItemTid = itemInfo.buyItem.tid
      local buyItemCount = itemInfo.buyItem.count
      ItemDataUtils.ShowItemGain({
        {tid = buyItemTid, changedNum = buyItemCount}
      }, System.fn(self, self._ShowMonthCardReceiveRewardsPanel))
    end, CommonDefine.MonthCardType.Diamond)
  end)
end

function MainShopView:_ShowMonthCardReceiveRewardsPanel()
  ShopController.Instance:ReqMonthCardInfo(CommonDefine.MonthCardType.Diamond, function()
    if self.monthCardData.rewardState ~= CommonDefine.RewardState.Available then
      return
    end
    UIManager.Instance:Reopen(Urls.MainShopMonthCardRewardPanel, self.monthCardData.expireTime, function()
      MainShopDataUtils.ReceiveRewards(function()
        local itemInfo = MainShopDataUtils.GetMonthCardItemInfo()
        local dailyItemTid = itemInfo.dailyItem.tid
        local dailyItemCount = itemInfo.dailyItem.count
        ItemDataUtils.ShowItemGain({
          {tid = dailyItemTid, changedNum = dailyItemCount}
        })
      end)
    end)
  end)
end

function MainShopView:_OnClickMonthCardTips()
  local title = LT.Text("RuleTipsTitle")
  local content = LT.Text("MonthCardRuleText")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

function MainShopView:_IsMonthCardDataValid()
  return self.monthCardData ~= nil
end

function MainShopView:_OpenBattlePassReview()
  self.uiAnimationController:StopPlayableGraph()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_Instructions_Open")
end

function MainShopView:_RefreshBattlePassUI()
  if self.curShopTypeTag ~= MainShopTypeTag.BattlePassReview then
    return
  end
  local countdownText = self:_GetBattlePassCountdownText()
  self:SetText(self.ui.Text_Battle_Pass_Time, countdownText)
  if not self.updatedBpUIRes then
    self.binder:UpdateLocalizedTextAndResouce(self.ui.UI_Recharge_Instructions)
    self.updatedBpUIRes = true
  end
end

function MainShopView:_GetBattlePassCountdownText()
  local endCountDown = BattlePassDataUtils.GetEndCountDown()
  if endCountDown then
    do return LT.Text end
    return LT.Text, endCountDown
  end
  do return LT.Text end
  return LT.Text, ""
end

function MainShopView:_OnClickBattlePassJumper()
  local startCountDown = BattlePassDataUtils.GetStartCountDown()
  if startCountDown then
    Alert.ShowStr(LT.Text(startCountDown))
  else
    BattlePassDataUtils.OpenBattlePassPanel()
  end
end

function MainShopView:_OpenGiftBag()
  self.uiAnimationController:StopPlayableGraph()
  self.uiAnimationController:PlayState("UI_Recharge_Panel_Main_GiftBag_Open")
end

function MainShopView:_RefreshGiftBagUI(reloadData)
  if not self.giftBagTableView then
    self:_CreateGiftBagTableView()
  end
  reloadData = reloadData or self.giftBagGoodsList == nil
  self:_RefreshGiftBagTableView(reloadData)
end

function MainShopView:_CreateGiftBagTableView()
  self.giftBagTableView = self:CreateTableview(self.ui.ScrollView_GiftBag, function()
    if not self.giftBagGoodsList then
      return 0
    end
    return #self.giftBagGoodsList
  end, function(view, index)
    do return self._GiftBagCellAtIndex, self, view end
    return self._GiftBagCellAtIndex, self, view, index
  end)
end

function MainShopView:_GiftBagCellAtIndex(view, index)
  local goods = self.giftBagGoodsList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Recharge_Courtesy_Item)
  local giftBagListItemCls = ShopGiftBagListItem
  if goods.isMonthCardGoods then
    giftBagListItemCls = ShopGiftBagMonthCardListItem
  end
  self:AddViewComponentOnce(cell.gameObject, giftBagListItemCls, goods)
  return cell
end

function MainShopView:_RefreshGiftBagTableView(reloadDataList)
  if reloadDataList then
    self.giftBagGoodsList = self:_GetGiftBagGoodsList(self.curShopTypeTid, true)
  end
  if self.giftBagTableView then
    self.giftBagTableView:ReloadData()
  end
end

function ShopViewBase:_GetGiftBagGoodsList(shopTypeTid, needCalc)
  do return ShopExtModel.Instance.GetGoodsList, ShopExtModel.Instance, shopTypeTid end
  return ShopExtModel.Instance.GetGoodsList, ShopExtModel.Instance, shopTypeTid, needCalc
end

return MainShopView
