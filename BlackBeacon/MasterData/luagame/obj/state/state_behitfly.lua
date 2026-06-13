local Base = require("obj.state.state_obj_base")
local M = Util.create_child_mt(Base)
local STATE_NAME = Config.STATE_NAME
local ACT_DEFINE = Config.ACT_DEFINE
local Rad2Deg = math.deg(1)
local _floor = math.floor
local _atan = math.atan
local NO_HIT_WALL = -1

local function do_behitfly(self, missile, is_first, be_hit_type)
  self.v_missile_owner = missile:get_owner()
  local cfg = missile.missile_cfg
  local angle_cfg = cfg.BeHitFlyRandomAngle
  local random_angle = self.v_random_angle or 0
  if angle_cfg and not self.v_random_angle then
    local angle_lower = angle_cfg[1]
    local angle_upper = angle_cfg[2]
    if angle_upper and angle_lower then
      if angle_lower > angle_upper then
        angle_lower, angle_upper = angle_upper, angle_lower
      end
      random_angle = math.random(math.floor(angle_lower), math.floor(angle_upper))
    end
    self.v_random_angle = random_angle
  end
  local dir = missile:get_hit_back_dir(self.v_owner)
  local dir_y = _floor(_atan(-dir.x, -dir.z) * Rad2Deg) % 360 + random_angle
  self.v_owner:set_target_dir(dir_y, true)
  self.v_can_turn_over_trigger = false
  self.v_cast_skill_event_trigger = false
  if self.v_action == ACT_DEFINE.LieHit then
    self.v_action = self.v_is_roll and ACT_DEFINE.HoverHitRoll or ACT_DEFINE.Hoverhit
  elseif is_first then
    self.v_action = self.v_is_roll and ACT_DEFINE.BeHitRollFly or ACT_DEFINE.BeHitFly
  elseif not self:check_can_lie_hit(be_hit_type) then
    self.v_action = self.v_is_roll and ACT_DEFINE.HoverHitRoll or ACT_DEFINE.Hoverhit
  else
    self.v_action = ACT_DEFINE.LieHit
  end
  self.v_state_manager:try_action(self.v_action, 0)
  self.v_state_manager:set_keep_end(0, true)
  self.v_owner.role_move_ctrl:on_behitfly(dir, self.v_speed_cfg, self.v_acc_cfg, self.v_fall_acc_cfg, cfg)
  local hit_wall_id = cfg.HitWallId
  if hit_wall_id and hit_wall_id ~= NO_HIT_WALL then
    self.can_hit_wall = true
    self.hitfly_caster = missile:get_owner()
  end
end

local STAND_CAN_TRANSIT_STATE = {
  [STATE_NAME.move] = true,
  [STATE_NAME.run] = true,
  [STATE_NAME.jump] = true,
  [STATE_NAME.attack] = true
}

local function _check_can_transit_for_stand_state(self, state_name)
  if self.v_action == ACT_DEFINE.Standup and STAND_CAN_TRANSIT_STATE[state_name] then
    local cur_time = self.v_owner.time_mgr:get_time()
    if cur_time > self.v_turn_over_timeout then
      return true
    end
  end
  return false
end

function M:_init(owner, state_manager)
  local BEHIT_MOVE_TIME = "CharBehitTime"
  local BEHIT_COUNTER_TIME = "CharBehitToCounter"
  local BEHIT_SKILL_TIME = "CharBehitToSkill"
  self.v_behit2move_time = ShareRes.get_comm_value(BEHIT_MOVE_TIME)
  self.v_behit2counter_time = ShareRes.get_comm_value(BEHIT_COUNTER_TIME)
  self.v_behit2skill_time = ShareRes.get_comm_value(BEHIT_SKILL_TIME)
  Base._init(self, owner, state_manager)
  self.v_standup_end_time = nil
  self.v_turn_over_stand_timeout = ShareRes.get_comm_value("TurnOverStandTimeout")
  self:set_is_lie_hit(false)
  self.v_die_callback_param = nil
  self.v_on_execute_die_callback = false
end

