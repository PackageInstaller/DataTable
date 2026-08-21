_class("BuffLogicClearRecordForceMovementStep", BuffLogicBase)
BuffLogicClearRecordForceMovementStep = BuffLogicClearRecordForceMovementStep

function BuffLogicClearRecordForceMovementStep:Constructor(buffInstance, logicParam)
end

function BuffLogicClearRecordForceMovementStep:DoLogic()
  local buffValueKey = "CurRoundForceMoveStep"
  self._buffComponent:SetBuffValue(buffValueKey, 0)
end
