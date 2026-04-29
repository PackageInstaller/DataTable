_class("BuffLogicSetViewCanTurn", BuffLogicBase)
BuffLogicSetViewCanTurn = BuffLogicSetViewCanTurn

function BuffLogicSetViewCanTurn:Constructor(_, logicParam)
  self._canTurn = logicParam.canTurn
end

function BuffLogicSetViewCanTurn:DoLogic()
  self._entity:BuffComponent():SetBuffValue("MONSTER_VIEW_CAN_TURN", self._canTurn)
end

_class("BuffLogicRevertViewCanTurn", BuffLogicBase)
BuffLogicRevertViewCanTurn = BuffLogicRevertViewCanTurn

function BuffLogicRevertViewCanTurn:DoLogic()
  self._entity:BuffComponent():SetBuffValue("MONSTER_VIEW_CAN_TURN", nil)
end
