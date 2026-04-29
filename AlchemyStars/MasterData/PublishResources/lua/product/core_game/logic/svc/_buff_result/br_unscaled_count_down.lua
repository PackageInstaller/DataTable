_class("BuffResultStartUnscaledCountDown", BuffResultBase)
BuffResultStartUnscaledCountDown = BuffResultStartUnscaledCountDown

function BuffResultStartUnscaledCountDown:Constructor(flagID, cdMs, showGlobalUI)
  self._flagID = flagID
  self._countDownValue = cdMs
  self._showGlobalUI = showGlobalUI
end

function BuffResultStartUnscaledCountDown:GetFlagID()
  return self._flagID
end

function BuffResultStartUnscaledCountDown:GetCountDownValue()
  return self._countDownValue
end

function BuffResultStartUnscaledCountDown:GetShowGlobalUI()
  return self._showGlobalUI
end

_class("BuffResultStopUnscaledCountDown", BuffResultBase)
BuffResultStopUnscaledCountDown = BuffResultStopUnscaledCountDown

function BuffResultStopUnscaledCountDown:Constructor(flagID, hideGlobalUI)
  self._flagID = flagID
  self._hideGlobalUI = hideGlobalUI
end

function BuffResultStopUnscaledCountDown:GetFlagID()
  return self._flagID
end

function BuffResultStopUnscaledCountDown:GetHideGlobalUI()
  return self._hideGlobalUI
end
