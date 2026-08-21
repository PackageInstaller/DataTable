_class("BuffLogicEnableRecordSkillDamageTarget", BuffLogicBase)
BuffLogicEnableRecordSkillDamageTarget = BuffLogicEnableRecordSkillDamageTarget

function BuffLogicEnableRecordSkillDamageTarget:Constructor(buffInstance, logicParam)
  local isEnable = logicParam.enable or 1
  self._isEnable = isEnable == 1
end

function BuffLogicEnableRecordSkillDamageTarget:DoLogic()
  local e = self._buffInstance:Entity()
  local uniqueBattleStat = self._world:BattleStat()
  if self._isEnable then
    uniqueBattleStat:EnableAffixUseSkillDamageRecord()
  else
    uniqueBattleStat:DisableAffixUseSkillDamageRecord()
  end
end
