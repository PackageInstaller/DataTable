local ShopGoodsDetailCtrl = class("ShopGoodsDetailCtrl", BaseCtrl)
ShopGoodsDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  goItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  goDiscStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
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
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  txtPrice = {sComponentName = "TMP_Text"},
  imgDiscount = {},
  txtDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Discount"
  },
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
ShopGoodsDetailCtrl._mapEventConfig = {}

function ShopGoodsDetailCtrl:Refresh(mapData, nShopId)
  self.mapData = mapData
  self.nShopId = nShopId
  self.bAble = self.mapData.bPurchasTime and self.mapData.bPurchasable and not self.mapData.bSoldOut
  self:PlayInAni()
  self:RefreshInfo(mapData)
  self:RefreshPrice(mapData)
  self:RefreshBuyState()
  self:RefreshBuyCount()
end

function ShopGoodsDetailCtrl:RefreshInfo(mapData)
  local mapCfg = ConfigTable.GetData_Item(mapData.nItemId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapData.sName)
  self._mapNode.goItem:SetItem(mapData.nItemId, nil, mapData.nItemQuantity, nil, nil, nil, nil, true)
  self._mapNode.goDiscStar.gameObject:SetActive(mapCfg.Type == GameEnum.itemType.Disc)
  if mapCfg.Type == GameEnum.itemType.Disc then
    local nStar = 6 - mapCfg.Rarity
    self._mapNode.goDiscStar:SetStar(nStar, nStar)
  end
  if mapCfg.Type == GameEnum.itemType.Disc or mapCfg.Type == GameEnum.itemType.Char or mapCfg.Type == GameEnum.itemType.CharacterSkin or mapCfg.Stype == GameEnum.itemStype.DormFurniture then
    self._mapNode.txtHas.gameObject:SetActive(false)
  else
    self._mapNode.txtHas.gameObject:SetActive(true)
    local nCount = PlayerData.Item:GetItemCountByID(mapData.nItemId)
    if 999999 < nCount then
      local nFloor = math.floor(nCount / 100)
      local nK = string.format("%.0f", nFloor / 10)
      local sCount = nK .. "k"
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. sCount)
    else
      NovaAPI.SetTMPText(self._mapNode.txtHas, ConfigTable.GetUIText("Shop_Has") .. nCount)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, mapData.sDesc)
  local bLimit = mapData.nMaximumLimit > 0
  if bLimit then
    local nLeft = mapData.nMaximumLimit - mapData.nBoughtCount
    NovaAPI.SetTMPText(self._mapNode.txtStock, orderedFormat(ConfigTable.GetUIText("Shop_Stock"), nLeft))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, nLeft == 0 and Red_Unable or Blue_Dark)
  else
    NovaAPI.SetTMPText(self._mapNode.txtStock, ConfigTable.GetUIText("Shop_Unlimited"))
    NovaAPI.SetTMPColor(self._mapNode.txtStock, Blue_Dark)
  end
  self._mapNode.btnDetail.interactable = mapCfg and (mapCfg.Stype == GameEnum.itemStype.Disc or mapCfg.Stype == GameEnum.itemStype.Char or mapCfg.Stype == GameEnum.itemStype.RandomPackage or mapCfg.Stype == GameEnum.itemStype.ComCYO or mapCfg.Stype == GameEnum.itemStype.OutfitCYO)
end

function ShopGoodsDetailCtrl:RefreshPrice(mapData)
  for i = 1, 2 do
    self:SetSprite_Coin(self._mapNode.imgCoin[i], mapData.nCurrencyItemId)
  end
  NovaAPI.SetTMPText(self._mapNode.txtPrice, mapData.nPrice)
  local bSale = mapData.nOriginalPrice > 0
  self._mapNode.imgDiscount:SetActive(bSale)
  self._mapNode.goOrigin:SetActive(bSale)
  if bSale then
    NovaAPI.SetTMPText(self._mapNode.txtOrigin, mapData.nOriginalPrice)
  end
end

function ShopGoodsDetailCtrl:RefreshBuyCount()
  local nCost = self.nBuyCount * self.mapData.nPrice
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, nCost)
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.mapData.nCurrencyItemId)
  NovaAPI.SetTMPColor(self._mapNode.txtCoinCount, nCost > nHasCoin and Red_Unable or Blue_Normal)
end

