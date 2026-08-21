_class("BuffResultCoffinMusumeHarmReduction", BuffResultBase)
BuffResultCoffinMusumeHarmReduction = BuffResultCoffinMusumeHarmReduction

function BuffResultCoffinMusumeHarmReduction:Constructor(tLightCandleID, uiText, val, lineList)
  self._tLightCandleID = tLightCandleID
  self._uiText = uiText or "str_battle_harm_reduction"
  self._val = val
  self._lineList = lineList
end

function BuffResultCoffinMusumeHarmReduction:GetLightCandleIDs()
  return self._tLightCandleID
end

function BuffResultCoffinMusumeHarmReduction:GetLightCandleCount()
  return #self._tLightCandleID
end

function BuffResultCoffinMusumeHarmReduction:GetHarmReduction()
  return self._val
end

function BuffResultCoffinMusumeHarmReduction:GetUIText()
  return self._uiText
end

function BuffResultCoffinMusumeHarmReduction:GetLines()
  return self._lineList
end
