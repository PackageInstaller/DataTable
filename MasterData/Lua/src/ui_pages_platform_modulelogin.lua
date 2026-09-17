local this = class("moduleLogin", G_UIModuleBase)

function this.bind()
  return {
    appVersionText = nil,
    resVersionText = nil,
    dev_box = true,
    dev_ipToggleValue = false,
    dev_InterimValue = false,
    versionText = "",
    mainUi = true,
    sdkLogging = false
  }
end

function this.methods()
  return {
    onClickAgeMark = function(self)
      self:refreshStatus(false)
      local data = {
        txtTitle = L_WordsTpl:getTplById("login_age_tip_title"),
        hideCancel = true,
        hideConfirm = true,
        txtContent = L_WordsTpl:getTplById("notice_login_agetips_1")
      }
      L_UI:open("pageTextNoticeWindow", data)
    end,
    dev_onInputIPMethodToggleChanged = function(self, isOn)
      self:setIpInputShow(isOn)
    end,
    dev_onInterimStateToggleChanged = function(self, isOn)
      self:setInterim(isOn)
    end,
    dev_onClickShowDebugToggleButton = function(self)
      C_MJLog.LogInfo("Debug GM Click")
      if self._showDebugToggleButtonClickCount == nil then
        self._showDebugToggleButtonClickCount = 0
      end
      self._showDebugToggleButtonClickCount = self._showDebugToggleButtonClickCount + 1
      if self._showDebugToggleButtonClickCount >= 10 then
        self._showDebugToggleButtonClickCount = 0
        C_MJLog.LogInfo("Debug GM Open")
        CS.Lens.Tools.RuntimeDebug.RuntimeDebugActionHelper.SetTouchToggleActive(true)
      end
    end,
    onClick_startBtn = function(self)
      self:startGame()
      self.isStartClick = true
    end,
    onClick_startBtnGamepad = function(self)
      self:startGame()
      self.isStartClick = true
    end,
    onEnter_startBtn = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Login_Begin_Enter")
    end,
    onExit_starBtn = function(self)
      if self.isStartClick then
        return
      end
      L_AudioUtil.playSound("Play_SFX_System_UI_Login_Begin_Exit")
    end,
    onClick_settingBtn = function(self)
      L_UI:open("pageOption")
    end,
    onClick_checkBtn = function(self)
      self:refreshStatus(false)
      C_GameUtil.EnterLoginResourceCheckPrecheck()
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("title_notice_option_ifcheckintegrity"),
        txtContent = L_WordsTpl:getValue("rescheck_start_tips1"),
        confirmCallback = function()
          self._resCheckFirstTipConfirmed = true
          self:startResPackageVerify()
        end,
        pageClosedCallback = function()
          if self._resCheckFirstTipConfirmed then
            self._resCheckFirstTipConfirmed = false
            return
          end
          C_GameUtil.CancelLoginResourceCheckPrecheck(function()
            self:refreshStatus(true)
          end)
        end
      })
    end,
    onClick_clearBtn = function(self)
      self:refreshStatus(false)
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("title_notice_login_clear"),
        txtContent = L_WordsTpl:getValue("notice_login_clear"),
        confirmCallback = function()
          C_PlayerPrefsUtility.DeleteAll()
        end
      })
    end,
    onClick_announceBtn = function(self)
      self:tryShowGameAnnounce()
    end,
    onClick_logoutBtn = function(self)
      self:refreshStatus(false)
      L_GameUtil.showCommonTip({
        txtTitle = L_WordsTpl:getValue("title_notice_login_exit"),
        txtContent = L_WordsTpl:getValue("notice_login_exit"),
        confirmCallback = function()
          C_LoginManager:ExitGame()
        end
      })
    end,
    onClick_sdkBtn = function(self)
      C_LoginManager.SdkLogout()
    end,
    onClick_starBtnScope = function(self)
      if C_GameUtil.IsLoginResourceCheckFlowActive and C_GameUtil.IsLoginResourceCheckFlowActive() then
        return
      end
      self:startGame()
      self.isStartClick = true
    end,
    onDown_starBtnScope = function(self)
      if self.bindComponents and self.bindComponents.startBtn_anim then
        self.bindComponents.startBtn_anim:SetTrigger("Highlighted")
      end
    end,
    onUp_starBtnScope = function(self)
      if self.bindComponents and self.bindComponents.startBtn_anim then
        self.bindComponents.startBtn_anim:SetTrigger("Normal")
      end
    end
  }
end

local function safeLogResCheckEvent(phase)
  local ok, err = pcall(function()
    L_GameUtil.logEvent(L_Const.logEventName.client_verify_resource, {verify_phase = phase})
  end)
  if not ok then
    C_MJLog.LogWarning("[LoginResCheck] logEvent verify_phase=" .. tostring(phase) .. " failed: " .. tostring(err))
  end
end

function this:startResPackageVerify()
  C_GameUtil.BeginLoginResourceCheck(function(_)
  end, function(code)
    local contentKey
    if code == 0 then
      contentKey = "rescheck_finish_tips1"
    elseif C_AppConfigManager.Platform == C_EAppPlatform.IOS then
      contentKey = "rescheck_finish_tips3"
    else
      contentKey = "rescheck_finish_tips2"
    end
    local tipData = {
      txtTitle = L_WordsTpl:getValue("title_notice_option_ifcheckintegrity"),
      txtContent = L_WordsTpl:getValue(contentKey),
      pageClosedCallback = function()
        C_GameUtil.EndLoginResourceCheck(function()
          self:refreshStatus(true)
        end)
      end,
      cancelCallback = function()
      end,
      confirmCallback = function()
        if code ~= 0 then
          C_GameUtil.SetLoginResourceCheckSkipRestore(true)
          C_GameUtil.QuitAndRestartAppFromLogin()
        end
      end
    }
    if code == 0 then
      tipData.hideCancel = true
    end
    L_GameUtil.showCommonTip(tipData)
    safeLogResCheckEvent(2)
  end)
  safeLogResCheckEvent(1)
