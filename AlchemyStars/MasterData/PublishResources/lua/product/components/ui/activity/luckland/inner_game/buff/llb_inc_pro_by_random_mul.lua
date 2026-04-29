require("llb_logic_base")
_class("LLBuffLogicIncProByRandomMul", LLBuffLogicBase)
LLBuffLogicIncProByRandomMul = LLBuffLogicIncProByRandomMul

function LLBuffLogicIncProByRandomMul:Constructor(buffObj, logicParam)
  self._min = logicParam.min
  self._max = logicParam.max
end

function LLBuffLogicIncProByRandomMul:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local randVal = math.random(self._min, self._max) * 0.01
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, randVal)
  end
end

function LLBuffLogicIncProByRandomMul:DoLogicSingle(target, randVal)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:SetFinalTempMulValue(randVal)
end
