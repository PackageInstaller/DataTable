local BuildRenameCtrl = class("BuildRenameCtrl", BaseCtrl)
BuildRenameCtrl._mapNodeConfig = {
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
    sLanguageId = "Friend_Rename"
  },
  txtOldName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_OldName"
  },
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
BuildRenameCtrl._mapEventConfig = {}

function BuildRenameCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function BuildRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  if self.sCurName ~= nil and self.sCurName ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtCurName, self.sCurName)
  elseif self.mapBuild.sName == "" or self.mapBuild.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtCurName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtCurName, self.mapBuild.sName)
  end
end

function BuildRenameCtrl:PlayInAni()
  self._mapNode.goWindow:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function BuildRenameCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function BuildRenameCtrl:Close()
  EventManager.Hit(EventId.ClosePanel, PanelId.BuildRename)
end

function BuildRenameCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapBuild = tbParam[1]
    self.callback = tbParam[2]
    self.bSkip = tbParam[3]
    self.sCurName = tbParam[4]
  end
end

function BuildRenameCtrl:OnEnable()
  self:Open()
end

function BuildRenameCtrl:OnDisable()
end

function BuildRenameCtrl:OnDestroy()
end

function BuildRenameCtrl:OnBtnClick_Cancel(btn)
  self:PlayOutAni()
end

function BuildRenameCtrl:OnBtnClick_Confirm(btn)
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
  if self.bSkip then
    self:PlayOutAni()
    self.callback(sNewName)
  else
    local function callback()
      self:PlayOutAni()
      
      self.callback(sNewName)
    end
    
    PlayerData.Build:ChangeBuildName(self.mapBuild.nBuildId, sNewName, callback)
  end
end

return BuildRenameCtrl
