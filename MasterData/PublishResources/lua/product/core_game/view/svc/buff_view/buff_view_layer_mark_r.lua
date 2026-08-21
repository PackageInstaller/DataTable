_class("BuffViewLayerMark", BuffViewBase)
BuffViewLayerMark = BuffViewLayerMark

function BuffViewLayerMark:PlayView(TT)
  self._viewInstance:SetLayerCount(TT, self._buffResult:GetLayer())
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end

function BuffViewLayerMark:IsNotifyMatch(notify)
  local casterID = notify:GetCasterEntityID()
  local buffResult = self._buffResult
  return casterID == buffResult:GetEntityID()
end

_class("BuffViewRemoveLayerMark", BuffViewBase)
BuffViewRemoveLayerMark = BuffViewRemoveLayerMark

function BuffViewRemoveLayerMark:PlayView(TT)
  self._viewInstance:SetLayerCount(TT, self._buffResult:GetLayer())
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
