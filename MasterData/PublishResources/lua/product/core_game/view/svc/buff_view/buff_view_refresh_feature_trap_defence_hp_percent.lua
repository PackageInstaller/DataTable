_class("BuffViewRefreshFeatureTrapDefenceHPPercent", BuffViewBase)
BuffViewRefreshFeatureTrapDefenceHPPercent = BuffViewRefreshFeatureTrapDefenceHPPercent

function BuffViewRefreshFeatureTrapDefenceHPPercent:PlayView(TT)
  local result = self._buffResult
  local curHPPercent = result:GetHPPercent()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshFeatureTrapDefenceHPPercent, curHPPercent)
end
