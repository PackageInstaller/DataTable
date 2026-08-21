require("base_state_node")
_class("Maze_RecoverFormation", Common_AsyncBase)
Maze_RecoverFormation = Maze_RecoverFormation

function Maze_RecoverFormation:TaskFunc(TT)
  local runData = self.m_pManager:GetMissionRunData()
  local petPstIds = runData:GetCurrentTeamPstIDList()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local teamCtx = missionModule:TeamCtx()
  local mazeTeam = teamCtx:GetMazeTeam()
  local mazeModule = GameGlobal.GetModule(MazeModule)
  mazeModule:UpdateMazeFormationInfo(TT, teamCtx.mazeTeamId, mazeTeam.name, petPstIds)
end
