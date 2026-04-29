_class("BuffLogicAddMiss", BuffLogicBase)
BuffLogicAddMiss = BuffLogicAddMiss

function BuffLogicAddMiss:Constructor(buffInstance, logicParam)
  self._miss = logicParam.miss
end

function BuffLogicAddMiss:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():AddBuffValue("Miss", self._miss)
end

_class("BuffLogicRemoveMiss", BuffLogicBase)
BuffLogicRemoveMiss = BuffLogicRemoveMiss

function BuffLogicRemoveMiss:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveMiss:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("Miss", 0)
end
