local Base = require("obj.state.state_move")
local M = Util.create_child_mt(Base)

function M:_on_inertial_speed_zero()
  local act = self.v_inertial_target_act
  self.v_cur_act = act
  self.v_state_manager:try_action(act, 0, nil, nil, true)
end

function M:state_update_value()
  local act = self:_get_act()
  local config_speed_buffer = self.v_owner.character_cfg.SpeedBuffer
  if config_speed_buffer and config_speed_buffer > 0 then
    self.v_inertial_target_act = act
    if act ~= self.v_cur_act then
      self.v_owner.role_move_ctrl:start_move_inertial(Config.MOVE_INERTIAL_STATE.SLOW_DOWN, self._on_inertial_speed_zero, self)
    else
      self.v_owner.role_move_ctrl:start_move_inertial(Config.MOVE_INERTIAL_STATE.SPEED_UP)
      self.v_cur_act = act
      self.v_state_manager:try_action(act, 0, nil, nil, true)
    end
  else
    self.v_state_manager:try_action(act, 0, nil, nil, true)
  end
end

return M
