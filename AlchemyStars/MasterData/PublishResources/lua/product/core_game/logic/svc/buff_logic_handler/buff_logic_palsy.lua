_class("BuffLogicSetPalsy", BuffLogicBase)
BuffLogicSetPalsy = BuffLogicSetPalsy

function BuffLogicSetPalsy:Constructor(buffInstance, logicParam)
end

function BuffLogicSetPalsy:DoLogic()
  local e = self._buffInstance:Entity()
  return true
end

_class("BuffLogicResetPalsy", BuffLogicBase)
BuffLogicResetPalsy = BuffLogicResetPalsy

function BuffLogicResetPalsy:Constructor(buffInstance, logicParam)
end

function BuffLogicResetPalsy:DoLogic()
  local e = self._buffInstance:Entity()
  return true
end
