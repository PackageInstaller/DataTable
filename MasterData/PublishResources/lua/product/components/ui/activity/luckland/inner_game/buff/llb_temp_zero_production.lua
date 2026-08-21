require("llb_logic_base")
_class("LLBuffLogicTempZeroProduction", LLBuffLogicBase)
LLBuffLogicTempZeroProduction = LLBuffLogicTempZeroProduction

function LLBuffLogicTempZeroProduction:Constructor(buffObj, logicParam)
  self._value = logicParam.value
end

function LLBuffLogicTempZeroProduction:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicTempZeroProduction:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:SetFinalTempZero(self._value)
end
