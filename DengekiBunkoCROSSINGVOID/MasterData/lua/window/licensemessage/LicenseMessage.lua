local WU, DB, REF = require("Common/WindowUtil")(this)
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local PB = require("Common/PbHelper")
local m_isRefuse = false
local m_onDestoryCallback

function SetupWindow()
  WU.BindButtonEvent(REF.UserProtocolLabel, OnClickUserProtocolLabel)
  WU.BindButtonEvent(REF.PrivacyPolicyLabel, OnClickPrivacyPolicyLabel)
  WU.BindButtonEvent(REF.BtnYes, OnClickOk)
  WU.BindButtonEvent(REF.BtnNo, OnClickRefuse)
  UpdateContent()
end

function SetDestoryCallback(callback)
  m_onDestoryCallback = callback
end

function UpdateContent()
  if m_isRefuse then
    REF.BtnOK.gameObject:SetActive(false)
    REF.LabelTitle.UIHtmlLabel.text = WU.GetString("TXLicense_title_hint")
    REF.Message.UIHtmlLabel.text = WU.GetString("TXLicense_refure_hint_message")
    REF.LabelYes.UILabel.text = WU.GetString("WindowSystem_Confirm")
    REF.LabelNo.UILabel.text = WU.GetString("WindowSystem_Cancel")
  else
    REF.BtnOK.gameObject:SetActive(true)
    REF.LabelTitle.UIHtmlLabel.text = WU.GetString("TXLicense_title")
    REF.Message.UIHtmlLabel.text = WU.GetString("TXLicense_message")
    REF.LabelYes.UILabel.text = WU.GetString("WindowLogin_TextAgree")
    REF.LabelNo.UILabel.text = WU.GetString("WindowLogin_TextDecline")
  end
end

function OnClickUserProtocolLabel()
  local contractUrl = PB.all("MsdkUrl"):first().UserProtocol
  WU.OpenUrl(contractUrl)
end

function OnClickPrivacyPolicyLabel()
  local contractUrl = PB.all("MsdkUrl"):first().PrivacyPolicyUrlGuide
  WU.OpenUrl(contractUrl)
end

function StoreIsAccetpLicense(isAccept)
  local preferences = m_configDataManager.GetPreferences()
  preferences.isAcceptLicense = isAccept
  m_configDataManager.SetPreferences(preferences)
end

function OnClickOk()
  StoreIsAccetpLicense(not m_isRefuse)
  WU.RecycleWindow(this)
  if m_onDestoryCallback then
    m_onDestoryCallback()
  end
end

function OnClickRefuse()
  if m_isRefuse then
    m_isRefuse = false
    UpdateContent()
  else
    m_isRefuse = true
    UpdateContent()
  end
end
