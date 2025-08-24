local Base = require("manager.fight.collider.collider")
local M = Util.create_child_mt(Base)

function M:_init(char, width, height)
  Base._init(self, char)
  self.v_width = width
  self.v_half_width = width / 2
  self.v_height = height
end

function M:check_collider(target)
  return true
end

function M:_check_rect_collide(target)
end

function M:is_circle()
  return true
end

return M
