local ActivityShopGoodsItemCtrl = class("ActivityShopGoodsItemCtrl", BaseCtrl)
ActivityShopGoodsItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgLeft = {},
  txtLeft = {sComponentName = "TMP_Text"},
  imgTime = {},
  txtLeftTime = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgIcon = {sComponentName = "Image"},
  imgElement = {sComponentName = "Image"},
  imgExpire = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  imgCoin = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  imgMask = {},
  goRestock = {},
  txtRestock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_SoldOut"
  },
  goCondition = {},
  txtCondition = {sComponentName = "TMP_Text"}
}
ActivityShopGoodsItemCtrl._mapEventConfig = {}

function ActivityShopGoodsItemCtrl:Refresh(mapData, nCurrencyItemId)
  self.mapData = mapData
  self.mapGoodsCfg = ConfigTable.GetData("ActivityGoods", mapData.nId)
  if not self.mapGoodsCfg then
    return
  end
  self:RefreshInfo()
  self:RefreshPrice(nCurrencyItemId)
  self:RefreshTime()
  self:RefreshLimit()
end

function ActivityShopGoodsItemCtrl:RefreshInfo()
  local mapItemCfg = ConfigTable.GetData_Item(self.mapGoodsCfg.ItemId)
  if not mapItemCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapGoodsCfg.Name)
  if mapItemCfg.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.imgIcon, mapItemCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
    self._mapNode.imgElement.gameObject:SetActive(true)
    local mapDiscCfgData = ConfigTable.GetData("Disc", self.mapGoodsCfg.ItemId)
    self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", AllEnum.Star_Element[mapDiscCfgData.EET].icon)
  else
    self:SetPngSprite(self._mapNode.imgIcon, mapItemCfg.Icon)
    self._mapNode.imgElement.gameObject:SetActive(false)
  end
  self._mapNode.imgExpire.gameObject:SetActive(mapItemCfg.ExpireType > 0)
  local sPath = "db_swimsuit_shop_" .. AllEnum.FrameColor_New[mapItemCfg.Rarity]
  self:SetActivityAtlasSprite(self._mapNode.imgRare, "Swim", sPath)
  local bLimit = 0 < self.mapData.nMaximumLimit
  if bLimit then
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), self.mapData.nMaximumLimit - self.mapData.nBoughtCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), ConfigTable.GetUIText("Shop_Unlimited")))
  end
  NovaAPI.SetTMPText(self._mapNode.txtCount, orderedFormat(ConfigTable.GetUIText("Shop_GoodsItem_Count"), self.mapGoodsCfg.ItemQuantity))
end

function ActivityShopGoodsItemCtrl:RefreshPrice(nCurrencyItemId)
  self:SetSprite_Coin(self._mapNode.imgCoin, nCurrencyItemId)
  NovaAPI.SetTMPText(self._mapNode.txtPrice, self.mapGoodsCfg.Price)
end

function ActivityShopGoodsItemCtrl:RefreshTime()
  local bTime = self.mapData.bPurchasTime and self.mapData.nNextRefreshTime > 0
  self._mapNode.imgTime:SetActive(bTime)
  if not bTime then
    return
  end
  local sTime = ""
  local nRemaining = self.mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
  if nRemaining <= 3600 and 0 < nRemaining then
    sTime = ConfigTable.GetUIText("Shop_WithinHour")
  elseif 3600 < nRemaining and nRemaining <= 86400 then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Hour"), math.floor(nRemaining / 3600))
  elseif 86400 < nRemaining then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Day"), math.floor(nRemaining / 86400))
  end
  NovaAPI.SetTMPText(self._mapNode.txtLeftTime, sTime)
end

function ActivityShopGoodsItemCtrl:RefreshLimit()
  local bMask = not self.mapData.bPurchasable or not self.mapData.bPurchasTime or self.mapData.bSoldOut
  self._mapNode.imgMask:SetActive(bMask)
  if self.mapData.bSoldOut then
    self._mapNode.goRestock:SetActive(true)
    self._mapNode.goCondition:SetActive(false)
    return
  end
  self._mapNode.goRestock:SetActive(false)
  self._mapNode.goCondition:SetActive(true)
  if self.mapData.nUnlockPurchaseTime > 0 and self.mapData.nUnlockPurchaseTime == self.mapData.nNextRefreshTime then
    local sTime = ""
    local nRemaining = self.mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
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
  if not self.mapData.bPurchasable then
    local sCond = ""
    if self.mapData.nPurchaseCondType == GameEnum.shopCond.WorldClassSpecific then
      sCond = orderedFormat(ConfigTable.GetUIText("Shop_Cond_WorldClass"), self.mapData.tbPurchaseCondParams[1])
    elseif self.mapData.nPurchaseCondType == GameEnum.shopCond.ShopPreGoodsSellOut or self.mapData.nPurchaseCondType == GameEnum.shopCond.ActivityShopPreGoodsSellOut then
      sCond = ConfigTable.GetUIText("Shop_Cond_PreGoodsSellOut")
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sCond)
    return
  end
end

function ActivityShopGoodsItemCtrl:Awake()
end

function ActivityShopGoodsItemCtrl:OnEnable()
end

function ActivityShopGoodsItemCtrl:OnDisable()
end

function ActivityShopGoodsItemCtrl:OnDestroy()
end

return ActivityShopGoodsItemCtrl
