_class("BuffViewRefreshTeamState", BuffViewBase)
BuffViewRefreshTeamState = BuffViewRefreshTeamState

function BuffViewRefreshTeamState:PlayView(TT, notify, trace)
  if self._world:Player():IsLocalTeamEntity(self._entity) == false then
    return
  end
  local buffView = self._entity:BuffView()
  local teamBuffList = buffView:GetBuffTeamStateShowList()
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeTeamBuff, teamBuffList)
end
