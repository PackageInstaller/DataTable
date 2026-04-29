_class("BuffViewAddChangeTeamLeaderCount", BuffViewBase)
BuffViewAddChangeTeamLeaderCount = BuffViewAddChangeTeamLeaderCount

function BuffViewAddChangeTeamLeaderCount:PlayView(TT)
  local result = self:GetBuffResult()
  local newCount = result:GetNewCount()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIChangeTeamLeaderLeftCount, newCount)
end
