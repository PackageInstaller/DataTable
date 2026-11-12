local ActivityShopGoodsDetailCtrl = class("ActivityShopGoodsDetailCtrl", BaseCtrl)
ActivityShopGoodsDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  txtHas = {sComponentName = "TMP_Text"},
  txtPriceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_UnitPrice"
  },
  imgCoin = {nCount = 2, sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtStock = {sComponentName = "TMP_Text"},
  goStock = {},
  txtBtnBuy = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Btn_Buy"
  },
  txtCoinCount = {sComponentName = "TMP_Text"},
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnBuy2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disable"
  },
  txtDisable = {sComponentName = "TMP_Text"},
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  }
}
ActivityShopGoodsDetailCtrl._mapEventConfig = {}

function ActivityShopGoodsDetailCtrl:Refresh(mapData, nShopId, nActId)
  self.mapGoodsCfg = ConfigTable.GetData("ActivityGoods", mapData.nId)
  local mapShopCfg = ConfigTable.GetData("ActivityShop", nShopId)
  if not self.mapGoodsCfg or not mapShopCfg then
    return
  end
  self.mapData = mapData
  self.nShopId = nShopId
  self.nCurrencyItemId = mapShopCfg.CurrencyItemId
  self.bAble = mapData.bPurchasTime and mapData.bPurchasable and not mapData.bSoldOut
  self.actShopData = PlayerData.Activity:GetActivityDataById(nActId)
  self:PlayInAni()
  self:RefreshInfo()
  self:RefreshPrice()
  self:RefreshBuyState()
  self:RefreshBuyCount()
end

function ActivityShopGoodsDetailCtrl:RefreshInfo()
  local nItemId = self.mapGoodsCfg.ItemId
  local mapCfg = ConfigTable.GetData_Item(nItemId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapGoodsCfg.Name)
  self._mapNode.goItem:SetItem(nItemId, nil, self.mapGoodsCfg.ItemQuantity, nil, nil, nil, nil, true)
  if mapCfg.Type == GameEnum.itemType.Disc or mapCfg.Type == GameEnum.itemType.Char or mapCfg.Type == GameEnum.itemType.CharacterSkin then
    self._mapNode.txtHas.gameObject:SetActive(false)
  else
    self._mapNode.txtHas.gameObject:SetActive(true)
    local nCount = PlayerData.Item:GetItemCountByID(nItemId)
    if 999999 < nCount then
      local nFloor = math.floor(nCount / 100)
      local nK = string.format("%.0f", nFloor / 10)
      local sCount = nK .. "k"
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. sCount)
    else
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. nCount)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, self.mapGoodsCfg.Desc)
  local bLimit = self.mapData.nMaximumLimit > 0
  if bLimit then
    local nLeft = self.mapData.nMaximumLimit - self.mapData.nBoughtCount
    NovaAPI.SetTMPText(self._mapNode.txtStock, orderedFormat(ConfigTable.GetUIText("Shop_Stock"), nLeft))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, nLeft == 0 and Red_Unable or Blue_Dark)
  else
    NovaAPI.SetTMPText(self._mapNode.txtStock, ConfigTable.GetUIText("Shop_Unlimited"))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, Blue_Dark)
  end
  self._mapNode.btnDetail.interactable = mapCfg and (mapCfg.Stype == GameEnum.itemStype.Disc or mapCfg.Stype == GameEnum.itemStype.Char or mapCfg.Stype == GameEnum.itemStype.RandomPackage or mapCfg.Stype == GameEnum.itemStype.ComCYO or mapCfg.Stype == GameEnum.itemStype.OutfitCYO)
end

function ActivityShopGoodsDetailCtrl:RefreshPrice()
  for i = 1, 2 do
    self:SetSprite_Coin(self._mapNode.imgCoin[i], self.nCurrencyItemId)
  end
  NovaAPI.SetTMPText(self._mapNode.txtPrice, self.mapGoodsCfg.Price)
end

function ActivityShopGoodsDetailCtrl:RefreshBuyCount()
  local nCost = self.nBuyCount * self.mapGoodsCfg.Price
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, nCost)
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.nCurrencyItemId)
  NovaAPI.SetTMPColor(self._mapNode.txtCoinCount, nCost > nHasCoin and Red_Unable or Blue_Normal)
end

