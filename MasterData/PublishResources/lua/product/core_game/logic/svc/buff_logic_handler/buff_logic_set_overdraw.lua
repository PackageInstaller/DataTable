require("buff_logic_base")
_class("BuffLogicSetOverdraw", BuffLogicBase)
BuffLogicSetOverdraw = BuffLogicSetOverdraw

function BuffLogicSetOverdraw:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.Overdraw)
end

_class("BuffLogicResetOverdraw", BuffLogicBase)
BuffLogicResetOverdraw = BuffLogicResetOverdraw

function BuffLogicResetOverdraw:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.Overdraw)
end
