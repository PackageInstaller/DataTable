local SettingsPreviewCtrl = class("SettingsPreviewCtrl", BaseCtrl)
SettingsPreviewCtrl._mapNodeConfig = {
  MainView = {
    sCtrlName = "Game.UI.Settings.PreviewMainViewCtrl"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtSliderTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Widescreen_Tips"
  },
  txtSliderCount = {sComponentName = "TMP_Text"},
  Slider = {
    sComponentName = "Slider",
    callback = "OnValueChange_Widescreen"
  }
}
SettingsPreviewCtrl._mapEventConfig = {}

function SettingsPreviewCtrl:Open(nType)
  self._mapNode.MainView:Refresh()
  self.nValue = NovaAPI.GetAdaptedAreaCustomWidth()
  NovaAPI.SetTMPText(self._mapNode.txtSliderCount, self.nValue)
end

function SettingsPreviewCtrl:Awake()
end

function SettingsPreviewCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self:Open()
  end
end

function SettingsPreviewCtrl:OnDisable()
end

function SettingsPreviewCtrl:OnDestroy()
end

function SettingsPreviewCtrl:OnBtnClick_Close()
  NovaAPI.SetSliderValue(self._mapNode.Slider, self.nValue)
  EventManager.Hit(EventId.ClosePanel, PanelId.SettingsPreview)
end

function SettingsPreviewCtrl:OnBtnClick_Confirm()
  EventManager.Hit(EventId.ClosePanel, PanelId.SettingsPreview)
end

function SettingsPreviewCtrl:OnValueChange_Widescreen(_, value)
  local curValue, _ = math.modf(value)
  NovaAPI.SetTMPText(self._mapNode.txtSliderCount, curValue)
end

return SettingsPreviewCtrl
