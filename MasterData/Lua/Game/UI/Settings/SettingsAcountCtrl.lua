local SettingsAcountCtrl = class("SettingsAcountCtrl", BaseCtrl)
local UIGameSystemSetup = CS.UIGameSystemSetup
local SDKManager = CS.SDKManager.Instance
SettingsAcountCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account"
  },
  btnLogout = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Logout"
  },
  txtBtnLogout = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Logout"
  },
  txtSecurity = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account_Security"
  },
  txtCenter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account_Center"
  },
  btnCenter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Center"
  },
  txtBtnCenter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Go"
  },
  userCenter = {
    sNodeName = "Option_UserCenter"
  },
  txtGem = {sComponentName = "TMP_Text"},
  btnGem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GemDetail"
  },
  txtBtnGem = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Detail"
  },
  option_gem = {sNodeName = "Option_Gem"},
  List_PlayerAcc = {
    sComponentName = "LayoutElement"
  },
  txtUserAgreement = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account_UserAgreement"
  },
  Agreement = {nCount = 4},
  txtBtnAgreement = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Read"
  },
  List_Agreement = {
    sComponentName = "LayoutElement"
  }
}
SettingsAcountCtrl._mapEventConfig = {
  SDKNotAvailable = "OnEvent_SDKNotAvailable"
}

function SettingsAcountCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
  self:InitStone()
  self:InitAgreement()
end

function SettingsAcountCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsAcountCtrl:InitStone()
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  local channelName = CS.ClientConfig.ClientPublishChannelName
  local line = self._mapNode.userCenter.transform:Find("line")
  local bShowUserCenter = self._panel.ShowUserCenter
  if bShowUserCenter == nil then
    bShowUserCenter = true
  end
  if bShowUserCenter == false then
    self._mapNode.List_PlayerAcc.gameObject:SetActive(false)
  elseif clientPublishRegion == CS.ClientPublishRegion.CN then
    if channelName == "Bilibili" then
      self._mapNode.List_PlayerAcc.gameObject:SetActive(false)
    else
      line.gameObject:SetActive(false)
      self._mapNode.option_gem:SetActive(false)
      self._mapNode.List_PlayerAcc.preferredHeight = 163.9
      self._mapNode.List_PlayerAcc.gameObject:SetActive(true)
    end
  else
    line.gameObject:SetActive(true)
    self._mapNode.option_gem:SetActive(true)
    self._mapNode.List_PlayerAcc.preferredHeight = 264
  end
  local stoneConfig = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
  local str = orderedFormat(ConfigTable.GetUIText("Settings_Account_Gem"), stoneConfig.Title)
  NovaAPI.SetTMPText(self._mapNode.txtGem, str)
end

function SettingsAcountCtrl:InitAgreement()
  for i = 1, 4 do
    self._mapNode.Agreement[i]:SetActive(false)
  end
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN then
    self:InitAgreement_CN()
  elseif clientPublishRegion == CS.ClientPublishRegion.TW then
    self:InitAgreement_TW()
  elseif clientPublishRegion == CS.ClientPublishRegion.JP then
    self:InitAgreement_JP()
  elseif clientPublishRegion == CS.ClientPublishRegion.US then
    self:InitAgreement_US()
  elseif clientPublishRegion == CS.ClientPublishRegion.KR then
    self:InitAgreement_KR()
  else
    self:InitAgreement_CN()
  end
end

function SettingsAcountCtrl:InitAgreement_CN()
  local agreement1 = self._mapNode.Agreement[1]
  local txtAgreement1 = agreement1.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement1:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PrivacyAgreement"))
  local btnAgreement1 = agreement1.transform:Find("btnAgreement")
  local btn1 = btnAgreement1:GetComponent("UIButton")
  btn1.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "privacy_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement1:SetActive(true)
  local agreement2 = self._mapNode.Agreement[2]
  local txtAgreement2 = agreement2.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement2:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_InfoAgreement"))
  local btnAgreement2 = agreement2.transform:Find("btnAgreement")
  local btn2 = btnAgreement2:GetComponent("UIButton")
  btn2.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowWebView(false, ConfigTable.GetUIText("Settings_Account_InfoAgreement"), "https://account.yostar.cn/cn-nova/collect", 1, 0, false, "CN-YOSTAR")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement2:SetActive(true)
  local agreement3 = self._mapNode.Agreement[3]
  local txtAgreement3 = agreement3.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement3:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_CooperationAgreement"))
  local btnAgreement3 = agreement3.transform:Find("btnAgreement")
  local btn3 = btnAgreement3:GetComponent("UIButton")
  btn3.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowWebView(false, ConfigTable.GetUIText("Settings_Account_CooperationAgreement"), "https://account.yostar.cn/cn-nova/shared_list")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement3:SetActive(true)
  local agreement4 = self._mapNode.Agreement[4]
  local txtAgreement4 = agreement4.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement4:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_GameRegistrationNumber"))
  local btnAgreement4 = agreement4.transform:Find("btnAgreement")
  local btn4 = btnAgreement4:GetComponent("UIButton")
  btn4.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowWebView(false, ConfigTable.GetUIText("Settings_Account_GameRegistrationNumber"), "https://beian.miit.gov.cn/#/Integrated/index")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  local line = agreement4.transform:Find("line")
  line.gameObject:SetActive(false)
  agreement4:SetActive(true)
  self._mapNode.List_Agreement.preferredHeight = 489.16
end

