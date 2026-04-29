_class("BuffViewMapPieceType", BuffViewBase)
BuffViewMapPieceType = BuffViewMapPieceType

function BuffViewMapPieceType:PlayView(TT)
end

function BuffViewMapPieceType:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
