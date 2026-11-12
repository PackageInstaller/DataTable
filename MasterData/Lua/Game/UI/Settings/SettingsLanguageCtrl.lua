local SettingsLanguageCtrl = class("SettingsLanguageCtrl", BaseCtrl)
SettingsLanguageCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Language"
  },
  txtVoiceTittle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Language_Settings"
  },
  Option = {},
  btnPackage = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Package"
  },
  txtPackage = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Language_Package"
  },
  txtBtnPackage = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Go"
  },
  Voice = {
    sCtrlName = "Game.UI.Settings.OptionDynamicCtrl"
  },
  Language = {
    sCtrlName = "Game.UI.Settings.OptionDynamicCtrl"
  }
}
SettingsLanguageCtrl._mapEventConfig = {
  SettingsDownloadLanguage = "OnEvent_DownloadLanguage"
}

function SettingsLanguageCtrl:RefreshText()
  local lan_voc = ConfigTable.GetUIText("Settings_Language_Voice")
  local lan_txt = ConfigTable.GetUIText("Settings_Language_Text")
  local lan_needDownload = ConfigTable.GetUIText("Settings_Language_NeedDownload")
  local lan_downloaded = ConfigTable.GetUIText("Settings_Language_Downloaded")
  local tbText = {}
  tbText[AllEnum.Language.CN] = ConfigTable.GetUIText("Settings_Language_Text_Chinese")
  tbText[AllEnum.Language.JP] = ConfigTable.GetUIText("Settings_Language_Text_Japanese")
  tbText[AllEnum.Language.EN] = ConfigTable.GetUIText("Settings_Language_Text_English")
  tbText[AllEnum.Language.KR] = ConfigTable.GetUIText("Settings_Language_Text_Korean")
  tbText[AllEnum.Language.TW] = ConfigTable.GetUIText("Settings_Language_Text_TraditionalChinese")
  local nTextCount = table.nums(tbText)
  local tbLang = {}
  tbLang[AllEnum.Language.CN] = ConfigTable.GetUIText("Settings_Language_Voice_Chinese")
  tbLang[AllEnum.Language.JP] = ConfigTable.GetUIText("Settings_Language_Voice_Japanese")
  tbLang[AllEnum.Language.EN] = ConfigTable.GetUIText("Settings_Language_Voice_English")
  tbLang[AllEnum.Language.KR] = ConfigTable.GetUIText("Settings_Language_Voice_Korean")
  tbLang[AllEnum.Language.TW] = ConfigTable.GetUIText("Settings_Language_Voice_TraditionalChinese")
  local nLangCount = table.nums(tbLang)
  local textLang = {}
  for i = 1, nTextCount do
    textLang[i] = tbText[self.tbTextAvailable[i]]
  end
  local voLang = {}
  for i = 1, nLangCount do
    voLang[i] = ""
    if self.tbVoAvailable[i] then
      local sPre = tbLang[self.tbVoAvailable[i]]
      local sSuf = self.tbDownload[self.tbVoAvailable[i]].bDownloaded and lan_downloaded or lan_needDownload
      voLang[i] = sPre .. sSuf
    end
  end
  self._mapNode.Voice:SetText(lan_voc, voLang)
  self._mapNode.Language:SetText(lan_txt, textLang)
end

function SettingsLanguageCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
  self:RefreshText()
end

function SettingsLanguageCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsLanguageCtrl:LoadSetting()
  local tbTextAvailable = NovaAPI.GetAvailable_TextLanguage()
  local tbVoAvailable = NovaAPI.GetAvailable_VoLanguage()
  self.tbTextAvailable, self.tbVoAvailable, self.tbDownload = {}, {}, {}
  for i = 0, tbTextAvailable.Length - 1 do
    table.insert(self.tbTextAvailable, tbTextAvailable[i])
  end
  for i = 0, tbVoAvailable.Length - 1 do
    local sVoLan = tbVoAvailable[i]
    table.insert(self.tbVoAvailable, sVoLan)
    local bDownloaded, nTotalSize, nNeedDownloadSize = NovaAPI.HasDownload_VoLanguage(sVoLan)
    self.tbDownload[sVoLan] = {
      bDownloaded = bDownloaded,
      nTotalSize = nTotalSize,
      nNeedDownloadSize = nNeedDownloadSize
    }
  end
  local sCurrentTxtLanguage = NovaAPI.GetCur_TextLanguage()
  local sCurrentVoLanguage = NovaAPI.GetCur_VoiceLanguage()
  self.nVoLang = table.indexof(self.tbVoAvailable, sCurrentVoLanguage)
  self.nTextLang = table.indexof(self.tbTextAvailable, sCurrentTxtLanguage)
  self._mapNode.Voice:Init(function(index)
    NovaAPI.SetCur_VoiceLanguage(self.tbVoAvailable[index])
    Settings.sCurrentVoLanguage = self.tbVoAvailable[index]
    self.nVoLang = index
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "set",
      "vocie_language"
    })
    table.insert(tab, {
      "arg",
      tostring(index)
    })
    NovaAPI.UserEventUpload("setting_choice", tab)
  end, self.nVoLang, #self.tbVoAvailable, nil, true)
  self._mapNode.Language:Init(function(index)
    NovaAPI.SetCur_TextLanguage(self.tbTextAvailable[index])
    Settings.sCurrentTxtLanguage = self.tbTextAvailable[index]
    self.nTextLang = index
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    table.insert(tab, {
      "set",
      "game_language"
    })
    table.insert(tab, {
      "arg",
      tostring(index)
    })
    NovaAPI.UserEventUpload("setting_choice", tab)
    PanelManager.OnConfirmBackToLogIn()
  end, self.nTextLang, #self.tbTextAvailable, ConfigTable.GetUIText("Settings_Language_BackConfirm"))
  
  local function gray(tbAvailable)
    local tbGray = {}
    for k, v in ipairs(tbAvailable) do
      if not self.tbDownload[v].bDownloaded then
        tbGray[k] = true
      end
    end
    return tbGray
  end
  
  self._mapNode.Voice:SetGray(gray(self.tbVoAvailable), ConfigTable.GetUIText("Settings_VoiceGrayTips"))
  if self.tbVoAvailable ~= nil and 1 >= #self.tbVoAvailable then
    self._mapNode.Option:SetActive(false)
    local languageTra = self._mapNode.Language.gameObject.transform
    local goLanLine = languageTra:Find("line").gameObject
    goLanLine:SetActive(false)
  end
end

function SettingsLanguageCtrl:SaveSetting()
end

function SettingsLanguageCtrl:Awake()
  self.bInit = false
end

function SettingsLanguageCtrl:OnEnable()
end

function SettingsLanguageCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
end

function SettingsLanguageCtrl:OnDestroy()
end

function SettingsLanguageCtrl:OnBtnClick_Package()
  EventManager.Hit("SettingsLanguage", self.tbVoAvailable, self.tbDownload)
end

function SettingsLanguageCtrl:OnEvent_DownloadLanguage()
end

return SettingsLanguageCtrl