end

function this:show()
  C_InputManager.SetGamepadUIInputMap("moduleLogin", true)
end

function this:open(options)
  self.bind.appVersionText = string.format("AppVer: %s", C_InfoManager.AppVersion)
  self.bind.resVersionText = string.format("ResVer: %s", C_InfoManager.AssetVersion)
  if L_DeviceTpl:getIsPc() then
    self.bind.versionText = L_WordsTpl:getValue("copyright_information_pc_text")
  else
    self.bind.versionText = L_WordsTpl:getValue("copyright_information_mobile_text")
  end
  self:initPlaySaveData()
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.moduleDownload.gameObject:ActiveTrans(false)
  else
    self:initModuleDownload()
  end
  
  function self._loginBeginHandle(sdkData)
    self:onLoginUiShow(false)
  end
  
  function self._loginEndHandle(sdkData)
    self:onLoginUiShow(true)
  end
  
  C_MJSDKManager.AddListener(C_EMJSDKType.BeginLogin, self._loginBeginHandle)
  C_MJSDKManager.AddListener(C_EMJSDKType.Login, self._loginEndHandle)
end

function this:close()
  C_MJSDKManager.RemoveListener(C_EMJSDKType.BeginLogin, self._loginBeginHandle)
  C_MJSDKManager.RemoveListener(C_EMJSDKType.Login, self._loginEndHandle)
  C_InputManager.SetGamepadUIInputMap("moduleLogin", false)
end

function this:onLoginUiShow(show)
  self.bind.mainUi = show
  self.bind.sdkLogging = not show
end

function this:initPlaySaveData()
  local isDev = C_LoginManager.GetIsDevLogin()
  self.bind.dev_box = isDev
  local isOnIp = L_SettingStore:getPrefsInt(L_Const.prefsKey.selectIPButton) == 1
  self.bind.dev_ipToggleValue = isOnIp
  self:setIpInputShow(isOnIp)
  local isInterim = L_SettingStore:getPrefsInt(L_Const.prefsKey.selectInterim) == 1
  self.bind.dev_InterimValue = isInterim
  self:setInterim(isInterim)
end

function this:setIpInputShow(isOn)
  L_SettingStore:setPrefsInt(L_Const.prefsKey.selectIPButton, isOn and 1 or 0)
end

function this:setInterim(isOn)
  C_LoginManager.SetIsOpenInterim(isOn)
  L_SettingStore:setPrefsInt(L_Const.prefsKey.selectInterim, isOn and 1 or 0)
end

function this:tryShowNotice(force)
  local notice = L_NoticeStore:getLoginNotice()
  if notice == nil then
    return
  end
  if not force then
    local read = L_NoticeStore:isNoticeRead(notice.id)
    if read then
      return
    end
  end
  self:refreshStatus(false)
  local data = {
    txtTitle = notice.title,
    txtContent = L_LoginPlatformManager:convertHtmlTag(notice.content),
    hideCancel = true,
    hideConfirm = true
  }
  L_UI:open("pageTextNoticeWindow", data)
  L_NoticeStore:setNoticeReadMark(notice.id, true, true)
end

function this:tryShowGameAnnounce()
  self:refreshStatus(false)
  L_UI:open("pageAnnouncementLogin", {
    announcementShowType = L_Const.AnnouncementShowType.OnlySystem,
    fromLogin = true
  })
end

function this:startGame()
  if C_GameUtil.IsLoginResourceCheckFlowActive and C_GameUtil.IsLoginResourceCheckFlowActive() then
    return
  end
  C_LoginManager.SdkLoginin()
end

function this:initModuleDownload()
  local addModuleDownload = xlua.get_generic_method(self.parent.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleDownload(CS.Lens.Gameplay.UI.ModuleDownload, CS.UnityEngine.GameObject)
  self.moduleDownload = addModule(self.parent.csharpPage, self.parent.csharpPage, self.bindComponents.moduleDownload.gameObject)
end

function this:refreshStatus(active)
  local navMgr = self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UINavigationBinding))
  if navMgr then
    navMgr.navigationEnabled = active
  end
  C_InputManager.SetGamepadUIInputMap("moduleLogin", active)
  if self.onPageHideHandle then
    CS.Azur.Gameplay.UI.UIManager.UnregisterEvent(CS.Azur.Gameplay.UI.EUIStatus.Hide, self.onPageHideHandle)
    if active then
      self.onPageHideHandle = nil
    end
  end
  if not active then
    self.onPageHideHandle = self.onPageHideHandle or handler(self, self.onPageHide)
    CS.Azur.Gameplay.UI.UIManager.RegisterEvent(CS.Azur.Gameplay.UI.EUIStatus.Hide, self.onPageHideHandle)
  end
end

function this:onPageHide(e, args)
  local pageName = args:GetString(0)
  local candidates = {
    "pageTextNoticeWindow",
    "pageAnnouncementLogin",
    "pageCommonTip"
  }
  local found = false
  for _, value in ipairs(candidates) do
    if value == pageName then
      found = true
      break
    end
  end
  if found then
    if C_GameUtil.IsLoginResourceCheckFlowActive and C_GameUtil.IsLoginResourceCheckFlowActive() then
      return
    end
    self:refreshStatus(true)
  end
end

return this
