local WorldStageShopCardPanel, Super = System.NewClass("WorldStageShopCardPanel", UIBasePanel)
WorldStageShopCardPanel.uiResCls = UI_Dbgcopy_Panel_StoreResource

function WorldStageShopCardPanel:ctor(showCards, uniqInfo, confirmCallback, runeTid)
  Super.ctor(self)
  self.showCards = Vue.ref(self:FilterUnexistCard(showCards))
  self.uniqInfo = uniqInfo or {}
  self.confirmCallback = confirmCallback
  self.runeTid = runeTid
  self.showUid = Vue.ref(0)
  self.cardItems = {}
  self.selectedCards = Vue.reactive({})
  self.cardItemList = {}
  self.selectNum = 1
  self.minNum = 1
  self.visible = true
end

function WorldStageShopCardPanel:OnBind(binder)
  binder:SetActive(self.ui.UI_Common_Item_Btn_2, true)
  self.ui.UI_Common_Item_Btn_2.transform.anchoredPosition = CS.UnityEngine.Vector2(620, -338)
  if self.uniqInfo.cardSelectPanelType == CommonDefine.CardSelectPanelType.sellCard then
    self.ui.Text_Sell_Tips:SetActive(true)
    binder:BindToText(self.ui.Text_Sell_Price, System.fn(self, self.GetSellPriceText))
    binder:BindToText(self.ui.Text_Sell_Tips, function()
      do return LT.Text end
      return LT.Text, "CellCardHint"
    end)
  end
  binder:BindToText(self.ui.Text_Title, function()
    return self.uniqInfo.title
  end)
  binder:BindToText(self.ui.Text_Effect, function()
    if self.runeTid then
      return DT.EnchantConfig[self.runeTid].Name
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Enchant, function()
    if self.runeTid then
      do return SkillUtils.GetEnchantDesc end
      return SkillUtils.GetEnchantDesc, self.runeTid
    end
    return ""
  end)
  self.btnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, function()
    if #self.selectedCards >= 1 then
      if self.confirmCallback then
        self.confirmCallback(self.selectedCards[1])
      end
      self:Close()
    else
      local tipKey = self.runeTid and "EnchantmentAwardUncheck" or "Card_Select_Tips1"
      Alert.ShowStr(LT.Text(tipKey))
    end
  end, function()
    return self.btnState.value
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  binder:BindToImage(self.ui.Image_Icon, function()
    if self.runeTid then
      return DT.EnchantConfig[self.runeTid].SmallIcon
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Image_Icon, function()
    return self.runeTid ~= nil
  end)
  binder:BindButtonClick(self.ui.Btn_Closure, function()
    self:Close()
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Card, function()
    return self.showCards.value
  end, function(itemBinder, item, index)
    local info = self.showCards.value[index]
    local uid = info.uid
    local card = CardDataUtils.GetCardInfo(uid)
    local selected = self.cardItemList[uid] and self.cardItemList[uid].selected or false
    local configId = card.configId
    local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, selected, card.cost, nil))
    cardComp:SetSelectFunc()
    cardComp:SetSelectShow(SystemUtils.Contain(self.selectedCards, uid))
    self.cardItemList[uid] = cardComp
  end, function(index)
    local uid = self.showCards.value[index].uid
    if self.cardItemList[uid] then
      self.cardItemList[uid] = nil
    end
  end)
  self:EnableConfirmButton(false)
  binder:BindEvent(EventMgr.Instance.SelectedCard, function(selected, uid)
    Logger.Debug(string.format("uid:%d, selected:%s", uid, tostring(selected)))
    if selected then
      self:OnCardSelect(uid)
    else
      self:OnCardDeselect(uid)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function WorldStageShopCardPanel:FilterUnexistCard(cards)
  local existCards = {}
  for _, card in ipairs(cards) do
    if CardDataUtils.GetCardInfo(card.uid) then
      table.insert(existCards, card)
    end
  end
  return existCards
end

function WorldStageShopCardPanel:SetCardItemSelectShow(uid, show)
  if self.cardItemList[uid] == nil then
    return
  end
  self.cardItemList[uid]:SetSelectShow(show)
end

function WorldStageShopCardPanel:EnableConfirmButton(enabled)
  if enabled then
    self.btnState.value = CommonDefine.BtnType.High
  else
    self.btnState.value = CommonDefine.BtnType.Unclickable
  end
end

function WorldStageShopCardPanel:OnCardSelect(uid)
  if self.selectNum <= 0 then
    return
  end
  if 1 == self.selectNum and 1 == #self.selectedCards then
    self:OnCardDeselect(self.selectedCards[1])
  end
  if #self.selectedCards < self.selectNum then
    table.insert(self.selectedCards, uid)
    self:SetCardItemSelectShow(uid, true)
  else
    local desc = LT.Textf(DT.TipsType[10168].Desc, self.selectNum)
    Alert.Show(10168, nil, nil, nil, desc)
  end
  self:EnableConfirmButton(#self.selectedCards >= self.minNum)
end

function WorldStageShopCardPanel:GetSellPriceText()
  if 0 == #self.selectedCards then
    return ""
  end
  local price = 0
  for _, uid in ipairs(self.selectedCards) do
    local card = self:GetCard(uid) or {}
    price = price + (card.price or 0)
  end
  do return string.format, "%s +%s", (LT.Text("PhiloStone")) end
  return string.format, "%s +%s", LT.Text("PhiloStone"), price, nil, nil, {}, card.price or 0, uid
end

function WorldStageShopCardPanel:GetCard(uid)
  for _, card in ipairs(self.showCards.value) do
    if card.uid == uid then
      return card
    end
  end
end

function WorldStageShopCardPanel:OnCardDeselect(uid)
  for index, value in ipairs(self.selectedCards) do
    if value == uid then
      table.remove(self.selectedCards, index)
      self:SetCardItemSelectShow(uid, false)
      break
    end
  end
  self:EnableConfirmButton(#self.selectedCards >= self.minNum)
end

return WorldStageShopCardPanel
