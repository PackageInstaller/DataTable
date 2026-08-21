_class("UIN25IdolApResult", UIController)
UIN25IdolApResult = UIN25IdolApResult

function UIN25IdolApResult:Constructor()
end

function UIN25IdolApResult:OnShow(uiParams)
  self._type = uiParams[1]
  self._value = uiParams[2]
  self:OnValue()
end

function UIN25IdolApResult:OnValue()
  if self._type == IdolTrainType.IdolTrainType_Music then
  elseif self._type == IdolTrainType.IdolTrainType_Dance then
  elseif self._type == IdolTrainType.IdolTrainType_Perform then
  end
  local yieldTime = 2000
  self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
    self:CloseDialog()
  end)
end

function UIN25IdolApResult:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end
