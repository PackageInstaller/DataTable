_class("BuffLogicSetSleep", BuffLogicBase)
BuffLogicSetSleep = BuffLogicSetSleep

function BuffLogicSetSleep:Constructor(buffInstance, logicParam)
end

function BuffLogicSetSleep:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.SkipTurn)
  return true
end

_class("BuffLogicResetSleep", BuffLogicBase)
BuffLogicResetSleep = BuffLogicResetSleep

function BuffLogicResetSleep:Constructor(buffInstance, logicParam)
end

function BuffLogicResetSleep:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.SkipTurn)
  return true
end
