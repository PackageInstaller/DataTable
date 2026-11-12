local EquipmentRenameCtrl = class("EquipmentRenameCtrl", BaseCtrl)
EquipmentRenameCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
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
    sLanguageId = "Equipment_Title_PresetRename"
  },
  txtOldName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_OldPresetName"
  },
  txtNameDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_NameDesc"
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
    sLanguageId = "MessageBox_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  }
}
EquipmentRenameCtrl._mapEventConfig = {}

function EquipmentRenameCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function EquipmentRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  NovaAPI.SetTMPText(self._mapNode.txtCurName, self.sCurName)
end

function EquipmentRenameCtrl:PlayInAni()
  self._mapNode.goWindow:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentRenameCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function EquipmentRenameCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentRename)
end

function EquipmentRenameCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
    self.sCurName = tbParam[2]
    self.callback = tbParam[3]
  end
end

function EquipmentRenameCtrl:OnEnable()
  self:Open()
end

function EquipmentRenameCtrl:OnDisable()
end

function EquipmentRenameCtrl:OnDestroy()
end

function EquipmentRenameCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function EquipmentRenameCtrl:OnBtnClick_Confirm(btn)
  local sNewName = NovaAPI.GetTMPInputFieldText(self._mapNode.inputRename)
  if sNewName == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_RenameEmptyTip"))
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
  local nSelect = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  
  local function callback()
    self:PlayOutAni()
    self.callback(sNewName)
  end
  
  PlayerData.Equipment:SendCharGemRenamePresetReq(self.nCharId, nSelect, sNewName, callback)
end

return EquipmentRenameCtrl
