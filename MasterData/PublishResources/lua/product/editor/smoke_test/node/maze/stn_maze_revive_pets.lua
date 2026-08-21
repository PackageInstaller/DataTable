require("base_state_node")
_class("Maze_RevivePets", Common_AsyncBase)
Maze_RevivePets = Maze_RevivePets

function Maze_RevivePets:TaskFunc(TT, status)
  self.m_pManager:AsyncGM_RevivePets(TT, status)
end
