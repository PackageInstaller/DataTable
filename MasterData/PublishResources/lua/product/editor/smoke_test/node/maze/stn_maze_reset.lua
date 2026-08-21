require("base_state_node")
_class("Maze_Reset", CTestRobot_Base)
Maze_Reset = Maze_Reset

function Maze_Reset:OnWorking()
  local strcmd = string.format("reset_maze %s", LocalDB.GetString("OpenIdTest"))
  self.m_pManager:SendCheatCommand(strcmd)
  self.m_pManager:Log(self, "Command sent: ", strcmd)
  return Maze_Reset.super.OnWorking(self)
end