function ActivityShopGoodsDetailCtrl:RefreshBuyState()
  self._mapNode.btnBuy.gameObject:SetActive(self.bAble)
  self._mapNode.btnBuy2.gameObject:SetActive(not self.bAble)
  self._mapNode.txtDisable.gameObject:SetActive(not self.mapData.bPurchasable or self.mapData.bSoldOut)
  self.nBuyCount = self.bAble and 1 or 0
  local nMax = self:CountMaxBuy()
  
  local function callback(nCount)
    self.nBuyCount = nCount
    self:RefreshBuyCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, self.nBuyCount, nMax)
  if self.mapData.bSoldOut then
    NovaAPI.SetTMPText(self._mapNode.txtDisable, ConfigTable.GetUIText("Shop_Cond_SoldOutShort"))
  elseif not self.mapData.bPurchasable then
    if self.mapData.nPurchaseCondType == GameEnum.shopCond.WorldClassSpecific then
      NovaAPI.SetTMPText(self._mapNode.txtDisable, orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClassShort"), self.mapData.tbPurchaseCondParams[1]))
    elseif self.mapData.nPurchaseCondType == GameEnum.shopCond.ShopPreGoodsSellOut or self.mapData.nPurchaseCondType == GameEnum.shopCond.ActivityShopPreGoodsSellOut then
      NovaAPI.SetTMPText(self._mapNode.txtDisable, ConfigTable.GetUIText("Shop_Cond_PreGoodsSellOut"))
    end
  end
end

function ActivityShopGoodsDetailCtrl:CountMaxBuy()
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.nCurrencyItemId)
  local nMax = math.floor(nHasCoin / self.mapGoodsCfg.Price)
  if nMax == 0 then
    return 1
  end
  if 0 < self.mapData.nMaximumLimit then
    local nRemain = self.mapData.nMaximumLimit - self.mapData.nBoughtCount
    return nMax > nRemain and nRemain or nMax
  else
    return nMax
  end
end

function ActivityShopGoodsDetailCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function ActivityShopGoodsDetailCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function ActivityShopGoodsDetailCtrl:Close()
  self.gameObject:SetActive(false)
end

function ActivityShopGoodsDetailCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function ActivityShopGoodsDetailCtrl:OnEnable()
end

function ActivityShopGoodsDetailCtrl:OnDisable()
end

function ActivityShopGoodsDetailCtrl:OnDestroy()
end

function ActivityShopGoodsDetailCtrl:OnBtnClick_Buy()
  local nCost = self.nBuyCount * self.mapGoodsCfg.Price
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.nCurrencyItemId)
  local sName = ConfigTable.GetData_Item(self.nCurrencyItemId).Title
  if nCost > nHasCoin then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Shop_NotEnough"), sName))
    return
  end
  
  local function buy()
    local function callback()
      EventManager.Hit("ActivityShopRefreshGoods")
      
      EventManager.Hit("ActivityShopCloseDetail")
      local bLimit = self.mapData.nMaximumLimit > 0
      EventManager.Hit("ActivityShopBuyVoice", bLimit)
    end
    
    self.actShopData:SendActivityShopPurchaseReq(self.nShopId, self.mapData.nId, self.nBuyCount, callback)
  end
  
  local function buy_confirm()
    local nAll = self.mapGoodsCfg.ItemQuantity * self.nBuyCount
    local sTip = 1 < nAll and orderedFormat(ConfigTable.GetUIText("Shop_MultiBuyComfirm"), nCost, sName, nAll, self.mapGoodsCfg.Name) or orderedFormat(ConfigTable.GetUIText("Shop_BuyComfirm"), nCost, sName, self.mapGoodsCfg.Name)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = buy,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local nItemId = self.mapGoodsCfg.ItemId
  local mapCfg = ConfigTable.GetData_Item(nItemId)
  local sTip
  if mapCfg then
    if mapCfg.Type == GameEnum.itemType.Disc then
      sTip = PlayerData.Item:GetDiscHoldingState(nItemId, self.nBuyCount)
    elseif mapCfg.Type == GameEnum.itemType.Char then
      sTip = PlayerData.Item:GetCharHoldingState(nItemId, self.nBuyCount)
    elseif mapCfg.Stype == GameEnum.itemStype.CharShard then
      local nCharId = PlayerData.Talent:GetFragmentsToChar(nItemId)
      sTip = PlayerData.Item:GetCharHoldingState(nCharId, 0, self.nBuyCount)
    end
  end
  if sTip then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = buy_confirm,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    buy_confirm()
  end
end

function ActivityShopGoodsDetailCtrl:OnBtnClick_Close()
  EventManager.Hit("ActivityShopCloseDetail")
end

function ActivityShopGoodsDetailCtrl:OnBtnClick_Detail()
  local nItemId = self.mapGoodsCfg.ItemId
  local mapCfg = ConfigTable.GetData_Item(nItemId)
  if not mapCfg then
    return
  end
  if mapCfg.Stype == GameEnum.itemStype.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, nItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.RandomPackage or mapCfg.Stype == GameEnum.itemStype.ComCYO then
    local tbDetailItem, sDetailTitle = PlayerData.Item:GetCYODisplayItem(nItemId)
    local msg = {
      nType = AllEnum.MessageBox.ItemList,
      tbItem = tbDetailItem,
      sTitle = sDetailTitle,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif mapCfg.Stype == GameEnum.itemStype.OutfitCYO then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, nItemId)
  end
end

function ActivityShopGoodsDetailCtrl:OnBtnClick_Disable()
  if self.mapData.bSoldOut then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_GoodsEmpty"))
  elseif not self.mapData.bPurchasable then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_Condition"))
  elseif not self.mapData.bPurchasTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_NotPurchasTime"))
  end
end

return ActivityShopGoodsDetailCtrl
