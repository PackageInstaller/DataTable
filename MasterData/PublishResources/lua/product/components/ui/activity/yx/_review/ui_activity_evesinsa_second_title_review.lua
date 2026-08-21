_class("UIActivityEveSinsaSecondTitle_Review", UICustomWidget)
UIActivityEveSinsaSecondTitle_Review = UIActivityEveSinsaSecondTitle_Review

function UIActivityEveSinsaSecondTitle_Review:_GetComponents()
  self._titleText = self:GetUIComponent("UILocalizationText", "_titleText")
  self._remainingText = self:GetUIComponent("UILocalizationText", "_remainingText")
end

function UIActivityEveSinsaSecondTitle_Review:OnShow()
  self._isOpen = true
  self:_GetComponents()
end

function UIActivityEveSinsaSecondTitle_Review:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
end

function UIActivityEveSinsaSecondTitle_Review:SetData(campaign, type)
  self._campaign = campaign
  self._type = type
  self:_SetTitle()
end

function UIActivityEveSinsaSecondTitle_Review:_SetTitle()
  local id = "str_activity_evesinsa_main_levelabtn"
  if self._type == 1 then
    id = "str_activity_evesinsa_main_levelbbtn"
  end
  self._titleText:SetText(StringTable.Get(id))
end

function UIActivityEveSinsaSecondTitle_Review:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIActivityEveSinsaSecondTitle_Review:_SetRemainingTimer()
  if self._isOpen then
    local uiText = self._remainingText
    local formatStr = "<color=#%s>%s</color>"
    local colorStr = "FFFFFF"
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local endTime = UIActivityEveSinsaHelper.GetPhaseEndTime(self._campaign, EActivityEveSinsaTimePhase.EPhase_Tree)
    local stamp = endTime - curTime
    local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
    local showStr = string.format(formatStr, colorStr, timeStr)
    uiText:SetText(showStr)
    if stamp <= 0 then
      self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
      return true
    end
  end
end
