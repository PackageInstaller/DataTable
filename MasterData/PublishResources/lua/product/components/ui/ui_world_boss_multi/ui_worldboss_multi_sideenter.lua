require("ui_side_enter_item_base")
_class("UIWorldBossMultiSideEnter", UISideEnterItem_Base)
UIWorldBossMultiSideEnter = UIWorldBossMultiSideEnter

function UIWorldBossMultiSideEnter:Constructor()
  self._worldBossModule = self:GetModule(WorldBossModule)
end

function UIWorldBossMultiSideEnter:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnOpenWorldBossMultiUI, self.OnOpenWorldBossMultiUI)
  self:_GetComponents()
end

function UIWorldBossMultiSideEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIWorldBossMultiSideEnter:_GetComponents()
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
end

function UIWorldBossMultiSideEnter:_CheckOpen(TT)
  self:Lock("UIWorldBossMultiSideEnter")
  local res = self._worldBossModule:ReqWorldBossData(TT)
  if not res:GetSucc() then
    res:SetSucc(false)
    self:UnLock("UIWorldBossMultiSideEnter")
    return
  end
  self:UnLock("UIWorldBossMultiSideEnter")
  local open = self._worldBossModule:AwardMultiOpen()
  local unlock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_WorldBoss)
  open = open and unlock
  return open
end

function UIWorldBossMultiSideEnter:GetSideEnterRawImage()
  return "n18_zaidian_ent"
end

function UIWorldBossMultiSideEnter:DoShow()
  UIWidgetHelper.SetLocalizationText(self, "txtTitle", StringTable.Get("str_n18_worldboss_title"))
  UIWidgetHelper.SetRawImage(self, "bg", self:GetSideEnterRawImage())
  self:_CheckClose(true)
end

function UIWorldBossMultiSideEnter:_CalcNew()
  return false
end

function UIWorldBossMultiSideEnter:_CalcRed()
  local key = self:_GetLocalDBKey()
  return UIWorldBossMultiToolFunctions.GetLocalDBInt(key, 0) <= 0
end

function UIWorldBossMultiSideEnter:SetData()
end

function UIWorldBossMultiSideEnter:_GetLocalDBKey()
  return UIWorldBossMultiKey.Opened .. self._worldBossModule.m_world_boss_data.boss_mission_id
end

function UIWorldBossMultiSideEnter:OnOpenWorldBossMultiUI(go)
  local key = self:_GetLocalDBKey()
  UIWorldBossMultiToolFunctions.SetLocalDBInt(key, 1)
  self:_CheckPoint()
end

function UIWorldBossMultiSideEnter:_CheckClose(unlock)
  if unlock then
    local remainTime = self._worldBossModule.m_world_boss_data.end_time - self:GetModule(SvrTimeModule):GetServerTime() * 0.001
    if 0 < remainTime then
      if self._timerHandler then
        GameGlobal.Timer():CancelEvent(self._timerHandler)
        self._timerHandler = nil
      end
      self._timerHandler = GameGlobal.Timer():AddEventTimes(remainTime * 1000, TimerTriggerCount.Once, function()
        self._setShowCallback(false)
      end)
    end
  end
end
