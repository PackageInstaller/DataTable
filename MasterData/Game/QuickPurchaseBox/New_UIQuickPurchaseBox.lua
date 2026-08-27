local New_UIQuickPurchaseBox = class("New_UIQuickPurchaseBox", UIBaseWindow)
local base = UIBaseWindow
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINQuickPurchaseLogicPreview = require("Game.QuickPurchaseBox.UINQuickPurchaseLogicPreview")
local UINQuickPurchasePayGift = require("Game.QuickPurchaseBox.UINQuickPurchasePayGift")
local UINQuickPurchaseFixedCountGood = require("Game.QuickPurchaseBox.UINQuickPurchaseFixedCountGood")
local UINQuickPurchaseRoomTheme = require("Game.QuickPurchaseBox.UINQuickPurchaseRoomTheme")
local UINOverflowTransNode = require("Game.QuickPurchaseBox.UINOverflowTransNode")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local ShopUtil = require("Game.Shop.ShopUtil")
local UINGiftItemListPage = require("Game.QuickPurchaseBox.UINGiftItemListPage")
local UINQuickPurchaseOptionItemNode = require("Game.ActivitySaveMoney.UI.UINQuickPurchaseOptionItemNode")
local CoinAllowExchange = {
  [ConstGlobalItem.SkinTicket] = ShopEnum.eQuickBuy.skinTicket,
  [ConstGlobalItem.SkinUpTicket] = ShopEnum.eQuickBuy.skinUpTicket,
  [ConstGlobalItem.ADCUnlockItem] = ShopEnum.eQuickBuy.ADCUnlockItem,
  [ConstGlobalItem.DormCoin] = ShopEnum.eQuickBuy.dormCoin
}
local QuickPurchaseType = {
  normal = 1,
  payGift = 2,
  fixedCountGoods = 3,
  roomTheme = 4,
  giftItemListNode = 5,
  saveMoney = 6
}
local QuickPurchaseNormalNodeType = {normal = 1, overflow = 2}

function New_UIQuickPurchaseBox:OnInit()
  self.oldRoot = self.transform.parent
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  self.buyNum = 0
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.gameResourceGroup)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Back, self, self.SlideOut, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.OnClickMin)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
  UIUtil.AddButtonListener(self.ui.btn_ExtrInfo, self, self.OnClickExtraInfo)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnPressAdd))
  self.ui.btn_Reduce.onPress:AddListener(BindCallback(self, self.OnPressMin))
  self.ui.tween_side.onComplete:AddListener(BindCallback(self, self.OnSlideInComplete))
  self.ui.tween_side.onRewind:AddListener(BindCallback(self, self.Hide))
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.itemWithCount)
  self.itemWithCount:SetNotNeedAnyJump(true)
  self.buildPreviewNode = UINQuickPurchaseLogicPreview.New()
  self.buildPreviewNode:Init(self.ui.obj_logicPreviewNode)
  self.buildPreviewNode:Hide()
  self.overflowTransNode = UINOverflowTransNode.New()
  self.overflowTransNode:Init(self.ui.obj_pageOverflowItem)
  self.overflowTransNode:Hide()
  self.__AddBuyCountCallback = BindCallback(self, self.__AddBuyCount)
  self._isSkinUpgradePurchase = false
end

function New_UIQuickPurchaseBox:SetRoot(transform)
  self.transform:SetParent(transform)
end

function New_UIQuickPurchaseBox:SlideIn(isJumpIn, isHideLeftBtn)
  self.isJumpIn = isJumpIn
  self.__isHideLeftBtn = isHideLeftBtn
  self.ui.tween_side:DOPlayForward()
  AudioManager:PlayAudioById(1070)
  if not self.isJumpIn then
    UIUtil.SetTopStatus(self, self.SlideOut, nil, nil, nil, nil)
    UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
  else
    local backData = UIUtil.PeekBackStack()
    if backData == nil or backData.backAction == nil then
      UIUtil.SetTopStatus(nil, nil, nil, nil, nil, nil)
      UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
    else
      UIUtil.SetTopStatus(self, self.SlideOut, nil, nil, nil, nil)
      UIUtil.SetCurButtonGroupActive(not isHideLeftBtn)
    end
  end
  self.slideInOver = false
  self.isSlideOuting = false
end

function New_UIQuickPurchaseBox:SlideOut(isHome, popBackStack)
  if not self.slideInOver then
    if popBackStack then
      UIUtil.PopFromBackStackByUiTab(self)
    end
    self.ui.tween_side:DOComplete()
    self:Hide()
    return
  elseif self.isSlideOuting then
    return
  end
  self.isSlideOuting = true
  AudioManager:PlayAudioById(1071)
  self.ui.tween_side:DOPlayBackwards()
  if popBackStack then
    if not self.isJumpIn then
      UIUtil.PopFromBackStackByUiTab(self)
      self.isJumpIn = nil
    else
      UIUtil.PopFromBackStackByUiTab(self)
    end
  end
end

function New_UIQuickPurchaseBox:SlideOutImmediately()
  if not self.active then
    return
  end
  self.ui.tween_side:DORewind(false)
  if UIUtil.CheckTopIsWindow(self:GetUIWindowTypeId()) then
    UIUtil.PopFromBackStackByUiTab(self)
  end
end