function SettingsAcountCtrl:InitAgreement_TW()
  local agreement1 = self._mapNode.Agreement[1]
  local txtAgreement1 = agreement1.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement1:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_UserTerms"))
  local btnAgreement1 = agreement1.transform:Find("btnAgreement")
  local btn1 = btnAgreement1:GetComponent("UIButton")
  btn1.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "user_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement1:SetActive(true)
  local agreement2 = self._mapNode.Agreement[2]
  local txtAgreement2 = agreement2.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement2:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PrivacyPolicy"))
  local btnAgreement2 = agreement2.transform:Find("btnAgreement")
  local btn2 = btnAgreement2:GetComponent("UIButton")
  btn2.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "privacy_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  local line = agreement2.transform:Find("line")
  line.gameObject:SetActive(false)
  agreement2:SetActive(true)
  self._mapNode.List_Agreement.preferredHeight = 244.58
end

function SettingsAcountCtrl:InitAgreement_JP()
  local agreement1 = self._mapNode.Agreement[1]
  local txtAgreement1 = agreement1.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement1:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_UseAgreement"))
  local btnAgreement1 = agreement1.transform:Find("btnAgreement")
  local btn1 = btnAgreement1:GetComponent("UIButton")
  btn1.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "user_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement1:SetActive(true)
  local agreement2 = self._mapNode.Agreement[2]
  local txtAgreement2 = agreement2.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement2:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PrivacyPolicy"))
  local btnAgreement2 = agreement2.transform:Find("btnAgreement")
  local btn2 = btnAgreement2:GetComponent("UIButton")
  btn2.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "privacy_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement2:SetActive(true)
  local agreement3 = self._mapNode.Agreement[3]
  local txtAgreement3 = agreement3.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement3:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_SCTL"))
  local btnAgreement3 = agreement3.transform:Find("btnAgreement")
  local btn3 = btnAgreement3:GetComponent("UIButton")
  btn3.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "specific_commercial_transaction_act"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement3:SetActive(true)
  local agreement4 = self._mapNode.Agreement[4]
  local txtAgreement4 = agreement4.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement4:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PaymentServicesAct"))
  local btnAgreement4 = agreement4.transform:Find("btnAgreement")
  local btn4 = btnAgreement4:GetComponent("UIButton")
  btn4.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "fund_settlement_algorithm"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  local line = agreement4.transform:Find("line")
  line.gameObject:SetActive(false)
  agreement4:SetActive(true)
  self._mapNode.List_Agreement.preferredHeight = 489.16
end

function SettingsAcountCtrl:InitAgreement_US()
  local agreement1 = self._mapNode.Agreement[1]
  local txtAgreement1 = agreement1.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement1:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_UserTerms"))
  local btnAgreement1 = agreement1.transform:Find("btnAgreement")
  local btn1 = btnAgreement1:GetComponent("UIButton")
  btn1.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "user_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement1:SetActive(true)
  local agreement2 = self._mapNode.Agreement[2]
  local txtAgreement2 = agreement2.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement2:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PrivacyPolicy"))
  local btnAgreement2 = agreement2.transform:Find("btnAgreement")
  local btn2 = btnAgreement2:GetComponent("UIButton")
  btn2.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "privacy_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  local line = agreement2.transform:Find("line")
  line.gameObject:SetActive(false)
  agreement2:SetActive(true)
  self._mapNode.List_Agreement.preferredHeight = 244.58
end

function SettingsAcountCtrl:InitAgreement_KR()
  local agreement1 = self._mapNode.Agreement[1]
  local txtAgreement1 = agreement1.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement1:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_UserTerms"))
  local btnAgreement1 = agreement1.transform:Find("btnAgreement")
  local btn1 = btnAgreement1:GetComponent("UIButton")
  btn1.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "user_agreement"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  agreement1:SetActive(true)
  local agreement2 = self._mapNode.Agreement[2]
  local txtAgreement2 = agreement2.transform:Find("txtAgreement")
  NovaAPI.SetTMPText(txtAgreement2:GetComponent("TMP_Text"), ConfigTable.GetUIText("Settings_Account_PrivacyPolicy"))
  local btnAgreement2 = agreement2.transform:Find("btnAgreement")
  local btn2 = btnAgreement2:GetComponent("UIButton")
  btn2.onClick:AddListener(function()
    if SDKManager:IsSDKInit() then
      SDKManager:ShowAgreement({
        "credit_investigation"
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  end)
  local line = agreement2.transform:Find("line")
  line.gameObject:SetActive(false)
  agreement2:SetActive(true)
  self._mapNode.List_Agreement.preferredHeight = 244.58
end

function SettingsAcountCtrl:LoadSetting()
end

function SettingsAcountCtrl:SaveSetting()
end

function SettingsAcountCtrl:Awake()
  self.bInit = false
end

function SettingsAcountCtrl:OnEnable()
end

function SettingsAcountCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
end

function SettingsAcountCtrl:OnDestroy()
end

function SettingsAcountCtrl:OnBtnClick_Center()
  if SDKManager:IsSDKInit() then
    local sDestoryUrl = PlayerData.Base:GetDestoryUrl()
    if sDestoryUrl == "" then
      local function cb(sUrl)
        SDKManager.SDK:ShowUserCenter(sUrl, sUrl)
      end
      
      PlayerData.Base:RequestDestoryUrl(cb)
    else
      SDKManager.SDK:ShowUserCenter(sDestoryUrl, sDestoryUrl)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
  end
end

function SettingsAcountCtrl:OnBtnClick_Logout()
  if SDKManager:IsSDKInit() then
    UTILS.SDK_Logout()
  else
    PanelManager.OnConfirmBackToLogIn()
  end
end

function SettingsAcountCtrl:OnBtnClick_GemDetail()
  EventManager.Hit("Setting_GemDetail")
end

function SettingsAcountCtrl:OnEvent_SDKNotAvailable()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
end

return SettingsAcountCtrl
