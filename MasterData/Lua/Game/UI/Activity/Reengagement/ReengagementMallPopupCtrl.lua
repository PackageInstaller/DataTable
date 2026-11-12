local ReengagementMallPopupCtrl = class("ReengagementMallPopupCtrl", BaseCtrl)
ReengagementMallPopupCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseDatail = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_CloseDetail"
  },
  PackageDetail = {
    sNodeName = "---PackageDetail---",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementMallPackageDetailCtrl"
  },
  ShopDetail = {
    sNodeName = "---ShopDetail---"
  },
  FurnitureDetail = {
    sNodeName = "---FurnitureDetail---"
  },
  FurnitureSet = {
    sNodeName = "---FurnitureSet---"
  }
}
ReengagementMallPopupCtrl._mapEventConfig = {
  ReengagementMallCloseDetail = "OnBtnClick_CloseDetail",
  MallOrderClear = "OnBtnClick_CloseDetail"
}

function ReengagementMallPopupCtrl:Awake()
  self._mapNode.PackageDetail.gameObject:SetActive(false)
  self._mapNode.ShopDetail:SetActive(false)
  self._mapNode.FurnitureDetail:SetActive(false)
  self._mapNode.FurnitureSet:SetActive(false)
  self._sPackageId = self:GetPanelParam()[1]
end

function ReengagementMallPopupCtrl:OnEnable()
  self._bClosing = false
  self._mapNode.blur:SetActive(true)
  self._mapNode.TopBar:CreateCoin({
    AllEnum.CoinItemId.FREESTONE
  }, true)
  self._mapNode.PackageDetail:Refresh(self._sPackageId)
end

function ReengagementMallPopupCtrl:OnBtnClick_CloseDetail()
  if self._bClosing then
    return
  end
  self._bClosing = true
  if self._mapNode.PackageDetail.gameObject.activeSelf then
    self._mapNode.PackageDetail:PlayOutAni()
  end
  self._mapNode.TopBar.gameObject:SetActive(false)
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.ReengagementMallPopup)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

return ReengagementMallPopupCtrl
