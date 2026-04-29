_class("BuffViewChangeMaintainColorTrapEffect", BuffViewBase)
BuffViewChangeMaintainColorTrapEffect = BuffViewChangeMaintainColorTrapEffect

function BuffViewChangeMaintainColorTrapEffect:PlayView(TT, notify)
end

function BuffViewChangeMaintainColorTrapEffect:IsNotifyMatch(notify)
  local result = self._buffResult
  local notifyType = result:GetNotifyType()
  local pos = result:GetPos()
  local beforePieceType = result:GetBeforePieceType()
  local afterPieceType = result:GetAfterPieceType()
  if notifyType ~= notify:GetNotifyType() then
    return false
  end
  if notifyType == NotifyType.GridConvert then
    local convertInfo = notify:GetConvertInfoAt(pos)
    if not convertInfo then
      return false
    end
  end
  return true
end
