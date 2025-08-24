local Base = require("obj.state.state_move")
local Math = require("base.mathx")
local M = Util.create_child_mt(Base)
local CounterToRunAcceleratedSpeed = ShareRes.get_comm_string_value("CounterToRunAcceleratedSpeed")
local CounterToRunSpeedMax = ShareRes.get_comm_value("CounterToRunSpeedMax")
local ACT_DEFINE = Config.ACT_DEFINE
local STATE_NAME = Config.STATE_NAME
local RUN_START = 1
local RUNNING = 2
local RUN_END = 3

function M:state_on_enter(...)
  Base.state_on_enter(self, ...)
end

function M:state_on_leave(...)
  self.v_move_timer = 0
  self.v_move_timer_on = false
  self.v_last_counter_move_speed = nil
  self.v_last_lerp_speed = nil
  Base.state_on_leave(self, ...)
end

function M:state_update_value()
  if self.v_state ~= RUN_START then
    if self.v_state_manager.dir_to_run then
      if self.v_owner.act_ctrl:old_action_is_counter() then
        self.v_last_counter_move_speed = self.v_owner.act_ctrl:get_counter_move_speed()
        if self.v_last_counter_move_speed then
          self.v_last_counter_move_speed = math.min(CounterToRunSpeedMax * self.v_owner:get_speed(), self.v_last_counter_move_speed)
        end
      end
      self.v_state = RUN_START
      self:_next_state()
      self.v_state_manager:set_dir_to_run(false)
      if self.v_owner:is_hero() then
        BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_MOVE)
      end
      return
    end
    local aciton = ACT_DEFINE.RunStart
    self.v_action = aciton
    self.v_move_timer_on = true
    self.v_move_timer = self:get_action_use_timer(aciton, ACT_DEFINE.Run)
    self.v_state_manager:try_action(aciton, 0)
    self.v_state = RUN_START
    if self.v_owner:is_hero() then
      BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_MOVE)
    end
  end
end

function M:state_can_reenter()
  return false
end

function M:state_update()
  if not Base.state_update(self) then
    return
  end
  self:update_move_timer()
end

function M:update_move_timer()
  if not self.v_move_timer_on then
    return
  end
  local act_ctrl = self.v_owner.act_ctrl
  local dt = self.v_owner.time_mgr:get_dt_time()
  if act_ctrl:is_follow_move_speed() then
    dt = dt * self.v_owner:get_speed_ratio() * (1 / self.v_owner.model_scale)
  end
  self.v_move_timer = self.v_move_timer - dt
  if self.v_move_timer <= 0 then
    self.v_move_timer_on = false
    self:on_move_timer_end()
    self.v_move_timer = 0
  end
end

function M:on_move_timer_end()
  if self.v_state == RUN_START then
    self:_next_state()
  elseif self.v_state == RUN_END then
    self.v_state_manager:exit_state(STATE_NAME.move)
  end
end

function M:move_by_dir(dirx, dirz, force_runing)
  if force_runing then
    self:_next_state()
  end
  if self.v_state == RUN_START then
    self.v_owner.role_move_ctrl:raw_update_dir(dirx, dirz)
  elseif self.v_state == RUNNING then
    self.v_owner.role_move_ctrl:move_by_dir(dirx, dirz, self.v_need_update)
    self.v_need_update = false
  else
    self:state_update_value()
  end
end

function M:stop_move()
  local action = self.v_state == RUN_START and ACT_DEFINE.RunStartEnd1 or ACT_DEFINE.RunEnd1
  self.v_state = RUN_END
  self.v_action = action
  self.v_owner.role_move_ctrl:stop_move()
  self.v_move_timer_on = true
  self.v_move_timer = self:get_action_use_timer(action, ACT_DEFINE.Idle2)
  self.v_state_manager:try_action(action, 0)
end

function M:_next_state()
  if self.v_state == RUN_START then
    self.v_state = RUNNING
    self.v_action = ACT_DEFINE.Run
    self.v_need_update = true
    self.v_owner.role_move_ctrl:disable_raw_move()
    self.v_state_manager:try_action(self.v_action, 0, nil, nil, true)
  end
end

function M:get_action_use_timer(aciton, next_action)
  local act_ctrl = self.v_owner.act_ctrl
  local total_time = act_ctrl:get_anima_total_time(aciton)
  if not total_time then
    Log.Error("获取动画总时长失败 动画：", aciton, debug.traceback())
    return 0
  end
  if next_action then
    local transition_time = act_ctrl:get_transition_time(0, aciton, next_action, false)
    if not transition_time then
      Log.Error("获取下一个动画融合时间失败， 动画：", next_action, debug.traceback())
      return 0
    end
    total_time = total_time - transition_time
  end
  return total_time
end

function M:get_counter_to_run_speed()
  if not self.v_last_counter_move_speed then
    return
  end
  if Global.close_counter_to_run_speed then
    return
  end
  if not self.v_last_lerp_speed then
    self.v_debug_time = self.v_owner.time_mgr:get_time()
  end
  local cur_speed = self.v_owner:get_speed()
  self.v_last_lerp_speed = self.v_last_lerp_speed or self.v_last_counter_move_speed
  local dif = cur_speed - self.v_last_lerp_speed
  if Util.almost_zero(dif, 0.1) then
    self.v_last_counter_move_speed = nil
    self.v_last_lerp_speed = nil
    return cur_speed
  end
  local more = dif > 0
  local acceleration = more and 1 or -1
  local addspeed = more and CounterToRunAcceleratedSpeed[1] or CounterToRunAcceleratedSpeed[2]
  local lerp_speed = self.v_last_lerp_speed + acceleration * self.v_owner.time_mgr:get_dt_time() * addspeed
  local break_lerp
  if more then
    lerp_speed = Math.Clamp(lerp_speed, self.v_last_counter_move_speed, cur_speed)
    break_lerp = cur_speed < lerp_speed
  else
    lerp_speed = Math.Clamp(lerp_speed, cur_speed, self.v_last_counter_move_speed)
    break_lerp = cur_speed > lerp_speed
  end
  if break_lerp then
    self.v_last_counter_move_speed = nil
    self.v_last_lerp_speed = nil
    return cur_speed
  else
    self.v_last_lerp_speed = lerp_speed
  end
  return lerp_speed
end

return M
