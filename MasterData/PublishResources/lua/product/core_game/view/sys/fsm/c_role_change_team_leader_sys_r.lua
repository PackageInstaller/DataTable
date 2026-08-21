require("role_change_team_leader_system")
_class("ClientRoleChangeTeamLeaderSystem_Render", RoleChangeTeamLeaderSystem)
ClientRoleChangeTeamLeaderSystem_Render = ClientRoleChangeTeamLeaderSystem_Render

function ClientRoleChangeTeamLeaderSystem_Render:_DoRenderChangeTeamLeader(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamOrderBefore, teamOrderAfter = teamEntity:Team():GetChangeTeamLeaderCmdData()
  local request = BattleTeamOrderViewRequest:New(teamOrderBefore, teamOrderAfter, BattleTeamOrderViewType.Exchange_ChangeTeamLeader)
  local renderBattleService = self._world:GetService("RenderBattle")
  renderBattleService:RequestUIChangeTeamOrderView(request)
  local utilDataSvc = self._world:GetService("UtilData")
  local leftChangeTeamLeaderCount = utilDataSvc:GetEntityAttributeByName(teamEntity, "ChangeTeamLeaderCount")
  local newTeamLeaderPetPstID = teamOrderAfter[1]
  local oldTeamLeaderPetPstID = teamOrderBefore[1]
  self._world:EventDispatcher():Dispatch(GameEventType.UIChangeTeamLeader, newTeamLeaderPetPstID, oldTeamLeaderPetPstID, leftChangeTeamLeaderCount, teamOrderBefore, teamOrderAfter)
  self._world:EventDispatcher():Dispatch(GameEventType.UIChangeTeamLeaderLeftCount, leftChangeTeamLeaderCount)
  local waitUIFinish = 0.5
  YIELD(TT, waitUIFinish * 1000)
  local ntTeamOrderChange = NTTeamOrderChange:New(teamEntity, teamOrderBefore, teamOrderAfter)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, ntTeamOrderChange)
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end
