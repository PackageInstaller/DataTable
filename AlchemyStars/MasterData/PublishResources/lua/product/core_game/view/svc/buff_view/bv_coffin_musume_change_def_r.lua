_class("BuffViewCoffinMusumeChangeDefenceByCandle", BuffViewBase)
BuffViewCoffinMusumeChangeDefenceByCandle = BuffViewCoffinMusumeChangeDefenceByCandle

function BuffViewCoffinMusumeChangeDefenceByCandle:PlayView(TT, notify)
  local buffResult = self._buffResult
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateCoffinMusumeUIDef, buffResult)
end
