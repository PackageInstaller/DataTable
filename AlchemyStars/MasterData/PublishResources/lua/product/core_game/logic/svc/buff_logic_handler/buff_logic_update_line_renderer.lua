_class("BuffLogicUpdateLineRenderer", BuffLogicBase)
BuffLogicUpdateLineRenderer = BuffLogicUpdateLineRenderer

function BuffLogicUpdateLineRenderer:Constructor(buffInstance, logicParam)
  self._target = logicParam.target
  self._current = logicParam.current
  self._buffEffect = logicParam.buffEffect
end

function BuffLogicUpdateLineRenderer:DoLogic(notify)
  local buffResult = BuffResultUpdateLineRenderer:New(self._target, self._current, self._buffEffect)
  return buffResult
end
