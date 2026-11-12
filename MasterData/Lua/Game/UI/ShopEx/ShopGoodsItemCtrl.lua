local ShopGoodsItemCtrl = class("ShopGoodsItemCtrl", BaseCtrl)
ShopGoodsItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgDiscount = {},
  txtDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Discount"
  },
  imgLeft = {},
  txtLeft = {sComponentName = "TMP_Text"},
  imgTime = {},
  txtLeftTime = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgIcon = {sComponentName = "Image"},
  imgElement = {sComponentName = "Image"},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtCount = {sComponentName = "TMP_Text"},
  imgCoin = {sComponentName = "Image"},
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  txtPrice = {sComponentName = "TMP_Text"},
  imgMask = {},
  goRestock = {},
  txtRestock = {sComponentName = "TMP_Text"},
  goCondition = {},
  txtCondition = {sComponentName = "TMP_Text"}
}
ShopGoodsItemCtrl._mapEventConfig = {}

function ShopGoodsItemCtrl:Refresh(mapData)
  self:RefreshInfo(mapData)
  self:RefreshPrice(mapData)
  self:RefreshTime(mapData)
  self:RefreshLimit(mapData)
end

function ShopGoodsItemCtrl:RefreshInfo(mapData)
  local mapCfg = ConfigTable.GetData_Item(mapData.nItemId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapData.sName)
  if mapCfg.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
    self._mapNode.imgElement.gameObject:SetActive(true)
    self._mapNode.goStar.gameObject:SetActive(true)
    local mapDiscCfgData = ConfigTable.GetData("Disc", mapData.nItemId)
    if mapDiscCfgData then
      self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", AllEnum.Star_Element[mapDiscCfgData.EET].icon)
    end
    local nStar = 6 - mapCfg.Rarity
    self._mapNode.goStar:SetStar(nStar, nStar)
    local bMax = false
    local mapDisc = PlayerData.Disc:GetDiscById(mapData.nItemId)
    if mapDisc then
      local _, nCount = PlayerData.Disc:GetBreakLimitMat(mapData.nItemId)
      if nCount + mapDisc.nStar >= mapDisc.nMaxStar then
        bMax = true
      end
    end
    local bGuideMissionShop = mapData.bGuideMissionShop == true
    if bMax or bGuideMissionShop then
      NovaAPI.SetTMPText(self._mapNode.txtRestock, ConfigTable.GetUIText("Mall_Package_SoldOut"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtRestock, ConfigTable.GetUIText("Shop_Restock"))
    end
  else
    self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
    self._mapNode.imgElement.gameObject:SetActive(false)
    self._mapNode.goStar.gameObject:SetActive(false)
    local bGuideMissionShop = mapData.bGuideMissionShop == true
    if bGuideMissionShop then
      NovaAPI.SetTMPText(self._mapNode.txtRestock, ConfigTable.GetUIText("Mall_Package_SoldOut"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtRestock, ConfigTable.GetUIText("Shop_Restock"))
    end
  end
  local sPath = AllEnum.FrameType_New.ShopGoods .. AllEnum.FrameColor_New[mapCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
  local bLimit = mapData.nMaximumLimit > 0
  if bLimit then
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), mapData.nMaximumLimit - mapData.nBoughtCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), ConfigTable.GetUIText("Shop_Unlimited")))
  end
  NovaAPI.SetTMPText(self._mapNode.txtCount, orderedFormat(ConfigTable.GetUIText("Shop_GoodsItem_Count"), mapData.nItemQuantity))
end

function ShopGoodsItemCtrl:RefreshPrice(mapData)
  self:SetSprite_Coin(self._mapNode.imgCoin, mapData.nCurrencyItemId)
  NovaAPI.SetTMPText(self._mapNode.txtPrice, mapData.nPrice)
  local bSale = mapData.nOriginalPrice > 0
  self._mapNode.imgDiscount:SetActive(bSale)
  self._mapNode.goOrigin:SetActive(bSale)
  if bSale then
    NovaAPI.SetTMPText(self._mapNode.txtOrigin, mapData.nOriginalPrice)
  end
end

function ShopGoodsItemCtrl:RefreshTime(mapData)
  local bTime = mapData.bPurchasTime and mapData.nNextRefreshTime > 0
  self._mapNode.imgTime:SetActive(bTime)
  if not bTime then
    return
  end
  local sTime = ""
  local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
  if nRemaining <= 3600 and 0 < nRemaining then
    sTime = ConfigTable.GetUIText("Shop_WithinHour")
  elseif 3600 < nRemaining and nRemaining <= 86400 then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Hour"), math.floor(nRemaining / 3600))
  elseif 86400 < nRemaining then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Day"), math.floor(nRemaining / 86400))
  end
  NovaAPI.SetTMPText(self._mapNode.txtLeftTime, sTime)
end

function ShopGoodsItemCtrl:RefreshLimit(mapData)
  local bMask = not mapData.bPurchasable or not mapData.bPurchasTime or mapData.bSoldOut
  self._mapNode.imgMask:SetActive(bMask)
  if mapData.bSoldOut then
    self._mapNode.goRestock:SetActive(true)
    self._mapNode.goCondition:SetActive(false)
    return
  end
  self._mapNode.goRestock:SetActive(false)
  self._mapNode.goCondition:SetActive(true)
  if mapData.nUnlockPurchaseTime > 0 and mapData.nUnlockPurchaseTime == mapData.nNextRefreshTime then
    local sTime = ""
    local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
    if nRemaining <= 3600 and 0 < nRemaining then
      sTime = ConfigTable.GetUIText("Shop_WithinHourUnLock")
    elseif 3600 < nRemaining and nRemaining <= 86400 then
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_HourUnLock"), math.floor(nRemaining / 3600))
    elseif 86400 < nRemaining then
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_DayUnLock"), math.floor(nRemaining / 86400))
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sTime)
    return
  end
  if not mapData.bPurchasable then
    local sCond = ""
    if mapData.nPurchaseCondType == GameEnum.shopCond.WorldClassSpecific then
      sCond = orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClass"), mapData.tbPurchaseCondParams[1])
    elseif mapData.nPurchaseCondType == GameEnum.shopCond.ShopPreGoodsSellOut then
      sCond = ConfigTable.GetUIText("Shop_Cond_PreGoodsSellOut")
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sCond)
    return
  end
end

function ShopGoodsItemCtrl:Awake()
end

function ShopGoodsItemCtrl:OnEnable()
end

function ShopGoodsItemCtrl:OnDisable()
end

function ShopGoodsItemCtrl:OnDestroy()
end

return ShopGoodsItemCtrl
