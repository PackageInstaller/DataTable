local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
  self.fix_heal_val = self.cfg[1]
end

function M:on_effect(magic_list)
end

function M.on_trigger_effect(magic_mgr, magic_map)
  local value = 0
  for _, magic in pairs(magic_map) do
    local fix_val = magic.fix_heal_val or 0
    value = value + fix_val
  end
  M.remove_magic_on_effect(magic_mgr, magic_map)
  return value / 10000
end

return M
