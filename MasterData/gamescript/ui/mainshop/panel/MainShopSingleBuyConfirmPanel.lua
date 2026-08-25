local typeof = _ENV.typeof
local Slider = CS.UnityEngine.UI.Slider
local MainShopTypeTag = CommonDefine.MainShopTypeTag
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local MainShopSingleBuyConfirmPanel, Super = System.NewClass("MainShopSingleBuyConfirmPanel", UIBasePanel)
MainShopSingleBuyConfirmPanel.uiResCls = UI_Shop_Popup_TipsResource
local MINBUYCOUNT = 1
local MAXBUYCOUNT = 9999999

function MainShopSingleBuyConfirmPanel:ctor(viewData)
  Super.ctor(self)
  self.viewData = viewData
  self.cost = viewData.shopItemData.price
  self.addNum = Vue.ref(MINBUYCOUNT)
  self.remainCount = Vue.ref(0)
  self.maxBuyCount = self:GetMaxBuyCount()
  self.shopUnlockType2FuncMap = {
    [CommonDefine.ShopUnlockType.PlayerLevelCondition] = {
      GetLockAlertStrFunc = System.fn(self, self._GetCommonShowStr)
    },
    [CommonDefine.ShopUnlockType.StageFirstClear] = {
      GetLockAlertStrFunc = System.fn(self, self._GetCommonShowStr)
    },
    [CommonDefine.ShopUnlockType.HaveSpecificItem] = {
      GetLockAlertStrFunc = System.fn(self, self._GetSpecificItemNotEnoughShowStr)
    }
  }
end

function MainShopSingleBuyConfirmPanel:OnBind(binder)
  self.binder = binder
  self:BindVisible()
  self:BindRaw()
  self:BindButton()
  self:BindImage()
  self:BindText()
  self:BindSlider()
  self:BindCurrency()
  self:BindItemComp()
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(MINBUYCOUNT))
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local clipsToPlay = ""
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, "UI_Shop_Popup_Tips_Open"), nil)
end

function MainShopSingleBuyConfirmPanel:BindItemComp()
  local itemTid = tonumber(self.viewData.shopItemData.itemTid)
  local itemData = {
    itemTid = itemTid,
    clickFunc = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, itemTid, true, {posX = -1010})
    end
  }
  self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
end

function MainShopSingleBuyConfirmPanel:IsSellOut()
  local buyCount = self.viewData.shopItemData.buyCount
  local BuyLimit = self:BuyLimitCnt()
  local isSellOut = BuyLimit and buyCount >= BuyLimit or false
  return isSellOut
end

function MainShopSingleBuyConfirmPanel:MatchCondition2Buy()
  local tid = self.viewData.shopItemData.tid
  if not tid then
    return true
  end
  local lock = MainShopDataUtils.GetShopItemLockedReason(tid)
  local sellout = self:IsSellOut()
  local owned = MainShopDataUtils.IsPlayerAvatarOwned(self.viewData.shopItemData)
  return not lock and not sellout and not owned
end

