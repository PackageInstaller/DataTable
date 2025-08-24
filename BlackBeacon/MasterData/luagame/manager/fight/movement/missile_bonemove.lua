local Base = require("manager.fight.movement.missile_movement")
local M = Util.create_child_mt(Base)

function M:_init(missile)
  Base._init(self, missile)
end

function M:update()
end

return M
