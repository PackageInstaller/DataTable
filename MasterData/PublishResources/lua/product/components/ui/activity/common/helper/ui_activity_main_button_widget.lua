_class("UIActivityMainButtonWidget", Object)
UIActivityMainButtonWidget = UIActivityMainButtonWidget

function UIActivityMainButtonWidget:Constructor(uiView, activityConst, componentId, checkRedComponentIds, checkNewComponentIds, activeCustomConst, callback, remainStr, unlockTimeStr, unlockMissionStr, extraCustomCheckRed)
  self._activityConst = activityConst
  self._checkRedComponentIds = checkRedComponentIds
  self._checkNewComponentIds = checkNewComponentIds
  self._extraCustomCheckRed = extraCustomCheckRed
  self._callback = callback
  self._remainStr = remainStr
  self._unlockTimeStr = unlockTimeStr
  self._unlockMissionStr = unlockMissionStr
  self._activeCustomConst = activeCustomConst
  self._componentId = componentId
  self._uiView = uiView
  self._red = self._uiView:GetGameObject("red")
  self._new = self._uiView:GetGameObject("new")
  self._open = self._uiView:GetGameObject("open")
  self._remaintime = self._uiView:GetUIComponent("UILocalizationText", "remaintime")
  self._close = self._uiView:GetGameObject("close")
  self._lock = self._uiView:GetGameObject("lock")
  self.locktips = self._uiView:GetUIComponent("UILocalizationText", "locktips")
  if self._red then
    self._red:SetActive(false)
  end
  if self._new then
    self._new:SetActive(false)
  end
end

function UIActivityMainButtonWidget:SetCustomTimeStr(dayStr, hourStr, minusStr, lessOneMinusStr)
  self._dayStr = dayStr
  self._hourStr = hourStr
  self._minusStr = minusStr
  self._lessOneMinusStr = lessOneMinusStr
end

function UIActivityMainButtonWidget:Init()
  self:RefreshRedAndNew()
  self._buttonStatus = UIActivityButtonStatus:New(function()
    return self._activeCustomConst:GetComponentStatus(self._componentId)
  end, function(TT)
    self:ReLoadData(TT, self._componentId)
  end, function(status, timeStr)
    if self._open then
      self._open:SetActive(false)
    end
    if self._close then
      self._close:SetActive(false)
    end
    if self._lock then
      self._lock:SetActive(false)
    end
    if status == ActivityComponentStatus.Open then
      if self._open then
        self._open:SetActive(true)
      end
      if self._remaintime then
        self._remaintime:SetText(StringTable.Get(self._remainStr, timeStr))
      end
    elseif status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd or status == ActivityComponentStatus.None then
      if self._close then
        self._close:SetActive(true)
      end
    elseif status == ActivityComponentStatus.TimeLock then
      if self._lock then
        self._lock:SetActive(true)
      end
      if self.locktips then
        self.locktips:SetText(StringTable.Get(self._unlockTimeStr, timeStr))
      end
    elseif status == ActivityComponentStatus.MissionLock then
      if self._lock then
        self._lock:SetActive(true)
      end
      if self.locktips then
        self.locktips:SetText(StringTable.Get(self._unlockMissionStr))
      end
    end
  end, self._dayStr, self._hourStr, self._minusStr, self._lessOneMinusStr)
end

function UIActivityMainButtonWidget:Refresh()
  if self._buttonStatus then
    self._buttonStatus:CheckButtonStatus()
  end
end

function UIActivityMainButtonWidget:RefreshRedAndNew()
  if self._red then
    local red = self._activeCustomConst:IsShowComponentRed(self._componentId)
    if self._checkRedComponentIds then
      for i = 1, #self._checkRedComponentIds do
        if self._activeCustomConst:IsShowComponentRed(self._checkRedComponentIds[i]) then
          red = true
          break
        end
      end
    end
    if self._extraCustomCheckRed and not red then
      local comOpen = self._activeCustomConst:GetComponentStatus(self._componentId)
      if comOpen and comOpen == ActivityComponentStatus.Open then
        red = self._extraCustomCheckRed()
      end
    end
    self._red:SetActive(red)
  end
  if self._new then
    local shownew = self._activeCustomConst:IsShowComponentNew(self._componentId)
    if self._checkNewComponentIds then
      for i = 1, #self._checkNewComponentIds do
        if self._activeCustomConst:IsShowComponentNew(self._checkNewComponentIds[i]) then
          shownew = true
          break
        end
      end
    end
    self._new:SetActive(shownew)
    if shownew and self._red then
      self._red:SetActive(false)
    end
  end
end

function UIActivityMainButtonWidget:Release()
  if self._buttonStatus then
    self._buttonStatus:Release()
    self._buttonStatus = nil
  end
end

function UIActivityMainButtonWidget:ReLoadData(TT, key)
  GameGlobal.UIStateManager():Lock("UIActivityMainButtonWidget_ReLoadData" .. key)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  GameGlobal.UIStateManager():UnLock("UIActivityMainButtonWidget_ReLoadData" .. key)
end

function UIActivityMainButtonWidget:BtnOnClick()
  local status, time = self._activeCustomConst:GetComponentStatus(self._componentId)
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    if status == ActivityComponentStatus.ActivityEnd then
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
    return
  elseif status == ActivityComponentStatus.TimeLock then
    ToastManager.ShowToast(StringTable.Get(self._unlockTimeStr, UIActivityCustomHelper.GetTimeString(time, self._dayStr, self._hourStr, self._minusStr, self._lessOneMinusStr)))
    return
  elseif status == ActivityComponentStatus.MissionLock then
    ToastManager.ShowToast(StringTable.Get(self._unlockMissionStr))
    return
  end
  self._activeCustomConst:ClearComponentNew(self._componentId)
  self:RefreshRedAndNew()
  if self._callback then
    self._callback()
  end
end
