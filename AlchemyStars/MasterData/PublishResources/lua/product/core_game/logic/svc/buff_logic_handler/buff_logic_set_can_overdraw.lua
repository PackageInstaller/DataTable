require("buff_logic_base")
_class("BuffLogicSetCanOverdraw", BuffLogicBase)
BuffLogicSetCanOverdraw = BuffLogicSetCanOverdraw

function BuffLogicSetCanOverdraw:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.CanOverdraw)
end

_class("BuffLogicResetCanOverdraw", BuffLogicBase)
BuffLogicResetCanOverdraw = BuffLogicResetCanOverdraw

function BuffLogicResetCanOverdraw:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.CanOverdraw)
end
