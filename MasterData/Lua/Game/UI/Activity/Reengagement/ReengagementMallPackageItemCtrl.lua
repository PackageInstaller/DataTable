local ReengagementMallPackageItemCtrl = class("ReengagementMallPackageItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
ReengagementMallPackageItemCtrl._mapNodeConfig = {
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
  reddotNew = {},
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  }
}
ReengagementMallPackageItemCtrl._mapEventConfig = {}

function ReengagementMallPackageItemCtrl:RefreshReengagement(mapData, bPurchased)
  self.sId = mapData.Id
  self.sStatistical = mapData.StatisticalGroup
  self.bPurchased = bPurchased
  self:RefreshInfo(mapData, bPurchased)
  self:RefreshPrice(mapData)
end

function ReengagementMallPackageItemCtrl:RefreshPrice(mapCfg)
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

function ReengagementMallPackageItemCtrl:RefreshInfo(mapCfg, bPurchased)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetPngSprite(self._mapNode.imgIcon, mapCfg.Icon)
  self:SetPngSprite(self._mapNode.imgBg, mapCfg.IconBg)
  self._mapNode.goSaleRate.gameObject:SetActive(not bPurchased)
  if mapCfg.SaleRate ~= 0 then
    if mapCfg.SaleRate == -1 then
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, ConfigTable.GetUIText("Mall_Package_Recommend"))
    else
      NovaAPI.SetTMPText(self._mapNode.txtSaleRate, string.format("%s%%", mapCfg.SaleRate))
    end
  end
  local sLimit = bPurchased and orderedFormat(ConfigTable.GetUIText("Mall_Package_Limit") or "", 0, 1) or orderedFormat(ConfigTable.GetUIText("Mall_Package_Limit") or "", 1, 1)
  NovaAPI.SetTMPText(self._mapNode.txtLimit, sLimit)
  self._mapNode.imgMask:SetActive(bPurchased)
end

function ReengagementMallPackageItemCtrl:RefreshTime(mapCfg, mapData)
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

function ReengagementMallPackageItemCtrl:RefreshCond(mapData, bPurchased)
  local bShowMask = not bPurchased
  self._mapNode.imgMask:SetActive(bShowMask)
  self._mapNode.imgSaleMask:SetActive(bShowMask)
  NovaAPI.SetComponentEnable(self._mapNode.fxSaleRate, not bShowMask)
  self._mapNode.goCondition:SetActive(not bPurchased)
  self._mapNode.goSoldOut:SetActive(not bPurchased)
  if not bPurchaseAble then
    local sCond = ""
    if mapCfg.OrderCondType == GameEnum.shopCond.WorldClassSpecific then
      sCond = orderedFormat(ConfigTable.GetUIText("Mall_Cond_WorldClass") or "", tbCond[1])
    end
    NovaAPI.SetTMPText(self._mapNode.txtCondition, sCond)
  end
  if bPurchased then
    local bTime = mapData.nNextRefreshTime > 0
    self._mapNode.imgSoldOut[1]:SetActive(not bTime)
    self._mapNode.imgSoldOut[2]:SetActive(bTime)
    if mapData.nNextRefreshTime > 0 then
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

function ReengagementMallPackageItemCtrl:RegisterRedDot(mapCfg)
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

function ReengagementMallPackageItemCtrl:Awake()
end

function ReengagementMallPackageItemCtrl:OnEnable()
end

function ReengagementMallPackageItemCtrl:OnDisable()
end

function ReengagementMallPackageItemCtrl:OnDestroy()
end

function ReengagementMallPackageItemCtrl:OnBtnClick_Buy()
  if self.bPurchased then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mall_Package_SoldOut"))
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.ReengagementMallPopup, self.sId)
end

return ReengagementMallPackageItemCtrl
