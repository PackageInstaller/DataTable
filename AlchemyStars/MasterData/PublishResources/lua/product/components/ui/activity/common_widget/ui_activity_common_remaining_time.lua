_class("UIActivityCommonRemainingTime", UICustomWidget)
UIActivityCommonRemainingTime = UIActivityCommonRemainingTime

function UIActivityCommonRemainingTime:_GetComponents()
  self._txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  if self._useLocalizedTMP then
    self._txtTime = self:GetUIComponent("UILocalizedTMP", "txtTime")
  end
end

function UIActivityCommonRemainingTime:OnShow()
  self._isOpen = true
  self:SetCustomTimeStr_Common_1()
end

function UIActivityCommonRemainingTime:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIActivityCommonRemainingTime:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIActivityCommonRemainingTime:SetData(endTime, tickCallback, stopCallback)
  self:_GetComponents()
  self._endTime = endTime
  self._tickCallback = tickCallback
  self._stopCallback = stopCallback
  self:_SetTimer()
end

function UIActivityCommonRemainingTime:SetTimeColor(timeColor)
  self._timeColor = timeColor
end

function UIActivityCommonRemainingTime:SetAdvanceText(descId)
  self._descId = descId
end

function UIActivityCommonRemainingTime:SetExtraText(widgetName, textColor, textId)
  widgetName = widgetName or "txtDesc"
  local txtExtra = self:GetUIComponent("UILocalizationText", widgetName)
  if not string.isnullorempty(textId) then
    self:_SetColorText(txtExtra, textColor, StringTable.Get(textId))
  end
end

function UIActivityCommonRemainingTime:SetExtraRollingText(widgetName)
  widgetName = widgetName or "txtTime"
  self._rollingText = self:GetUIComponent("RollingText", widgetName)
end

function UIActivityCommonRemainingTime:SetExtraSprite(widgetName, sprite)
  widgetName = widgetName or "icon"
  local icon = self:GetUIComponent("Image", widgetName)
  icon.sprite = sprite
end

function UIActivityCommonRemainingTime:SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityCommonRemainingTime:SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIActivityCommonRemainingTime:SetLocalizedTMPMaterial(matName)
  self._useLocalizedTMP = true
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "txtTime", matName, self._matReq)
end

function UIActivityCommonRemainingTime:SetCustomTimeStr(customStr)
  self._customStr = customStr
end

function UIActivityCommonRemainingTime:SetCustomTimeStr_Common_1()
  self:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  })
end

function UIActivityCommonRemainingTime:SetCustomTimeStr_Common_2()
  self:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_common_less_minute"
  })
end

function UIActivityCommonRemainingTime:_SetTimer()
  self._first = true
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
  if self._rollingText then
    self._rollingText:RefreshText(nil)
  end
end

function UIActivityCommonRemainingTime:_SetRemainingTimer()
  if not self._isOpen then
    return
  end
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local endTime = self._endTime
  local stamp = 0
  if endTime ~= nil then
    stamp = endTime - curTime
    local timeStr = UIActivityHelper.GetFormatTimerStr(stamp, self._customStr)
    self:_SetTimeText(timeStr)
  end
  if self._tickCallback then
    self._tickCallback()
  end
  if stamp <= 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    if self._stopCallback then
      self._stopCallback(self._first)
    end
    self:_SetTimeText(StringTable.Get(self._customStr.over))
    return true
  end
  self._first = false
end

function UIActivityCommonRemainingTime:_SetTimeText(content)
  if not string.isnullorempty(self._descId) then
    content = StringTable.Get(self._descId, content)
  end
  self:_SetColorText(self._txtTime, self._timeColor, content)
end

function UIActivityCommonRemainingTime:_SetColorText(uiText, colorStr, content)
  local showStr = content
  if not string.isnullorempty(colorStr) then
    local formatStr = "<color=#%s>%s</color>"
    showStr = string.format(formatStr, colorStr, content)
  end
  if uiText then
    uiText:SetText(showStr)
  end
end
