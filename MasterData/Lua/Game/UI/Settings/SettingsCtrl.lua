local SettingsCtrl = class("SettingsCtrl", BaseCtrl)
local UIGameSystemSetup = CS.UIGameSystemSetup
local ClientManager = CS.ClientManager.Instance
local InputManager = CS.InputManager
SettingsCtrl._mapNodeConfig = {
  txtWeekDay = {sComponentName = "TMP_Text"},
  txtTime1 = {sComponentName = "TMP_Text"},
  txtTime2 = {sComponentName = "TMP_Text"},
  aniRoot = {
    sNodeName = "----Content----",
    sComponentName = "Animator"
  },
  btnClose = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  Page1 = {
    sCtrlName = "Game.UI.Settings.SettingsAcountCtrl"
  },
  Page2 = {
    sCtrlName = "Game.UI.Settings.SettingsGraphicCtrl"
  },
  Page3 = {
    sCtrlName = "Game.UI.Settings.SettingsSoundCtrl"
  },
  Page4 = {
    sCtrlName = "Game.UI.Settings.SettingsBattleCtrl"
  },
  Page5 = {
    sCtrlName = "Game.UI.Settings.SettingsLanguageCtrl"
  },
  Page6 = {
    sCtrlName = "Game.UI.Settings.SettingsNotificationCtrl"
  },
  Page7 = {
    sCtrlName = "Game.UI.Settings.SettingsKeyboardCtrl"
  },
  Page8 = {
    sCtrlName = "Game.UI.Settings.SettingsGamepadCtrl"
  },
  cgPage = {
    nCount = 8,
    sNodeName = "Page",
    sComponentName = "CanvasGroup"
  },
  trPage = {
    nCount = 8,
    sNodeName = "Page",
    sComponentName = "Transform"
  },
  btnPage = {
    nCount = 8,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Page"
  },
  imgOn = {nCount = 8},
  aniTab = {sNodeName = "---Tab---", sComponentName = "Animator"},
  scTab = {
    sNodeName = "scrollTab",
    sComponentName = "UIScrollToClick"
  },
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePop"
  },
  Language = {
    sNodeName = "---Language---",
    sCtrlName = "Game.UI.Settings.SettingsLangPkgCtrl"
  },
  Resolution = {
    sNodeName = "---Resolution---",
    sCtrlName = "Game.UI.Settings.SettingsResolutionCtrl"
  },
  GemPop = {
    sNodeName = "---Gem---",
    sCtrlName = "Game.UI.Settings.SettingsGemCtrl"
  },
  LogBtn = {sComponentName = "Button"},
  ShowBtn = {sComponentName = "Button"}
}
SettingsCtrl._mapEventConfig = {
  SettingsLanguage = "OnEvent_Language",
  SettingsResolution = "OnEvent_Resolution",
  SettingsClosePop = "OnBtnClick_ClosePop",
  Setting_GemDetail = "OnEvent_Stone"
}

function SettingsCtrl:InitPageState()
  self.pageIndex = 1
  for i = 1, 8 do
    if i == 1 then
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgPage[i], 1)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgPage[i], true)
      self._mapNode.imgOn[i]:SetActive(true)
      self._mapNode["Page" .. i]:Init()
    else
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgPage[i], 0)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgPage[i], false)
      self._mapNode.imgOn[i]:SetActive(false)
    end
  end
  local bMobile = NovaAPI.IsMobilePlatform()
  self._mapNode.btnPage[7].gameObject:SetActive(not bMobile)
  self._mapNode.btnPage[6].gameObject:SetActive(false)
  if bMobile then
    local bAble = false
    self._mapNode.btnPage[8].gameObject:SetActive(bAble)
    self._mapNode.btnPage[5].gameObject.transform:Find("AnimRoot/line").gameObject:SetActive(bAble)
  else
    self._mapNode.btnPage[8].gameObject:SetActive(true)
    self._mapNode.btnPage[5].gameObject.transform:Find("AnimRoot/line").gameObject:SetActive(true)
  end
  self._mapNode.txtTime1.gameObject:SetActive(false)
  self._mapNode.txtTime2.gameObject:SetActive(false)
  self._mapNode.txtWeekDay.gameObject:SetActive(false)
