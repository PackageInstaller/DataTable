_class("UIGlobalModule", UIModule)
UIGlobalModule = UIGlobalModule

function UIGlobalModule:Constructor()
  self:AttachEvent(GameEventType.AppHome, self.OnAppHome)
  self:AttachEvent(GameEventType.AppResume, self.OnAppResume)
  self:AttachEvent(GameEventType.AppReturn, self.OnAppReturn)
  self:AttachEvent(GameEventType.AskPopupReset, self.OnAskPopupReset)
  self:AttachEvent(GameEventType.PopupReset, self.OnPopupReset)
  self:AttachEvent(GameEventType.SwitchUIStateFinish, self.OnSwitchUIStateFinish)
  self:AttachEvent(GameEventType.NetWorkRetryStart, self.OnStartNetRetry)
  self:AttachEvent(GameEventType.NetWorkRetryEnd, self.OnEndNetRetry)
  self:AttachEvent(GameEventType.PushNotification, self.OnPushNotification)
  self.networkMonitorPopup = nil
  self.appHomeTipTime = 3000
  self.forceShutting = false
  self.networkType = GetInternetReachability()
  self._quitTips = nil
end

function UIGlobalModule:Dispose()
end

local homeTime = 0

function UIGlobalModule:OnAppHome()
  homeTime = GameGlobal:GetInstance():GetCurrentRealTime()
  self.networkType = GetInternetReachability()
  if APPVER1140 then
    HotUpdate.ActivityLuaProxy.SaveManifestImmediately()
  end
  Log.debug("UIGlobalModule:OnAppHome 游戏暂停 一切中止 unityTime ", homeTime, " current networkType ", self.networkType)
end

function UIGlobalModule:OnAppResume()
  Log.debug("UIGlobalModule:OnAppHome 游戏开始 准备万物生机")
  local moduleMain = self:GetModule(LoginModule)
  if not moduleMain:IsLogin() then
    return
  end
  local waitTime = GameGlobal:GetInstance():GetCurrentRealTime() - homeTime
  local new_nettype = GetInternetReachability()
  Log.debug("UIGlobalModule:OnAppResume 游戏开始 万物生机 current= ", GameGlobal:GetInstance():GetCurrentRealTime(), ", unity wait= ", waitTime, "old neworktype ", self.networkType, " new networkType ", new_nettype)
  if new_nettype ~= self.networkType then
    self.networkType = new_nettype
    moduleMain.caller:LostAuth()
    moduleMain.caller:Connect()
    moduleMain.caller:DisconnectLink("network change")
    moduleMain:Retry("network change")
  elseif waitTime > self.appHomeTipTime then
    moduleMain.caller:LostAuth()
    moduleMain:Retry("wait time too long " .. tostring(waitTime))
  end
end

function UIGlobalModule:OnAppReturn()
  Log.debug("UIGlobalModule:OnAppReturn")
  local loginModule = GameGlobal.GetModule(LoginModule)
  if not loginModule:EnableEscKey() then
    return
  end
  if GameGlobal.UIStateManager():IsLocked() then
    Log.debug("UIGlobalModule:OnAppReturn, UI is Lock Now.")
    return
  end
  if self._quitTips then
    GameGlobal.UIStateManager():ClosePopup(self._quitTips)
    self._quitTips = nil
    return
  end
  local uiStateManager = GameGlobal.UIStateManager()
  local currentState = uiStateManager.curState
  if not currentState then
    return
  end
  local curUIStateType = GameGlobal.UIStateManager():CurUIStateType()
  if curUIStateType == UIStateType.LoginEmpty then
    return
  end
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    self:ShowQuitUI()
  else
    if curUIStateType == UIStateType.UIAircraft then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
      return
    end
    if curUIStateType == UIStateType.UIHomeland or curUIStateType == UIStateType.UIHomelandBuild or curUIStateType == UIStateType.UIHomeStoryController then
      return
    end
    if curUIStateType == UIStateType.UIDrawCardAnim then
      self:ShowQuitUI()
      return
    end
    local uiControllerManager = currentState.uiControllerManager
    local visibleUIList = uiControllerManager:VisibleUIList()
    if visibleUIList:Size() > 1 then
      if visibleUIList:Contains("UICommonLoading") then
        self:ShowQuitUI()
      else
        local name = visibleUIList:GetAt(visibleUIList:Size())
        if name == "UIPetIntimacyMainController" then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.PlayInOutAnimation, true)
        end
        GameGlobal.UIStateManager():CloseDialog(name)
      end
    elseif curUIStateType == UIStateType.UICommonLoading or curUIStateType == UIStateType.BattleLoading or curUIStateType == UIStateType.UIBattle or curUIStateType == UIStateType.UIMain or curUIStateType == UIStateType.UIDrawCardAnim then
      self:ShowQuitUI()
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
  end
end

function UIGlobalModule:ShowQuitUI()
  self._quitTips = PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_common_quit_application"), function(param)
    EngineGameHelper.QuitApp()
    self._quitTips = nil
  end, nil, function(param)
    Log.debug("sale cancel. .")
    self._quitTips = nil
  end, nil)
end

function UIGlobalModule:OnAskPopupReset(txt, func1, func2)
  if self.networkMonitorPopup then
    Log.warn("UIGlobalModule:OnAskPopupReset return, 已经出现弹框了 return")
    return
  end
  self.networkMonitorPopup = PopupManager.Alert("UICommonMessageBox", PopupPriority.Network, PopupMsgBoxType.OkCancel, "", txt, function()
    self.networkMonitorPopup = nil
    if func1 then
      func1()
    end
  end, nil, function()
    self.networkMonitorPopup = nil
    if func2 then
      func2()
    end
  end, nil)
