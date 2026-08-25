local originColor, notEnoughColor
local NOT_ENOUGHT_COLOR_KEY = "Shop3"
local WorldStageNewShopPanel, Super = System.NewClass("WorldStageNewShopPanel", UIBasePanel)
WorldStageNewShopPanel.uiResCls = UI_Dbgcopy_Panel_ActionResource

function WorldStageNewShopPanel:ctor(shopUid, callback, gearItemType, shopName)
  Super.ctor(self)
  self.shopUid = shopUid
  self.shopName = shopName
  self.callback = callback
  self.gearItemType = gearItemType
  self.saleCards = Vue.ref({})
  self.relieveCardInfos = Vue.ref({})
  self.relics = Vue.ref({})
  self.enchants = Vue.ref({})
  self.relicComp = {}
  self.enchantComp = {}
  self.shopData = ShopDataUtils.GetShopData(shopUid)
  originColor = "#FFFFFF"
  notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig[NOT_ENOUGHT_COLOR_KEY])
end

function WorldStageNewShopPanel:OnBind(binder)
  self.binder = binder
  self:SetShopData()
  UICommonBtnVibes.BindCommonBtnVibes(binder, self.ui.UI_Common_Btn_Vibes)
  binder:onDestroy(function()
    EventMgr.Instance.GuideEvent:Dispatch(CommonDefine.GuideEvent.GuideCloseShop)
  end)
  self:_OnBindEvent()
  binder:BindButtonClick(self.ui.Btn_Blackseal, System.fn(self, self.SellCard))
  binder:BindButtonClick(self.ui.Btn_Awaken, System.fn(self, self.AwakeRole))
  binder:BindButtonClick(self.ui.Btn_Flushed, System.fn(self, self.OnRefresh))
  binder:BindButtonClick(self.ui.Btn_Closure, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, self.shopName
  end)
  binder:BindToText(self.ui.Text_Sell, function()
    do return LT.Text end
    return LT.Text, "StoreSellCard"
  end)
  binder:BindToText(self.ui.Text_Awaken, function()
    do return LT.Text end
    return LT.Text, "StoreAwakerAwake"
  end)
  binder:BindToText(self.ui.Text_Number, function()
    local cost = self.shopData.RelieveCardPrice
    local have = DataCenter.playerData.DMoney.gold or 0
    if have < math.abs(cost) then
      binder:SetTextColorByHtml(self.ui.Text_Number, notEnoughColor)
    else
      binder:SetTextColorByHtml(self.ui.Text_Number, originColor)
    end
    do return LT.Text, string.format("%s%s", cost, LT.Text("PhiloStone")) end
    return LT.Text, string.format("%s%s", cost, LT.Text("PhiloStone"))
  end)
  binder:BindToText(self.ui.Text_Flushed, function()
    do return LT.Textf, "StoreRenewButton", self.shopData.refreshCount end
    return LT.Textf, "StoreRenewButton", self.shopData.refreshCount, self.shopData.maxRefreshCount or 1
  end)
  binder:BindToImage(self.ui.Image_Awaken_Icon, function()
    return DT.GetOriginalConstant("PhiloStone")[2]
  end)
  binder:BindToVisible(self.ui.Image_Mask, function()
    return self.shopData.SaleCardCount <= 0
  end)
  binder:BindToVisible(self.ui.Image_Sellout, function()
    return self.shopData.RelieveCardCount <= 0
  end)
  binder:BindToVisible(self.ui.Image_Currency, function()
    return (self.shopData.refreshPrice or 0) > 0 and self.shopData.maxRefreshCount > 0
  end)
  binder:BindToVisible(self.ui.Btn_Flushed, function()
    return self.shopData.maxRefreshCount > 0
  end)
  binder:BindToText(self.ui.Text_IconNum, function()
    local price = self.shopData.refreshPrice or 0
    local have = DataCenter.playerData.DMoney.gold or 0
    if price > have then
      do return binder.GetColorText, binder, price end
      return binder.GetColorText, binder, price, NOT_ENOUGHT_COLOR_KEY
    end
    return self.shopData.refreshPrice or 0
  end)
  BarrierDataUtils.SetTopInfoShow(true, true, true)
  self:CreateShop()
