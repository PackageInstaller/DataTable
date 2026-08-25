local WorldStageMysteryPanel, Super = System.NewClass("WorldStageMysteryPanel", UIBasePanel)
WorldStageMysteryPanel.uiResCls = UI_Dbgcopy_Panel_Special_ShopResource

function WorldStageMysteryPanel:ctor(shopUid, callFunc)
  Super.ctor(self)
  self.shopUid = shopUid
  self.callFunc = callFunc
  self.relicItems = {}
  self.enchantItems = {}
  self.shopData = ShopDataUtils.GetShopData(shopUid)
end

function WorldStageMysteryPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.BtnCloseClick))
  binder:BindToVisible(self.ui.Btn_Refresh, function()
    return self.shopData.refreshCount > 0
  end)
  binder:BindButtonClick(self.ui.Btn_Refresh, System.fn(self, self.BtnFresh))
  binder:SetText(self.ui.Text_Refresh_1, "")
  binder:BindToText(self.ui.Text_Refresh_2, function()
    do return string.format, (LT.Text("Battle_Acount_8")) end
    return string.format, LT.Text("Battle_Acount_8"), self.shopData.refreshCount
  end)
  self:UpdateView()
end

function WorldStageMysteryPanel:UpdateView()
  local relics = {}
  local enchants = {}
  for _, value in ipairs(self.shopData.ShopArray) do
    if value.type == CommonDefine.WorldStageShopItemType.Relic then
      table.insert(relics, {
        uid = value.uid,
        tid = value.tid,
        price = value.price
      })
    elseif value.type == CommonDefine.WorldStageShopItemType.Enchant then
      table.insert(enchants, {
        uid = value.uid,
        tid = value.tid,
        price = value.price
      })
    end
  end
  for slot, value in ipairs(relics) do
    self.binder:SetActive(self.ui["Gold_Shop_" .. slot], value.tid > 0)
    self.binder:SetActive(self.ui["Text_No_" .. slot], value.tid <= 0)
    if not self.relicItems[slot] then
      local item = self.binder:BindComponent(ShopItem(self.ui["Gold_Shop_" .. slot], value.uid, System.fn(self, self.ClickRelicItem), true, value.tid, CommonDefine.WorldStageShopItemType.Relic))
      self.relicItems[slot] = item
    else
      self.relicItems[slot]:SetShopData(value.uid, value.tid)
    end
  end
  for idx = #relics + 1, 2 do
    local slot = idx
    self.binder:SetActive(self.ui["Gold_Shop_" .. slot], false)
    self.binder:SetActive(self.ui["Text_No_" .. slot], false)
  end
  for idx, value in ipairs(enchants) do
    local slot = idx + 4
    self.binder:SetActive(self.ui["Gold_Shop_" .. slot], value.tid > 0)
    self.binder:SetActive(self.ui["Text_No_" .. slot], value.tid <= 0)
    if not self.enchantItems[slot] then
      local item = self.binder:BindComponent(ShopItem(self.ui["Gold_Shop_" .. slot], value.uid, System.fn(self, self.ClickRuneItem), true, value.tid, CommonDefine.WorldStageShopItemType.Enchant))
      self.enchantItems[slot] = item
    else
      self.enchantItems[slot]:SetShopData(value.uid, value.tid)
    end
  end
  for idx = #enchants + 1, 2 do
    local slot = idx + 4
    self.binder:SetActive(self.ui["Gold_Shop_" .. slot], false)
    self.binder:SetActive(self.ui["Text_No_" .. slot], false)
  end
end

function WorldStageMysteryPanel:BtnCloseClick()
  if self.callFunc then
    self.callFunc()
  end
  self:Close()
end