function M:state_update_value(missile, missile_cfg, is_fall_down, is_roll)
  if not self.v_owner.update_land_height_block[STATE_NAME.behitfly] then
    self.v_owner:set_update_land_height_block(STATE_NAME.behitfly, true)
  end
  if not missile_cfg then
    return
  end
  self.v_owner.attr_mgr:reset_behitfly_count()
  self.v_owner.attr_mgr:inc_behitfly_count(missile_cfg.Protect)
  self.v_hitdown_time = 0
  self.v_missile_cfg = missile_cfg
  if not missile_cfg.FlyVelocity or #missile_cfg.FlyVelocity < 2 then
    Log.Error("missile cfg FlyVelocity field is illegal, missile_id=", missile_cfg.Id)
  end
  if not is_fall_down and (not missile_cfg.FlyParameter or #missile_cfg.FlyParameter < 2) then
    Log.Error("missile cfg FlyParameter field is illegal, missile_id=", missile_cfg.Id)
  end
  self:_update_config(missile_cfg.FlyVelocity, missile_cfg.FlyParameter, missile_cfg.Fall)
  if not is_fall_down then
    self.v_beattack_falldown = false
    self.v_is_roll = is_roll
    do_behitfly(self, missile, true, self.v_missile_cfg.Type)
    if self.v_owner:is_hero() then
      BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_BEHITFLY)
    end
  else
    self.v_beattack_falldown = true
    self:_on_falldown()
    if self.v_owner:is_hero() then
      BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_BEHITDOWN)
    end
  end
  self.v_owner.skill_mgr:abort(Config.SKILL_ABORT_TYPE.FOECE | Config.SKILL_ABORT_TYPE.BEHIT_ABORT)
  self.v_interrupt_timer = 0
end

function M:get_missile_cfg()
  return self.v_missile_cfg
end

function M:on_beattack(missile, missile_cfg)
  self.v_owner.attr_mgr:inc_behitfly_count(missile_cfg.Protect)
  local velocity, parameter
  if self:check_lie_hit_param(missile_cfg) and self.v_action ~= ACT_DEFINE.LieHit and not self.v_is_lie_hit and self.v_owner:is_npc() then
    velocity, parameter = missile_cfg.LieHitVelocity, missile_cfg.LieHitParameter
    self:set_is_lie_hit(true)
  else
    if not missile_cfg.HoverHitVelocity or #missile_cfg.HoverHitVelocity < 2 then
      Log.Error("missile cfg HoverHitVelocity field is illegal, missile_id=", missile_cfg.Id)
    end
    if not missile_cfg.HoverHitParameter or #missile_cfg.HoverHitParameter < 2 then
      Log.Error("missile cfg HoverHitParameter field is illegal, missile_id=", missile_cfg.Id)
    end
    self:set_is_lie_hit(false)
    velocity, parameter = missile_cfg.HoverHitVelocity, missile_cfg.HoverHitParameter
  end
  self:_update_config(velocity, parameter, missile_cfg.Fall)
  do_behitfly(self, missile, false, missile_cfg.Type)
  if self.v_owner:is_hero() and not self.v_is_lie_hit then
    BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_BEHITFLY)
  end
end

function M:_update_config(speed_cfg, acc_cfg, fall_acc_cfg)
  if speed_cfg then
    self.v_speed_cfg = speed_cfg
  end
  if acc_cfg then
    self.v_acc_cfg = acc_cfg
  end
  if fall_acc_cfg then
    self.v_fall_acc_cfg = fall_acc_cfg
  end
end

function M:on_rebound()
  self.v_on_the_ground = false
  self.v_action = ACT_DEFINE.Hoverhit
  self.v_state_manager:try_action(self.v_action, 0)
  self.v_state_manager:set_keep_end(0, true)
end

local TURN_OVER_MOMENT = {
  FALL_DOWN_FISNIH = 1,
  IMMEDIATE = 2,
  TIME_OUT = 3
}

function M:_check_turn_over(moment)
  if not self.v_owner:is_hero() then
    return
  end
  if moment == TURN_OVER_MOMENT.IMMEDIATE then
    if not self.v_can_turn_over_trigger then
      NextFrameMgr:add_next_update_order(BehaviorMgr.call_behavior_fun, BehaviorMgr, self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.LIE_CAN_TURN_OVER)
      self.v_can_turn_over_trigger = true
    end
  elseif _check_can_transit_for_stand_state(self, STATE_NAME.attack) and not self.v_cast_skill_event_trigger then
    NextFrameMgr:add_next_update_order(BehaviorMgr.call_behavior_fun, BehaviorMgr, self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.LIE_CAN_CAST)
    self.v_cast_skill_event_trigger = true
  end