function New_UIQuickPurchaseBox:InitSkinUpgradePurchase(skinId, callBack)
  self.ui.obj_limit:SetActive(false)
  self.ui.obj_discount:SetActive(false)
  self.ui.btn_ExtrInfo.gameObject:SetActive(false)
  self.BuySuccessCallback = callBack
  self:ShowChildNodeByType(QuickPurchaseType.fixedCountGoods)
  local costId, costNum = PlayerDataCenter.skinData:GetSkinUpgradeCost(skinId)
  local resIdList = {costId}
  if ConstGlobalItem.SkinUpTicket == costId then
    table.insert(resIdList, 1, ConstGlobalItem.PaidItem)
  end
  self:__refreshResGroup(true, resIdList)
  
  local function buyFunc()
    ControllerManager:GetController(ControllerTypeId.Skin, true):ReqSkinUpgrade(skinId, function()
      if callBack then
        callBack()
      end
      self:TryClosePurchaseBox()
    end)
  end
  
  local function preBuyfunc()
    if CoinAllowExchange[costId] ~= nil then
      local ownMoney = PlayerDataCenter:GetItemCount(costId)
      if ownMoney < costNum then
        self:_ConvertCoinAndBuy(costId, costNum, ownMoney, buyFunc)
        return
      end
    end
    buyFunc()
  end
  
  function self._InitPurchaseSkinUpgradeFixedFunc()
    self.quickPurchaseFixedCountGood:InitPurchaseSkinUpgradeFixed(skinId, costId, costNum, preBuyfunc)
  end
  
  self._InitPurchaseSkinUpgradeFixedFunc()
  self._isSkinUpgradePurchase = true
end

function New_UIQuickPurchaseBox:InitBuyRoomTheme(shopGoodsDic, isNeedRes, resIdList)
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  self.shopGoodsDic = shopGoodsDic
  self.themeItem = self.shopGoodsDic[1]
  self:ShowChildNodeByType(QuickPurchaseType.roomTheme)
  self.ui.obj_limit:SetActive(false)
  self.ui.obj_discount:SetActive(false)
  self.quickPurchaseRoomTheme:OnInitPayGift(shopGoodsDic, self.themeItem, self)
  self:__refreshResGroup(isNeedRes, resIdList)
  self.ui.btn_ExtrInfo.gameObject:SetActive(false)
end

function New_UIQuickPurchaseBox:InitBuyPayGift(payGiftInfo)
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  payGiftInfo:CleanSelfSelectInfo()
  self.payGiftInfo = payGiftInfo
  self:ShowChildNodeByType(QuickPurchaseType.payGift)
  self.ui.obj_limit:SetActive(false)
  self.ui.obj_discount:SetActive(false)
  self.quickPurchasePayGift:OnInitPayGift(payGiftInfo, self)
  if payGiftInfo:IsUseItemPay() then
    local redIds = {}
    table.insert(redIds, payGiftInfo.defaultCfg.costId)
    self:__refreshResGroup(true, redIds)
  else
    self:__refreshResGroup(false)
  end
  self.ui.btn_ExtrInfo.gameObject:SetActive(false)
end

function New_UIQuickPurchaseBox:InitGiftItemList(payGiftInfo, callback)
  if self.outDataTiemr ~= nil then
    TimerManager:StopTimer(self.outDataTiemr)
    self.outDataTiemr = nil
  end
  self.payGiftInfo = payGiftInfo
  self:ShowChildNodeByType(QuickPurchaseType.giftItemListNode)
  self.ui.obj_limit:SetActive(false)
  self.ui.obj_discount:SetActive(false)
  self.giftItemListNode:InitGiftItemListPage(payGiftInfo, callback)
  if payGiftInfo:IsUseItemPay() then
    local redIds = {}
    table.insert(redIds, payGiftInfo.defaultCfg.costId)
    self:__refreshResGroup(true, redIds)
  else
    self:__refreshResGroup(false)
  end
  self.ui.btn_ExtrInfo.gameObject:SetActive(false)
  UIUtil.SetTopStatusBtnShow(false, false)
end

function New_UIQuickPurchaseBox:InitQuickPurchaseSaveMoney(optionCfg)
  self.optionCfg = optionCfg
  self:ShowChildNodeByType(QuickPurchaseType.saveMoney)
  self.saveMoneyNode:OnInitOptionItemNode(self.optionCfg, BindCallback(self, self.OnClickBuySaveMoney), self)
  UIUtil.SetTopStatusBtnShow(false, false)
  self.ui.obj_limit:SetActive(false)
  self.ui.obj_discount:SetActive(false)
  self.ui.btn_ExtrInfo.gameObject:SetActive(false)
  self:__refreshResGroup(false)
end

function New_UIQuickPurchaseBox:ShieldPopRewardWindow(flag)
  self.__shieldRewardWindow = flag
end

function New_UIQuickPurchaseBox:InitBuyTarget(goodData, BuySuccessCallback, isNeedRes, resIdList, JumpOtherWinCallback, isOverflow)
  self:ShowChildNodeByType(QuickPurchaseType.normal)
  self.goodData = goodData
  self.BuySuccessCallback = BuySuccessCallback
  self.isNeedRes = isNeedRes
  self.resIdList = resIdList
  self.__hasPopTips = false
  self.JumpOtherWinCallback = JumpOtherWinCallback
  self.ui.obj_pageOverflowItem:SetActive(false)
  self.ui.obj_pageNormalItem:SetActive(false)
  self.__isOverflow = isOverflow
  if self.__isOverflow then
    self.normalNodeType = QuickPurchaseNormalNodeType.overflow
    self.ui.obj_pageOverflowItem:SetActive(true)
    self:m_RefreshOverflowUI(goodData)
  else
    self.normalNodeType = QuickPurchaseNormalNodeType.normal
    self.ui.obj_pageNormalItem:SetActive(true)
    self:m_RefreshGoodUI(goodData)
  end
  self:m_RefreshTotalMoney()
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
end

function New_UIQuickPurchaseBox:__isContainExtrInfo()
  if self.goodData.shopType == ShopEnum.eShopType.Charcter then
    self.ui.btn_ExtrInfo.gameObject:SetActive(true)
  else
    self.ui.btn_ExtrInfo.gameObject:SetActive(false)
  end
  if self.outDataTiemrId ~= nil then
    TimerManager:StopTimer(self.outDataTiemrId)
    self.outDataTiemrId = nil
  end
  self.__outDataTime = nil
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
  local flag, outDataTime = shopCtrl:GetShelfOutDataTime(self.goodData.shopId, self.goodData.shelfId)
  if flag then
    self.__outDataTime = outDataTime
    self.outDataTiemrId = TimerManager:StartTimer(1, self.OnTimerOutData, self)
  end
