local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

local VALUE_TYPE = {FIXED = 1, RATIO = 2}
local RATIO_IN = 1.0E-4

function M:on_effect()
  local value = self.cfg[1]
  local value_type = self.cfg[2]
  local tar_ratio_type = self.cfg[3]
  if value_type == VALUE_TYPE.FIXED then
    self.v_temp_value = value
  else
    local tar_attr = self.owner.attr_mgr:get_attr(tar_ratio_type)
    self.v_temp_value = value * RATIO_IN * tar_attr
  end
  self.owner:set_temp_blue_dirty()
  if self.owner:is_hero() then
    MsgGame:mq_publish2(Const.MSG_ON_TEMP_BLUE)
  end
end

function M:correct_magic_val(blue_val)
  local blocked_value = blue_val < self.v_temp_value and blue_val or self.v_temp_value
  self.v_temp_value = self.v_temp_value - blocked_value
  self.v_temp_value = math.max(self.v_temp_value, 0)
  return blue_val - blocked_value, blocked_value
end

function M:on_remove()
  if self.owner:is_hero() then
    MsgGame:mq_publish2(Const.MSG_ON_TEMP_BLUE)
  end
end

return M
