local MallPackageDetailCtrl = import("Game.UI.Mall.MallPackageDetailCtrl")
local ReengagementMallPackageDetailCtrl = class("ReengagementMallPackageDetailCtrl", MallPackageDetailCtrl)

function ReengagementMallPackageDetailCtrl:Refresh(sPackageId)
  self._sPackageId = sPackageId
  local mapCfg = ConfigTable.GetData("ActivityReturneePack", sPackageId)
  if not mapCfg or not PlayerData.Reengagement:GetActIsOpen() then
    self:OnBtnClick_Close()
    return
  end
  local bPurchased = table.indexof(PlayerData.Reengagement:GetPurchasedBundles(), sPackageId) > 0
  local mapData = {
    nCurStock = bPurchased and 0 or 1,
    nNextRefreshTime = PlayerData.Reengagement:GetReengagementCloseTime(),
    bPrioritizeDeList = true
  }
  self:PlayInAni()
  self:RefreshInfo(mapCfg)
  self:RefreshPrice(mapCfg)
  self:RefreshLimit(mapCfg, mapData)
  self:RefreshTime(mapData)
  self:RefreshItem(mapCfg)
  self:RefreshBuy(mapCfg, mapData)
end

function ReengagementMallPackageDetailCtrl:RefreshLimit(mapCfg, mapData)
  NovaAPI.SetTMPText(self._mapNode.txtLimit, mapData.nCurStock .. "/1")
  NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_LimitTitle"))
end

function ReengagementMallPackageDetailCtrl:OnBtnClick_Buy()
  if not PlayerData.Reengagement:GetActIsOpen() then
    self:OnBtnClick_Close()
    return
  end
  local mapCfg = ConfigTable.GetData("ActivityReturneePack", self._sPackageId)
  if not mapCfg then
    return
  end
  if table.indexof(PlayerData.Reengagement:GetPurchasedBundles(), self._sPackageId) > 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mall_Package_SoldOut"))
    return
  end
  if not PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, decodeJson(mapCfg.OrderCondParams)) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_Condition"))
    return
  end
  PlayerData.Mall:BuyReengagementPackage(self._sPackageId, mapCfg.StatisticalGroup)
end

function ReengagementMallPackageDetailCtrl:OnBtnClick_Close()
  EventManager.Hit("ReengagementMallCloseDetail")
end

return ReengagementMallPackageDetailCtrl
