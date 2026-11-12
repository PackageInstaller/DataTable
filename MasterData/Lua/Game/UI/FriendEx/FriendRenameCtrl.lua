local FriendRenameCtrl = class("FriendRenameCtrl", BaseCtrl)
FriendRenameCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Rename"
  },
  txtOldName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_OldName"
  },
  txtTimeLimit = {sComponentName = "TMP_Text"},
  txtNameDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_NameDesc"
  },
  txtCurName = {sComponentName = "TMP_Text"},
  inputRename = {
    sComponentName = "TMP_InputField"
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
FriendRenameCtrl._mapEventConfig = {}

function FriendRenameCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendRenameCtrl:Refresh()
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  NovaAPI.SetTMPText(self._mapNode.txtCurName, PlayerData.Base:GetPlayerNickName())
  local sec = ConfigTable.GetConfigNumber("NickNameResetTimeLimit")
  local day = math.ceil(sec / 86400)
  NovaAPI.SetTMPText(self._mapNode.txtTimeLimit, orderedFormat(ConfigTable.GetUIText("Friend_Rename_TimeLimit"), day))
end

function FriendRenameCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendRenameCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendRenameCtrl:Close()
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputRename, "")
  self.gameObject:SetActive(false)
end

function FriendRenameCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function FriendRenameCtrl:OnEnable()
end

function FriendRenameCtrl:OnDisable()
end

function FriendRenameCtrl:OnDestroy()
end

function FriendRenameCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendRenameCtrl:OnBtnClick_Confirm(btn)
  local bCD = PlayerData.Base:CheckRenameCD()
  if bCD then
    return
  end
  local sNewName = NovaAPI.GetTMPInputFieldText(self._mapNode.inputRename)
  local sOldName = PlayerData.Base:GetPlayerNickName()
  if sNewName == "" then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_04"))
    return
  end
  if sNewName == sOldName then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_03"))
    return
  end
  if not NovaAPI.IsChannelString(sNewName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_00"))
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
  if string.find(sNewName, "%d") == 1 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_05"))
    return
  end
  
  local function isFullWidthDigit(s)
    local firstChar = string.sub(s, 1)
    local code = UFT8ToUnicode(firstChar)
    return 65296 <= code and code <= 65305
  end
  
  if isFullWidthDigit(sNewName) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PLAYER_05"))
    return
  end
  
  local function callback()
    EventManager.Hit("FriendClosePop")
    EventManager.Hit("FriendRefreshName")
  end
  
  PlayerData.Base:SendPlayerNameEditReq(sNewName, callback)
end

return FriendRenameCtrl
