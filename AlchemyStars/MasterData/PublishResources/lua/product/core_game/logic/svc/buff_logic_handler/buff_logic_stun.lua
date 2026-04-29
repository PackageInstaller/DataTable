_class("BuffLogicSetStun", BuffLogicBase)
BuffLogicSetStun = BuffLogicSetStun

function BuffLogicSetStun:Constructor(buffInstance, logicParam)
end

function BuffLogicSetStun:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.SkipTurn)
  return true
end

_class("BuffLogicResetStun", BuffLogicBase)
BuffLogicResetStun = BuffLogicResetStun

function BuffLogicResetStun:Constructor(buffInstance, logicParam)
end

function BuffLogicResetStun:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.SkipTurn)
  return true
end