end

function UIGlobalModule:OnPopupReset(txt, func)
  if self.networkMonitorPopup then
    Log.warn("UIGlobalModule:OnPopupReset return, 已经出现弹框了 return")
    return
  end
  self.networkMonitorPopup = PopupManager.Alert("UICommonMessageBox", PopupPriority.Network, PopupMsgBoxType.Ok, "", txt, function()
    self.networkMonitorPopup = nil
    if func then
      func()
    end
  end)
end

function UIGlobalModule:SetCSUICameraStatus(status)
  local csui = UnityEngine.GameObject.Find("CSUI")
  if csui then
    local csuiTran = csui.transform
    local cameraFrameworkTran = csuiTran:Find("FrameworkUI/CameraFramework")
    if cameraFrameworkTran then
      local cameraFramework = cameraFrameworkTran:GetComponent("Camera")
      if cameraFramework then
        cameraFramework.enabled = status
      end
    end
    local cameraTran = csuiTran:Find("UI/Camera")
    if cameraTran then
      local camera = cameraTran:GetComponent("Camera")
      if camera then
        camera.enabled = status
      end
    end
  end
end

function UIGlobalModule:GoBackCallback(cb, ...)
  GameGlobal.UIStateManager():ShowBusy(false)
  local goBackFunc
  local uistate = cb(...)
  Log.debug("UIGlobalModule:GoBackCallback uistate", uistate, Log.traceback())
  if uistate == GameGlobal.UIStateManager():CurUIStateType() then
    function goBackFunc()
      GameGlobal.TaskManager():KillCoreGameTasks()
      
      GameGlobal:GetInstance():ExitCoreGame()
      if uistate == UIStateType.Login or uistate == UIStateType.LoginEmpty then
        if GameGlobal.UIStateManager():IsShow("UIStoryController") then
          GameGlobal.UIStateManager():CloseDialog("UIStoryController")
        end
        if GameGlobal.UIStateManager():IsShow("UICommonLoading") then
          GameGlobal.UIStateManager():CloseDialog("UICommonLoading")
        end
      end
      GameGlobal.RealTimer():AddEvent(0, function()
        GameGlobal.GameLogic():Init("GoBackCallback")
        LogoutGameNew()
      end)
    end
  elseif uistate ~= UIStateType.Invalid and UIHelper.GameStartType() == EGameStartType.Normal then
    local args = {
      ...
    }
    
    function goBackFunc()
      GameGlobal.UIStateManager():PopupPriorityFilter(PopupPriority.Network, true)
      GameGlobal.TaskManager():KillCoreGameTasks()
      GameGlobal:GetInstance():ExitCoreGame()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.BeforeRelogin)
      GameGlobal.UIStateManager():Reset()
      self:StartTask(UIStateManager.ForceSwitchState, GameGlobal.UIStateManager(), uistate, table.unpack(args))
      if uistate == UIStateType.Login or uistate == UIStateType.LoginEmpty then
        GameGlobal.RealTimer():AddEvent(0, function()
          GameGlobal.GameLogic():Init("GoBackCallback")
          LogoutGameNew()
        end)
      end
    end
  end
  if GameGlobal.LoadingManager():IsLoading() then
    GameGlobal.LoadingManager():Interrupt(goBackFunc)
  elseif goBackFunc then
    goBackFunc()
  end
end

function UIGlobalModule:OnSwitchUIStateFinish(uiStateType)
  if (uiStateType == UIStateType.Login or uiStateType == UIStateType.LoginEmpty) and GameGlobal.UIStateManager():IsLogouting() then
    GameGlobal.UIStateManager():UnLockAll()
    GameGlobal.UIStateManager():ClearBusy()
    GameGlobal.UIStateManager():SetIsLogouting(false)
  end
  if self.forceShutting and not GameGlobal.LoadingManager():IsLoading() and uiStateType ~= UIStateType.UIBattle then
    self:ShowShutDialog()
  end
end

function UIGlobalModule:OnStartNetRetry()
  GameGlobal.UIStateManager():Lock("NetRetry")
  GameGlobal.UIStateManager():ShowBusy(true)
end

function UIGlobalModule:OnEndNetRetry()
  GameGlobal.UIStateManager():UnLock("NetRetry")
  GameGlobal.UIStateManager():ClearBusy()
end

function UIGlobalModule:OnPushNotification(notification_type, notification_res_ver)
  if notification_type == MOBILE_NOTIFICATION_TYPE.MOBILE_NOTIFICATION_FORCE_CLIENT_UPDATE then
    self.forceShutting = true
  elseif notification_type == MOBILE_NOTIFICATION_TYPE.MOBILE_NOTIFICATION_FORCE_RESVER_UPDATE then
    local cur_res_ver = EngineGameHelper.CurrentResVersion()
    if notification_res_ver and cur_res_ver ~= notification_res_ver then
      self.forceShutting = true
    end
  end
  if not self.forceShutting then
    return
  end
  local curUIState = GameGlobal.UIStateManager():CurUIStateType()
  if GameGlobal.LoadingManager():IsLoading() or curUIState == UIStateType.UIBattle then
    return
  end
  self:ShowShutDialog()
end

function UIGlobalModule:ShowShutDialog()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_common_force_shut"), function()
    UnityEngine.Application.Quit()
  end)
end
