_class("BuffViewSetBoardPieceMapWithTrap", BuffViewBase)
BuffViewSetBoardPieceMapWithTrap = BuffViewSetBoardPieceMapWithTrap

function BuffViewSetBoardPieceMapWithTrap:PlayView(TT)
end

function BuffViewSetBoardPieceMapWithTrap:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