end

function New_UIQuickPurchaseBox:__refreshResGroup(isNeedRes, resIdList)
  if isNeedRes then
    self.resourceGroup:SetResourceIds(resIdList)
    self.resourceGroup:Show()
  else
    self.resourceGroup:Hide()
  end
  self.transform:SetAsLastSibling()
end

function New_UIQuickPurchaseBox:m_RefreshGoodOriUI(goodData)
  self:__refreshPriceDiscountUIData(goodData)
  self.ui.tex_currPrice.text = goodData.newCurrencyNum
  local currencyItemCfg = ConfigData.item[goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_currencyIcon.sprite = CRH:GetSprite(smallIcon)
  self.ui.img_totalCurrencyIcon.sprite = CRH:GetSprite(smallIcon)
end

function New_UIQuickPurchaseBox:m_RefreshGoodUI(goodData)
  self:__refreshLimitUIData(goodData)
  self:__refreshDiscountTipUI(goodData)
  self:m_RefreshGoodOriUI(goodData)
  self.itemWithCount:InitItemWithCount(goodData.itemCfg, goodData.itemNum, nil)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(goodData.itemCfg.name)
  self.ui.tex_Detail.text = LanguageUtil.GetLocaleText(goodData.itemCfg.describe)
  if goodData.itemCfg.type == eItemType.DormFurniture then
    local fntCfg = ConfigData.dorm_furniture[goodData.itemCfg.id]
    if fntCfg ~= nil then
      self.ui.comfortLv:SetActive(true)
      self.ui.tex_Comfort.text = tostring(fntCfg.comfort)
      self.ui.obj_img_ThemeFurniture:SetActive(fntCfg.is_theme)
      self.ui.obj_img_CheckIn:SetActive(fntCfg.can_binding)
      self.ui.obj_img_OnlyBig:SetActive(fntCfg.only_big)
    end
  else
    self.ui.comfortLv:SetActive(false)
    self.ui.obj_img_ThemeFurniture:SetActive(false)
    self.ui.obj_img_CheckIn:SetActive(false)
    self.ui.obj_img_OnlyBig:SetActive(false)
  end
  self:RefreshItemLeftTime()
end

function New_UIQuickPurchaseBox:m_RefreshOverflowUI(goodData)
  self:m_RefreshGoodOriUI(goodData)
  self.overflowTransNode:InitOverflowTransItemInfo(goodData)
end

function New_UIQuickPurchaseBox:__refreshPriceDiscountUIData(goodData)
  if goodData.discount == 100 then
    self.ui.obj_discount:SetActive(false)
    self.ui.tex_oldPrice.gameObject:SetActive(false)
  else
    self.ui.tex_oldPrice.text = goodData.oldCurrencyNum
    self.ui.tex_oldPrice.gameObject:SetActive(true)
  end
end

function New_UIQuickPurchaseBox:__refreshDiscountTipUI(goodData)
  local shelfCfg = goodData.shelfCfg
  local discountNum = goodData.discount
  if shelfCfg ~= nil and 0 < (shelfCfg.showdiscount or 0) then
    discountNum = shelfCfg.showdiscount
  end
  if discountNum == 100 then
    self.ui.obj_discount:SetActive(false)
    return
  end
  self.ui.obj_discount:SetActive(true)
  self.ui.tex_Discount:SetIndex(0, tostring(100 - discountNum))
end

function New_UIQuickPurchaseBox:__refreshLimitUIData(goodData)
  if goodData.shopType ~= ShopEnum.eShopType.Random and goodData.isLimit and goodData.limitType ~= ShopEnum.eLimitType.None then
    self.ui.tex_LimitType:SetIndex(goodData.limitType - 1)
    if goodData.totallimitTime ~= nil then
      self.ui.tex_LimitCount:SetIndex(0, tostring(goodData.totallimitTime - goodData.purchases), tostring(goodData.totallimitTime))
    else
      self.ui.tex_LimitCount:SetIndex(0, tostring(goodData.limitTime - goodData.purchases), tostring(goodData.limitTime))
    end
    self.ui.obj_limit:SetActive(true)
  else
    self.ui.obj_limit:SetActive(false)
  end
end

function New_UIQuickPurchaseBox:OnClickAdd(isIgnoreTip)
  if self:m_CouldAdd(1, isIgnoreTip) then
    if isIgnoreTip then
      self:__AddBuyCount(1)
    else
      self:__TryAddCountTip(1, self.__AddBuyCountCallback)
    end
  end
end

function New_UIQuickPurchaseBox:OnPressAdd(isIgnoreTip)
  local pressedTime = self.ui.btn_Add:GetPressedTime()
  local changeNum = math.ceil(pressedTime * pressedTime / 5)
  changeNum = math.min(changeNum, 100)
  if self:m_CouldAdd(changeNum, isIgnoreTip) then
    if isIgnoreTip then
      self:__AddBuyCount(changeNum)
    else
      self:__TryAddCountTip(changeNum, self.__AddBuyCountCallback)
    end
  else
    self:Add2Max()
  end
end

function New_UIQuickPurchaseBox:__AddBuyCount(changeNum)
  AudioManager:PlayAudioById(1064)
  self.buyNum = self.buyNum + changeNum
  self:m_RefreshTotalMoney()
end

function New_UIQuickPurchaseBox:OnClickMin()
  if self.buyNum <= 1 then
    if not self.goodData.isLimit and table.contain(ConfigData.game_config.highValueCurrencyList, self.goodData.currencyId) then
      AudioManager:PlayAudioById(1065)
      return
    end
    local maxNum = self:Add2Max(false, true)
    if maxNum == 0 then
      AudioManager:PlayAudioById(1065)
    else
      local changeNum = maxNum - self.buyNum
      if 0 < changeNum then
        self:__TryAddCountTip(changeNum, self.__AddBuyCountCallback)
      end
    end
    return
  end
  AudioManager:PlayAudioById(1065)
  self.buyNum = self.buyNum - 1
  self:m_RefreshTotalMoney()
end

function New_UIQuickPurchaseBox:OnPressMin()
  local pressedTime = self.ui.btn_Reduce:GetPressedTime()
  local changeNum = math.ceil(pressedTime * pressedTime / 5)
  changeNum = math.min(changeNum, 100)
  if self.buyNum - changeNum <= 1 then
    if self.buyNum > 1 then
      AudioManager:PlayAudioById(1065)
    end
    self.buyNum = 1
    self:m_RefreshTotalMoney()
    return
  end
  AudioManager:PlayAudioById(1065)
  self.buyNum = self.buyNum - changeNum
  self:m_RefreshTotalMoney()
end

function New_UIQuickPurchaseBox:m_CouldAdd(count, isIgnoreTip)
  if (count or 0) == 0 then
    count = 1
  end
  if self.goodData.isSoldOut then
    if not isIgnoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_SoldOut))
    end
    return false
  elseif self.goodData.fragMaxBuyNum ~= nil and self.goodData.fragMaxBuyNum < self.buyNum + count then
    if not isIgnoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_BuyNumLimit))
    end
    return false
  end
  local wharehouseMaxNum = self.goodData:GetCouldBuyMaxBuyNum()
  if ConfigData:GetCanByLimitGoodByShopId(self.goodData.shopId) and self.goodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
    wharehouseMaxNum = -1
    if self.goodData.itemCfg.action_type == eItemActionType.HeroCardFrag and self.normalNodeType == QuickPurchaseNormalNodeType.normal then
      local heroData = PlayerDataCenter.heroDic[self.goodData.itemCfg.arg[1]]
      if heroData ~= nil then
        wharehouseMaxNum = heroData:GetMaxNeedFragNum(true)
      end
    end
  end
  if self.goodData.isLimit then
    if self.buyNum + count > self.goodData.limitTime - self.goodData.purchases then
      if not isIgnoreTip then
        if self.goodData.totallimitTime ~= nil and self.buyNum + count <= self.goodData.totallimitTime - self.goodData.purchases then
          cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_PriceChange))
        else
          cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_BuyNumLimit))
        end
      end
      return false
    end
    if 0 <= wharehouseMaxNum and wharehouseMaxNum < self.buyNum + count then
      if not isIgnoreTip then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(336))
      end
      return false
    end
  end
  if 0 <= wharehouseMaxNum and wharehouseMaxNum < self.buyNum + count then
    if not isIgnoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
    end
    return false
  end
  local totalMoney = PlayerDataCenter:GetItemCount(self.goodData.currencyId)
  local enableBuyOne = false
  if self.goodData.currencyId == ConstGlobalItem.PaidSubItem or self.goodData.currencyId == ConstGlobalItem.PaidItem then
    totalMoney = totalMoney + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
    enableBuyOne = 1 >= self.buyNum + count
  elseif CoinAllowExchange[self.goodData.currencyId] ~= nil then
    enableBuyOne = true
  elseif ShopUtil.CheckCurrencyExchange(self.goodData.currencyId) then
    enableBuyOne = true
  end
  local totalNeedMoney = (self.buyNum + count) * self.goodData.newCurrencyNum
  if totalMoney < totalNeedMoney and not enableBuyOne then
    if not isIgnoreTip then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
    end
    return false
  end
  return true
