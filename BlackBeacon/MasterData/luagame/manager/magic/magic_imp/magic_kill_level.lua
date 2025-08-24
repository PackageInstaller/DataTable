local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

local RATIO_IN = 1.0E-4

function M:on_effect()
  local value = self.cfg[2]
  if type(value) == "table" then
    self.magic_value = value[self.magic_level] or 0
  else
    self.magic_value = value
  end
end

function M:get_magic_val()
  return self.magic_value
end

return M
