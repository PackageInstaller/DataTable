local MallShopItemCtrl = class("MallShopItemCtrl", BaseCtrl)
MallShopItemCtrl._mapNodeConfig = {
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
  txtCount = {sComponentName = "TMP_Text"},
  imgCoin = {sComponentName = "Image"},
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  txtPrice = {sComponentName = "TMP_Text"},
  imgMask = {},
  goRestock = {},
  txtRestock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Restock"
  },
  goCondition = {},
  txtCondition = {sComponentName = "TMP_Text"}
}
MallShopItemCtrl._mapEventConfig = {}

function MallShopItemCtrl:Refresh(mapData)
  local mapCfg = ConfigTable.GetData("MallShop", mapData.sId)
  self:RefreshInfo(mapCfg, mapData)
  self:RefreshPrice(mapCfg)
  self:RefreshLimit(mapCfg, mapData)
end

function MallShopItemCtrl:RefreshInfo(mapCfg, mapData)
  local mapItemCfg = ConfigTable.GetData_Item(mapCfg.ItemId)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  if mapItemCfg.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.imgIcon, mapItemCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
  else
    self:SetPngSprite(self._mapNode.imgIcon, mapItemCfg.Icon)
  end
  local sPath = AllEnum.FrameType_New.MallGoods .. AllEnum.FrameColor_New[mapItemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
  local bLimit = mapCfg.Stock > 0
  if bLimit then
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), mapData.nCurStock))
  else
    NovaAPI.SetTMPText(self._mapNode.txtLeft, orderedFormat(ConfigTable.GetUIText("Shop_Left"), ConfigTable.GetUIText("Shop_Unlimited")))
  end
  NovaAPI.SetTMPText(self._mapNode.txtCount, orderedFormat(ConfigTable.GetUIText("Shop_GoodsItem_Count"), mapCfg.ItemQty))
end

function MallShopItemCtrl:RefreshPrice(mapCfg)
  self:SetSprite_Coin(self._mapNode.imgCoin, mapCfg.ExchangeItemId)
  NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.ExchangeItemQty)
end

function MallShopItemCtrl:RefreshTime(mapData)
  self._mapNode.imgTime:SetActive(mapData.bPrioritizeDeList)
  if not mapData.bPrioritizeDeList then
    return
  end
  local sTime
  local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
  if nRemaining <= 3600 and 0 < nRemaining then
    sTime = ConfigTable.GetUIText("Shop_WithinHour")
  elseif 3600 < nRemaining and nRemaining <= 86400 then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Hour") or "", math.floor(nRemaining / 3600))
  elseif 86400 < nRemaining then
    sTime = orderedFormat(ConfigTable.GetUIText("Shop_Day") or "", math.floor(nRemaining / 86400))
  end
  NovaAPI.SetTMPText(self._mapNode.txtLeftTime, sTime)
end

function MallShopItemCtrl:RefreshLimit(mapCfg, mapData)
  local tbCond = decodeJson(mapCfg.OrderCondParams)
  local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
  self._mapNode.imgMask:SetActive(mapData.nCurStock == 0 or not bPurchaseAble)
  if mapData.nCurStock == 0 then
    self._mapNode.goRestock:SetActive(true)
    self._mapNode.goCondition:SetActive(false)
    return
  end
  self._mapNode.goRestock:SetActive(false)
  self._mapNode.goCondition:SetActive(true)
  if not bPurchaseAble then
    local sCond = ""
    if mapCfg.OrderCondType == GameEnum.shopCond.WorldClassSpecific then
      sCond = orderedFormat(ConfigTable.GetUIText("Mall_Cond_WorldClass") or "", tbCond[1])
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sCond)
  end
end

function MallShopItemCtrl:Awake()
end

function MallShopItemCtrl:OnEnable()
end

function MallShopItemCtrl:OnDisable()
end

function MallShopItemCtrl:OnDestroy()
end

return MallShopItemCtrl
