require("llb_logic_base")
_class("LLBuffLogicIncProFinalTempFactor", LLBuffLogicBase)
LLBuffLogicIncProFinalTempFactor = LLBuffLogicIncProFinalTempFactor

function LLBuffLogicIncProFinalTempFactor:Constructor(buffObj, logicParam)
  self._val = logicParam.value
end

function LLBuffLogicIncProFinalTempFactor:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicIncProFinalTempFactor:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:AddFinalTempFactorValue(self._val)
end
