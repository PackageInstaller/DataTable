require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionLossHpMonster", LLBuffLogicBase)
LLBuffLogicIncreaseProductionLossHpMonster = LLBuffLogicIncreaseProductionLossHpMonster

function LLBuffLogicIncreaseProductionLossHpMonster:Constructor(buffObj, logicParam)
  self._coefficient = logicParam.coefficient
end

function LLBuffLogicIncreaseProductionLossHpMonster:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local lossHpPercent = 0
  if notifyEntity:GetEntityType() == LuckLandEntityType.Monster then
    local monsterEntity = notifyEntity
    local maxHp = monsterEntity:MaxHp()
    local curHp = monsterEntity:GetCurHP()
    local lossHp = maxHp - curHp
    local lossHpPercent = lossHp / maxHp
    lossHpPercent = lossHpPercent * self._coefficient
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, lossHpPercent)
  end
end

function LLBuffLogicIncreaseProductionLossHpMonster:DoLogicSingle(target, tempPercent)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Temp then
    target:AddTempPerValue(tempPercent)
  end
end
