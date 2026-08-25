local PatchConst = require("GameLauncher.PatchConst")
local E = require("ejoysdk_lua.ejoysdk")
local ReqMaskView, Super = NewClass("ReqMaskView", BaseView)
ReqMaskView.uiResCls = Panel_ReqMaskResource

function ReqMaskView:ctor()
  Super.ctor(self)
  self._isInLoginScene = SceneMgr.Instance:IsLoginScene()
  self._isShowStory = false
end

function ReqMaskView:OnBuildView()
end

function ReqMaskView:RegisterNotifications()
end

function ReqMaskView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.OpenReqMask, System.fn(self, self._OpenReqMask))
  self:BindEvent(EventMgr.Instance.CloseReqMask, System.fn(self, self._CloseReqMask))
  self:BindEvent(EventMgr.Instance.OpenAnimMask, System.fn(self, self._OpenAnimMask))
  self:BindEvent(EventMgr.Instance.CloseAnimMask, System.fn(self, self._CloseAnimMask))
  self:BindEvent(EventMgr.Instance.OpenClickMask, System.fn(self, self._OpenClickMask))
  self:BindEvent(EventMgr.Instance.CloseClickMask, System.fn(self, self._CloseClickMask))
  self:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self._OnEnterScene))
  self:BindEvent(EventMgr.Instance.GameEvent, System.fn(self, self._OnUpdateShowStory))
  self:BindEvent(EventMgr.Instance.HideWhenCaptureScreen, System.fn(self, self._HideWhenCaptureScreen))
  self:BindEvent(EventMgr.Instance.ShowUserInfoText, System.fn(self, self._SetUserInfoTextShow))
end

function ReqMaskView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Mask:SetActive(false)
  self.ui.AnimMask:SetActive(false)
  self.ui.Text:SetActive(false)
  self:BindTimer(1, -1, System.fn(self, self._OnTimerTick), nil)
  self:BindTimer(1, -1, System.fn(self, self._CheckToHideClickMask), nil)
end

function ReqMaskView:OnExitView()
  Super.OnExitView(self)
end

function ReqMaskView:_OnTimerTick()
  self:_RefreshTimeText()
  self:_RefreshVersionText()
  self:_RefreshUserText()
  self:_RefreshNetDelay()
end

function ReqMaskView:_RefreshVersionText()
  local userText = self:_GetUserText() or ""
  local showVersion = self._isInLoginScene and "" == userText
  self.ui.Text_Ver:SetActive(showVersion)
  if showVersion then
    local pkgInfo = E.get_pkg_info()
    local pkgName = pkgInfo.pkg_name
    local pkgShortName = require("Share.Version.version").GetPkgShortName(pkgName)
    local bundleVersionCode = E.Sysinfo.app_version_code()
    local svnVersion = PatchConst.GetShowVersion()
    local versionText = string.format("%s_%s_%s(%s)", pkgShortName, bundleVersionCode, svnVersion, self:_GetUidOrUtdid())
    self:SetText(self.ui.Text_Ver, versionText)
  end
end

function ReqMaskView:_RefreshUserText()
  local userText = self:_GetUserText()
  self.ui.Text_User:SetActive("" ~= userText)
  if "" ~= userText then
    self:SetText(self.ui.Text_User, userText)
  end
end

function ReqMaskView:_RefreshNetDelay()
  local showLag = DataCenter.gameData.ShowLag
  self.ui.Text_Net:SetActive(showLag)
  if not showLag then
    return
  end
  if self._isShowStory then
    self.ui.Text_Net:SetActive(false)
    return
  end
  if not DataCenter.barrierData.InBattle then
    self.ui.Text_Net:SetActive(false)
    return
  end
  if DataCenter.copiesData.copiesSettleData ~= nil or nil ~= DataCenter.pvpSettleData.win then
    self.ui.Text_Net:SetActive(false)
    return
  end
  if DataCenter.playerData.netDelayTime <= 100 then
    self.ui.Text_Net:SetActive(false)
    return
  end
  self:SetText(self.ui.Text_Net, "   " .. LT.Textf("GMNetText", DataCenter.playerData.netDelayTime))
  local colorStr = "#9BA3A2"
  if DataCenter.playerData.netDelayTime > 100 then
    colorStr = DT.ColorConfig.NetworkDelayYellow.Light
  end
  if DataCenter.playerData.netDelayTime > 200 then
    colorStr = DT.ColorConfig.NetworkDelayRed.Light
  end
  self:SetTextColorByHtml(self.ui.Text_Net, colorStr)
end

function ReqMaskView:_RefreshTimeText()
  local now = TimeUtils.GetServerTime()
  local timeText = TimeUtils.TimestampToString(now, TimeUtils.TimeExactType.HourAndMinute)
  if Binder.OpenConfuseText then
    timeText = ""
  end
  self:SetText(self.ui.Text_Time, timeText)
end

