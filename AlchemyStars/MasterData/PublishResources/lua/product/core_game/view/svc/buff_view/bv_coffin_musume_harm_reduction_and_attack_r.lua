_class("BuffViewCoffinMusumeHarmReductionAndAttack", BuffViewBase)
BuffViewCoffinMusumeHarmReductionAndAttack = BuffViewCoffinMusumeHarmReductionAndAttack

function BuffViewCoffinMusumeHarmReductionAndAttack:PlayView(TT, notify)
  local buffResult = self._buffResult
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateCoffinMusumeUIAtkDef, buffResult)
end
