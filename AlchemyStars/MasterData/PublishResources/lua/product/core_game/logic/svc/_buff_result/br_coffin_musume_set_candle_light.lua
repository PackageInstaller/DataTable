_class("BuffResultCoffinMusumeSetCandleLight", BuffResultBase)
BuffResultCoffinMusumeSetCandleLight = BuffResultCoffinMusumeSetCandleLight

function BuffResultCoffinMusumeSetCandleLight:Constructor(isLightBefore, isLightAfter)
  self._isLightBefore = isLightBefore
  self._isLightAfter = isLightAfter
end

function BuffResultCoffinMusumeSetCandleLight:IsLightAfter()
  return self._isLightAfter
end
