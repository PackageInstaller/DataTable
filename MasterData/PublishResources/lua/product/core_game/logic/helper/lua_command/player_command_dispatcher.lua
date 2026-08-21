_class("PlayerCommandDispatcher", IEntityCommandDispatcher)

function PlayerCommandDispatcher:Constructor(world)
  self._world = world
end

function PlayerCommandDispatcher:HandleCommand(cmd)
  local cmdHandler = self._world:GetPlayerCommandHandler()
  cmdHandler:AddCommand(cmd)
  cmdHandler:HandleCommand()
end