end

function New_UIQuickPurchaseBox:__TryAddCountTip(changeNum, confirmFunc)
  if confirmFunc == nil then
    return
  end
  if self.__hasPopTips then
    confirmFunc(changeNum)
    return
  end
  local itemCfg = self.goodData.itemCfg
  if itemCfg.action_type ~= eItemActionType.HeroCardFrag then
    confirmFunc(changeNum)
    return
  end
  local heroData = PlayerDataCenter.heroDic[self.goodData.itemCfg.arg[1]]
  if heroData == nil or heroData:GetMaxNeedFragNum(true) >= (self.buyNum + changeNum) * self.goodData.itemNum then
    confirmFunc(changeNum)
    return
  end
  if self.normalNodeType == QuickPurchaseNormalNodeType.overflow then
    confirmFunc(changeNum)
    return
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(3010), function()
    self.__hasPopTips = true
    confirmFunc(changeNum)
  end, nil)
end

function New_UIQuickPurchaseBox:Add2Max(maxLimit, getMax)
  local maxNum = 0
  local totalMoney = PlayerDataCenter:GetItemCount(self.goodData.currencyId)
  if self.goodData.currencyId == ConstGlobalItem.PaidSubItem then
    totalMoney = totalMoney + PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
  end
  local totalNeedMoney = (self.buyNum + 1) * self.goodData.newCurrencyNum
  maxNum = math.max(math.floor(totalMoney / self.goodData.newCurrencyNum), 0)
  if self.goodData.currencyId == ConstGlobalItem.PaidSubItem then
    maxNum = math.max(1, maxNum)
  end
  if self.goodData.isLimit then
    if CoinAllowExchange[self.goodData.currencyId] ~= nil then
      maxNum = self.goodData.limitTime - self.goodData.purchases
    else
      maxNum = math.min(self.goodData.limitTime - self.goodData.purchases, maxNum)
    end
  end
  if self.goodData.fragMaxBuyNum ~= nil then
    maxNum = math.min(self.goodData.fragMaxBuyNum, maxNum)
  end
  local wharehouseMaxNum = self.goodData:GetCouldBuyMaxBuyNum()
  if self.goodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
    wharehouseMaxNum = -1
    if self.goodData.itemCfg.action_type == eItemActionType.HeroCardFrag and self.normalNodeType == QuickPurchaseNormalNodeType.normal then
      local heroData = PlayerDataCenter.heroDic[self.goodData.itemCfg.arg[1]]
      if heroData ~= nil then
        wharehouseMaxNum = heroData:GetMaxNeedFragNum(true)
      end
    end
  end
  if 0 <= wharehouseMaxNum then
    maxNum = math.min(maxNum, wharehouseMaxNum)
  end
  if maxLimit then
    maxNum = math.min(maxNum, 99)
  end
  if not getMax then
    self.buyNum = maxNum
    self:m_RefreshTotalMoney()
    return maxNum
  else
    return maxNum
  end
