_class("BuffLogicFeatureDeath", BuffLogicBase)
BuffLogicFeatureDeath = BuffLogicFeatureDeath

function BuffLogicFeatureDeath:Constructor(buffInstance, logicParam)
end

function BuffLogicFeatureDeath:DoLogic(notify)
  if self._entity:HasDeadMark() then
    return
  end
  local skillLogic = self._world:GetService("SkillLogic")
  local curHp = self._entity:Attributes():GetCurrentHP()
  self._entity:Attributes():Modify("HP", 0)
  if self._entity:HasMonsterID() then
    local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
    self._entity:AddDeadMark()
    sMonsterShowLogic:DoLogicFeatureDead(self._entity)
  elseif self._entity:HasTrapID() then
    local trapServiceLogic = self._world:GetService("TrapLogic")
    trapServiceLogic:DoTrapFeatureDead(self._entity)
  else
    return
  end
  local buffResult = BuffResultFeatureDeath:New(self._entity:GetID())
  return buffResult
end
