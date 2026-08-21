require("main_state_sys")
_class("RoleChangeTeamLeaderSystem", MainStateSystem)
RoleChangeTeamLeaderSystem = RoleChangeTeamLeaderSystem

function RoleChangeTeamLeaderSystem:_GetMainStateID()
  return GameStateID.RoleChangeTeamLeader
end

function RoleChangeTeamLeaderSystem:_OnMainStateEnter(TT)
  self:_DoRenderChangeTeamLeader(TT)
  self._world:EventDispatcher():Dispatch(GameEventType.RoleChangeTeamLeaderFinish, 1)
end

function RoleChangeTeamLeaderSystem:_DoRenderChangeTeamLeader(TT)
end