end

function New_UIQuickPurchaseBox:OnClickBuy(buyNum, OnBuyCompleted)
  if self.isSlideOuting then
    return
  end
  if buyNum ~= nil then
    self.buyNum = buyNum
  end
  if self.buyNum <= 0 then
    return
  end
  local containAth = false
  local itemCfg = self.goodData.itemCfg
  if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
    containAth = true
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  local tatalBuyNum = self.buyNum * self.goodData.itemNum
  local freeBuyNum = self.buyNum
  
  local function buyFunc()
    self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop)
    if shopCtrl:GetShelfIsSouldOut(self.goodData.shopId, self.goodData.shelfId) then
      return
    end
    local itemTransDic = {}
    if self.goodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
      local num = PlayerDataCenter:GetItemOverflowNum(self.goodData.itemId, self.buyNum)
      if num ~= 0 then
        itemTransDic[self.goodData.itemId] = num
      end
    end
    local freeItemTransDic = {}
    if self.goodData.shelfCfg ~= nil and self.goodData.shelfCfg.freeItems ~= nil and 0 < #self.goodData.shelfCfg.freeItems then
      for index, id in pairs(self.goodData.shelfCfg.freeItems) do
        local freeItemNum = self.goodData.shelfCfg.freeItemNums[index]
        local itemCfg = ConfigData.item[id]
        if itemCfg.overflow_type == eItemTransType.actMoneyX then
          local num = PlayerDataCenter:GetItemOverflowNum(id, freeItemNum * freeBuyNum)
          if num ~= 0 then
            freeItemTransDic[id] = num
          end
        end
      end
    end
    self.ctrl:ReqBuyGoods(self.goodData.shopId, self.goodData.shelfId, self.buyNum, function(addInfo)
      local _shieldRewardWindow = self.__shieldRewardWindow
      self.__shieldRewardWindow = nil
      if _shieldRewardWindow then
        if self.BuySuccessCallback ~= nil then
          self.BuySuccessCallback()
        end
      else
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local overflowInfo
          local rewardDic = {
            [self.goodData.itemId] = tatalBuyNum
          }
          if addInfo ~= nil then
            overflowInfo = addInfo.purchase_overflowInfo
            if overflowInfo ~= nil then
              for k, v in pairs(rewardDic) do
                if overflowInfo[k] ~= nil then
                  rewardDic[k] = v - overflowInfo[k].itemNum
                end
              end
            end
            local randomPackage = addInfo.purchase_randomPackage or table.emptytable
            for parentItemId, data in pairs(randomPackage) do
              rewardDic[parentItemId] = (rewardDic[parentItemId] or 0) - data.itemNum
              if rewardDic[parentItemId] <= 0 then
                rewardDic[parentItemId] = nil
              end
              local resultDic = data.product
              for itemId, num in pairs(resultDic) do
                rewardDic[itemId] = (rewardDic[itemId] or 0) + num
              end
            end
          end
          local CommonRewardData = require("Game.CommonUI.CommonRewardData")
          local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRItemCustomTransDic(overflowInfo):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRShowOverFunc(self.QuickPurchaseBoxCloseCallback):SetCRItemTransDic(itemTransDic)
          window:AddAndTryShowReward(CRData)
          if self.goodData.shelfCfg ~= nil and self.goodData.shelfCfg.freeItems ~= nil and 0 < #self.goodData.shelfCfg.freeItems then
            for index, num in pairs(self.goodData.shelfCfg.freeItemNums) do
              local curNum = num * freeBuyNum
              self.goodData.shelfCfg.freeItemNums[index] = curNum
            end
            local freeIds = self.goodData.shelfCfg.freeItems
            local freeNums = self.goodData.shelfCfg.freeItemNums
            local FreeCRData = CommonRewardData.CreateCRDataUseList(freeIds, freeNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
            FreeCRData:SetCRItemTransDic(freeItemTransDic)
            window:AddAndTryShowReward(FreeCRData)
          end
          self.buyNum = 0
          if UIManager:GetWindow(self:GetUIWindowTypeId()) ~= nil then
            self:m_RefreshTotalMoney()
            self:m_RefreshGoodUI(self.goodData)
          end
          if self.BuySuccessCallback ~= nil then
            self.BuySuccessCallback()
          end
        end)
      end
      self:TryClosePurchaseBox()
    end)
  end
  
  if self.normalNodeType == QuickPurchaseNormalNodeType.overflow then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(15002), function()
      local totalNeedMoney = self.buyNum * self.goodData.newCurrencyNum
      local ownMoney = PlayerDataCenter:GetItemCount(self.goodData.currencyId)
      if totalNeedMoney <= ownMoney then
        buyFunc()
        return
      end
    end, nil)
    return
  end
  local totalNeedMoney = self.buyNum * self.goodData.newCurrencyNum
  local ownMoney = PlayerDataCenter:GetItemCount(self.goodData.currencyId)
  if totalNeedMoney <= ownMoney then
    buyFunc()
    return
  end
  if self.goodData.currencyId == ConstGlobalItem.PaidSubItem or self.goodData.currencyId == ConstGlobalItem.PaidItem then
    if totalNeedMoney > ownMoney then
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      
      local function beforeJumpCallback(callBack)
        if self.JumpOtherWinCallback ~= nil then
          self.JumpOtherWinCallback()
        end
        if callBack ~= nil then
          callBack()
        end
      end
      
      local directShowShop = shopWin == nil
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      payCtrl:TryConvertPayItem(self.goodData.currencyId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
      return
    end
  elseif CoinAllowExchange[self.goodData.currencyId] ~= nil then
    if totalNeedMoney > ownMoney then
      self:_ConvertCoinAndBuy(self.goodData.currencyId, totalNeedMoney, ownMoney, buyFunc)
      return
    end
  elseif ShopUtil.StartCurrencyExchange(self.goodData.currencyId) ~= nil then
    return
  end
  buyFunc()
end

function New_UIQuickPurchaseBox:SetQuickPurchaseBoxCloseCallback(Callback)
  self.QuickPurchaseBoxCloseCallback = Callback
end

function New_UIQuickPurchaseBox:_ConvertCoinAndBuy(currencyId, totalNeedMoney, ownMoney, buyFunc)
  local coinQuickBuyCfg = CoinAllowExchange[currencyId]
  local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not shopCtrl:ShopIsUnlock(coinQuickBuyCfg.shopId) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
    return
  end
  shopCtrl:GetShopData(coinQuickBuyCfg.shopId, function(shopData)
    local exChangeGoodData = shopData.shopGoodsDic[coinQuickBuyCfg.shelfId]
    if exChangeGoodData == nil then
      error("Cant get goodData from normalShop, itemId = " .. currencyId)
      return
    end
    local needItemNum = math.ceil((totalNeedMoney - ownMoney) / exChangeGoodData.itemNum)
    local needCurrencyNum = exChangeGoodData.newCurrencyNum * needItemNum
    self:PaidCoinExecute(exChangeGoodData.currencyId, needCurrencyNum, currencyId, needItemNum * exChangeGoodData.itemNum, function()
      shopCtrl:ReqBuyGoods(exChangeGoodData.shopId, exChangeGoodData.shelfId, needItemNum, function()
        buyFunc()
      end)
    end)
  end)
end

function New_UIQuickPurchaseBox:OnClickBuySaveMoney()
  if self.isSlideOuting then
    return
  end
  local currencyItemId = self.optionCfg.save_consume_ids[1]
  local currencyItemNum = self.optionCfg.save_consume_nums[1]
  
  local function buyFunc()
    local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
    if saveMoneyController == nil then
      return
    end
    saveMoneyController:ReqBuySaveMoney(self.optionCfg.id, self.optionCfg.save_level)
    self:SlideOut(nil, true)
  end
  
  local totalNeedMoney = currencyItemNum
  local ownMoney = PlayerDataCenter:GetItemCount(currencyItemId)
  if totalNeedMoney <= ownMoney then
    buyFunc()
    return
  end
  if totalNeedMoney > ownMoney then
    local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
    
    local function beforeJumpCallback(callBack)
      if self.JumpOtherWinCallback ~= nil then
        self.JumpOtherWinCallback()
      end
      if callBack ~= nil then
        callBack()
      end
    end
    
    local directShowShop = shopWin == nil
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    payCtrl:TryConvertPayItem(currencyItemId, totalNeedMoney - ownMoney, beforeJumpCallback, nil, buyFunc, directShowShop)
    return
  end
  buyFunc()
end

function New_UIQuickPurchaseBox:PaidCoinExecute(currencyId, currencyNum, coinId, coinNum, executeFunc)
  local containCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
  local currencyCfg = ConfigData.item[currencyId]
  if currencyCfg == nil then
    error("Item Cfg is null,ID:" .. tostring(currencyId))
    return
  end
  local currencyName = LanguageUtil.GetLocaleText(currencyCfg.name)
  local srcIdList = {}
  local srcNumList = {}
  local needPaidItemNum = 0
  needPaidItemNum = currencyNum - containCurrencyNum
  local linkSign = ""
  if LanguageUtil.LanguageInt == eLanguageType.EN_US then
    linkSign = " "
  end
  if currencyId == ConstGlobalItem.PaidSubItem then
    if 0 < needPaidItemNum and (containCurrencyNum == 0 or currencyId == coinId) then
      table.insert(srcIdList, ConstGlobalItem.PaidItem)
      table.insert(srcNumList, needPaidItemNum)
      local itemCfg = ConfigData.item[ConstGlobalItem.PaidItem]
      currencyName = tostring(needPaidItemNum) .. linkSign .. LanguageUtil.GetLocaleText(itemCfg.name)
    elseif 0 < needPaidItemNum and 0 < containCurrencyNum then
      table.insert(srcIdList, ConstGlobalItem.PaidItem)
      table.insert(srcNumList, needPaidItemNum)
      table.insert(srcIdList, ConstGlobalItem.PaidSubItem)
      table.insert(srcNumList, containCurrencyNum)
      local itemCfg = ConfigData.item[ConstGlobalItem.PaidItem]
      currencyName = tostring(needPaidItemNum) .. linkSign .. LanguageUtil.GetLocaleText(itemCfg.name) .. linkSign .. "+" .. linkSign .. tostring(containCurrencyNum) .. linkSign .. currencyName
    else
      table.insert(srcIdList, ConstGlobalItem.PaidSubItem)
      table.insert(srcNumList, currencyNum)
      currencyName = tostring(currencyNum) .. linkSign .. currencyName
    end
  else
    table.insert(srcIdList, currencyId)
    table.insert(srcNumList, currencyNum)
    currencyName = tostring(currencyNum) .. linkSign .. currencyName
  end
  local needItemName = LanguageUtil.GetLocaleText(ConfigData.item[coinId].name)
  local msg = string.format(ConfigData:GetTipContent(322), currencyName, tostring(coinNum), needItemName)
  if Consts.GameChannelType.IsJp() then
    msg = msg .. ConfigData:GetTipContent(334)
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowItemConvert(msg, srcIdList, srcNumList, {coinId}, {coinNum}, function()
    if needPaidItemNum <= 0 then
      executeFunc()
      return
    end
    local canConvert = true
    for i, itemId in ipairs(srcIdList) do
      local itemCount = srcNumList[i]
      if itemCount > PlayerDataCenter:GetItemCount(itemId) then
        canConvert = false
        break
      end
    end
    if canConvert then
      executeFunc()
      return
    end
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.PaidItemNotEnoughTip), function()
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      
      local function beforeJumpCallback(callBack)
        if self.JumpOtherWinCallback ~= nil then
          self.JumpOtherWinCallback()
        end
        if callBack ~= nil then
          callBack()
        end
      end
      
      local directShowShop = shopWin == nil
      if directShowShop then
        JumpManager:DirectShowShop(beforeJumpCallback, nil, ShopEnum.ShopId.recharge)
      else
        JumpManager:Jump(JumpManager.eJumpTarget.DynShop, beforeJumpCallback, nil, {
          ShopEnum.ShopId.recharge
        })
      end
    end, nil)
  end)
