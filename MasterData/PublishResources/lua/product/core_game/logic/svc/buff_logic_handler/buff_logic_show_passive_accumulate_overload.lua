_class("BuffLogicShowPassiveAccumulateOverload", BuffLogicBase)
BuffLogicShowPassiveAccumulateOverload = BuffLogicShowPassiveAccumulateOverload

function BuffLogicShowPassiveAccumulateOverload:Constructor(buffInstance, logicParam)
  self._showOverload = logicParam.showOverload
end

function BuffLogicShowPassiveAccumulateOverload:DoLogic(notify)
  local buffResult = BuffResultShowPassiveAccumulateOverload:New(self._showOverload)
  return buffResult
end