end

function WorldStageNewShopPanel:_OnBindEvent()
  self.binder:BindEvent(EventMgr.Instance.OnWorldStageShopPurchased, System.fn(self, self.SetShopData))
end

function WorldStageNewShopPanel:CreateShop()
  local MaxRelicGoodsNum = 5
  for i = 1, MaxRelicGoodsNum do
    if self.ui["Goods_" .. i] then
      self.ui["Goods_" .. i]:SetActive(false)
    end
  end
  for index, value in ipairs(self.relics.value) do
    if self.relicComp[index] then
      self.relicComp[index].binder:teardown()
    end
    self.ui["Goods_" .. value.slot]:SetActive(true)
    self.relicComp[index] = self.binder:BindComponent(WorldStageShopItem(self.ui["Goods_" .. value.slot], value.tid, value.uid, CommonDefine.WorldStageShopItemType.Relic, function(uid)
      self:ClickRelicItem(uid)
    end))
  end
  for index, value in ipairs(self.enchants.value) do
    if self.enchantComp[index] then
      self.enchantComp[index].binder:teardown()
    end
    self.ui["Goods_" .. value.slot]:SetActive(true)
    self.enchantComp[index] = self.binder:BindComponent(WorldStageShopItem(self.ui["Goods_" .. value.slot], value.tid, value.uid, CommonDefine.WorldStageShopItemType.Enchant, function(uid)
      self:ClickEnchantItem(uid)
    end))
  end
end