end

function New_UIQuickPurchaseBox:OnSlideInComplete()
  self.slideInOver = true
end

function New_UIQuickPurchaseBox:TryClosePurchaseBox()
  if not UIManager:GetWindow(UIWindowTypeID.QuickBuy) then
    return
  end
  if self.isJumpIn then
    self:SlideOut(false, true)
  elseif UIUtil.CheckTopIsWindow(UIWindowTypeID.QuickBuy) then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.QuickBuy, true)
  else
    self:SlideOut(false, true)
  end
end

function New_UIQuickPurchaseBox:OnClickClose()
  if not self.active then
    return
  end
  if self.quickPurchasePayGift ~= nil then
    self.quickPurchasePayGift:Hide()
  end
  self.isSlideOuting = false
  self:SetRoot(self.oldRoot)
  self.__beforeHideBuyNum = self.buyNum
  self.buyNum = 0
  if self.goodData ~= nil then
    self:m_RefreshTotalMoney()
  end
end

function New_UIQuickPurchaseBox:m_RefreshTotalMoney()
  if self.buyNum == 0 then
    self.ui.btn_Buy.gameObject:SetActive(false)
    self.ui.obj_cantBuy:SetActive(true)
  else
    self.ui.btn_Buy.gameObject:SetActive(true)
    self.ui.obj_cantBuy:SetActive(false)
  end
  self.ui.tex_buyCount.text = tostring(self.buyNum)
  local totalMoney = self.buyNum * self.goodData.newCurrencyNum
  self.ui.tex_totalcurrPrice.text = tostring(totalMoney)
