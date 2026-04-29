_class("BuffLogicFillMonsterAntiAttackState", BuffLogicBase)
BuffLogicFillMonsterAntiAttackState = BuffLogicFillMonsterAntiAttackState

function BuffLogicFillMonsterAntiAttackState:Constructor(buffInstance, logicParam)
end

function BuffLogicFillMonsterAntiAttackState:DoLogic()
  local entity = self._buffInstance:Entity()
  if not entity then
    return
  end
  local attributeCmpt = entity:Attributes()
  local roundCount = "MaxAntiSkillCountPerRound"
  local curValue = attributeCmpt:GetAttribute(roundCount)
  local newValue = curValue - 1
  if newValue < 0 then
    newValue = 0
  end
  attributeCmpt:Modify(roundCount, newValue)
  local curAntiCount = attributeCmpt:GetAttribute("WaitActiveSkillCount")
  if curAntiCount == 0 then
    local originalAntiCount = attributeCmpt:GetAttribute("OriginalWaitActiveSkillCount")
    attributeCmpt:Modify("WaitActiveSkillCount", originalAntiCount)
  end
  local buffResult = BuffResultFillMonsterAntiAttackState:New(entity:GetID())
  return buffResult
end
