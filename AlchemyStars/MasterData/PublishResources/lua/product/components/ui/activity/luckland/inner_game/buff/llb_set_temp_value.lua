require("llb_logic_base")
_class("LLBuffLogicSetTempValue", LLBuffLogicBase)
LLBuffLogicSetTempValue = LLBuffLogicSetTempValue

function LLBuffLogicSetTempValue:Constructor(buffObj, logicParam)
  self._key = logicParam.key
  self._value = logicParam.value
end

function LLBuffLogicSetTempValue:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicSetTempValue:DoLogicSingle(target)
  target:SetTempValue(self._key, self._value)
end
