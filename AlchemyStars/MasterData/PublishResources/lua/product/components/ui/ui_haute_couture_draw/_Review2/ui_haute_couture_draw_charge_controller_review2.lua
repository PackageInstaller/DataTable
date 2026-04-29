_class("UIHauteCoutureDrawChargeController_Review2", UIController)
UIHauteCoutureDrawChargeController_Review2 = UIHauteCoutureDrawChargeController_Review2

function UIHauteCoutureDrawChargeController_Review2:LoadDataOnEnter(TT, res, uiParams)
  self._buyComponet = uiParams[1]
  self._costItemID = uiParams[2]
  self._buyComponet:GetAllGiftLocalPrice()
end

function UIHauteCoutureDrawChargeController_Review2:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self._backBtn = btns:SpawnObject("UINewCommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  local currency = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self._topTips = currency:SpawnObject("UINewCurrencyMenu")
  self._topTips:SetData({
    self._costItemID
  }, true)
  self._topTips:ShowHideTSFBtn(true)
  local ids = self._buyComponet:GetAllGiftIDByType(CampaignGiftType.ECGT_SENIOR_SKIN)
  
  local function onclick(id)
    self:BuyGift(id)
  end
  
  local itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._items = itemPool:SpawnObjects("UISeniorSkinGiftItem", table.count(ids))
  local closeTime = self._buyComponet:GetComponentInfo().m_close_time
  for i, uiItem in ipairs(self._items) do
    uiItem:SetData(ids[i], onclick, closeTime)
  end
  self:RefreshPrice()
  self:AttachEvent(GameEventType.PayGetLocalPriceFinished, self.RefreshPrice)
  self:AttachEvent(GameEventType.ActivityCurrencyBuySuccess, self.OnBuySuccess)
end

function UIHauteCoutureDrawChargeController_Review2:RefreshPrice()
  for i, uiItem in ipairs(self._items) do
    local price = self._buyComponet:GetGiftPriceForShowById(uiItem:GetID())
    uiItem:SetPrice(price)
  end
end

function UIHauteCoutureDrawChargeController_Review2:BuyGift(id)
  local type = CampaignGiftType.ECGT_SENIOR_SKIN
  self._buyID = id
  Log.debug("请求购买礼包:", self._buyID)
  self._buyComponet:BuyGift(id, 1, type)
end

function UIHauteCoutureDrawChargeController_Review2:OnBuySuccess(id)
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
  self:ShowDialog("UIHauteCoutureGetItemController", awards, StringTable.Get("str_pay_gain_goods"), true, function()
  end)
end
