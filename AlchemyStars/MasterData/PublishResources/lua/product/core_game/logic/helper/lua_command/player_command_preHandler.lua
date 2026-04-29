_class("PlayerCommandPreHandler", IEntityCommandPreHandler)

function PlayerCommandPreHandler:BindOwner(owner)
  self.owner = owner
end

function PlayerCommandPreHandler:UnBindOwner()
  self.owner = nil
end

function PlayerCommandPreHandler:PreHandleCommand(cmd)
end
