local MainShopEnergyMonthCardItem, Super = System.NewComponent("MainShopEnergyMonthCardItem")

function MainShopEnergyMonthCardItem:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Recharge_Courtesy_ItemResource(uiNode)
  self.itemTid = DT.GetConstant("EnergyMonthlyCardDropItemId")
  self.itemCfg = DT.Item[self.itemTid]
  self.costItemTid = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[1]
  self.price = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[2]
end

function MainShopEnergyMonthCardItem:OnBind(binder)
  self.binder = binder
  self.binder:SetActive(self.ui.Group_CoinNormal, false)
  binder:BindToVisible(self.ui.Image_Mask_Lock, function()
    return false
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.itemCfg.Icon
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local quality = self.itemCfg.Quality
    return DT.ItemQuality[quality].GiftBagQualityRes or ""
  end)
  binder:BindToText(self.ui.Text_Countdown_1, function()
    local endTs = MainShopDataUtils.GetEnergyMonthCardTs()
    do return LT.Textf, "EnergyMonthCardCountDownDesc", MainShopDataUtils.GetMonthCardRemainDays(endTs) end
    return LT.Textf, "EnergyMonthCardCountDownDesc", MainShopDataUtils.GetMonthCardRemainDays(endTs)
  end)
  binder:BindToVisible(self.ui.Image_Countdown_1, function()
    local state = MainShopDataUtils.GetEnergyMonthCardState()
    return state == CommonDefine.MonthCardState.InEffect
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return LT.Text end
    return LT.Text, self.itemCfg.Name
  end)
  binder:BindToText(self.ui.Text_Price, function()
    do return LT.Text end
    return LT.Text, self.price
  end)
  binder:BindToTextColor(self.ui.Text_Price, function()
    local totalCurrency = ItemDataUtils.GetItemNum(self.costItemTid) or 0
    if totalCurrency < self.price then
      return CommonDefine.ColorType.Light
    else
      return CommonDefine.ColorType.Dark
    end
  end)
  binder:BindToImage(self.ui.Image_Currency_Icon, function()
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, self.costItemTid
  end, false)
  binder:BindZ1Button(self.ui.Image_Quality, System.fn(self, self.OnBtnBuyClick))
  binder:BindToVisible(self.ui.Red_Dot, function()
    return true
  end)
  binder:BindComponent(RedDotComponent(self.ui.Red_Dot, CommonDefine.RedDotType.TextNew, function()
    do return RedPointDataUtils.GetRedPointState end
    return RedPointDataUtils.GetRedPointState, RedPointDataUtils.RedType.EnergyCardExpire
  end))
  binder:BindToVisible(self.ui.Text_Remainder, function()
    return false
  end)
  binder:BindToVisible(self.ui.Text_OriginalPrice, function()
    return false
  end)
  self:OnBindAdditionalReward()
end

function MainShopEnergyMonthCardItem:OnBindAdditionalReward()
  local diamondData = DT.GetOriginalConstant("EnergyMonthlyCardReward")
  local tid = diamondData[1]
  local num = diamondData[2]
  if not tid or tid ~= DT.GetConstant("DiamondItemTid") then
    self.ui.Image_Gradient:SetActive(false)
  end
  self.ui.Image_Gradient:SetActive(true)
  UIAdditionalRewardUtils.BindAdditionalReward(self.binder, self.ui.Text_Additional, self.ui.Image_Additional_Icon, tid, num)
end

function MainShopEnergyMonthCardItem:OnBtnBuyClick()
  MainShopDataUtils.OpenEnergyMonthCardExchangePanel()
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.EnergyCardExpire, RedPointDataUtils.RedAttrType.IsNew)
end

return MainShopEnergyMonthCardItem
