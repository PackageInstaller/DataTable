local EquipmentSucBarCtrl = class("EquipmentSucBarCtrl", BaseCtrl)
EquipmentSucBarCtrl._mapNodeConfig = {
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  SuccessBar = {
    sCtrlName = "Game.UI.SuccessBarEx.SuccessBarCtrl"
  },
  goProperty = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  ani1 = {sNodeName = "rt1", sComponentName = "Animator"},
  ani2 = {sNodeName = "rt2", sComponentName = "Animator"},
  ani3 = {sNodeName = "rt3", sComponentName = "Animator"}
}
EquipmentSucBarCtrl._mapEventConfig = {}

function EquipmentSucBarCtrl:Open()
  self:RefreshContent()
  self._mapNode.SuccessBar.gameObject:SetActive(true)
  self._mapNode.SuccessBar:PlayAni(AllEnum.SuccessBar.Blue, self.tbAni)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.8)
end

function EquipmentSucBarCtrl:RefreshContent()
  self.tbAni = {}
  local nAffixId = self._panel.mapData.nAffixId
  local nCharId = self._panel.mapData.nCharId
  local nUpgradeCount = self._panel.mapData.nUpgradeCount
  self._mapNode.goProperty[1]:SetProperty(nAffixId, nCharId, false, nUpgradeCount - 1)
  table.insert(self.tbAni, self._mapNode.ani1)
  table.insert(self.tbAni, self._mapNode.ani2)
  self._mapNode.goProperty[2]:SetProperty(nAffixId, nCharId, false, nUpgradeCount)
  table.insert(self.tbAni, self._mapNode.ani3)
end

function EquipmentSucBarCtrl:Awake()
end

function EquipmentSucBarCtrl:OnEnable()
  self._mapNode.aniBlur.gameObject:SetActive(true)
  self:Open()
end

function EquipmentSucBarCtrl:OnDisable()
end

function EquipmentSucBarCtrl:OnDestroy()
end

function EquipmentSucBarCtrl:OnBtnClick_Close(btn)
  if self._panel.callback then
    self._panel.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentSucBar)
end

return EquipmentSucBarCtrl
