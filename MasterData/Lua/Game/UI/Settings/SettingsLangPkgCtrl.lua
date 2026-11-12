local SettingsLangPkgCtrl = class("SettingsLangPkgCtrl", BaseCtrl)
SettingsLangPkgCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Language_Package"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Download"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Back"
  },
  Option = {nCount = 2},
  txtOptionTitle = {nCount = 2, sComponentName = "TMP_Text"},
  txtState = {nCount = 2, sComponentName = "TMP_Text"},
  btnDownload = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Download"
  },
  Checkmark = {nCount = 2, sComponentName = "Animator"},
  txtBackTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_LangPkg_BackTip"
  },
  txtVoJpTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "SwitchToJPLanTips2"
  }
}
SettingsLangPkgCtrl._mapEventConfig = {}

function SettingsLangPkgCtrl:Open(tbVoAvailable, tbDownload)
  self.tbVoAvailable = tbVoAvailable
  self.tbDownload = tbDownload
  self.tbEnableState = {}
  self:Refresh()
  self:PlayInAni()
end

function SettingsLangPkgCtrl:Refresh()
  local nCount = #self.tbVoAvailable
  for i = 1, 2 do
    if i > nCount then
      self._mapNode.Option[i]:SetActive(false)
    else
      self._mapNode.Option[i]:SetActive(true)
      local mapDownloadData = self.tbDownload[self.tbVoAvailable[i]]
      if mapDownloadData.nTotalSize == 0 then
        NovaAPI.SetTMPText(self._mapNode.txtOptionTitle[i], self.tbLang[self.tbVoAvailable[i]])
      else
        local nSize = math.ceil(mapDownloadData.nTotalSize / 1048576)
        NovaAPI.SetTMPText(self._mapNode.txtOptionTitle[i], self.tbLang[self.tbVoAvailable[i]] .. " (" .. nSize .. "MB)")
      end
      local bDownload = mapDownloadData.bDownloaded
      self._mapNode.btnDownload[i].gameObject:SetActive(not bDownload)
      self._mapNode.txtState[i].gameObject:SetActive(bDownload)
      if bDownload then
        NovaAPI.SetTMPText(self._mapNode.txtState[i], ConfigTable.GetUIText("Settings_LangPkg_Downloaded"))
      else
        self.tbEnableState[self.tbVoAvailable[i]] = false
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          self._mapNode.Checkmark[i]:Play("checkmark_out", -1, 1)
        end
        
        cs_coroutine.start(wait)
      end
    end
  end
end

function SettingsLangPkgCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SettingsLangPkgCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function SettingsLangPkgCtrl:Close()
  self.gameObject:SetActive(false)
end

function SettingsLangPkgCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbLang = {}
  self.tbLang[AllEnum.Language.CN] = ConfigTable.GetUIText("Settings_Language_Voice_Chinese")
  self.tbLang[AllEnum.Language.JP] = ConfigTable.GetUIText("Settings_Language_Voice_Japanese")
  self.tbLang[AllEnum.Language.EN] = ConfigTable.GetUIText("Settings_Language_Voice_English")
  self.tbLang[AllEnum.Language.KR] = ConfigTable.GetUIText("Settings_Language_Voice_Korean")
  self.tbLang[AllEnum.Language.TW] = ConfigTable.GetUIText("Settings_Language_Voice_TraditionalChinese")
end

function SettingsLangPkgCtrl:OnEnable()
end

function SettingsLangPkgCtrl:OnDisable()
end

function SettingsLangPkgCtrl:OnDestroy()
end

function SettingsLangPkgCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("SettingsClosePop")
end

function SettingsLangPkgCtrl:OnBtnClick_Confirm(btn)
  if next(self.tbEnableState) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Download_None"))
    return
  end
  local bAllfalse = true
  for _, v in pairs(self.tbEnableState) do
    if v == true then
      bAllfalse = false
      break
    end
  end
  if bAllfalse then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Download_NeedSelect"))
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Settings_LangPkg_BackConfirm"),
    callbackConfirm = function()
      for language, bEnable in pairs(self.tbEnableState) do
        if bEnable then
          NovaAPI.Enable_VoLanguage(language)
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          table.insert(tab, {
            "set",
            "language_manage"
          })
          table.insert(tab, {
            "arg",
            tostring(language)
          })
          NovaAPI.UserEventUpload("setting_choice", tab)
        end
      end
      PanelManager.OnConfirmBackToLogIn()
    end,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function SettingsLangPkgCtrl:OnBtnClick_Download(btn, nIndex)
  self.tbEnableState[self.tbVoAvailable[nIndex]] = not self.tbEnableState[self.tbVoAvailable[nIndex]]
  if self.tbEnableState[self.tbVoAvailable[nIndex]] then
    self._mapNode.Checkmark[nIndex]:SetTrigger("PlayCheckmarkShow")
  else
    self._mapNode.Checkmark[nIndex]:SetTrigger("PlayCheckmarkHide")
  end
end

return SettingsLangPkgCtrl
