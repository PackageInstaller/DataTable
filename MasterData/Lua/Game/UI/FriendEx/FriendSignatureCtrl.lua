local FriendSignatureCtrl = class("FriendSignatureCtrl", BaseCtrl)
FriendSignatureCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_SignTitle"
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
  },
  inputSign = {
    sComponentName = "TMP_InputField",
    callback = "OnValueChanged_Sign"
  },
  txtSignDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_ClickInput"
  },
  txtLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TextLimit"
  },
  txtCurCount = {sComponentName = "TMP_Text"}
}
FriendSignatureCtrl._mapEventConfig = {}

function FriendSignatureCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendSignatureCtrl:Refresh()
  local sSign = PlayerData.Base:GetPlayerSignature()
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputSign, sSign)
  local nCount = string.utf8len(sSign)
  if nCount > self.nMaxSignature then
    NovaAPI.SetTMPText(self._mapNode.txtCurCount, string.format("<color=#BD3059>%d</color>/%d", nCount, self.nMaxSignature))
  else
    NovaAPI.SetTMPText(self._mapNode.txtCurCount, string.format("<color=#264278>%d</color>/%d", nCount, self.nMaxSignature))
  end
end

function FriendSignatureCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendSignatureCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendSignatureCtrl:Close()
  self.gameObject:SetActive(false)
end

function FriendSignatureCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.nMaxSignature = ConfigTable.GetConfigNumber("FriendSignatureMax")
end

function FriendSignatureCtrl:OnEnable()
end

function FriendSignatureCtrl:OnDisable()
end

function FriendSignatureCtrl:OnDestroy()
end

function FriendSignatureCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendSignatureCtrl:OnBtnClick_Confirm(btn)
  local sSign = NovaAPI.GetTMPInputFieldText(self._mapNode.inputSign)
  local sOld = PlayerData.Base:GetPlayerSignature()
  if sSign == sOld then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SignSame"))
    return
  end
  if string.utf8len(sSign) > self.nMaxSignature then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SignLong"))
    return
  end
  if string.find(sSign, "[<>/']") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SignUnableString"))
    sSign = string.gsub(sSign, "<u>", "")
    sSign = string.gsub(sSign, "</u>", "")
    sSign = string.gsub(sSign, "'", "")
    NovaAPI.SetTMPInputFieldText(self._mapNode.inputSign, sSign)
    return
  end
  local bInit = NovaAPI.IsDirtyWordsInit()
  if not bInit then
    NovaAPI.InitDirtyWords()
  end
  if NovaAPI.IsDirtyString(sSign) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SignDirty"))
    return
  end
  
  local function callback()
    EventManager.Hit("FriendClosePop")
    EventManager.Hit("FriendRefreshSign")
  end
  
  PlayerData.Base:SendPlayerSignatureEditReq(sSign, callback)
end

function FriendSignatureCtrl:OnValueChanged_Sign(_, sContent)
  local nCount = string.utf8len(sContent)
  if nCount > self.nMaxSignature then
    NovaAPI.SetTMPText(self._mapNode.txtCurCount, string.format("<color=#BD3059>%d</color>/%d", nCount, self.nMaxSignature))
  else
    NovaAPI.SetTMPText(self._mapNode.txtCurCount, string.format("<color=#264278>%d</color>/%d", nCount, self.nMaxSignature))
  end
end

return FriendSignatureCtrl