end

function New_UIQuickPurchaseBox:OnClickExtraInfo()
  local intervalList, priceList, curIndex = self.goodData:GetPriceInterval()
  self.buildPreviewNode:InitBuyFragPreview(intervalList, priceList, curIndex)
  self.buildPreviewNode:Show()
end

function New_UIQuickPurchaseBox:InitBuyFixedCountGood(fixedCount, goodData, isNeedRes, resIdList, buySuccessCallback)
  self.fixedCount = fixedCount
  self.goodData = goodData
  self.isNeedRes = isNeedRes
  self.resIdList = resIdList
  self.BuySuccessCallback = buySuccessCallback
  self:ShowChildNodeByType(QuickPurchaseType.fixedCountGoods)
  self:__refreshLimitUIData(goodData)
  self:__refreshDiscountTipUI(goodData)
  self:__refreshResGroup(isNeedRes, resIdList)
  self:__isContainExtrInfo()
  self.quickPurchaseFixedCountGood:InitWithDataForFixedCountGood(goodData, BindCallback(self, self.OnClickBuy), BindCallback(self, self.m_CouldAdd))
  self.quickPurchaseFixedCountGood:SetBuyFixedCount(fixedCount)
  self.buyNum = 0
end

function New_UIQuickPurchaseBox:ShowChildNodeByType(purchaseType)
  self.__purchaseType = purchaseType
  self.ui.itemPage:SetActive(purchaseType == QuickPurchaseType.normal)
  self.normalNodeType = QuickPurchaseNormalNodeType.normal
  if self.quickPurchasePayGift ~= nil then
    if purchaseType == QuickPurchaseType.payGift then
      self.quickPurchasePayGift:Show()
    else
      self.quickPurchasePayGift:Hide()
    end
  elseif purchaseType == QuickPurchaseType.payGift then
    self.ui.giftBagPage:SetActive(true)
    self.quickPurchasePayGift = UINQuickPurchasePayGift.New()
    self.quickPurchasePayGift:Init(self.ui.giftBagPage)
  else
    self.ui.giftBagPage:SetActive(false)
  end
  if self.quickPurchaseFixedCountGood ~= nil then
    if purchaseType == QuickPurchaseType.fixedCountGoods then
      self.quickPurchaseFixedCountGood:Show()
    else
      self.quickPurchaseFixedCountGood:Hide()
    end
  elseif purchaseType == QuickPurchaseType.fixedCountGoods then
    self.ui.singleBuyPage:SetActive(true)
    self.quickPurchaseFixedCountGood = UINQuickPurchaseFixedCountGood.New()
    self.quickPurchaseFixedCountGood:Init(self.ui.singleBuyPage)
  else
    self.ui.singleBuyPage:SetActive(false)
  end
  if self.quickPurchaseRoomTheme ~= nil then
    if purchaseType == QuickPurchaseType.roomTheme then
      self.quickPurchaseRoomTheme:Show()
    else
      self.quickPurchaseRoomTheme:Hide()
    end
  elseif purchaseType == QuickPurchaseType.roomTheme then
    self.ui.roomThemePage:SetActive(true)
    self.quickPurchaseRoomTheme = UINQuickPurchaseRoomTheme.New()
    self.quickPurchaseRoomTheme:Init(self.ui.roomThemePage)
  else
    self.ui.roomThemePage:SetActive(false)
  end
  if self.giftItemListNode ~= nil then
    if purchaseType == QuickPurchaseType.giftItemListNode then
      self.giftItemListNode:Show()
    else
      self.giftItemListNode:Hide()
    end
  elseif purchaseType == QuickPurchaseType.giftItemListNode then
    self.ui.giftItemListPage:SetActive(true)
    self.giftItemListNode = UINGiftItemListPage.New()
    self.giftItemListNode:Init(self.ui.giftItemListPage)
  else
    self.ui.giftItemListPage:SetActive(false)
  end
  if self.saveMoneyNode ~= nil then
    if purchaseType == QuickPurchaseType.saveMoney then
      self.saveMoneyNode:Show()
    else
      self.saveMoneyNode:Hide()
    end
  elseif purchaseType == QuickPurchaseType.saveMoney then
    self.ui.optionItemPage:SetActive(true)
    self.saveMoneyNode = UINQuickPurchaseOptionItemNode.New()
    self.saveMoneyNode:Init(self.ui.optionItemPage)
  else
    self.ui.optionItemPage:SetActive(false)
  end
