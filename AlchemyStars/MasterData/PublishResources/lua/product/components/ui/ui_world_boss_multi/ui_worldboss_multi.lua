_class("UIWorldBossMulti", UISideEnterCenterContentBase)
UIWorldBossMulti = UIWorldBossMulti

function UIWorldBossMulti:Constructor()
  self._worldBossModule = self:GetModule(WorldBossModule)
end

function UIWorldBossMulti:DoInit()
end

function UIWorldBossMulti:DoShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnOpenWorldBossMultiUI)
end

function UIWorldBossMulti:_GetComponents()
  self._remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UIWorldBossMulti:_OnValue()
  local count = string.format("<color=#ffff4e>%d</color>", self._worldBossModule:GetAwardMultiple())
  self._desc:SetText(StringTable.Get("str_n18_worldboss_desc", count))
  self:RefreshRemainTime()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshRemainTime()
  end)
end

function UIWorldBossMulti:RefreshRemainTime()
  local remainTime = self._worldBossModule.m_world_boss_data.end_time - self:GetModule(SvrTimeModule):GetServerTime() * 0.001
  if 0 < remainTime then
    remainTime = string.format("<color=#ffff4e>%s</color>", UIWorldBossMultiToolFunctions.GetRemainTime(remainTime))
    self._remainTimeText:SetText(StringTable.Get("str_n18_worldboss_remain_time", remainTime))
  end
end

function UIWorldBossMulti:DoHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIWorldBossMulti:GotoBtnOnClick(go)
  local open = self._worldBossModule:AwardMultiOpen()
  if not open then
    ToastManager.ShowToast(StringTable.Get("str_n18_worldboss_close"))
    self:CloseDialog()
  else
    self:SwitchState(UIStateType.UIWorldBoss)
  end
end

function UIWorldBossMulti:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIWorldBossMulti:DoDestroy()
end
