require("buff_logic_base")
_class("BuffLogicHPLock", BuffLogicBase)
BuffLogicHPLock = BuffLogicHPLock

function BuffLogicHPLock:Constructor(buffInstance, logicParam)
end

function BuffLogicHPLock:DoLogic(notify)
  local result = BuffResultHPLock:New(notify:GetIndex())
  return result
end
