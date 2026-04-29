_class("BuffLogicChangeShaderValue", BuffLogicBase)
BuffLogicChangeShaderValue = BuffLogicChangeShaderValue

function BuffLogicChangeShaderValue:Constructor(buffInstance, logicParam)
  self._root = logicParam.root
  self._param = logicParam.param
end

function BuffLogicChangeShaderValue:DoLogic(notify)
  local buffResult = BuffResultChangeShaderValue:New(self._root, self._param, notify:GetHPPercent())
  return buffResult
end
