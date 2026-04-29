_class("BuffLogicPlayEffect", BuffLogicBase)
BuffLogicPlayEffect = BuffLogicPlayEffect

function BuffLogicPlayEffect:Constructor(buffInstance, logicParam)
  self._effectID = logicParam.effectID
end

function BuffLogicPlayEffect:DoLogic()
  local buffResult = BuffResultPlayEffect:New(self._effectID)
  return buffResult
end
