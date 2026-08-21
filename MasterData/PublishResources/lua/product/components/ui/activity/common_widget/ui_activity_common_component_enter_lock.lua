_class("UIActivityCommonComponentEnterLock", UICustomWidget)
UIActivityCommonComponentEnterLock = UIActivityCommonComponentEnterLock
local EActivityComponentLockBtnState = {
  LockWithTime = 1,
  Lock = 2,
  Unlock = 3,
  Closed = 4
}
_enum("EActivityComponentLockBtnState", EActivityComponentLockBtnState)

function UIActivityCommonComponentEnterLock:OnShow()
  self:_AttachEvents()
  self._isOpen = true
end

function UIActivityCommonComponentEnterLock:OnHide()
  self:_DetachEvents()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIActivityCommonComponentEnterLock:SetNew(widgetName, checkNewFunc)
  self._widgetName_New = widgetName
  self._checkNewFunc = checkNewFunc
end

function UIActivityCommonComponentEnterLock:SetRed(widgetName, checkRedFunc)
  self._widgetName_Red = widgetName
  self._checkRedFunc = checkRedFunc
end

function UIActivityCommonComponentEnterLock:SetRedCount(widgetName, widgetNameText, checkRedFunc)
  self._widgetName_RedCount = widgetName
  self._widgetName_RedCountText = widgetNameText
  self._checkRedFunc = checkRedFunc
end

function UIActivityCommonComponentEnterLock:SetNew_RedDotModule(widgetName, newdotType)
  self._widgetName_New = widgetName
  self._newdotType = newdotType
end

function UIActivityCommonComponentEnterLock:SetRed_RedDotModule(widgetName, reddotType)
  self._widgetName_Red = widgetName
  self._reddotType = reddotType
end

function UIActivityCommonComponentEnterLock:SetLockStateCallback(lockWithTimeCallback, lockCallback, closedCallback)
  self._lockWithTimeCallback = lockWithTimeCallback
  self._lockCallback = lockCallback
  self._closedCallback = closedCallback
end

function UIActivityCommonComponentEnterLock:SetActivityCommonRemainingTime(widgetName, descId, endTime, customTimeStr, tickCallback, stopCallback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UIActivityCommonComponentEnterLock:SetWidgetNameGroup(widgetNameGroup)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup)
end

function UIActivityCommonComponentEnterLock:SetData(campaign, componentId, uiCallback)
  self._campaign = campaign
  self._componentId = componentId
  self._component = self._campaign:GetComponent(componentId)
  self._uiCallback = uiCallback
  self:_SetTimerForUpdate()
  self:_CheckPoint()
end

function UIActivityCommonComponentEnterLock:_SetTimerForUpdate()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    if self._isOpen then
      self:_Refresh()
    end
  end)
end

function UIActivityCommonComponentEnterLock:_Refresh()
  local state = self:_CheckState()
  if self._state ~= state then
    local reload = self._state == EActivityComponentLockBtnState.LockWithTime
    if reload then
      self:_ReloadCampaignInfo_ChangeState()
    else
      self:_ChangeState()
    end
  end
  self:_CheckPoint()
end

function UIActivityCommonComponentEnterLock:_CheckState()
  local component = self._component
  if not component then
    Log.info("UIActivityCommonComponentEnterLock:_CheckState() component == nil")
    return EActivityComponentLockBtnState.Closed
  end
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local unlockTime = component:ComponentUnLockTime()
  local stamp = unlockTime - curTime
  if component:ComponentIsClose() then
    return EActivityComponentLockBtnState.Closed
  elseif 0 < stamp then
    return EActivityComponentLockBtnState.LockWithTime
  elseif not component:ComponentIsUnLock() then
    return EActivityComponentLockBtnState.Lock
  else
    return EActivityComponentLockBtnState.Unlock
  end
end

function UIActivityCommonComponentEnterLock:_ReloadCampaignInfo_ChangeState()
  local lockName = "UIActivityCommonComponentEnterLock:_ReloadCampaignInfo_ChangeState()"
  self:Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_ChangeState()
    self:UnLock(lockName)
  end)
end

function UIActivityCommonComponentEnterLock:_ChangeState()
  local state = self:_CheckState()
  if self._state ~= state and self._isOpen and self._stateObj then
    UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
  end
  self._state = state
end

function UIActivityCommonComponentEnterLock:BtnOnClick()
  Log.info("UIActivityCommonComponentEnterLock:BtnOnClick")
  
  local function unlockCallback()
    UIActivityHelper.PlayFirstPlot_Component(self._campaign, self._componentId, function()
      if self._uiCallback then
        self._uiCallback()
      end
    end)
  end
  
  local func = {
    [EActivityComponentLockBtnState.LockWithTime] = self._lockWithTimeCallback,
    [EActivityComponentLockBtnState.Lock] = self._lockCallback,
    [EActivityComponentLockBtnState.Unlock] = unlockCallback,
    [EActivityComponentLockBtnState.Closed] = self._closedCallback
  }
  local callback = func[self._state]
  if callback then
    callback()
  end
end

function UIActivityCommonComponentEnterLock:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityCommonComponentEnterLock:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityCommonComponentEnterLock:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIActivityCommonComponentEnterLock:_OnQuestUpdate()
  self:_CheckPoint()
end

function UIActivityCommonComponentEnterLock:_CheckPoint()
  if self._newdotType or self._reddotType then
    self:_CheckPoint_RedDotModule()
    return
  end
  local new = self._checkNewFunc and self._checkNewFunc() or false
  local red = self._checkRedFunc and self._checkRedFunc() or false
  UIWidgetHelper.SetNewAndReds(self, new, red, self._widgetName_New, self._widgetName_Red, self._widgetName_RedCount, self._widgetName_RedCountText)
end

function UIActivityCommonComponentEnterLock:_CheckPoint_RedDotModule()
  GameGlobal.TaskManager():StartTask(function(TT)
    local checkList = {}
    checkList[#checkList + 1] = self._newdotType
    checkList[#checkList + 1] = self._reddotType
    local redDotModule = GameGlobal.GetModule(RedDotModule)
    local results = redDotModule:RequestRedDotStatus(TT, checkList)
    local new = results[self._newdotType]
    local red = results[self._reddotType]
    UIWidgetHelper.SetNewAndReds(self, new, red, self._widgetName_New, self._widgetName_Red, self._widgetName_RedCount, self._widgetName_RedCountText)
  end)
end
