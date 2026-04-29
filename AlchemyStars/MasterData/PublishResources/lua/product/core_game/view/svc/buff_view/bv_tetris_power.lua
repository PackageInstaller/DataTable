_class("BuffViewTetrisChangePower", BuffViewBase)
BuffViewTetrisChangePower = BuffViewTetrisChangePower

function BuffViewTetrisChangePower:PlayView(TT, notify, trace)
  local featureSvcR = self._world:GetService("FeatureRender")
  featureSvcR:NotifyTetrisPower(TT, self._buffResult:GetNewPower())
end

function BuffViewTetrisChangePower:IsNotifyMatch(notify)
  if notify and (notify:GetNotifyType() == NotifyType.EntityMoveEnd or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd) then
    local n = notify
    local ntPosNew = n:GetPosNew()
    local resPosNew = self._buffResult:GetNewPos()
    if ntPosNew and resPosNew and ntPosNew == resPosNew then
      return true
    end
    return false
  end
  return true
end