end

function SettingsCtrl:RefreshTime()
  local curTime = ClientManager.serverTimeStamp
  NovaAPI.SetTMPText(self._mapNode.txtTime1, (os.date("%I:%M", curTime)))
  NovaAPI.SetTMPText(self._mapNode.txtTime2, (os.date("%p", curTime)))
  NovaAPI.SetTMPText(self._mapNode.txtWeekDay, ConfigTable.GetUIText("Settings_Weekday" .. tonumber(os.date("%w")) + 1))
end

function SettingsCtrl:Awake()
end

function SettingsCtrl:OnEnable()
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:InitPageState()
  self._mapNode.ShowBtn.gameObject:SetActive(false)
  self._mapNode.LogBtn.gameObject:SetActive(false)
  EventManager.Hit("PlayerLog", self._mapNode.LogBtn)
  EventManager.Hit("ShowSettingsG", self._mapNode.ShowBtn)
end

function SettingsCtrl:OnDisable()
  local nUID = PlayerData.Base:GetPlayerId()
  CS.InputManager.Instance:SaveBindingOverrides(nUID)
end

function SettingsCtrl:OnDestroy()
end

function SettingsCtrl:OnBtnClick_Close()
  self._mapNode.aniRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.Settings)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function SettingsCtrl:OnBtnClick_Page(btn, index)
  if self.pageIndex == index then
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgPage[self.pageIndex], 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgPage[self.pageIndex], false)
  self._mapNode.imgOn[self.pageIndex]:SetActive(false)
  self._mapNode["Page" .. self.pageIndex]:Quit()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgPage[index], 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgPage[index], true)
  self._mapNode.imgOn[index]:SetActive(true)
  self._mapNode["Page" .. index]:Init()
  self._mapNode.aniTab:Play("Tab_btnPage" .. index)
  self.pageIndex = index
  self._mapNode.scTab:ScrollToClick(btn.gameObject, 0.1)
  local scrollRect = self._mapNode.trPage[index]:Find("sv"):GetComponent("ScrollRect")
  NovaAPI.SetVerticalNormalizedPosition(scrollRect, 1)
end

function SettingsCtrl:OnBtnClick_ClosePop()
  if self.ctrlPop then
    self.ctrlPop:PlayOutAni()
    self.ctrlPop = nil
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function SettingsCtrl:OnEvent_Language(tbVoAvailable, tbDownload)
  self.ctrlPop = self._mapNode.Language
  self._mapNode.Language:Open(tbVoAvailable, tbDownload)
  self._mapNode.blur:SetActive(true)
end

function SettingsCtrl:OnEvent_Resolution(nResolution, tbResolution)
  self.ctrlPop = self._mapNode.Resolution
  self._mapNode.Resolution:Open(nResolution, tbResolution)
  self._mapNode.blur:SetActive(true)
end

function SettingsCtrl:OnEvent_Stone()
  self.ctrlPop = self._mapNode.GemPop
  self._mapNode.GemPop:Open()
  self._mapNode.blur:SetActive(true)
end

function SettingsCtrl:OnEvent_DeviceChange(changeType)
  if not NovaAPI.IsMobilePlatform() then
    return
  end
  if changeType.value__ == 0 then
    local nType = InputManager.Instance:CheckGamepadType()
    if nType == InputManager.GamepadType.PS or nType == InputManager.GamepadType.XBox then
      self._mapNode.btnPage[8].gameObject:SetActive(true)
      self._mapNode.btnPage[5].gameObject.transform:Find("AnimRoot/line").gameObject:SetActive(true)
    end
  elseif changeType.value__ == 1 then
    self._mapNode.btnPage[8].gameObject:SetActive(false)
    self._mapNode.btnPage[5].gameObject.transform:Find("AnimRoot/line").gameObject:SetActive(false)
    if self.pageIndex == 8 then
      self:OnBtnClick_Page(self._mapNode.btnPage[1], 1)
    end
  end
end

return SettingsCtrl
