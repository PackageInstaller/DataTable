_class("BuffResultCoffinMusumeHarmReductionAndAttack", BuffResultBase)
BuffResultCoffinMusumeHarmReductionAndAttack = BuffResultCoffinMusumeHarmReductionAndAttack

function BuffResultCoffinMusumeHarmReductionAndAttack:Constructor(tLightCandleID, uiText, harmReductionVal, attackVal, lineList)
  self._tLightCandleID = tLightCandleID
  self._uiText = uiText or "str_battle_coffin_musume_harm_reduction"
  self._harmReductionVal = harmReductionVal
  self._attackVal = attackVal
  self._lineList = lineList
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetLightCandleIDs()
  return self._tLightCandleID
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetLightCandleCount()
  return #self._tLightCandleID
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetHarmReduction()
  return self._harmReductionVal
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetAttackVal()
  return self._attackVal
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetUIText()
  return self._uiText
end

function BuffResultCoffinMusumeHarmReductionAndAttack:GetLines()
  return self._lineList
end
