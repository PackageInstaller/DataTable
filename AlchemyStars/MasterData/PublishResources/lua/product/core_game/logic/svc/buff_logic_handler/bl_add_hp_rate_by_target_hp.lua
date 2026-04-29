_class("BuffLogicAddHPRateByTargetHP", BuffLogicBase)
BuffLogicAddHPRateByTargetHP = BuffLogicAddHPRateByTargetHP

function BuffLogicAddHPRateByTargetHP:Constructor(buffinstance, logicparam)
  self._rate = logicparam.rate
end

function BuffLogicAddHPRateByTargetHP:DoLogic(notify)
  self._buffComponent:SetBuffValue("AddHPRateByTargetHP", self._rate)
end

_class("BuffLogicRemoveHPRateByTargetHP", BuffLogicBase)
BuffLogicRemoveHPRateByTargetHP = BuffLogicRemoveHPRateByTargetHP

function BuffLogicRemoveHPRateByTargetHP:Constructor(buffinstance, logicparam)
  self._rate = logicparam.rate
end

function BuffLogicRemoveHPRateByTargetHP:DoLogic(notify)
  self._buffComponent:SetBuffValue("AddHPRateByTargetHP", 1)
end
