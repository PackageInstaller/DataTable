require("command_base_handler")
require("move_path_done_command")
_class("MovePathDownCommandHandler_Maze", MovePathDownCommandHandler)
MovePathDownCommandHandler_Maze = MovePathDownCommandHandler_Maze

function MovePathDownCommandHandler_Maze:_HandlePetDead()
  local battleService = self._world:GetService("Battle")
  battleService:AddPetDeadMark()
end

function MovePathDownCommandHandler_Maze:_HandleNormalAttackDead()
  MovePathDownCommandHandler_Maze.super._HandleNormalAttackDead(self)
  self:_HandlePetDead()
end