function ReqMaskView:_GetUserText()
  if Binder.OpenConfuseText then
    return ""
  end
  if not DataCenter.playerData.DRole.uid or DataCenter.playerData.DRole.uid <= 0 then
    return ""
  end
  local debugText = ""
  if ApplicationUtils.is_open_gm() then
    local account = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.Account)
    if account then
      debugText = debugText .. "  " .. account
    end
    local serverInfo = LoginMgr.Instance.model:GetCurrServerData()
    if serverInfo and serverInfo.name then
      debugText = debugText .. "  " .. serverInfo.name
    end
    if DataCenter.gameData.serverVersion and type(DataCenter.gameData.serverVersion) == "table" then
      local serverInfoStr = ""
      local configVersion = DataCenter.gameData.serverVersion.config_version
      local serverVersion = DataCenter.gameData.serverVersion.server_version
      local branch = DataCenter.gameData.serverVersion.branch
      if branch then
        serverInfoStr = serverInfoStr .. " " .. branch
      end
      if configVersion then
        serverInfoStr = serverInfoStr .. " cfg:" .. configVersion
      end
      if serverVersion then
        serverInfoStr = serverInfoStr .. " svr:" .. serverVersion
      end
      if serverInfoStr and "" ~= serverInfoStr then
        debugText = debugText .. " " .. serverInfoStr
      end
    end
  end
  return LT.Textf("GMUserIdText", DataCenter.playerData.DRole.uid) .. debugText
end

function ReqMaskView:_GetUidOrUtdid()
  local savedPlayerUid = MobileFileDataManager.Instance:GetCommFileValue("playerUid")
  if savedPlayerUid then
    return savedPlayerUid
  end
  local pkgInfo = E.get_pkg_info()
  if pkgInfo and pkgInfo.utdid then
    local utdid = pkgInfo.utdid
    do return _ejoysdk_crypt.base64encode, tostring(utdid) end
    return _ejoysdk_crypt.base64encode, tostring(utdid)
  end
  return ""
end

function ReqMaskView:_OpenReqMask()
  Logger.Debug("ReqMaskView._OpenReqMask")
  self.ui.Mask:SetActive(true)
  if self._reqMaskTimer then
    self:StopTimer(self._reqMaskTimer)
    self._reqMaskTimer = nil
  end
  self._reqMaskTimer = self:BindTimer(2, 0, nil, function()
    self.ui.Mask:SetActive(false)
  end)
end

function ReqMaskView:_CloseReqMask()
  self.ui.Text:SetActive(false)
  self.ui.Mask:SetActive(false)
end

function ReqMaskView:_OpenAnimMask()
  self.ui.AnimMask:SetActive(true)
  if self._animMaskTimer then
    self:StopTimer(self._animMaskTimer)
    self._animMaskTimer = nil
  end
  self._animMaskTimer = self:BindTimer(2, 0, nil, function()
    self.ui.AnimMask:SetActive(false)
  end)
end

function ReqMaskView:_CloseAnimMask()
  self.ui.Text:SetActive(false)
  self.ui.AnimMask:SetActive(false)
end

function ReqMaskView:_OpenClickMask(reason, time)
  assert(reason, "OpenClickMask 需要传入 reason")
  self.ui.ClickMask:SetActive(true)
  time = time or 2
  Logger.Info("[ReqMaskView]OpenClickMask", reason, time)
  self._clickMaskUnlockTimeMap = self._clickMaskUnlockTimeMap or {}
  self._clickMaskUnlockTimeMap[reason] = time + os.time()
end

function ReqMaskView:_CloseClickMask(reason)
  assert(reason, "CloseClickMask 需要传入 reason")
  if not self._clickMaskUnlockTimeMap then
    return
  end
  Logger.Info("[ReqMaskView]CloseClickMask", reason)
  self._clickMaskUnlockTimeMap[reason] = 0
  self:_CheckToHideClickMask()
end

function ReqMaskView:_CheckToHideClickMask()
  if not self._clickMaskUnlockTimeMap or not table.next(self._clickMaskUnlockTimeMap) then
    return
  end
  local now = os.time()
  for _reason, unlockTime in pairs(self._clickMaskUnlockTimeMap) do
    if unlockTime > now then
      return
    end
  end
  Logger.Info("[ReqMaskView]CheckToHideClickMask")
  self.ui.ClickMask:SetActive(false)
  table.clear(self._clickMaskUnlockTimeMap)
end

function ReqMaskView:_OnEnterScene(sceneType)
  if not sceneType then
    return
  end
  self._isInLoginScene = sceneType == CommonDefine.SceneType.Login
  self:_RefreshVersionText()
  self:_RefreshUserText()
end

function ReqMaskView:_OnUpdateShowStory(eventType)
  if eventType ~= CommonDefine.GameEvent.EnterAvg and eventType ~= CommonDefine.GameEvent.ExitAvg then
    return
  end
  self._isShowStory = eventType == CommonDefine.GameEvent.EnterAvg
  self:_RefreshNetDelay()
end

function ReqMaskView:_HideWhenCaptureScreen(value)
  self.ui.Text_User:SetActive(value)
end

function ReqMaskView:_SetUserInfoTextShow(show)
  self.ui.Group_Text:SetActive(show)
  self.ui.Text_Time:SetActive(show)
end

return ReqMaskView
