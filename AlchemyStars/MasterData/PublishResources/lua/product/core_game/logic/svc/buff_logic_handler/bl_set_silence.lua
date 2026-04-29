require("buff_logic_base")
_class("BuffLogicSetSilence", BuffLogicBase)
BuffLogicSetSilence = BuffLogicSetSilence

function BuffLogicSetSilence:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.Silence)
end

_class("BuffLogicResetSilence", BuffLogicBase)
BuffLogicResetSilence = BuffLogicResetSilence

function BuffLogicResetSilence:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.Silence)
end
