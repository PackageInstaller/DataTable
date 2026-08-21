_class("BuffViewChangeFeatureCoinCount", BuffViewBase)
BuffViewChangeFeatureCoinCount = BuffViewChangeFeatureCoinCount

function BuffViewChangeFeatureCoinCount:IsNotifyMatch(notify)
  if notify:GetNotifyType() == NotifyType.PlayerEachMoveStart or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  elseif notify:GetNotifyType() == NotifyType.TrapSkillStart then
    local movePos = self._buffResult:GetMovePos()
    return movePos == notify:GetPos()
  else
    return true
  end
end

function BuffViewChangeFeatureCoinCount:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifyShopCoinCountChange(result:GetCurCount(), result:GetOldCount(), result:GetModifyValue())
  end
  local ntCoinCountChange = NTFeatureShopCoinCountChange:New(result:GetCurCount(), result:GetOldCount())
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntCoinCountChange)
end
