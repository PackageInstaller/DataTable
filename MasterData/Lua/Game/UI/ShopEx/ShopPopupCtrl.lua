local ShopPopupCtrl = class("ShopPopupCtrl", BaseCtrl)
ShopPopupCtrl._mapNodeConfig = {
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
    sCtrlName = "Game.UI.ShopEx.ShopGoodsDetailCtrl"
  }
}
ShopPopupCtrl._mapEventConfig = {
  ShopCloseDetail = "OnBtnClick_CloseDetail"
}

function ShopPopupCtrl:Open()
  self._mapNode.TopBar:CreateCoin({
    self.mapData.nCurrencyItemId
  }, true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.Detail:Refresh(self.mapData, self.nShopId)
end

function ShopPopupCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapData = tbParam[1]
    self.nShopId = tbParam[2]
  end
end

function ShopPopupCtrl:OnEnable()
  self:Open()
end

function ShopPopupCtrl:OnDisable()
end

function ShopPopupCtrl:OnDestroy()
end

function ShopPopupCtrl:OnBtnClick_CloseDetail()
  if self._mapNode.Detail.gameObject.activeSelf == false then
    return
  end
  self._mapNode.Detail:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.ShopPopupPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

return ShopPopupCtrl
