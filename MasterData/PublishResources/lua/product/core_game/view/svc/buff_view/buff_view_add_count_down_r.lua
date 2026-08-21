_class("BuffViewAddCountDown", BuffViewBase)
BuffViewAddCountDown = BuffViewAddCountDown

function BuffViewAddCountDown:PlayView(TT)
  local buffResult = self._buffResult
  local curCountDown = buffResult:GetCountDown()
  local buffseq = buffResult:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    return
  end
  viewInstance:SetCountDown(curCountDown)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end

function BuffViewAddCountDown:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  return true
end
