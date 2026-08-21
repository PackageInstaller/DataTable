_class("BuffViewCoffinMusumeHarmReduction", BuffViewBase)
BuffViewCoffinMusumeHarmReduction = BuffViewCoffinMusumeHarmReduction

function BuffViewCoffinMusumeHarmReduction:PlayView(TT, notify)
  local buffResult = self._buffResult
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateCoffinMusumeUIDef, buffResult)
end
