local TraceHuntSucBarCtrl = class("TraceHuntSucBarCtrl", BaseCtrl)
TraceHuntSucBarCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  Upgrade = {
    sCtrlName = "Game.UI.SuccessBarEx.TraceHuntUpgradeSucCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
TraceHuntSucBarCtrl._mapEventConfig = {}

function TraceHuntSucBarCtrl:Open()
  self._mapNode.Upgrade.gameObject:SetActive(true)
  self._mapNode.Upgrade:Open()
end

function TraceHuntSucBarCtrl:Awake()
  self._mapNode.Upgrade.gameObject:SetActive(false)
end

function TraceHuntSucBarCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function TraceHuntSucBarCtrl:OnDisable()
end

function TraceHuntSucBarCtrl:OnDestroy()
end

function TraceHuntSucBarCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.TraceHuntSucBar)
end

return TraceHuntSucBarCtrl
