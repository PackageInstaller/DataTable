local DiscSucBarCtrl = class("DiscSucBarCtrl", BaseCtrl)
DiscSucBarCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  Upgrade = {
    sCtrlName = "Game.UI.SuccessBarEx.DiscUpgradeSucCtrl"
  },
  Advance = {
    sCtrlName = "Game.UI.SuccessBarEx.DiscAdvanceSucCtrl"
  },
  BreakLimit = {
    sCtrlName = "Game.UI.SuccessBarEx.DiscStarSucCtrl"
  },
  BreakLimitAll = {
    sCtrlName = "Game.UI.SuccessBarEx.DiscBreakLimitAllSucCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
DiscSucBarCtrl._mapEventConfig = {}

function DiscSucBarCtrl:Open()
  self._mapNode.Upgrade.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscSucBar.Upgrade)
  self._mapNode.Advance.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscSucBar.Advance)
  self._mapNode.BreakLimit.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscSucBar.BreakLimit)
  self._mapNode.BreakLimitAll.gameObject:SetActive(self._panel.nCurTog == AllEnum.DiscSucBar.BreakLimitAll)
  if self._panel.nCurTog == AllEnum.DiscSucBar.Upgrade then
    self._mapNode.Upgrade:Open()
  elseif self._panel.nCurTog == AllEnum.DiscSucBar.Advance then
    self._mapNode.Advance:Open()
  elseif self._panel.nCurTog == AllEnum.DiscSucBar.BreakLimit then
    self._mapNode.BreakLimit:Open(AllEnum.SuccessBar.Yellow)
  elseif self._panel.nCurTog == AllEnum.DiscSucBar.BreakLimitAll then
    self._mapNode.BreakLimitAll:Open(AllEnum.SuccessBar.Yellow)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
end

function DiscSucBarCtrl:Awake()
end

function DiscSucBarCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function DiscSucBarCtrl:OnDisable()
end

function DiscSucBarCtrl:OnDestroy()
end

function DiscSucBarCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.DiscSucBar)
end

return DiscSucBarCtrl
