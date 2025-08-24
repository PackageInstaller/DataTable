local Base = require("manager.magic.magic_imp.magic_base")
local CommonDef = require("cs_share.common_define")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  self.v_immune_count = self.cfg[3]
  self.owner.magic_mgr:add_immune_magic(self)
end

function M:immune_damage()
  if self.cfg[3] < 0 then
    return true
  end
  if self.v_immune_count < 0 then
    return false
  end
  self.v_immune_count = self.v_immune_count - 1
  if 0 == self.v_immune_count then
    local is_building = MagicReporter:is_building_report()
    MagicReporter:push_action_start(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
    self.owner.magic_mgr:remove_magic_by_rtid(self.rtid)
    MagicReporter:push_action_end(is_building, CommonDef.MAGIC_ACTION_TYPE.remove_magic_on_effect)
  end
  return true
end

function M:on_remove(magic_list)
  self.owner.magic_mgr:remove_immune_magic(self)
end

return M