end

function M:check_can_turn_over()
  return self.v_can_turn_over_trigger
end

function M:_turn_over()
  self.v_state_manager:to_turn_over_state()
end

function M:state_update()
  local height = self.v_owner:get_air_height()
  local is_behitfly_up_end = self.v_owner.role_move_ctrl:is_behitfly_up_end()
  local speed = self.v_owner.role_move_ctrl:get_behitfly_vspeed()
  local finish_rebound = self.v_owner.role_move_ctrl:finish_rebound() or self.v_beattack_falldown
  local dt = self.v_owner.time_mgr:get_dt_time()
  self.v_interrupt_timer = self.v_interrupt_timer + dt
  if Config.HIT_FLY_UP_STATE[self.v_action] then
    self:_check_turn_over(TURN_OVER_MOMENT.FALL_DOWN_FISNIH)
    if (speed < 0 or is_behitfly_up_end) and height <= 0.25 then
      self:_on_falldown()
    else
      self.v_on_the_ground = false
    end
  elseif self.v_action == ACT_DEFINE.Falldown then
    if height <= 0.01 then
      self:_check_turn_over(TURN_OVER_MOMENT.IMMEDIATE)
    else
      self:_check_turn_over(TURN_OVER_MOMENT.FALL_DOWN_FISNIH)
    end
    if self.v_fall_down_time == nil then
      self.v_fall_down_time = 0
      self.v_fall_down_ani_len = self.v_owner.act_ctrl:get_cur_anim_len()
    else
      self.v_fall_down_time = self.v_fall_down_time + self.v_owner.time_mgr:get_dt_time()
    end
    if self.in_state and (height <= 0.01 or self.v_fall_down_time > self.v_fall_down_ani_len) and finish_rebound and not self.v_is_fallingdown then
      self:enter_lie_on_floor()
      self.v_fall_down_time = nil
    end
  elseif self.v_action == ACT_DEFINE.Lieonfloor then
    self:_check_turn_over(TURN_OVER_MOMENT.IMMEDIATE)
    if self.in_state then
      self:check_need_execute_die_callback()
      self.v_hitdown_time = self.v_hitdown_time - dt
      if self.v_hitdown_time <= 0 then
        self.v_action = ACT_DEFINE.Standup
        self.v_owner.role_move_ctrl:_on_hit_down_end()
        self.v_owner.state_manager:on_leave_lie()
        local suc = self.v_state_manager:try_action(self.v_action, 0)
        if suc then
          local act_ctrl = self.v_owner.act_ctrl
          self.v_standup_end_time = act_ctrl:get_anima_total_time(self.v_action)
          self.v_owner.state_manager:on_enter_lie_to_stand()
        end
        self.v_turn_over_timeout = self.v_owner.time_mgr:get_time() + self.v_turn_over_stand_timeout
      end
    elseif self.v_action == ACT_DEFINE.Standup then
      self:_check_turn_over(TURN_OVER_MOMENT.TIME_OUT)
    end
  elseif self.v_action == ACT_DEFINE.Standup then
    self:update_standup_end_timer()
    self:_check_turn_over(TURN_OVER_MOMENT.TIME_OUT)
  end
end

local BEHIT_INTERRUPT_TYPE = Config.BEHIT_INTERRUPT_TYPE

function M:can_interrupt(interrupt_type)
  if interrupt_type == BEHIT_INTERRUPT_TYPE.MOVE then
    if self.v_interrupt_timer > self.v_behit2move_time then
      return true
    end
  elseif interrupt_type == BEHIT_INTERRUPT_TYPE.SKILL then
    if self.v_interrupt_timer > self.v_behit2skill_time then
      return true
    end
  elseif interrupt_type == BEHIT_INTERRUPT_TYPE.COUNTER and self.v_interrupt_timer > self.v_behit2counter_time then
    return true
  end
  return false
end

function M:update_standup_end_timer()
  if not self.v_standup_end_time then
    return
  end
  local act_ctrl = self.v_owner.act_ctrl
  local dt = self.v_owner.time_mgr:get_dt_time()
  if act_ctrl:is_follow_move_speed() then
    dt = dt * self.v_owner:get_speed_ratio() * (1 / self.v_owner.model_scale)
  end
  self.v_standup_end_time = self.v_standup_end_time - dt
  if self.v_standup_end_time <= 0 then
    self:_on_standup_end()
    self.v_standup_end_time = nil
  end
