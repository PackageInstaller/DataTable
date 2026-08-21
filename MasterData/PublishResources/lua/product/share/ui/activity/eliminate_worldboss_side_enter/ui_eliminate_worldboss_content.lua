require("ui_side_enter_center_content_base")
_class("UIEliminateWorldBossContent", UISideEnterCenterContentBase)
UIEliminateWorldBossContent = UIEliminateWorldBossContent

function UIEliminateWorldBossContent:DoInit()
  self._countdown = self:GetUIComponent("UILocalizationText", "Countdown")
  local endTime = Cfg.cfg_main_side_enter_btn.EliminateWorldBoss.EndTime
  self._endTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
end

function UIEliminateWorldBossContent:DoShow()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnShowEliminateWorldBoss)
  self:_Countdown()
end

function UIEliminateWorldBossContent:DoHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    self._timeStr = nil
  end
end

function UIEliminateWorldBossContent:DoDestroy()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
    self._timeStr = nil
  end
end

function UIEliminateWorldBossContent:BattleOnClick()
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_WorldBoss)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_worldboss_tips"))
    return
  end
  local controller = GameGlobal.UIStateManager():GetController("UISideEnterCenterController")
  local screenShot = controller:GetScreenShot()
  screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera("UISideEnterCenterController")
  local rt = screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  self:StartTask(function(TT)
    YIELD(TT)
    if self.view then
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:ShowDialog("UIWorldBossController", cache_rt)
    end
  end)
end

function UIEliminateWorldBossContent:_Countdown()
  local delatTime = self._endTime - GetSvrTimeNow()
  local str = HelperProxy:GetInstance():FormatTime_3(delatTime)
  if self._timeStr ~= str then
    self._countdown:SetText(StringTable.Get("str_activity_common_remainingtime_3", str))
    self._timeStr = str
  end
  if delatTime <= 0 then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
      self._timeStr = nil
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnEliminateWorldBossClosed)
    end
  elseif not self._timer then
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_Countdown()
    end)
  end
end
