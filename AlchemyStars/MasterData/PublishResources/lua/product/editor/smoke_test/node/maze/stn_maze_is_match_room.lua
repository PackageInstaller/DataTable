require("base_state_node")
_class("Maze_IsMatchRoom", CTestRobot_Base)
Maze_IsMatchRoom = Maze_IsMatchRoom

function Maze_IsMatchRoom:OnWorking()
  local mazeRoomInfo = self.m_pRunData
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  local mazeModule = self:GetModule(MazeModule)
  local teamInfo = mazeModule:GetFormationInfo()
  ctx:InitMazeTeam(teamInfo)
  ctx:Init(TeamOpenerType.Maze, mazeRoomInfo.room_index)
  self:PrintLog("MazeFix, RoomIndex = ", mazeRoomInfo.room_index)
  if self:_IsNeedMatch(mazeRoomInfo) then
    self.m_nLogicResult = 1
  else
    self.m_nLogicResult = 0
  end
  self.m_pReturnData = self.m_pRunData
  return Maze_IsMatchRoom.super.OnWorking(self)
end

function Maze_IsMatchRoom:_IsNeedMatch(mazeRoomInfo)
  local configRoomData = Cfg.cfg_maze_room[mazeRoomInfo.room_id]
  if nil == configRoomData then
    return false
  end
  if MazeRoomType.MazeRoomType_Battery == configRoomData.MazeRoomType then
    return false
  end
  return true
end
