local SelectCardPanel, Super = System.NewClass("SelectCardPanel", UIBasePanel)
SelectCardPanel.uiResCls = UI_Level_Panel_Delete_CardResource

function SelectCardPanel:ctor(showCards, uniqInfo, confirmCallback, runeTid)
  Super.ctor(self)
  self.showCards = Vue.ref(showCards)
  self.uniqInfo = uniqInfo or {}
  self.confirmCallback = confirmCallback
  self.runeTid = runeTid
  self.showUid = Vue.ref(0)
  self.cardItems = {}
  Logger.Info("showCards == ", table.tostring(showCards))
end

function SelectCardPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.Close))
  if self.uniqInfo.title then
    binder:SetText(self.ui.Text_Title, self.uniqInfo.title)
  end
  if self.uniqInfo.forbidClose then
    self.ui.Btn_Close:SetActive(false)
  else
    self.ui.Btn_Close:SetActive(true)
  end
  binder:BindToCircularListView(self.ui.ScrollView_CardList, function()
    return self.showCards.value
  end, function(itemBinder, item, index)
    local info = self.showCards.value[index]
    local uid = info.uid
    local configId = info.configId or info.tid
    local card = itemBinder:BindComponent(DeleteCardItem(item, {
      uid = uid,
      configId = configId,
      state = info.notSale or false
    })).card
    if info.notSale ~= true then
      card:SetSelectFunc()
    end
    card:SetSelectShow(self.showUid.value == uid)
    self.cardItems[uid] = card
  end, function(index)
    local info = self.showCards.value[index]
    local uid = info.uid
    if self.cardItems[uid] then
      self.cardItems[uid] = nil
    end
  end)
  binder:BindToRaw(function(_, newValue, oldValue)
    if self.cardItems[oldValue] then
      self.cardItems[oldValue]:SetSelectShow(false)
    end
    if self.cardItems[newValue] then
      self.cardItems[newValue]:SetSelectShow(true)
    end
  end, function()
    return self.showUid.value
  end)
  binder:BindEvent(EventMgr.Instance.SelectedCard, function(ret, uid, configId)
    if ret then
      self.showUid.value = uid
      local confirmCb = System.fn(self, self.ClickCardItem)
      local cancelCb = System.fn(self, self.OnCancelSelect)
      local confirmWord = self.uniqInfo.confirm or "Event_Shop_String_Botton"
      local cancelWord = self.uniqInfo.cancel or "Energy_String_2"
      local costItemId = self.uniqInfo.costItemId
      local cost = self.uniqInfo.value
      local runeTid = self.runeTid
      local data = {
        cardUid = uid,
        configId = configId,
        confirmCb = confirmCb,
        cancelCb = cancelCb,
        confirmWord = confirmWord,
        cancelWord = cancelWord,
        costItemId = costItemId,
        cost = cost,
        runeTid = runeTid
      }
      CardDataUtils.ReopneShopCardChoosePanel(data)
    end
  end)
end

function SelectCardPanel:ClickCardItem()
  if self.confirmCallback then
    self.confirmCallback(self.showUid.value)
    UIManager.Instance:CloseByUrl(Urls.ShopChooseCardPanel)
    UIManager.Instance:CloseByUrl(Urls.SelectCardPanel)
  end
end

function SelectCardPanel:OnCancelSelect()
  CardDataUtils.CloseShopCardChoosePanel()
  self.showUid.value = 0
end

function SelectCardPanel:Close()
  if self.uniqInfo.closeCallback then
    self.uniqInfo.closeCallback()
  else
    Super.Close(self)
  end
end

return SelectCardPanel