end

function New_UIQuickPurchaseBox:OnTimerOutData()
  self:RefreshItemLeftTime()
  if self.__outDataTime == nil then
    return
  end
  if self.__outDataTime - PlayerDataCenter.timestamp > 0 then
    return
  end
  if self.outDataTiemrId ~= nil then
    TimerManager:StopTimer(self.outDataTiemrId)
    self.outDataTiemrId = nil
    self.__outDataTime = nil
  end
  self:TryClosePurchaseBox()
end

function New_UIQuickPurchaseBox:RefreshItemLeftTime()
  self.ui.obj_fntBuyLimittime:SetActive(false)
  if self.__purchaseType == QuickPurchaseType.normal and self.goodData.itemCfg.type == eItemType.DormFurniture then
    local hasTimeLimit, inTime, startTime, endTime = self.goodData:GetStillTime()
    if not (hasTimeLimit and inTime) or endTime == -1 then
      return
    end
    self.ui.obj_fntBuyLimittime:SetActive(true)
    local remaindTime = endTime - PlayerDataCenter.timestamp
    local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
    if 0 < d then
      self.ui.tex_fntBuyLimittime:SetIndex(0, tostring(d), tostring(h))
    elseif 0 < h then
      self.ui.tex_fntBuyLimittime:SetIndex(1, tostring(h), tostring(m))
    elseif 0 < s then
      m = m + 1
      self.ui.tex_fntBuyLimittime:SetIndex(2, tostring(m))
    end
  end
end

function New_UIQuickPurchaseBox:GenCoverJumpReturnCallback()
  local dataTable = {}
  for key, value in pairs(self) do
    dataTable[key] = value
  end
  self:SlideOut(nil, true)
  return function()
    for key, value in pairs(dataTable) do
      self[key] = value
    end
    if self.__purchaseType == QuickPurchaseType.saveMoney then
      self:SlideIn(nil, true)
      if self.optionCfg == nil then
        self:SlideOut(nil, true)
        return true
      end
      self:InitQuickPurchaseSaveMoney(self.optionCfg)
      return
    end
    self.buyNum = self.__beforeHideBuyNum
    self:SlideIn(nil, self.__isHideLeftBtn)
    if self.__purchaseType == QuickPurchaseType.payGift then
      local flag, startTime, endTime = self.payGiftInfo:IsUnlockTimeCondition()
      if flag and endTime <= PlayerDataCenter.timestamp then
        self:SlideOut(nil, true)
        return true
      end
      self:InitBuyPayGift(self.payGiftInfo)
      return
    end
    if self._isSkinUpgradePurchase and self.__purchaseType == QuickPurchaseType.fixedCountGoods then
      self._InitPurchaseSkinUpgradeFixedFunc()
      return
    end
    local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not ShopController:ShopIsUnlock(self.goodData.shopId) then
      self:SlideOut(nil, true)
      return true
    end
    local notNeedShow = false
    ShopController:GetShopData(self.goodData.shopId, function(shopData)
      if shopData == nil then
        self:SlideOut(nil, true)
        notNeedShow = true
        return
      end
      self.goodData = shopData.shopGoodsDic[self.goodData.shelfId]
      if self.goodData == nil then
        self:SlideOut(nil, true)
        notNeedShow = true
        return
      end
      if self.__purchaseType == QuickPurchaseType.normal then
        local maxNum = self:Add2Max(nil, true)
        if maxNum < self.buyNum then
          if maxNum < 0 then
            maxNum = 0
          end
          self.buyNum = maxNum
        end
        self:InitBuyTarget(self.goodData, self.BuySuccessCallback, self.isNeedRes, self.resIdList, self.JumpOtherWinCallback, self.__isOverflow)
      elseif self.__purchaseType == QuickPurchaseType.fixedCountGoods then
        self:InitBuyFixedCountGood(self.fixedCount, self.goodData, self.isNeedRes, self.resIdList, self.BuySuccessCallback)
      end
    end)
    return notNeedShow
  end
end

function New_UIQuickPurchaseBox:Hide()
  self:OnClickClose()
  base.Hide(self)
end

function New_UIQuickPurchaseBox:OnHide()
  if self.buildPreviewNode.active then
    self.buildPreviewNode:_OnClickClose()
  end
  if self.quickPurchaseRoomTheme ~= nil then
    self.quickPurchaseRoomTheme:ClearQPRoomThemeTimerId()
  end
  if self.outDataTiemrId ~= nil then
    TimerManager:StopTimer(self.outDataTiemrId)
    self.outDataTiemrId = nil
    self.__outDataTime = nil
  end
  base.OnHide(self)
end

function New_UIQuickPurchaseBox:OnDelete()
  self.ui.tween_side:DOKill()
  self.resourceGroup:Delete()
  self.itemWithCount:Delete()
  self.buildPreviewNode:Delete()
  if self.quickPurchaseFixedCountGood ~= nil then
    self.quickPurchaseFixedCountGood:Delete()
    self.quickPurchaseFixedCountGood = nil
  end
  if self.quickPurchasePayGift ~= nil then
    self.quickPurchasePayGift:Delete()
    self.quickPurchasePayGift = nil
  end
  if self.quickPurchaseRoomTheme ~= nil then
    self.quickPurchaseRoomTheme:Delete()
    self.quickPurchaseRoomTheme = nil
  end
  if self.outDataTiemrId ~= nil then
    TimerManager:StopTimer(self.outDataTiemrId)
    self.outDataTiemrId = nil
  end
  if self.saveMoneyNode ~= nil then
    self.saveMoneyNode:Delete()
    self.saveMoneyNode = nil
  end
  base.OnDelete(self)
end

return New_UIQuickPurchaseBox
