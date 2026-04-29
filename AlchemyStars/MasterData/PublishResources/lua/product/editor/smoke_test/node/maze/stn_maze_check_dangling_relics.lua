require("base_state_node")
_class("Maze_CheckDanglingRelics", CTestRobot_Base)
Maze_CheckDanglingRelics = Maze_CheckDanglingRelics

function Maze_CheckDanglingRelics:OnWorking()
  local mazeModule = self:GetModule(MazeModule)
  local mazeInfo = mazeModule:GetMazeInfo()
  local nRelicCount = table.count(mazeInfo.dangling_relics)
  if 0 < nRelicCount then
    self.m_nLogicResult = 1
    self.m_pReturnData = mazeInfo.dangling_relics
  else
    self.m_nLogicResult = 0
  end
  return Maze_CheckDanglingRelics.super.OnWorking(self)
end
