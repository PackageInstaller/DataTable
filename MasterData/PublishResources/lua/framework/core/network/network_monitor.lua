_class("NetworkMonitor", Object)

function NetworkMonitor:Constructor()
  self.page = UIStateType.Invalid
end

function NetworkMonitor:Dispose()
  Log.debug("NetworkMonitor:Dispose")
  self:Choose(false, GameGlobal.GameLogic():GetModule(LoginModule), "NetworkMonitor:Dispose", Log.traceback())
  self.page = UIStateType.Invalid
end

function NetworkMonitor:Choose(choose, module, reason)
  if module == nil then
    return self.page
  end
  GameGlobal.UAReportForceGuideEvent("ReConnect", {}, true)
  if choose then
    Log.debug(module:Key(), " choose retry, reason: ", reason)
    self:GoBack(UIStateType.Invalid)
  else
    Log.debug(module:Key(), " choose reset, reason: ", reason)
    module.stateType = ModuleStateType.ResetDuring
  end
  local moduleMain = GameGlobal.GameLogic():GetModule(LoginModule)
  if moduleMain == nil then
  elseif moduleMain.stateType == ModuleStateType.ResetDuring then
    Log.debug(moduleMain:Key(), " need reset, reset all", Log.traceback())
    GameGlobal.GameLogic():ForModules(function(m)
      if m and m:IsChildOf("LoginBaseModule") then
        local moduleOth = m
        if moduleOth ~= moduleMain then
          moduleOth:Reset(reason)
        end
      end
    end)
    moduleMain:Reset(reason)
  elseif moduleMain.stateType == ModuleStateType.RetryResetDuring then
    Log.debug(moduleMain:Key(), " can retry, retry all", Log.traceback())
    moduleMain:Retry(reason)
    GameGlobal.GameLogic():ForModules(function(m)
      if m and m:IsChildOf("LoginBaseModule") then
        local moduleOth = m
        if moduleOth == moduleMain then
        elseif moduleOth.stateType == ModuleStateType.RetryResetDuring then
          moduleOth:Retry(reason)
        elseif moduleOth.stateType == ModuleStateType.ResetDuring then
          moduleOth:Reset(reason)
        end
      end
    end)
  else
    Log.debug(moduleMain:Key(), " normal, retry all")
    GameGlobal.GameLogic():ForModules(function(m)
      if m and m:IsChildOf("LoginBaseModule") then
        local moduleOth = m
        if moduleOth == moduleMain then
        elseif moduleOth.stateType == ModuleStateType.RetryResetDuring then
          moduleOth:Retry(reason)
        elseif moduleOth.stateType == ModuleStateType.ResetDuring then
          moduleOth:Reset(reason)
        end
      end
    end)
  end
  local page = self.page
  self.page = UIStateType.Invalid
  return page
end

function NetworkMonitor:ConnectRetryReset(module, reason)
  if module == nil or module.stateType ~= ModuleStateType.Unset then
    return
  end
  Log.debug(module:Key(), " ConnectRetryReset, reason: ", reason, Log.traceback())
  module.stateType = ModuleStateType.RetryResetDuring
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AskPopupReset, StringTable.Get("str_login_ask_login_connect_timeout_text"), function()
    UIGlobalModule:GoBackCallback(function()
      return self:Choose(true, module, reason)
    end)
  end, function()
    UIGlobalModule:GoBackCallback(function()
      return self:Choose(false, module, reason)
    end)
  end)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ConnectReset, reason)
end

function NetworkMonitor:CallRetryReset(module, reason)
  if module == nil or module.stateType ~= ModuleStateType.Unset then
    return
  end
  Log.debug(module:Key(), " CallRetryReset, reason: ", reason, Log.traceback())
  module.stateType = ModuleStateType.RetryResetDuring
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AskPopupReset, StringTable.Get("str_login_ask_login_request_timeout_text"), function()
    UIGlobalModule:GoBackCallback(function()
      return self:Choose(true, module, reason)
    end)
  end, function()
    UIGlobalModule:GoBackCallback(function()
      return self:Choose(false, module, reason)
    end)
  end)
end

function NetworkMonitor:LogoutReset(module, reason, popup, errcode, ...)
  UIGlobalModule:SetCSUICameraStatus(true)
  if module == nil or module.stateType == ModuleStateType.ResetDuring then
    return
  end
  Log.debug(module:Key(), " LogoutReset, reason: ", reason, Log.traceback())
  local retrys = true
  local tips = "str_login_ask_login_connect_timeout_text"
  if errcode == MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_MULTI_LOGIN then
    if IsPc() then
      tips = "str_login_mobile_logout_multi_login_dmm"
    else
      tips = "str_login_mobile_logout_multi_login"
    end
    retrys = false
  elseif errcode == MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_SERVER_KICK then
    tips = "str_login_mobile_logout_server_kick"
    retrys = false
  elseif errcode == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_NO_PLAYER then
    tips = "str_login_mobile_longtime_leave"
  elseif errcode == MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_MATCH_ERROR then
    tips = "str_login_match_error"
  elseif errcode == MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_LOADDATA then
    tips = "str_login_load_data_error"
    popup = true
  elseif errcode == MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_PLAYER_LOGOUT then
    popup = false
  end
  if IsPc() == false then
    module.stateType = ModuleStateType.ResetDuring
    UIGlobalModule:GoBackCallback(function()
      return self:Choose(false, module, reason)
    end, ...)
  end
  if popup == nil and true or popup then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PopupReset, StringTable.Get(tips), function()
      if IsPc() then
        EngineGameHelper.QuitApp()
      elseif retrys == true then
        UIGlobalModule:GoBackCallback(function()
          return self:Choose(true, GameGlobal.GameLogic():GetModule(LoginModule), reason)
        end)
      end
    end)
  end
end

function NetworkMonitor:GoBack(page)
  Log.debug("[net] NetworkMonitor:GoBack ", page, Log.traceback())
  self.page = page
end
