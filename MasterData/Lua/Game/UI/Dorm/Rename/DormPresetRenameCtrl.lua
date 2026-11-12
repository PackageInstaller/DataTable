local DormPresetRenameCtrl = class("DormPresetRenameCtrl", BaseCtrl)
DormPresetRenameCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  txtHint2 = {},
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  aniWindow = {
    sNodeName = "---Rename---",
    sComponentName = "Animator"
  },
  goWindow = {
    sNodeName = "---Rename---"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Rename"
  },
  txtOldName = {sComponentName = "TMP_Text"},
  txtNameDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_NameDesc"
  },
  txtCurName = {sComponentName = "TMP_Text"},
  inputRename = {
    sComponentName = "TMP_InputField"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Cancel"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Cancel"
  }
}
DormPresetRenameCtrl._mapEventConfig = {}

function DormPresetRenameCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function DormPresetRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  NovaAPI.SetTMPText(self._mapNode.txtCurName, self.sCurName)
end

function DormPresetRenameCtrl:PlayInAni()
  self._mapNode.goWindow:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function DormPresetRenameCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function DormPresetRenameCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.DormPresetRenamePanel)
end

function DormPresetRenameCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nRoomId = tbParam[1]
    self.sCurName = tbParam[2]
  end
end

function DormPresetRenameCtrl:OnEnable()
  self._mapNode.txtHint2.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtOldName, ConfigTable.GetUIText("Dorm_RenamePresetTitle"))
  self:Open()
end

function DormPresetRenameCtrl:OnDisable()
end

function DormPresetRenameCtrl:OnDestroy()
end

function DormPresetRenameCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function DormPresetRenameCtrl:OnBtnClick_Confirm(btn)
  local sNewName = NovaAPI.GetTMPInputFieldText(self._mapNode.inputRename)
  if sNewName == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("BUILD_05"))
    return
  end
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  if NovaAPI.IsDirtyString(sNewName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_01"))
    return
  end
  
  local function callback()
    self:PlayOutAni()
  end
  
  PlayerData.PlayerDormData:DormUpdatePresetName(self.nRoomId, sNewName, callback)
end

return DormPresetRenameCtrl
