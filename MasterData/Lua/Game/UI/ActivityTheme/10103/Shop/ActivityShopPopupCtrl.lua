local ActivityShopPopupCtrl = class("ActivityShopPopupCtrl", BaseCtrl)
ActivityShopPopupCtrl._mapNodeConfig = {
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
  Detail = {
    sNodeName = "---Detail---",
    sCtrlName = "Game.UI.ActivityTheme.10103.Shop.ActivityShopGoodsDetailCtrl"
  }
}
ActivityShopPopupCtrl._mapEventConfig = {
  ActivityShopCloseDetail = "OnBtnClick_CloseDetail"
}

function ActivityShopPopupCtrl:Open()
  local mapCfg = ConfigTable.GetData("ActivityShop", self.nShopId)
  if not mapCfg then
    return
  end
  self._mapNode.TopBar:CreateCoin({
    mapCfg.CurrencyItemId
  }, true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.Detail:Refresh(self.mapData, self.nShopId, self.nActId)
end

function ActivityShopPopupCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapData = tbParam[1]
    self.nShopId = tbParam[2]
    self.nActId = tbParam[3]
  end
end

function ActivityShopPopupCtrl:OnEnable()
  self:Open()
end

function ActivityShopPopupCtrl:OnDisable()
end

function ActivityShopPopupCtrl:OnDestroy()
end

function ActivityShopPopupCtrl:OnBtnClick_CloseDetail()
  if self._mapNode.Detail.gameObject.activeSelf == false then
    return
  end
  self._mapNode.Detail:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.ShopPopup_10103)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

return ActivityShopPopupCtrl
