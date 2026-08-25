local PatchConst = require("GameLauncher.PatchConst")
local E = require("ejoysdk_lua.ejoysdk")
local ReqMaskPanel, Super = System.NewClass("ReqMaskPanel", UIBasePanel)
ReqMaskPanel.uiResCls = Panel_ReqMaskResource

function ReqMaskPanel:ctor()
  Super.ctor(self)
  self.showMask = {}
  self.isInLoginScene = Vue.ref(SceneMgr.Instance:IsLoginScene())
  self.isShowStory = Vue.ref(false)
end

function ReqMaskPanel:OnBind(binder)
  self.binder = binder
  self.binder:SetActive(self.ui.Mask, false)
  self.binder:SetActive(self.ui.AnimMask, false)
  self.binder:SetActive(self.ui.Text, false)
  self.binder:BindEvent(EventMgr.Instance.OpenReqMask, System.fn(self, self.OpenReqMask))
  self.binder:BindEvent(EventMgr.Instance.CloseReqMask, System.fn(self, self.CloseReqMask))
  self.binder:BindEvent(EventMgr.Instance.OpenAnimMask, System.fn(self, self.OpenAnimMask))
  self.binder:BindEvent(EventMgr.Instance.CloseAnimMask, System.fn(self, self.CloseAnimMask))
  self.binder:BindEvent(EventMgr.Instance.OpenClickMask, System.fn(self, self.OpenClickMask))
  self.binder:BindEvent(EventMgr.Instance.CloseClickMask, System.fn(self, self.CloseClickMask))
  self.binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self._OnEnterScene))
  self.binder:BindEvent(EventMgr.Instance.GameEvent, System.fn(self, self._OnUpdateShowStory))
  self.binder:BindEvent(EventMgr.Instance.HideWhenCaptureScreen, System.fn(self, self.HideWhenCaptureScreen))
  self.binder:BindEvent(EventMgr.Instance.ShowUserInfoText, System.fn(self, self.SetUserInfoTextShow))
  self.binder:BindEvent(EventMgr.Instance.OpenAnimMask, System.fn(self, self.OpenAnimMask))
  self.binder:BindEvent(EventMgr.Instance.CloseAnimMask, System.fn(self, self.CloseAnimMask))
  binder:BindToText(self.ui.Text_Ver, function()
    local versionText = ""
    if self.isInLoginScene.value then
      local pkg_info = E.get_pkg_info()
      local pkgName = pkg_info.pkg_name
      local pkgShortName = require("Share.Version.version").GetPkgShortName(pkgName)
      local bundleVersionCode = E.Sysinfo.app_version_code()
      local svnVersion = PatchConst.GetShowVersion()
      versionText = string.format("%s_%s_%s(%s)", pkgShortName, bundleVersionCode, svnVersion, self:GetUidOrUtdid())
    end
    return versionText
  end)
  binder:BindToVisible(self.ui.Text_Ver, function()
    local userText = self:GetUserText() or ""
    return self.isInLoginScene.value and "" == userText
  end)
  binder:BindToText(self.ui.Text_User, function()
    do return self.GetUserText end
    return self.GetUserText, self
  end)
  binder:BindToVisible(self.ui.Text_Net, function()
    return DataCenter.gameData.ShowLag
  end)
  binder:BindToText(self.ui.Text_Net, function()
    if not DataCenter.gameData.ShowLag then
      return ""
    end
    if self.isShowStory.value then
      return ""
    end
    if not DataCenter.barrierData.InBattle then
      return ""
    end
    if DataCenter.copiesData.copiesSettleData ~= nil or nil ~= DataCenter.pvpSettleData.win then
      return ""
    end
    if DataCenter.playerData.netDelayTime <= 100 then
      return ""
    end
    return "   " .. LT.Textf("GMNetText", DataCenter.playerData.netDelayTime)
  end)
  binder:BindToTextColorOld(self.ui.Text_Net, function()
    local rst = "#9BA3A2"
    if DataCenter.playerData.netDelayTime > 100 then
      rst = DT.ColorConfig.NetworkDelayYellow.Light
    end
    if DataCenter.playerData.netDelayTime > 200 then
      rst = DT.ColorConfig.NetworkDelayRed.Light
    end
    return rst
  end)
  binder:BindTimer(1, -1, function()
    local now = TimeUtils.GetServerTime()
    local timeText = TimeUtils.TimestampToString(now, TimeUtils.TimeExactType.HourAndMinute)
    if Binder.OpenConfuseText then
      timeText = ""
    end
    binder:SetText(self.ui.Text_Time, timeText)
  end)
  binder:BindTimer(1, -1, System.fn(self, self.CheckToHideClickMask))
end

