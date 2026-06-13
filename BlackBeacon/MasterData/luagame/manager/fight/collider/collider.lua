local Base = Util.create_class()
local M = Util.create_child_mt(Base)

function M:_init(char)
  self.v_char = char
end

function M:on_destroy()
  self.v_char = nil
  Util.unbind_all_msg(self)
end

function M:check_collider(target)
  return false
end

function M:is_circle()
  return false
end

function M:is_rect()
  return false
end

function M:is_sector()
  return false
end

function M:is_missile_sector()
  return false
end

return M
