_class("BuffLogicDeathInstant", BuffLogicBase)
BuffLogicDeathInstant = BuffLogicDeathInstant

function BuffLogicDeathInstant:Constructor(buffInstance, logicParam)
end

function BuffLogicDeathInstant:DoLogic(notify)
  if self._entity:HasDeadMark() then
    return
  end
  local buffLogicSvc = self:GetBuffLogicService()
  if not buffLogicSvc:IsTargetCanBeToDie(self._entity) then
    return
  end
  local skillLogic = self._world:GetService("SkillLogic")
  local curHp = self._entity:Attributes():GetCurrentHP()
  local damageInfo = DamageInfo:New(curHp * -1, DamageType.Real, nil, nil)
  self._entity:Attributes():SetSimpleAttribute("BuffDeathHp", curHp)
  local endHP = 0
  if not self._buffComponent:GetBuffValue("LockHPByRound") and not self._buffComponent:GetBuffValue("LockHPAlways") then
    endHP = 0
  else
    endHP = skillLogic:CalcTargetHP(self._entity:GetID(), damageInfo)
  end
  self._entity:Attributes():Modify("HP", endHP)
  Log.debug("BuffLogicDeathInstant ModifyHP =", endHP, " defender=", self._entity:GetID())
  if self._entity:MonsterID() and endHP == 0 then
    local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
    sMonsterShowLogic:AddMonsterDeadMark(self._entity)
    sMonsterShowLogic:_DoLogicDead(self._entity)
  end
  local casterID = notify:GetNotifyEntity():GetID()
  local hasDead = self._entity:HasDeadMark()
  local buffResult = BuffResultDeathInstant:New(casterID, hasDead)
  return buffResult
end