function ReqMaskPanel:GetUserText()
  if Binder.OpenConfuseText then
    return ""
  end
  if not DataCenter.playerData.DRole.uid or DataCenter.playerData.DRole.uid <= 0 then
    return ""
  end
  local debug_text = ""
  if ApplicationUtils.is_open_gm() then
    local account = MobileFileDataManager.Instance:GetCommFileValue(cd.LocalSaveKeyCommon.Account)
    if account then
      debug_text = debug_text .. "  " .. account
    end
    local serverInfo = LoginMgr.Instance.model:GetCurrServerData()
    if serverInfo and serverInfo.name then
      debug_text = debug_text .. "  " .. serverInfo.name
    end
    if DataCenter.gameData.serverVersion and type(DataCenter.gameData.serverVersion) == "table" then
      local server_info = ""
      local config_version = DataCenter.gameData.serverVersion.config_version
      local server_version = DataCenter.gameData.serverVersion.server_version
      local branch = DataCenter.gameData.serverVersion.branch
      if branch then
        server_info = server_info .. " " .. branch
      end
      if config_version then
        server_info = server_info .. " cfg:" .. config_version
      end
      if server_version then
        server_info = server_info .. " svr:" .. server_version
      end
      if server_info and "" ~= server_info then
        debug_text = debug_text .. " " .. server_info
      end
    end
  end
  return LT.Textf("GMUserIdText", DataCenter.playerData.DRole.uid) .. debug_text
end

function ReqMaskPanel:_OnEnterScene(sceneType)
  if not sceneType then
    return
  end
  self.isInLoginScene.value = sceneType == CommonDefine.SceneType.Login
end

function ReqMaskPanel:_OnUpdateShowStory(eventType)
  if eventType ~= CommonDefine.GameEvent.EnterAvg and eventType ~= CommonDefine.GameEvent.ExitAvg then
    return
  end
  local show = false
  if eventType == CommonDefine.GameEvent.EnterAvg then
    show = true
  end
  self.isShowStory.value = show
end

function ReqMaskPanel:HideWhenCaptureScreen(value)
  self.ui.Text_User:SetActive(value)
end

function ReqMaskPanel:SetUserInfoTextShow(show)
  self.ui.Group_Text:SetActive(show)
  self.ui.Text_Time:SetActive(show)
end

function ReqMaskPanel:GetUidOrUtdid()
  local savedPlayerUid = MobileFileDataManager.Instance:GetCommFileValue("playerUid")
  if savedPlayerUid then
    return savedPlayerUid
  else
    local E = require("ejoysdk_lua.ejoysdk")
    if E.get_pkg_info() and E.get_pkg_info().utdid then
      local utdid = E.get_pkg_info().utdid
      do return _ejoysdk_crypt.base64encode, tostring(utdid) end
      return _ejoysdk_crypt.base64encode, tostring(utdid)
    end
  end
  return ""
end

function ReqMaskPanel:OpenReqMask()
  Logger.Debug("ReqMaskPanel.OpenReqMask")
  self.binder:SetActive(self.ui.Mask, true)
  if self.reqMaskTimer then
    self.binder:StopTimer(self.reqMaskTimer)
    self.reqMaskTimer = nil
  end
  self.reqMaskTimer = self.binder:BindTimer(2, 0, nil, function()
    self.binder:SetActive(self.ui.Mask, false)
  end)
end

function ReqMaskPanel:OpenAnimMask()
  self.binder:SetActive(self.ui.AnimMask, true)
  if self.animMaskTimer then
    self.binder:StopTimer(self.animMaskTimer)
    self.animMaskTimer = nil
  end
  self.animMaskTimer = self.binder:BindTimer(2, 0, nil, function()
    self.binder:SetActive(self.ui.AnimMask, false)
  end)
end

function ReqMaskPanel:OpenClickMask(reason, time)
  assert(reason, "OpenClickMask 需要传入 reason")
  self.binder:SetActive(self.ui.ClickMask, true)
  time = time or 2
  Logger.Info("[ReqMaskPanel]OpenClickMask", reason, time)
  self._clickMaskUnlockTimeMap = self._clickMaskUnlockTimeMap or {}
  self._clickMaskUnlockTimeMap[reason] = time + os.time()
end

function ReqMaskPanel:CloseClickMask(reason)
  assert(reason, "CloseClickMask 需要传入 reason")
  if not self._clickMaskUnlockTimeMap then
    return
  end
  Logger.Info("[ReqMaskPanel]CloseClickMask", reason)
  self._clickMaskUnlockTimeMap[reason] = 0
  self:CheckToHideClickMask()
end

function ReqMaskPanel:CheckToHideClickMask()
  if not self._clickMaskUnlockTimeMap or not table.next(self._clickMaskUnlockTimeMap) then
    return
  end
  local now = os.time()
  for reason, unlockTime in pairs(self._clickMaskUnlockTimeMap) do
    if unlockTime > now then
      return
    end
  end
  Logger.Info("[ReqMaskPanel]CheckToHideClickMask ")
  self.binder:SetActive(self.ui.ClickMask, false)
  table.clear(self._clickMaskUnlockTimeMap)
end

function ReqMaskPanel:CloseReqMask()
  self.binder:SetActive(self.ui.Text, false)
  self.binder:SetActive(self.ui.Mask, false)
end

function ReqMaskPanel:CloseAnimMask()
  self.binder:SetActive(self.ui.Text, false)
  self.binder:SetActive(self.ui.AnimMask, false)
end

return ReqMaskPanel