end

function M:is_standup()
  return self.v_action == ACT_DEFINE.Standup
end

function M:_on_standup_end()
  if self.v_action ~= ACT_DEFINE.Standup and self.v_action ~= ACT_DEFINE.TurnOver then
    return
  end
  self.v_random_angle = nil
  self.v_on_the_ground = false
  self:set_is_lie_hit(false)
  self.v_owner.state_manager:on_leave_lie_to_stand()
  self.v_state_manager:exit_state(STATE_NAME.behitfly)
end

function M:_on_falldown()
  self.v_is_roll = false
  self.v_is_fallingdown = true
  self.v_action = ACT_DEFINE.Falldown
  self.v_state_manager:try_action(self.v_action, 0, function()
    self.v_is_fallingdown = false
    if self.v_owner.role_move_ctrl:finish_rebound() then
      self:set_is_lie_hit(false)
      self.v_on_the_ground = true
    end
  end)
end

function M:to_on_falldown()
  if self.v_is_fallingdown or self.v_on_the_ground then
    return
  end
  self:_on_falldown()
end

function M:can_move()
  if _check_can_transit_for_stand_state(self, STATE_NAME.move) then
    return true
  end
  return false
end

function M:state_can_transit(state_name)
  if _check_can_transit_for_stand_state(self, state_name) then
    return true
  end
  return Base.state_can_transit(self, state_name)
end

function M:state_can_coexist(state_name)
  if _check_can_transit_for_stand_state(self, state_name) then
    return true
  end
  return Base.state_can_coexist(self, state_name)
end

function M:state_on_leave()
  self.v_owner:set_update_land_height_block(STATE_NAME.behitfly, nil)
  self.v_on_the_ground = false
  self:check_need_execute_die_callback()
  Base.state_on_leave(self)
  self.v_is_roll = false
  self.v_owner.attr_mgr:reset_behitfly_count()
  self.v_action = nil
  self.v_standup_end_time = nil
  self.v_cache_turn_over = false
  self.v_can_turn_over_trigger = false
  self.v_cast_skill_event_trigger = false
  self.v_owner.role_move_ctrl:exit_behitfly_state()
end

function M:state_get_name()
  return STATE_NAME.behitfly
end

function M:enter_lie_on_floor()
  self.v_owner:set_update_land_height_block(STATE_NAME.behitfly, nil)
  self.v_action = ACT_DEFINE.Lieonfloor
  local suc = self.v_state_manager:try_action(self.v_action, 0)
  if suc then
    self.v_owner.state_manager:on_enter_lie()
  end
  self.v_hitdown_time = self.v_owner.character_cfg.HitDownTime
  if self.v_owner:is_hero() then
    BehaviorMgr:call_behavior_fun(self.v_owner, BehaviorMgr.EVENTS.ON_ROLE_BEHIT_STATE_CHANGE, Config.BEHIT_STATE_TYPE.ENTER_LIE)
  end
end

function M:is_on_the_ground()
  return self.v_on_the_ground
end

function M:on_lie_hit_end()
  self:enter_lie_on_floor()
end

function M:set_die_callback(...)
  if not self.v_on_execute_die_callback then
    self.v_die_callback_param = table.pack(...)
  end
end

function M:check_need_execute_die_callback()
  if (self.v_owner:is_after_behitfly_die() or self.v_die_callback_param) and self.v_die_callback_param and not self.v_on_execute_die_callback then
    self.v_on_execute_die_callback = true
    self.v_owner:on_dead(table.unpack(self.v_die_callback_param))
    self.v_on_execute_die_callback = false
    self.v_die_callback_param = nil
  end
end

function M:check_have_die_callback()
  return self.v_die_callback_param ~= nil
end

function M:check_can_lie_hit(be_hit_type)
  return self.v_on_the_ground and self.v_owner:is_npc() and self.v_is_lie_hit
end

function M:check_lie_hit_param(missile_cfg)
  return self.v_on_the_ground and missile_cfg.LieHitVelocity and #missile_cfg.LieHitVelocity >= 2 and missile_cfg.LieHitParameter and #missile_cfg.LieHitParameter >= 2
end

function M:set_is_lie_hit(is_lie_hit)
  self.v_is_lie_hit = is_lie_hit
end

return M
