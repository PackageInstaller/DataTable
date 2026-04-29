require("_buff_result_base")
_class("BuffResultSetBoardPieceMapWithTrap", BuffResultBase)
BuffResultSetBoardPieceMapWithTrap = BuffResultSetBoardPieceMapWithTrap

function BuffResultSetBoardPieceMapWithTrap:Constructor(mapByPosition)
  self._mapByPosition = mapByPosition
end

function BuffResultSetBoardPieceMapWithTrap:GetMapByPosition()
  return self._mapByPosition
end
