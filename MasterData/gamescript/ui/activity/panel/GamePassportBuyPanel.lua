local GamePassportBuyPanel, Super = System.NewClass("GamePassportBuyPanel", UIBasePanel)
GamePassportBuyPanel.uiResCls = UI_Passport_Exchange_NewResource

function GamePassportBuyPanel:ctor(buyInfo)
  Super.ctor(self)
  self.desc = buyInfo.desc
  self.actPromotional = buyInfo.actPromotional
  self.buyItem = buyInfo.buyItem
  self.rewards = buyInfo.rewards
  self.costItemOrChargeId = buyInfo.costItem
  self.costNum = buyInfo.costNum
  self.buyCallback = buyInfo.buyCallback
end

function GamePassportBuyPanel:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), nil, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnBtnConfirm), nil, function()
    do return LT.Text end
    return LT.Text, "Shop_Buy_Btn"
  end)
  binder:SetText(self.ui.Text_C_Title, LT.Text("Shop_Confirm_Buy_Str_Title"))
  binder:SetText(self.ui.Text_Prompt, self.desc)
  if ItemDataUtils.IsPayMoneyType(self.costItemOrChargeId) then
    local giftTip = LT.Textf("GiftDiamondDeductTip", ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.PayMoney, true), ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.FreePayMoney, true))
    if not string.isempty(self.actPromotional) then
      self.actPromotional = self.actPromotional .. "\n" .. giftTip
    else
      self.actPromotional = giftTip
    end
    self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, {
      CommonDefine.CurrencyType.PayMoney
    }, true))
  else
    binder:SetActive(self.ui.Group_Coin, false)
  end
  binder:SetText(self.ui.Text_ActPromotional, self.actPromotional)
  binder:SetActive(self.ui.Group_Buy, false)
  binder:SetActive(self.ui.Text_ActPromotional, not string.isempty(self.actPromotional))
  local costIcon = ItemDataUtils.GetIcon(self.costItemOrChargeId)
  binder:SetImage(self.ui.Image_Cost_Currency, costIcon)
  binder:SetActive(self.ui.Image_Cost_Currency, not string.isempty(costIcon))
  binder:BindToText(self.ui.Text_Cost_Num, function()
    do return self._GetCostNumText end
    return self._GetCostNumText, self
  end)
  self:ShowDisplayItems(self.rewards)
end

function GamePassportBuyPanel:ShowDisplayItems(rewards)
  local maxMiddleItemCount = self.ui.Content_Middle.transform.childCount
  if maxMiddleItemCount >= #rewards then
    self.binder:SetActive(self.ui.ScrollView_Reward_Middle, true)
    self.binder:SetActive(self.ui.ScrollView_Reward, false)
    for i = 1, maxMiddleItemCount do
      local rewardData = rewards[i]
      local itemObj = self.ui["Reward_" .. i]
      self.binder:SetActive(itemObj, nil ~= rewardData)
      if rewardData then
        local viewData = {
          itemTid = rewardData.tid,
          itemCount = rewardData.num
        }
        self.binder:BindComponent(CommonIconItemType2(itemObj, viewData))
      end
    end
  else
    self.binder:SetActive(self.ui.ScrollView_Reward_Middle, false)
    self.binder:SetActive(self.ui.ScrollView_Reward, true)
    if not self.rewardListView then
      self:_InitRewardListView()
    end
    self.rewardListView:ReloadData()
  end
end

function GamePassportBuyPanel:_GetCostNumText()
  local chargeCfg = ShopDataUtils.GetChargeCfgById(self.costItemOrChargeId)
  if chargeCfg then
    do return ShopDataUtils.GetChargePriceStr end
    return ShopDataUtils.GetChargePriceStr, self.costItemOrChargeId, nil, nil, nil, nil, nil, nil
  end
  local costNum = self.costNum
  local haveNum = ItemDataUtils.GetItemNum(self.costItemOrChargeId)
  local rst = LT.Text(string.format("%s/%s", haveNum, costNum))
  if costNum > haveNum then
    rst = LT.Text(string.format("<color=#FA3A50>%s</color>/%s", haveNum, costNum))
  end
  return rst
end

function GamePassportBuyPanel:_GetPromotionalDesc()
end

function GamePassportBuyPanel:OnBtnConfirm()
  if ItemDataUtils.IsPayMoneyType(self.costItemOrChargeId) then
    local haveNum = ItemDataUtils.GetPayMoneyTotalNum()
    if haveNum < self.costNum then
      Alert.Show(10635, nil, function()
        UIManager.Instance:Reopen(Urls.ChargeMainPanel)
      end)
      return
    end
  end
  if self.buyCallback then
    self.buyCallback()
  end
end

function GamePassportBuyPanel:_InitRewardListView()
  local baseGameObj = self.ui.Reward
  local sizeDelta = baseGameObj.transform.sizeDelta
  local width, height = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.rewardListView = self:CreateTableview(self.ui.ScrollView_Reward, function()
    if not self.rewards then
      return 0
    end
    return #self.rewards
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rewardData = self.rewards[index]
    local viewData = {
      itemTid = rewardData.tid,
      itemCount = rewardData.num
    }
    itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, viewData))
    return cell
  end, function()
    return width, height
  end)
end

return GamePassportBuyPanel
