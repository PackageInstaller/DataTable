local UINCDKeyPanelNode = class("UINCDKeyPanelNode", UIBaseNode)
local cs_MessageCommon = CS.MessageCommon

function UINCDKeyPanelNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_cDKey, self, self.EnterCDKey)
  self.ui.btn_cDKey.onInCDCallBack = BindCallback(self.OnBtnInCDClick)
  UIUtil.AddButtonListener(self.ui.btn_systemCopy, self, self.EnterSystemCopy)
  self:RefreshText2Empty()
end

function UINCDKeyPanelNode:EnterCDKey()
  self.inputCDkey = self.ui.input_cDkey.text
  if string.IsNullOrEmpty(self.inputCDkey) then
    self:ShowErrorTips()
  else
    NetworkManager:GetNetwork(NetworkTypeID.CDKey):SendCDKRedeem(self.inputCDkey)
  end
end

function UINCDKeyPanelNode:OnBtnInCDClick()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(195))
end

function UINCDKeyPanelNode:EnterSystemCopy()
  local copyCDKey = CS.UnityEngine.GUIUtility.systemCopyBuffer
  if string.IsNullOrEmpty(copyCDKey) then
    return
  end
  self.ui.input_cDkey.text = copyCDKey
end

function UINCDKeyPanelNode:ShowErrorTips(errorCode)
  local errorStr = self:TranslationErrorCode(errorCode)
  self.ui.tex_Failed.text = errorStr
  cs_MessageCommon.ShowMessageTips(errorStr, true)
  local isALREADY = errorCode == proto_csmsg_ErrorCode.CDK_NOT_SURPLUS
  local isINVALID = errorCode == proto_csmsg_ErrorCode.CDK_HAS_EXCHANGED
  local isEXPIRED = errorCode == proto_csmsg_ErrorCode.CDK_TIME_EXCEEDED
  if not isALREADY and not isINVALID and not isEXPIRED then
    self.ui.input_cDkey.text = self.inputCDkey
  else
    self.ui.input_cDkey.text = ""
  end
  return true
end

function UINCDKeyPanelNode:TranslationErrorCode(ret)
  local tipId = 193
  if ret == proto_csmsg_ErrorCode.CDK_NOT_SURPLUS then
    tipId = 191
  elseif ret == proto_csmsg_ErrorCode.CDK_HAS_EXCHANGED then
    tipId = 190
  elseif ret == proto_csmsg_ErrorCode.CDK_TIME_EXCEEDED then
    tipId = 192
  end
  return ConfigData:GetTipContent(tipId)
end

function UINCDKeyPanelNode:RefreshText2Empty()
  self.ui.tex_Failed.text = ""
  self.ui.input_cDkey.text = ""
end

return UINCDKeyPanelNode
