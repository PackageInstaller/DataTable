require("buff_logic_base")
_class("BuffLogicPlayAnim", BuffLogicBase)
BuffLogicPlayAnim = BuffLogicPlayAnim

function BuffLogicPlayAnim:Constructor(buffInstance, logicParam)
end

function BuffLogicPlayAnim:DoLogic(notify)
  return true
end

require("buff_logic_base")
_class("BuffLogicStopAnim", BuffLogicBase)
BuffLogicStopAnim = BuffLogicStopAnim

function BuffLogicStopAnim:Constructor(buffInstance, logicParam)
end

function BuffLogicStopAnim:DoLogic(notify)
  return true
end
