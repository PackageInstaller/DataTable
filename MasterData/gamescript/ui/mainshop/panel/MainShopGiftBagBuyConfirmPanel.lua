local MainShopGiftBagBuyConfirmPanel, Super = System.NewClass("MainShopGiftBagBuyConfirmPanel", UIBasePanel)
MainShopGiftBagBuyConfirmPanel.uiResCls = UI_Recharge_Exchange_TipsResource

function MainShopGiftBagBuyConfirmPanel:ctor(shopItemData, shopType, currencyList)
  Super.ctor(self)
  self.shopItemData = shopItemData
  self.shopType = shopType
  self.currencyList = currencyList
end

function MainShopGiftBagBuyConfirmPanel:OnBind(binder)
  self.binder = binder
  local itemTid = self.shopItemData.itemList[1]
  binder:BindToImage(self.ui.Image_Icon, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemTid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local quality = DT.Item[itemTid].Quality
    return DT.ItemQuality[quality].GiftBagBuyQualityRes or ""
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, itemTid
  end)
  binder:BindToText(self.ui.Text_Description, function()
    do return ItemDataUtils.GetItemDesc end
    return ItemDataUtils.GetItemDesc, itemTid
  end)
  binder:BindToImage(self.ui.Image_Currency_Icon, function()
    local tid = self.shopItemData.tid
    local shopItemCfg = DT.Shop[tid]
    local moneyTid = shopItemCfg.Price[1]
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, moneyTid
  end, false)
  binder:BindToRaw(function(_, nVT)
    binder:SetText(self.ui.Text_Price, self.shopItemData.price)
    CS.Framework.UIUtilTool.RefreshLayout(self.ui.Text_Price)
  end, function()
    return {
      ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(self.shopItemData.tid)),
      self.shopItemData.price
    }
  end)
  binder:BindToTextColor(self.ui.Text_Price, function()
    return self:IsCurrencyEnough() and CommonDefine.ColorType.Normal or CommonDefine.ColorType.Dark
  end)
  binder:BindToVisible(self.ui.Image_Not, function()
    return not self:IsCurrencyEnough()
  end)
  binder:BindToVisible(self.ui.Image_Frame, function()
    local buyLimitNum = self:GetBuyLimitNum()
    return nil ~= buyLimitNum and not self:IsLock()
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    if self:IsSellOut() then
      return ""
    end
    local buyLimitNum = self:GetBuyLimitNum()
    if buyLimitNum then
      local shopCfgId = self.shopItemData.tid
      local shopItemCfg = DT.Shop[shopCfgId]
      local left = math.min(self.shopItemData.maxBuyCount, buyLimitNum) - self.shopItemData.buyCount
      if 0 ~= shopItemCfg.PricingModel then
        left = 1
      end
      do return LT.Textf, "Shop_Buy_Str_BuyLimit", (math.max(left, 0)) end
      return LT.Textf, "Shop_Buy_Str_BuyLimit", math.max(left, 0), 0, 0
    else
      return ""
    end
  end)
  binder:BindToRaw(function(_, isLock)
    self.ui.Text_Lock_Desc:SetActive(isLock)
    if isLock then
      local str = MainShopDataUtils.GetLockShopStr(self.shopItemData.tid)
      binder:SetText(self.ui.Text_Lock_Desc, str)
    end
  end, function()
    do return self.IsLock end
    return self.IsLock, self
  end)
  binder:BindToVisible(self.ui.Image_Sellout, function()
    do return self.IsSellOut end
    return self.IsSellOut, self
  end)
  binder:BindToText(self.ui.Text_C_Sellout, function()
    do return LT.Text end
    return LT.Text, "Event_Shop_String_5"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Shop_Confirm_Buy_Btn_Back"
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if self:IsLock() then
      Alert.Show(10711)
      return
    end
    if self:IsSellOut() then
      Alert.Show(10710)
      return
    end
    if not self:IsCurrencyEnough() then
      Alert.Show(10635, nil, function()
        self:Close()
        UIManager.Instance:Reopen(Urls.ChargeMainPanel)
      end)
      return
    end
    local uid = self.shopItemData.uid
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnShopBuyGoods", function(data)
      self:Close()
      MainShopDataUtils.OnUpdateShopGoods(data)
      ShopExtModel.Instance:LocalNotify(NotifyId.OnUpdateShopGoodsList, data.shopType)
    end, nil, uid, self.shopType, 1)
  end, function()
    if self:IsLock() or self:IsSellOut() or not self:IsCurrencyEnough() then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end, function()
    do return LT.Text end
    return LT.Text, "Shop_Buy_Btn"
  end)
  local dropID = DT.Item[itemTid].SpParam[1]
  local dropList = DT.Drop[dropID].data_list
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return dropList
  end, function(itemBinder, obj, index)
    local drop = dropList[index]
    local isDiamond = drop.DropItem == DT.GetConstant("DiamondItemTid")
    local itemData = {
      itemTid = drop.DropItem,
      itemCount = drop.DropNum,
      bgType = isDiamond and CommonDefine.MainShopContentItemDescBgType.Blue or nil,
      desc = isDiamond and LT.Text("ExtraGift") or nil
    }
    itemBinder:BindComponent(MainShopGiftBagContentItem(obj, itemData))
  end)
  binder:BindToVisible(self.ui.UI_Common_Btn_Question, function()
    return false
  end)
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, self.currencyList, true, true))
end

function MainShopGiftBagBuyConfirmPanel:GetBuyLimitNum()
  do return MainShopDataUtils.GetLimitNum end
  return MainShopDataUtils.GetLimitNum, self.shopItemData
end

function MainShopGiftBagBuyConfirmPanel:IsLock()
  do return MainShopDataUtils.GetShopItemLockedReason end
  return MainShopDataUtils.GetShopItemLockedReason, self.shopItemData.tid
end

function MainShopGiftBagBuyConfirmPanel:IsSellOut()
  local data = self.shopItemData
  local BuyLimit = MainShopDataUtils.GetLimitNum(data)
  return BuyLimit and BuyLimit <= data.buyCount or false
end

function MainShopGiftBagBuyConfirmPanel:IsCurrencyEnough()
  local totalCurrency = ItemDataUtils.GetItemNum(MainShopDataUtils.GetShopCurrency(self.shopItemData.tid)) or 0
  return totalCurrency >= self.shopItemData.price
end

function MainShopGiftBagBuyConfirmPanel:Close()
  Super.Close(self)
end

return MainShopGiftBagBuyConfirmPanel
