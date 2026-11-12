local MallPackageItemCtrl = class("MallPackageItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
MallPackageItemCtrl._mapNodeConfig = {
  txtName = {sComponentName = "TMP_Text"},
  imgIcon = {sComponentName = "Image"},
  imgBg = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtLimit = {sComponentName = "TMP_Text"},
  imgCurrency = {sComponentName = "Image"},
  goCurrency = {},
  goTime = {},
  goCondition = {},
  goSoldOut = {},
  imgSoldOut = {nCount = 2},
  imgLimit = {nCount = 2},
  txtRefreshTime = {sComponentName = "TMP_Text"},
  txtTime = {sComponentName = "TMP_Text"},
  txtSoldOut = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_SoldOut"
  },
  txtCondition = {sComponentName = "TMP_Text"},
  goSaleRate = {
    sComponentName = "RectTransform"
  },
  fxSaleRate = {sNodeName = "goSaleRate", sComponentName = "UIShiny"},
  txtSaleRate = {sComponentName = "TMP_Text"},
  imgMask = {},
  imgSaleMask = {},
  reddotPkg = {},
  reddotNew = {}
}
MallPackageItemCtrl._mapEventConfig = {}

function MallPackageItemCtrl:Refresh(mapData)
  local mapCfg = ConfigTable.GetData("MallPackage", mapData.sId)
  self.sId = mapData.sId
  self:RefreshInfo(mapCfg)
  self:RefreshPrice(mapCfg)
  self:RefreshLimit(mapCfg, mapData)
  self:RefreshCond(mapCfg, mapData)
  self:RefreshTime(mapCfg, mapData)
  self:RegisterRedDot(mapCfg)
end

function MallPackageItemCtrl:RefreshPrice(mapCfg)
  if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.CurrencyShowPrice))
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
    self._mapNode.goCurrency:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.CurrencyItemQty)
    self:SetPngSprite(self._mapNode.imgCurrency, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Free then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, ConfigTable.GetUIText("Mall_Package_Free"))
  end
end

function MallPackageItemCtrl:RefreshLimit(mapCfg, mapData)
  self._mapNode.imgLimit[1]:SetActive(mapData.nNextRefreshTime > 0 and mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None)
  self._mapNode.imgLimit[2]:SetActive(mapData.nNextRefreshTime > 0 and mapCfg.RefreshType ~= GameEnum.mallPackageRefreshType.None)
  if mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None then
    NovaAPI.SetTMPText(self._mapNode.txtLimit, orderedFormat(ConfigTable.GetUIText("Mall_Package_Limit") or "", mapData.nCurStock, mapCfg.Stock))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Day then
    NovaAPI.SetTMPText(self._mapNode.txtLimit, orderedFormat(ConfigTable.GetUIText("Mall_Package_DayLimit") or "", mapData.nCurStock, mapCfg.Stock))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Week then
    NovaAPI.SetTMPText(self._mapNode.txtLimit, orderedFormat(ConfigTable.GetUIText("Mall_Package_WeekLimit") or "", mapData.nCurStock, mapCfg.Stock))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Month then
    NovaAPI.SetTMPText(self._mapNode.txtLimit, orderedFormat(ConfigTable.GetUIText("Mall_Package_MonthLimit") or "", mapData.nCurStock, mapCfg.Stock))
  end
end

function MallPackageItemCtrl:RefreshInfo(mapCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self:SetPngSprite(self._mapNode.imgBg, mapCfg.IconBg)
  self._mapNode.goSaleRate.gameObject:SetActive(mapCfg.SaleRate ~= 0)
  if mapCfg.SaleRate ~= 0 then
    if mapCfg.SaleRate == -1 then
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, ConfigTable.GetUIText("Mall_Package_Recommend"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, string.format("%s%%", mapCfg.SaleRate))
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goSaleRate)
  end
end

function MallPackageItemCtrl:RefreshTime(mapCfg, mapData)
  local bDisposable = mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None
  self._mapNode.goTime.gameObject:SetActive(mapData.nNextRefreshTime > 0 and bDisposable)
  if mapData.nNextRefreshTime > 0 and bDisposable then
    local sSuffix = mapData.bPrioritizeDeList and ConfigTable.GetUIText("Mall_Package_Delist") or ConfigTable.GetUIText("Mall_Package_Refresh")
    local sPrefix
    local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
    if nRemaining <= 3600 then
      sPrefix = ConfigTable.GetUIText("Mall_Package_WithinHour")
    elseif 3600 < nRemaining and nRemaining <= 86400 then
      sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemaining / 3600))
    elseif 86400 < nRemaining then
      sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemaining / 86400))
    end
    NovaAPI.SetTMPText(self._mapNode.txtTime, sPrefix .. sSuffix)
  end
end

function MallPackageItemCtrl:RefreshCond(mapCfg, mapData)
  local tbCond = decodeJson(mapCfg.OrderCondParams)
  local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
  local bShowMask = mapData.nCurStock == 0 or not bPurchaseAble
  self._mapNode.imgMask:SetActive(bShowMask)
  self._mapNode.imgSaleMask:SetActive(bShowMask)
  NovaAPI.SetComponentEnable(self._mapNode.fxSaleRate, not bShowMask)
  self._mapNode.goCondition:SetActive(not bPurchaseAble)
  self._mapNode.goSoldOut:SetActive(mapData.nCurStock == 0)
  if not bPurchaseAble then
    local sCond = ""
    if mapCfg.OrderCondType == GameEnum.shopCond.WorldClassSpecific then
      sCond = orderedFormat(ConfigTable.GetUIText("Mall_Cond_WorldClass") or "", tbCond[1])
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sCond)
  end
  if mapData.nCurStock == 0 then
    local bDisposable = mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None
    local bTime = 0 < mapData.nNextRefreshTime and not bDisposable
    self._mapNode.imgSoldOut[1]:SetActive(not bTime)
    self._mapNode.imgSoldOut[2]:SetActive(bTime)
    if 0 < mapData.nNextRefreshTime then
      local sPrefix
      local nRemaining = mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
      if nRemaining <= 3600 then
        sPrefix = ConfigTable.GetUIText("Mall_Package_WithinHourRefresh")
      elseif 3600 < nRemaining and nRemaining <= 86400 then
        sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_HourRefresh") or "", math.floor(nRemaining / 3600))
      elseif 86400 < nRemaining then
        sPrefix = orderedFormat(ConfigTable.GetUIText("Mall_Package_DayRefresh") or "", math.floor(nRemaining / 86400))
      end
      NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, sPrefix)
    end
  end
end

function MallPackageItemCtrl:RegisterRedDot(mapCfg)
  RedDotManager.RegisterNode(RedDotDefine.FreePackage, self.sId, self._mapNode.reddotPkg)
  local groupCfg = ConfigTable.GetData("MallPackagePage", mapCfg.GroupId)
  if groupCfg == nil then
    return
  end
  RedDotManager.RegisterNode(RedDotDefine.Mall_Package_New, {
    AllEnum.MallToggle.Package,
    groupCfg.Sort,
    self.sId
  }, self._mapNode.reddotNew)
end

function MallPackageItemCtrl:Awake()
end

function MallPackageItemCtrl:OnEnable()
end

function MallPackageItemCtrl:OnDisable()
end

function MallPackageItemCtrl:OnDestroy()
end

return MallPackageItemCtrl
