local CharSucBarCtrl = class("CharSucBarCtrl", BaseCtrl)
CharSucBarCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  Upgrade = {
    sCtrlName = "Game.UI.SuccessBarEx.CharUpgradeSucCtrl"
  },
  Advance = {
    sCtrlName = "Game.UI.SuccessBarEx.CharAdvanceSucCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
CharSucBarCtrl._mapEventConfig = {}

function CharSucBarCtrl:Open()
  self._mapNode.Upgrade.gameObject:SetActive(self._panel.bUp)
  self._mapNode.Advance.gameObject:SetActive(not self._panel.bUp)
  if self._panel.bUp then
    self._mapNode.Upgrade:Open()
  else
    self._mapNode.Advance:Open()
  end
end

function CharSucBarCtrl:Awake()
end

function CharSucBarCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function CharSucBarCtrl:OnDisable()
end

function CharSucBarCtrl:OnDestroy()
end

function CharSucBarCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.CharSucBar)
end

return CharSucBarCtrl
