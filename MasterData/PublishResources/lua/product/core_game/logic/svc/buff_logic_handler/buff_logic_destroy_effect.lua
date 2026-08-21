_class("BuffLogicDestroyEffect", BuffLogicBase)
BuffLogicDestroyEffect = BuffLogicDestroyEffect

function BuffLogicDestroyEffect:Constructor(buffInstance, logicParam)
  self._objName = logicParam.objName
  self._time = logicParam.time
end

function BuffLogicDestroyEffect:DoLogic()
  local buffResult = BuffResultDestroyEffect:New(self._objName, self._time)
  return buffResult
end
