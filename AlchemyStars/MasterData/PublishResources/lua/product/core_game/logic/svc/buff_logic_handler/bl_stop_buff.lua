require("buff_logic_base")
_class("BuffLogicStopBuff", BuffLogicBase)
BuffLogicStopBuff = BuffLogicStopBuff

function BuffLogicStopBuff:Constructor(buffInstance, logicParam)
end

function BuffLogicStopBuff:DoLogic()
  local buffComponent = self._entity:BuffComponent()
  buffComponent:SetBuffValue("Freeze", 1)
end

_class("BuffLogicResumeBuff", BuffLogicBase)
BuffLogicResumeBuff = BuffLogicResumeBuff

function BuffLogicResumeBuff:Constructor(buffInstance, logicParam)
end

function BuffLogicResumeBuff:DoLogic()
  local buffComponent = self._entity:BuffComponent()
  buffComponent:SetBuffValue("Freeze", nil)
end