function WorldStageNewShopPanel:SetShopData()
  local relics = {}
  local relieveCardInfos = {}
  local saleCards = {}
  local enchants = {}
  local relicSlot = {
    [1] = 2,
    [2] = 3,
    [3] = 4
  }
  local enchantSlot = {
    [1] = 1
  }
  for _, value in pairs(self.shopData.ShopArray) do
    if value.type == CommonDefine.WorldStageShopItemType.Relic then
      local tmpSlot = relicSlot[#relics + 1]
      if tmpSlot then
        table.insert(relics, {
          uid = value.uid,
          tid = value.tid,
          slot = tmpSlot,
          price = value.price
        })
      end
    elseif value.type == CommonDefine.WorldStageShopItemType.Enchant then
      local tmpSlot = enchantSlot[#enchants + 1]
      if tmpSlot then
        table.insert(enchants, {
          uid = value.uid,
          tid = value.tid,
          slot = tmpSlot,
          price = value.price
        })
      end
    elseif value.type == CommonDefine.WorldStageShopItemType.SaleCard and value.notSale ~= true then
      table.insert(saleCards, value)
    elseif value.type == CommonDefine.WorldStageShopItemType.RelieveAbCard then
      table.insert(relieveCardInfos, {
        configId = value.tid,
        uid = value.uid
      })
    end
  end
  self.saleCards.value = saleCards
  self.relics.value = relics
  self.enchants.value = enchants
  relieveCardInfos = CardDataUtils.SortCardsByActorOrder(relieveCardInfos)
  for i = #relieveCardInfos, 1, -1 do
    local uid = relieveCardInfos[i].uid
    local lock = CardDataUtils.GetCardInfo(uid).lock
    if not lock then
      table.remove(relieveCardInfos, i)
    end
  end
  self.relieveCardInfos.value = relieveCardInfos
end

function WorldStageNewShopPanel:SellCard()
  if self.shopData.SaleCardCount <= 0 then
    Alert.ShowStr(LT.Text("StoreReleaseTimesOut"))
    return
  end
  self:SetShopData()
  local showCards = {}
  for _, value in ipairs(self.saleCards.value) do
    table.insert(showCards, value)
  end
  local langInfo = {
    title = LT.Text("StoreSellCardTitle"),
    confirm = LT.Text("StoreSellCardConfirm"),
    cancel = LT.Text("StoreSellCardCancel"),
    costItemId = nil,
    forbidClose = false,
    cost = nil,
    cardSelectPanelType = CommonDefine.CardSelectPanelType.sellCard
  }
  
  local function confirmCallback(uid)
    if not CardDataUtils.GetCardInfo(uid) then
      return
    end
    self.shopData.SaleCardCount = self.shopData.SaleCardCount - 1
    ShopDataUtils.BuyShopItem(uid, System.fn(self, self.SetShopData), CommonDefine.WorldStageShopItemType.SaleCard)
    Alert.ShowStr(LT.Text("SaleSuccessful"))
  end
  
  UIManager.Instance:Reopen(Urls.WorldStageShopCardPanel, showCards, langInfo, confirmCallback)
end

function WorldStageNewShopPanel:AwakeRole()
  if self.shopData.RelieveCardCount <= 0 then
    Alert.ShowStr(LT.Text("StoreReleaseTimesOut"))
    return
  end
  local haveMoney = DataCenter.playerData.DMoney.gold or 0
  if haveMoney < self.shopData.RelieveCardPrice then
    Alert.ShowStr(LT.Text("StorePhiloStoneLack"))
    return
  end
  if #self.relieveCardInfos.value <= 0 then
    Alert.ShowStr(LT.Text("StoreReleaseNoAwaker"))
    return
  end
  self:SetShopData()
  
  local function confirmCallback(uid)
    self.shopData.RelieveCardCount = 0
    ShopDataUtils.BuyShopItem(uid, System.fn(self, self.SetShopData), CommonDefine.WorldStageShopItemType.RelieveAbCard)
  end
  
  UIManager.Instance:Reopen(Urls.CardUnlockAbPanel, self.relieveCardInfos.value, confirmCallback, {
    price = self.shopData.RelieveCardPrice,
    cardType = 1
  })
end

function WorldStageNewShopPanel:OnRefresh()
  if self.shopData.refreshCount <= 0 then
    Alert.ShowStr(LT.Text("StoreReleaseTimesOut"))
    return
  end
  Alert.SetMaskClickClose(true)
  Alert.Show(20009, nil, function()
    local refreshPrice = self.shopData.refreshPrice or 0
    local ownNum = DataCenter.playerData.DMoney.gold or 0
    if refreshPrice > ownNum then
      Alert.Show(10320)
      return
    end
    WorldstageReqUtils.ReqOnShopRefresh(nil, function()
      self:SetShopData()
      self:CreateShop()
    end)
  end, LT.Text(DT.TipsType[20009].Title) or "", nil, "")
end

function WorldStageNewShopPanel:GetRefreshCostWord()
  local refreshPrice = self.shopData.refreshPrice or 0
  if refreshPrice > 0 then
    local ownNum = DataCenter.playerData.DMoney.gold or 0
    local color = refreshPrice > ownNum and self.binder:GetColorStr(NOT_ENOUGHT_COLOR_KEY)
    do return string.color, (LT.Textf("Shop_Refresh_Cost_Text", refreshPrice)) end
    return string.color, LT.Textf("Shop_Refresh_Cost_Text", refreshPrice), color, refreshPrice
  end
end

function WorldStageNewShopPanel:ClickRelicItem(uid)
  WorldStageShopUtils.OnClickRelicGoods(uid)
end

function WorldStageNewShopPanel:ClickEnchantItem(uid)
  WorldStageShopUtils.OnClickEnchantGoods(uid)
end

function WorldStageNewShopPanel:IsCanCloseInZeroChapter()
  if IntroductionDataUtils.IsFinish() then
    return true
  end
  local relics = self.relics.value or {}
  if 1 == #relics then
    local relic = relics[1]
    local item = ShopDataUtils.GetShopItem(relic.uid)
    if not item.use and 1 ~= item.use then
      return false
    end
  end
  return true
end

function WorldStageNewShopPanel:Close()
  if not self:IsCanCloseInZeroChapter() then
    Alert.Show(10536)
    return
  end
  BarrierDataUtils.SetTopInfoLastShow()
  Super.Close(self)
  if self.callback then
    self.callback()
  end
end

return WorldStageNewShopPanel
