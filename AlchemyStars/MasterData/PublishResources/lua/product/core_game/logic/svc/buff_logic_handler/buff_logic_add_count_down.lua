require("buff_logic_base")
_class("BuffLogicAddCountDown", BuffLogicBase)
BuffLogicAddCountDown = BuffLogicAddCountDown

function BuffLogicAddCountDown:Constructor(buffInstance, logicParam)
  self._value = logicParam.value
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
end

function BuffLogicAddCountDown:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local addValue = self._value
  local curCountDown, buffInstance = svc:AddCountDown(self._entity, self._layerType, addValue)
  if not buffInstance then
    return
  end
  local buffResult = BuffResultAddCountDown:New(curCountDown, buffInstance:BuffSeq(), self._layerType)
  return buffResult
end
