require("common_async_base")
_class("Maze_BuildTeamByRunData", Common_AsyncBase)
Maze_BuildTeamByRunData = Maze_BuildTeamByRunData

function Maze_BuildTeamByRunData:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function Maze_BuildTeamByRunData:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  if runData:IsRandomTeam() then
    self.m_pManager:AsyncBuildRandomMazeTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    elseif not result:GetCustomData("PetPstIDs") then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildMazeTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    end
  end
  local petPstID = result:GetCustomData("PetPstIDs")
  runData:SetCurrentTeamPstIDList(petPstID)
  self.m_nLogicResult = 1
  return
end
