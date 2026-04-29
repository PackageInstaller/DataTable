_class("UIHauteCoutureDrawChargeBase", UICustomWidget)
UIHauteCoutureDrawChargeBase = UIHauteCoutureDrawChargeBase

function UIHauteCoutureDrawChargeBase:Constructor()
  self.controller = nil
end

function UIHauteCoutureDrawChargeBase:InitWidgetsBase()
  self.controller = self.uiOwner
  self._ctx = self.controller._ctx
  local btns = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self._backBtn = btns:SpawnObject("UINewCommonTopButton")
  self._backBtn:SetData(function()
    self.controller:CloseDialog()
  end, nil, nil, true)
  local currency = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self._topTips = currency:SpawnObject("UINewCurrencyMenu")
  self._topTips:SetData({
    HauteCouture:GetInstance().CostCoinId
  }, true)
  self._topTips:ShowHideTSFBtn(true)
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIHauteCoutureDrawChargeBase:_OnValueBase()
  local ids = self.controller._buyComponet:GetAllGiftIDByType(CampaignGiftType.ECGT_SENIOR_SKIN)
  
  local function onclick(id)
    self:buyGift(id)
  end
  
  self._items = self._itemPool:SpawnObjects(self:GetItemImpl(), table.count(ids))
  local closeTime = self.controller._buyComponet:GetComponentInfo().m_close_time
  for i, uiItem in ipairs(self._items) do
    uiItem:SetData(ids[i], onclick, closeTime)
  end
  self:RefreshPrice()
  self:AttachEvent(GameEventType.PayGetLocalPriceFinished, self.RefreshPrice)
end

function UIHauteCoutureDrawChargeBase:GetItemImpl()
  Log.error("UIHauteCoutureDrawChargeBase:GetItemImpl should be inherited")
  return ""
end

function UIHauteCoutureDrawChargeBase:RefreshPrice()
  for i, uiItem in ipairs(self._items) do
    local price = self.controller._buyComponet:GetGiftPriceForShowById(uiItem:GetID())
    uiItem:SetPrice(price)
  end
end

function UIHauteCoutureDrawChargeBase:AddEventBase()
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnBuySuccess)
end

function UIHauteCoutureDrawChargeBase:RemoveEventBase()
  self:DetachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnBuySuccess)
end

function UIHauteCoutureDrawChargeBase:buyGift(id)
  local type = CampaignGiftType.ECGT_SENIOR_SKIN
  self._buyID = id
  Log.debug("请求购买礼包:", self._buyID)
  self.controller._buyComponet:BuyGift(id, 1, type)
end

function UIHauteCoutureDrawChargeBase:OnBuySuccess(id)
  Log.debug("购买礼包成功:", self._buyID)
  local cfg = Cfg.cfg_component_buy_gift({
    GiftID = self._buyID
  })[1]
  self._buyID = nil
  local id = cfg.ExtraAward[1][1]
  local count = cfg.ExtraAward[1][2]
  local asset = RoleAsset:New()
  asset.assetid = id
  asset.count = count
  local awards = {asset}
  self:ShowDialog("UIHauteCoutureDrawGetItemV2Controller", awards, StringTable.Get("str_pay_gain_goods"), true, function()
  end, self._ctx)
end
