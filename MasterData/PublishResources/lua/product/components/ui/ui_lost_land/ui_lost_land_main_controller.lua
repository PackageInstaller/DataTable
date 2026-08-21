_class("UILostLandMainController", UIController)
UILostLandMainController = UILostLandMainController

function UILostLandMainController:OnShow(uiParams)
  self._module = GameGlobal.GetModule(LostAreaModule)
  self._uiModule = GameGlobal.GetUIModule(LostAreaModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._enterData = self._uiModule:GetEnterData()
  self:GetComponents()
  local resetTime = uiParams[1]
  if resetTime then
    self:ResetAnim()
  end
  self:OnValue()
  self:AttachEvent(GameEventType.OnLostLandTimeReset, self.OnLostLandTimeReset)
end

function UILostLandMainController:GetComponents()
  local ltBtns = self:GetUIComponent("UISelectObjectPath", "btnBack")
  self._backBtn = ltBtns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseController()
  end)
  self._resetGo = self:GetGameObject("reset")
  self._resetGo:SetActive(false)
  self._timerTex = self:GetUIComponent("UILocalizationText", "timerTex")
  self._enterPool = self:GetUIComponent("UISelectObjectPath", "enterPool")
end

function UILostLandMainController:CloseController()
  self:SwitchState(UIStateType.UIDiscovery)
end

function UILostLandMainController:ResetAnim()
  self._resetGo:SetActive(true)
  GameGlobal.Timer():AddEvent(3000, function()
    if self._resetGo then
      self._resetGo:SetActive(false)
    end
  end)
end

function UILostLandMainController:OnLostLandTimeReset()
  self:OnValue()
end

function UILostLandMainController:OnValue()
  self:InitTimer()
  self:InitEnterData()
end

function UILostLandMainController:InitEnterData()
  local count = #self._enterData
  self._enterPool:SpawnObjects("UILostLandMainItem", count)
  self._enterPools = self._enterPool:GetAllSpawnList()
  for i = 1, #self._enterPools do
    local item = self._enterPools[i]
    item:SetData(i, self._enterData[i], function(idx)
      self:EnterItemClick(idx)
    end)
  end
end

function UILostLandMainController:EnterItemClick(idx)
  local enterData = self._enterData[idx]
  local state = enterData:GetLockState()
  if state == UILostLandEnterLockType.UNLOCK then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_lost_land_choose_enter_pop_tips"), function(param)
      Log.debug("###[UILostLandMainController] 难度选择", idx)
      self:ChooseEnter(enterData)
    end, nil, function(param)
      Log.debug("###[UILostLandMainController] 取消难度选择")
    end, nil)
  elseif state == UILostLandEnterLockType.CANUNLOCK then
    self:UnLockEnter(idx)
  elseif state == UILostLandEnterLockType.LOCK then
    ToastManager.ShowToast(StringTable.Get("str_lost_land_enter_lock_tips"))
  elseif state == UILostLandEnterLockType.CHOOSE then
    self:ChooseEnter(enterData)
  end
end

function UILostLandMainController:ChooseEnter(enterdata)
  self._uiModule:ChooseEnter(enterdata)
end

function UILostLandMainController:UnLockEnter(idx)
  Log.debug("###[UILostLandMainController] 开始解锁 idx --> ", idx)
  GameGlobal.TaskManager():StartTask(self._OnUnLockEnter, self, idx)
end

function UILostLandMainController:_OnUnLockEnter(TT, idx)
  local enterData = self._enterData[idx]
  local unlockid = enterData:GetEnterID()
  local res = self._module:RequestLostAreaUnlockOnedifficulty(TT, unlockid)
  if res:GetSucc() then
    Log.debug("###[UILostLandMainController] 解锁成功")
    self._enterData[idx]:UnLock()
    self._enterPools[idx]:FlushData(self._enterData[idx])
  else
    Log.debug("###[UILostLandMainController] 解锁失败,res-->", res:GetResult())
  end
end

function UILostLandMainController:OnHide()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
end

function UILostLandMainController:InitTimer()
  self._resetTime = self._uiModule:GetResetTime()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTimerTex()
  end)
  self:SetTimerTex()
end

function UILostLandMainController:SetTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._resetTime - svrTime
  if sec < 0 then
    self:TimeReset()
  else
    local timeTex = self._uiModule:Time2Tex(sec)
    self._timerTex:SetText(StringTable.Get("str_lost_land_reset_time_tips", timeTex))
  end
end

function UILostLandMainController:TimeReset()
  Log.debug("###[UILostLandMainController] 时间到，迷失之地重置")
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self:ResetAnim()
  self._uiModule:ResetTime(UILostLandResetTimeDialog.Main)
end

function UILostLandMainController:weekBtnOnClick()
  self:ShowDialog("UILostLandWeekInfoController")
end