function MainShopSingleBuyConfirmPanel:BindVisible()
  self.binder:BindToVisible(self.ui.Group_No_Money, function()
    do return self.GetGroupNoMoneyVisiable end
    return self.GetGroupNoMoneyVisiable, self
  end)
  self.binder:BindToVisible(self.ui.Group_Buy, function()
    local enoughMoney = self.cost <= ItemDataUtils.GetItemNum(self.viewData.itemId)
    local hasGoods = self:MatchCondition2Buy()
    return enoughMoney and hasGoods and not ShopCfgUtils.IsLimitByMaxPotency(self.viewData)
  end)
  self.binder:BindToVisible(self.ui.UI_Common_Btn_Max, function()
    return true
  end)
  self.binder:BindToVisible(self.ui.Btn_Add, function()
    return 1 ~= self.maxBuyCount
  end)
  self.binder:BindToVisible(self.ui.Btn_Subtract, function()
    return 1 ~= self.maxBuyCount
  end)
  self.binder:BindToVisible(self.ui.Group_Slider, function()
    return 1 ~= self.maxBuyCount
  end)
  self.binder:BindToVisible(self.ui.Image_One_Good, function()
    return 1 == self.maxBuyCount
  end)
  self.binder:BindToVisible(self.ui.Group_SellOut, function()
    if not self.viewData.shopItemData.tid then
      return false
    end
    do return self.GetSellOutGroupVisiable end
    return self.GetSellOutGroupVisiable, self
  end)
  self.binder:BindToVisible(self.ui.Group_NotUnlocked, function()
    if self:GetSellOutGroupVisiable() then
      return false
    end
    do return MainShopDataUtils.GetShopItemLockedReason end
    return MainShopDataUtils.GetShopItemLockedReason, self.viewData.shopItemData.tid
  end)
  
  local function AddValue_Equal_MaxCnt()
    return self.addNum.value == self.maxBuyCount
  end
  
  local function SubValue_Equal_MinCnt()
    return self.addNum.value == MINBUYCOUNT
  end
  
  self.binder:BindToVisible(self.ui.Add_Group_Normal, function()
    return not AddValue_Equal_MaxCnt()
  end)
  self.binder:BindToVisible(self.ui.Add_Group_Unclickable, AddValue_Equal_MaxCnt)
  self.binder:BindToVisible(self.ui.Sub_Group_Normal, function()
    return not SubValue_Equal_MinCnt()
  end)
  self.binder:BindToVisible(self.ui.Sub_Group_Unclickable, SubValue_Equal_MinCnt)
end

function MainShopSingleBuyConfirmPanel:BindImage()
  self.binder:BindToImage(self.ui.Image_Icon, function()
    local cfg = ItemDataUtils.GetItemConfig(tonumber(self.viewData.itemId))
    return cfg.Icon or ""
  end)
end

function MainShopSingleBuyConfirmPanel:BindRaw()
  local binder = self.binder
  binder:BindToRaw(function(_, num)
    self.cost = self.viewData.shopItemData.price * num
    if self.confirmItemComp then
      self.confirmItemComp:UpdateNextCount(num * self.viewData.shopItemData.num)
    end
  end, function()
    return self.addNum.value
  end)
  binder:BindToRaw(function()
    local BuyLimit = self:BuyLimitCnt() or MAXBUYCOUNT
    local left = math.min(self.viewData.maxNum, BuyLimit) - self.viewData.shopItemData.buyCount
    local shopCfgId = self.viewData.shopItemData.tid
    local shopItemCfg = shopCfgId and DT.Shop[shopCfgId] or nil
    if shopItemCfg and 0 ~= shopItemCfg.PricingModel then
      left = 1
    end
    local itemCfg = ItemCfgUtils.GetCfg(self.viewData.shopItemData.itemTid)
    if itemCfg and itemCfg.Type == cd.ItemType.Weapon and itemCfg.Quality == CommonDefine.CommonQuality.Orange then
      left = math.min(left, DT.GetConstant("UnLockExtraSSRWeaponLv") + 1 - ItemDataUtils.GetWeaponAllRefineLevelByTid(self.viewData.shopItemData.itemTid))
    elseif ItemDataUtils.IsAwakerChip(self.viewData.shopItemData.itemTid) then
      left = math.min(left, ItemDataUtils.GetAwakerChipRemainOwnedNum(self.viewData.shopItemData.itemTid))
    end
    self.remainCount.value = math.max(MINBUYCOUNT, left)
    if 1 == self.maxBuyCount then
      self.addNum.value = 1
    end
    self.ui.Slider_Buy:GetComponent(typeof(CS.UnityEngine.UI.Slider)).interactable = 1 ~= self.maxBuyCount
  end, function()
    return self.viewData.shopItemData.buyCount
  end)
  binder:BindToRaw(function(_, lock)
    self.ui.Image_Lock:SetActive(lock)
    local str = self:GetSellOutContent()
    binder:SetText(self.ui.Text_SellOut, str)
  end, function()
    local tid = self.viewData.shopItemData.tid
    do return MainShopDataUtils.GetShopItemLockedReason end
    return MainShopDataUtils.GetShopItemLockedReason, tid
  end)
  binder:SetText(self.ui.Text_NotUnlocked, LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
end

function MainShopSingleBuyConfirmPanel:GetSellOutContent()
  local tid = self.viewData.shopItemData.tid
  if not tid then
    return ""
  end
  local lock = MainShopDataUtils.GetShopItemLockedReason(tid)
  local sellout = self:IsSellOut()
  local owned = MainShopDataUtils.IsPlayerAvatarOwned(self.viewData.shopItemData)
  if lock then
    do return LT.Text end
    return LT.Text, "MainShopSingleBuyConfirmPanel_Lock", nil, nil, nil
  elseif ShopCfgUtils.IsLimitByMaxPotency(self.viewData) then
    local itemTid = self.viewData.shopItemData.itemList[1]
    local isAwakerChip = ItemDataUtils.IsAwakerChip(itemTid)
    local textKey = isAwakerChip and "MaxPotencyAwakerShopTips" or "MaxLevelWeaponShopTips"
    do return LT.Text end
    return LT.Text, textKey
  elseif sellout then
    do return LT.Text end
    return LT.Text, "MainShopSingleBuyConfirmPanel_SellOut", "MaxLevelWeaponShopTips", LT.Text, textKey
  elseif owned then
    do return LT.Text end
    return LT.Text, "Owned", "MaxLevelWeaponShopTips", LT.Text, textKey
  end
  return ""
end

function MainShopSingleBuyConfirmPanel:CreateComfirmAndCancelButton()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self.OnConfirmClick),
    text = LT.Text("Shop_Buy_Btn"),
    stateFunc = function()
      local canBuy = self:MatchCondition2Buy()
      return not (not canBuy or ShopCfgUtils.IsLimitByMaxPotency(self.viewData)) and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    end
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      self:OnBtnCancelClick()
    end,
    text = LT.Text("Event_Shop_BuyBtn_N"),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.M,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = LT.Text("ShopConfirmExchange")
  }
  self.binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_M, commonPopupConfirmTipsData))