function WorldStageMysteryPanel:ClickRuneItem(uid)
  local shopItem = ShopDataUtils.GetShopItem(uid, "rune")
  if not shopItem then
    Logger.Error("ui == " .. uid)
    return
  end
  local cost = math.modf(shopItem.price)
  DataCenter.relicData.RelicDetailDarkMode = true
  RelicDataUtils.ShowGainRelicDetailPanel({
    uid = shopItem.uid,
    relicTid = shopItem.tid,
    itemType = shopItem.type
  }, nil, function(_)
    if DataCenter.playerData.DMoney.gold == nil or math.abs(cost) > DataCenter.playerData.DMoney.gold then
      Alert.Show(10222)
      return
    end
    DataCenter.copiesData.ShowRuneGainTipPanel = false
    self:BuyItem(shopItem.uid, function()
      DataCenter.copiesData.ShowRuneGainTipPanel = true
    end, CommonDefine.WorldStageShopItemType.Enchant)
    self:OpenRuneCardSelectPanel(shopItem.tid)
    self.cancelCallback = nil
  end, function()
  end, function(component)
    local haveMoney = DataCenter.playerData.DMoney.gold or 0
    local icon = 100 == DataCenter.itemData.Coin and DT.GetConstant("PhiloStone")[2] or DT.Item[DataCenter.itemData.Coin].SmallIcon
    component:SetPrice(cost, haveMoney, icon)
    component:SetGiveUpStr("")
    component:SetBtnText(LT.Text("StoreBuyCancel"), LT.Text("StoreBuyConfirm"))
  end)
end

function WorldStageMysteryPanel:BtnFresh()
  Alert.Show(20009, nil, function()
    ProtoManager.Instance:ReqServer("WorldRequest", "OnGearShopRefresh", function(data)
      ShopDataUtils.OnShopData(data)
      self:UpdateView()
    end, function()
      Logger.Info("WorldRequest OnGearShopRefresh Fail")
    end)
  end)
end

function WorldStageMysteryPanel:ClickRelicItem(uid)
  local shopItem = ShopDataUtils.GetShopItem(uid, "relic")
  if not shopItem then
    Logger.Error("ui == " .. uid)
    return
  end
  local cost = math.modf(shopItem.price)
  DataCenter.relicData.RelicDetailDarkMode = true
  RelicDataUtils.ShowGainRelicDetailPanel({
    uid = shopItem.uid,
    relicTid = shopItem.tid,
    itemType = shopItem.type
  }, nil, function(callBack)
    if DataCenter.playerData.DMoney.gold == nil or math.abs(cost) > DataCenter.playerData.DMoney.gold then
      Alert.Show(10222)
      return
    end
    self:BuyItem(shopItem.uid, callBack, CommonDefine.WorldStageShopItemType.Relic)
  end, function()
  end, function(component)
    local haveMoney = DataCenter.playerData.DMoney.gold or 0
    local icon = 100 == DataCenter.itemData.Coin and DT.GetConstant("PhiloStone")[2] or DT.Item[DataCenter.itemData.Coin].SmallIcon
    component:SetPrice(cost, haveMoney, icon)
    component:SetGiveUpStr("")
    component:SetBtnText(LT.Text("StoreBuyCancel"), LT.Text("StoreBuyConfirm"))
  end)
end

function WorldStageMysteryPanel:BuyItem(uid, callback, shopType)
  ShopDataUtils.BuyShopItem(uid, function()
    if callback then
      callback()
    end
  end, shopType)
end

function WorldStageMysteryPanel:OpenRuneCardSelectPanel(runeTid, _)
  local runeCfg = DT.EnchantConfig[runeTid]
  local showCards = CardDataUtils.GetCanInlayRuneCards(runeTid)
  showCards = CardDataUtils.SortCardsByActorOrder(showCards)
  local cardCount = #(showCards or {})
  if 0 == cardCount then
    return
  end
  local langInfo = {
    title = LT.Textf("RuneGain_Title", runeCfg.Name),
    confirm = LT.Text("RuneGain_Btn"),
    cancel = LT.Text("Common_Button_Cancel"),
    costItemId = runeTid,
    cost = nil,
    forbidClose = true,
    notAutoClose = true,
    closeCallback = function()
    end
  }
  
  local function confirmCallback(uid)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("WorldRequest", "PutRune", function(_)
      EventMgr.Instance.PutOnRune:Dispatch(true)
      UIManager.Instance:CloseByUrl(Urls.SelectCardPanel)
      if CopiesDataUtils.HasInitRuneTid() then
        CopiesDataUtils.SetInitRuneTid(0)
      end
    end, function()
      EventMgr.Instance.PutOnRune:Dispatch(false)
      if CopiesDataUtils.HasInitRuneTid() then
        CopiesDataUtils.SetInitRuneTid(0)
      end
    end, uid, runeTid)
  end
  
  UIManager.Instance:Reopen(Urls.SelectCardPanel, showCards, langInfo, confirmCallback, runeTid)
end

return WorldStageMysteryPanel
