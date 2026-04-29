require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionLossHp", LLBuffLogicBase)
LLBuffLogicIncreaseProductionLossHp = LLBuffLogicIncreaseProductionLossHp

function LLBuffLogicIncreaseProductionLossHp:Constructor(buffObj, logicParam)
  self._coefficient = logicParam.coefficient
end

function LLBuffLogicIncreaseProductionLossHp:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local curHp, maxHp = LuckLandInnerGameHelper.GetCurHP()
  local lossHp = maxHp - curHp
  local lossHpPercent = lossHp / maxHp
  lossHpPercent = lossHpPercent * self._coefficient
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, lossHpPercent)
  end
end

function LLBuffLogicIncreaseProductionLossHp:DoLogicSingle(target, tempPercent)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:AddTempPerValue(tempPercent)
end