end

function MainShopSingleBuyConfirmPanel:BindButton()
  local binder = self.binder
  self:CreateComfirmAndCancelButton()
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindZ1Button(self.ui.Btn_Help, System.fn(self, self.ShowItemTips))
  binder:BindZ1Button(self.ui.Btn_Add, System.fn(self, self.OnAddClick))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Max, System.fn(self, self.OnMaxClick))
  binder:BindZ1Button(self.ui.Btn_Subtract, System.fn(self, self.OnReduceClick))
end

function MainShopSingleBuyConfirmPanel:OnMaxClick()
  local nextNum = self.maxBuyCount
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function MainShopSingleBuyConfirmPanel:OnAddClick()
  local nextNum = math.min(self.maxBuyCount, self.addNum.value + 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function MainShopSingleBuyConfirmPanel:OnReduceClick()
  local nextNum = math.max(MINBUYCOUNT, self.addNum.value - 1)
  self.binder:SetSliderCurValue(self.ui.Slider_Buy, math.floor(nextNum))
  self.addNum.value = nextNum
end

function MainShopSingleBuyConfirmPanel:BindText()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Item_Name, function()
    local cfg = ItemDataUtils.GetItemConfig(tonumber(self.viewData.shopItemData.itemTid))
    return cfg.Name or ""
  end)
  if self:BuyLimitCnt() == nil then
    self.ui.Text_Group_No_Money_Residue:SetActive(false)
    self.ui.Text_Group_Buy_Residue:SetActive(false)
  else
    binder:BindToText(self.ui.Text_Group_No_Money_Residue, function()
      do return LT.Textf, "Shop_Buy_Str_BuyLimit" end
      return LT.Textf, "Shop_Buy_Str_BuyLimit", self.remainCount.value
    end)
    binder:BindToText(self.ui.Text_Group_Buy_Residue, function()
      do return LT.Textf, "Shop_Buy_Str_BuyLimit" end
      return LT.Textf, "Shop_Buy_Str_BuyLimit", self.remainCount.value
    end)
  end
  local showOwnTxtTypeGroup = DT.GetOriginalConstant("ItemTipsNum")
  local cfg = ItemDataUtils.GetItemConfig(tonumber(self.viewData.shopItemData.itemTid))
  if not MainShopDataUtils.IsAwaker(self.viewData.shopItemData.itemTid) and table.contains(showOwnTxtTypeGroup, cfg.Type) then
    self.ui.Text_Have:SetActive(true)
    self.ui.Image_Have:SetActive(true)
    binder:SetText(self.ui.Text_Have, LT.Textf("Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.viewData.shopItemData.itemTid)))
  else
    self.ui.Text_Have:SetActive(false)
    self.ui.Image_Have:SetActive(false)
  end
  binder:BindToText(self.ui.Text_Describe, function()
    return cfg.Desc or ""
  end)
  binder:BindToText(self.ui.Text_Group_No_Money_Title, function()
    do return LT.Text end
    return LT.Text, "ShopExchangeQuantity"
  end)
  binder:BindToText(self.ui.Text_Group_Buy_Title, function()
    do return LT.Text end
    return LT.Text, "ShopExchangeQuantity"
  end)
  binder:BindToText(self.ui.Text_Min, function()
    do return LT.Text end
    return LT.Text, MINBUYCOUNT
  end)
  binder:BindToText(self.ui.Text_Max, function()
    do return LT.Text end
    return LT.Text, self.maxBuyCount
  end)
  binder:BindToText(self.ui.Text_Item_Num, function()
    if 1 == self.viewData.shopItemData.num then
      return ""
    else
      do return LT.Text, ItemNumUtils.GetStr(self.viewData.shopItemData.num) end
      return LT.Text, ItemNumUtils.GetStr(self.viewData.shopItemData.num)
    end
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    do return LT.Text end
    return LT.Text, self.addNum.value
  end)
  binder:BindToText(self.ui.Text_Price, function()
    local cnt = self.addNum.value > 0 and self.addNum.value or 1
    do return LT.Text end
    return LT.Text, self.viewData.shopItemData.price * cnt
  end)
  binder:BindToTextColor(self.ui.Text_Price, function()
    local ret = CommonDefine.ColorType.Light
    local cnt = self.addNum.value > 0 and self.addNum.value or 1
    if self.viewData.shopItemData.price * cnt > ItemDataUtils.GetItemNum(self.viewData.itemId) then
      ret = CommonDefine.ColorType.Dark
    end
    return ret
  end)
  StrUtils.SetPreferredHeight(self.ui.Text_Describe)
end

function MainShopSingleBuyConfirmPanel:BindSlider()
  self.binder:BindToSliderValueChange(self.ui.Slider_Buy, function()
    self.addNum.value = math.floor(self.ui.Slider_Buy:GetComponent(typeof(Slider)).value)
  end)
  self.binder:BindToSliderMaxValue(self.ui.Slider_Buy, function()
    return self.maxBuyCount
  end)
  self.binder:BindToSliderMinValue(self.ui.Slider_Buy, function()
    if 1 == self.maxBuyCount then
      return MINBUYCOUNT - 1
    end
    return MINBUYCOUNT
  end)
end

function MainShopSingleBuyConfirmPanel:_TryInterceptLocked()
  local unlockType = MainShopDataUtils.GetShopItemLockedReason(self.viewData.shopItemData.tid)
  local unlockFunc = self.shopUnlockType2FuncMap[unlockType]
  if unlockFunc and unlockFunc.GetLockAlertStrFunc then
    Alert.ShowStr(unlockFunc.GetLockAlertStrFunc())
    self:Close()
    return true
  end
  return false
end

function MainShopSingleBuyConfirmPanel:_DoConfirmBuy(isJumpCheckWeaponLv)
  local costItemId = self.viewData.itemId
  local shopType = self.viewData.shopType
  local uid = self.viewData.shopItemData.uid
  if self:_TryInterceptLocked() then
    return
  end
  local isSellOut = MainShopDataUtils.IsShopSellOut(self.viewData.shopItemData)
  local isMoneyEnough = self.viewData.shopItemData.price <= ItemDataUtils.GetItemNum(costItemId)
  if ShopCfgUtils.IsLimitByMaxPotency(self.viewData) then
    local itemTid = self.viewData.shopItemData.itemList[1]
    local isAwakerChip = ItemDataUtils.IsAwakerChip(itemTid)
    local textKey = isAwakerChip and "MaxPotencyAwakerShopTips" or "MaxLevelWeaponShopTips"
    Alert.ShowStr(LT.Text(textKey))
    self:Close()
    return
  end
  if isSellOut then
    Alert.Show(10710)
    self:Close()
    return
  end
  if MainShopDataUtils.IsPlayerAvatarOwned(self.viewData.shopItemData) then
    Alert.ShowStr(LT.Text("Owned"))
    self:Close()
    return
  end
  if not isMoneyEnough then
    if shopType == MainShopDataUtils.GetShopTypeIDByTag(MainShopTypeTag.DiamondShop) then
      DiamondShopDataUtils.RechargeTips(self.viewData.shopItemData.price - ItemDataUtils.GetItemNum(self.viewData.itemId))
    else
      Alert.ShowStr(LT.Textf(DT.TipsType[10709].Desc, ItemDataUtils.GetItemName(costItemId)))
    end
    self:Close()
    return
  end
  
  local function CheckEnergyOver()
    local buyItemid = self.viewData.shopItemData.itemTid
    local energyItemId = DT.GetConstant("EnergyItemTid")
    if buyItemid == energyItemId then
      local energyItemNum = PlayerDataUtils.GetEnergyRestoreNum(DataCenter.playerData.DRole.level)
      if energyItemNum > 0 then
        do return GetEnergyCheckUtils.EnergyIsOverMax end
        return GetEnergyCheckUtils.EnergyIsOverMax, energyItemNum
      else
        return false
      end
    else
      return false
    end
  end
  
  local function ConfirmBuy()
    MainShopDataUtils.ReqOnShopBuyGoods(uid, shopType, self.addNum.value, function(data)
      MainShopDataUtils.OnUpdateShopGoods(data)
    end)
    self:Close()
  end
  
  if CheckEnergyOver() then
    GetEnergyCheckUtils.TipsShow(ConfirmBuy)
  else
    ConfirmBuy()
  end
end

function MainShopSingleBuyConfirmPanel:OnConfirmClick(isJumpCheckWeaponLv)
  if self.viewData.customConfirmClick then
    self.viewData.customConfirmClick(self.addNum.value)
    self:Close()
    return
  end
  local buyTid = self.viewData.shopItemData.itemTid
  if ItemDataUtils.GetItemType(buyTid) == cd.ItemType.Weapon and not isJumpCheckWeaponLv then
    local buyCount = self.addNum.value
    local ownedWeaponItem = ItemDataUtils.GetItemByTid(buyTid)
    local curLevel = ownedWeaponItem and ownedWeaponItem.level + 1 or 0
    local maxLevel = cd.MaxWeaponLevel + 1
    if curLevel < maxLevel and maxLevel < curLevel + buyCount then
      local maxNum = maxLevel - curLevel
      Alert.ShowWithParams(20241, {
        maxNum,
        ItemDataUtils.GetName(buyTid)
      }, nil, function()
        local jumpCheck = true
        self:OnConfirmClick(jumpCheck)
      end)
      return
    end
  end
  if self:_TryInterceptLocked() then
    return
  end
  local costItemId = self.viewData.itemId
  local buyCount = self.addNum.value
  local perShareNum = self.viewData.shopItemData.num or 1
  ShopController.Instance:CheckBulkBuyConfirm({
    costItemId = costItemId,
    totalCost = self.cost,
    gainItemTid = self.viewData.shopItemData.itemTid,
    gainNum = buyCount * perShareNum
  }, function()
    self:_DoConfirmBuy(isJumpCheckWeaponLv)
  end)
end

function MainShopSingleBuyConfirmPanel:OnBtnCancelClick()
  self:Close()
end

function MainShopSingleBuyConfirmPanel:ShowItemTips()
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Help, nil, self.viewData.shopItemData.itemTid)
end

function MainShopSingleBuyConfirmPanel:GetMaxBuyCount()
  local price = self.viewData.shopItemData.price
  local BuyLimit = self:BuyLimitCnt()
  local shopCfgId = self.viewData.shopItemData.tid
  local shopItemCfg = shopCfgId and DT.Shop[shopCfgId] or nil
  if shopItemCfg and 0 ~= shopItemCfg.PricingModel then
    return MINBUYCOUNT
  end
  local buyMaxNum = MAXBUYCOUNT
  if nil ~= BuyLimit then
    buyMaxNum = math.min(self.viewData.maxNum, BuyLimit) - self.viewData.shopItemData.buyCount
  end
  buyMaxNum = nil == BuyLimit and 0 == price and buyMaxNum < 0 and 1 or buyMaxNum
  if 0 == price then
    return buyMaxNum
  end
  local itemTid = self.viewData.shopItemData.itemTid
  local isAwakerChip = ItemDataUtils.IsAwakerChip(itemTid)
  if isAwakerChip then
    local canBuyChipNum = MainShopDataUtils.GetCanBuyChipNum(itemTid)
    buyMaxNum = buyMaxNum > canBuyChipNum and canBuyChipNum or buyMaxNum
  end
  local itemCfg = ItemCfgUtils.GetCfg(itemTid)
  if itemCfg and itemCfg.Type == cd.ItemType.Weapon and itemCfg.Quality == CommonDefine.CommonQuality.Orange then
    local allRefineLevel = ItemDataUtils.GetWeaponAllRefineLevelByTid(itemTid)
    buyMaxNum = math.min(buyMaxNum, DT.GetConstant("UnLockExtraSSRWeaponLv") + 1 - allRefineLevel)
  end
  local haveMoney = ItemDataUtils.GetItemNum(self.viewData.itemId)
  do return math.min, (math.floor(haveMoney / price)) end
  return math.min, math.floor(haveMoney / price), buyMaxNum, "UnLockExtraSSRWeaponLv"
end

function MainShopSingleBuyConfirmPanel:BindCurrency()
  local currencyList = self.viewData.currencyList
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, currencyList, true, true))
end

