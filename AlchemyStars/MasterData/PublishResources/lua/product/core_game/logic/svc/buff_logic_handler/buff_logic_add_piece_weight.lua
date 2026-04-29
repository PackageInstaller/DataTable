_class("BuffLogicAddPieceWeight", BuffLogicBase)
BuffLogicAddPieceWeight = BuffLogicAddPieceWeight

function BuffLogicAddPieceWeight:Constructor(buffInstance, logicParam)
  self._pieceType = logicParam.pieceType
  self._addValue = logicParam.addValue
end

function BuffLogicAddPieceWeight:DoLogic()
  local world = self._buffInstance:World()
  local boardServiceLogic = world:GetService("BoardLogic")
  boardServiceLogic:ModifyPieceWeight(self._pieceType, self._addValue, self._buffInstance:BuffSeq())
end

_class("BuffLogicRemovePieceWeight", BuffLogicBase)
BuffLogicRemovePieceWeight = BuffLogicRemovePieceWeight

function BuffLogicRemovePieceWeight:Constructor(buffInstance, logicParam)
end

function BuffLogicRemovePieceWeight:DoLogic()
  local world = self._buffInstance:World()
  local boardServiceLogic = world:GetService("BoardLogic")
  boardServiceLogic:RemoveModifyPieceWeight(self._pieceType, self._buffInstance:BuffSeq())
end