function ShopGoodsDetailCtrl:RefreshBuyState()
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
    elseif self.mapData.nPurchaseCondType == GameEnum.shopCond.ShopPreGoodsSellOut then
      NovaAPI.SetTMPText(self._mapNode.txtDisable, ConfigTable.GetUIText("Shop_Cond_PreGoodsSellOut"))
    end
  end
end

function ShopGoodsDetailCtrl:CountMaxBuy()
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.mapData.nCurrencyItemId)
  local nMax = math.floor(nHasCoin / self.mapData.nPrice)
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

function ShopGoodsDetailCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function ShopGoodsDetailCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function ShopGoodsDetailCtrl:Close()
  self.gameObject:SetActive(false)
end

function ShopGoodsDetailCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function ShopGoodsDetailCtrl:OnEnable()
end

function ShopGoodsDetailCtrl:OnDisable()
end

function ShopGoodsDetailCtrl:OnDestroy()
end

function ShopGoodsDetailCtrl:OnBtnClick_Buy()
  local nCost = self.nBuyCount * self.mapData.nPrice
  local nHasCoin = PlayerData.Item:GetItemCountByID(self.mapData.nCurrencyItemId)
  local sName = ConfigTable.GetData_Item(self.mapData.nCurrencyItemId).Title
  if nCost > nHasCoin then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Shop_NotEnough"), sName))
    return
  end
  
  local function buy()
    local function callback()
      EventManager.Hit("ShopRefreshGoods")
      
      EventManager.Hit("ShopCloseDetail")
      local bSale = self.mapData.nOriginalPrice > 0
      local bLimit = 0 < self.mapData.nMaximumLimit or 0 < self.mapData.nDownShelfTime
      EventManager.Hit("ShopBuyVoice", bSale, bLimit)
    end
    
    PlayerData.Shop:SendResidentShopPurchaseReq(self.nShopId, self.mapData.nId, self.nBuyCount, callback)
  end
  
  local function buy_confirm()
    local nAll = self.mapData.nItemQuantity * self.nBuyCount
    local sTip = 1 < nAll and orderedFormat(ConfigTable.GetUIText("Shop_MultiBuyComfirm"), nCost, sName, nAll, self.mapData.sName) or orderedFormat(ConfigTable.GetUIText("Shop_BuyComfirm"), nCost, sName, self.mapData.sName)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = buy,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local mapCfg = ConfigTable.GetData_Item(self.mapData.nItemId)
  local sTip
  if mapCfg.Type == GameEnum.itemType.Disc then
    sTip = PlayerData.Item:GetDiscHoldingState(self.mapData.nItemId, self.nBuyCount)
  elseif mapCfg.Type == GameEnum.itemType.Char then
    sTip = PlayerData.Item:GetCharHoldingState(self.mapData.nItemId, self.nBuyCount)
  elseif mapCfg.Stype == GameEnum.itemStype.CharShard then
    local nCharId = PlayerData.Talent:GetFragmentsToChar(self.mapData.nItemId)
    sTip = PlayerData.Item:GetCharHoldingState(nCharId, 0, self.nBuyCount)
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

function ShopGoodsDetailCtrl:OnBtnClick_Close()
  EventManager.Hit("ShopCloseDetail")
end

function ShopGoodsDetailCtrl:OnBtnClick_Detail()
  local mapCfg = ConfigTable.GetData_Item(self.mapData.nItemId)
  if not mapCfg then
    return
  end
  if mapCfg.Stype == GameEnum.itemStype.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.mapData.nItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.mapData.nItemId)
  elseif mapCfg.Stype == GameEnum.itemStype.RandomPackage or mapCfg.Stype == GameEnum.itemStype.ComCYO then
    local tbDetailItem, sDetailTitle = PlayerData.Item:GetCYODisplayItem(self.mapData.nItemId)
    local msg = {
      nType = AllEnum.MessageBox.ItemList,
      tbItem = tbDetailItem,
      sTitle = sDetailTitle,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif mapCfg.Stype == GameEnum.itemStype.OutfitCYO then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, self.mapData.nItemId)
  end
end

function ShopGoodsDetailCtrl:OnBtnClick_Disable()
  if self.mapData.bSoldOut then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_GoodsEmpty"))
  elseif not self.mapData.bPurchasable then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_Condition"))
  elseif not self.mapData.bPurchasTime then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_NotPurchasTime"))
  end
end

return ShopGoodsDetailCtrl