function MainShopSingleBuyConfirmPanel:_GetCommonShowStr()
  local tipCfg = DT.TipsType[10711]
  do return LT.Text end
  return LT.Text, tipCfg.Desc
end

function MainShopSingleBuyConfirmPanel:_GetSpecificItemNotEnoughShowStr()
  local shopCfgId = self.viewData.shopItemData.tid
  local shopItemCfg = shopCfgId and DT.Shop[shopCfgId] or {}
  do return MainShopDataUtils.GetHaveSpecificItemLockStr end
  return MainShopDataUtils.GetHaveSpecificItemLockStr, shopItemCfg
end

function MainShopSingleBuyConfirmPanel:BuyLimitCnt()
  local shopCfgId = self.viewData.shopItemData.tid
  if not shopCfgId then
    return
  end
  local BuyLimit = MainShopDataUtils.GetLimitNum(self.viewData.shopItemData)
  return BuyLimit
end

function MainShopSingleBuyConfirmPanel:GetSellOutGroupVisiable()
  if self:IsSellOut() then
    return true
  end
  if MainShopDataUtils.IsPlayerAvatarOwned(self.viewData.shopItemData) then
    return true
  end
  return ShopCfgUtils.IsLimitByMaxPotency(self.viewData) and not self:GetGroupNoMoneyVisiable()
end

function MainShopSingleBuyConfirmPanel:GetGroupNoMoneyVisiable()
  local noMoney = self.cost > ItemDataUtils.GetItemNum(self.viewData.itemId)
  local hasGoods = self:MatchCondition2Buy()
  return noMoney and hasGoods
end

return MainShopSingleBuyConfirmPanel
