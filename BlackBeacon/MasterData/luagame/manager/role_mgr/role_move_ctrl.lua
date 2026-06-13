local Base = require("obj.base_component")
local Mathx = require("base.mathx")
local vec3 = require("base.vec3")
local vec2 = require("base.vec2")
local Layer = require("utils.layer")
local spline_bezier = require("gamelogic.splines.spline_bezier")
local SkillDefine = require("manager.fight.skill_define")
local SKILL_MOVE_TYPE = SkillDefine.SKILL_MOVE_TYPE
local M = Util.create_child_mt(Base)
local deg2rad = math.pi / 180
local rad2deg = 180 / math.pi
local half_pi = math.pi / 2
local MOVE_TYPE = Config.ROLE_MOVE_TYPE
local LAND_LAYER = Layer.LayerMask.Terrain
local BEHIT_TYEP = Config.BEHIT_TYEP
local HUGE = math.huge
local _max = math.max
local _atan = math.atan
local _sin = math.sin
local _cos = math.cos
local _abs = math.abs
local IS_IGNORE = Config.IGNORE_ARMOR.IGNORE
local DIRECTION_TYPE = {CLOSE = 0, AWAY_FROM = 1}
local DISTANCE_TYPE = {LINE = 0, PROJECTION = 1}
local CAN_SHIFT_TYPE = {
  CONTINUE = 0,
  STOP = 1,
  PAUSE = 2,
  END_SETP = 3
}

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_dirx, self.v_dirz = 0, 0
  self.v_is_raw = true
  self.v_moveby_dir = nil
  self.v_move_by_skill = false
  self.v_skill_move_speed = 0
  self.v_skill_move_deg = nil
  self.fixed_time_shift_data = nil
  self.v_force_shift = false
  self.v_allow_slide = false
  self.v_force_shift_speed = 0
  self.v_force_shift_dir_flag = nil
  self.v_force_shift_caster_pos = nil
  self.v_force_shift_a = 0
  self.v_break_lenth = nil
  self.v_skill_joystic_move_queue = {}
  self.v_move_by_skill_joystick = false
  self.is_skill_joystick_forced_reduce = false
  self.v_skill_accel_val = nil
  self.v_joystick_dirx = 0
  self.v_joystick_dirz = 0
  self.v_change_speed_percent = 0
  self.v_inertial = false
  self.v_inertial_target_pos = vec3.New(0, 0, 0)
  self.v_rebound_cfg = self.v_char.character_cfg.Rebound
  local hitback_ratio = self.v_char.character_cfg.HitBackRatio
  self.v_behit_fly_height_limit = self.v_char.character_cfg.BeHitFlyHeightLimit
  if nil ~= hitback_ratio then
    self.v_hitback_ratio_speed = hitback_ratio[1]
    self.v_hitback_ratio_acceleration = hitback_ratio[2]
    self.v_hitback_ratio_movetime = hitback_ratio[3]
  end
  self.v_navigator = self.v_char.navigator_ctrl
  self:mgr_bind_auto_mq(Const.MSG_OBJ_LEAVE, self.on_obj_leave, self)
end

function M:on_before_destroy()
  self.v_char = nil
  self.v_navigator = nil
end

function M:start_move_inertial(state, stop_cb, cb_self)
  self.v_inertial = true
  self.v_inertial_state = state
  self.v_inertial_dir_x = self.v_dirx
  self.v_inertial_dir_z = self.v_dirz
  self.v_inertial_cb = stop_cb
  self.v_inertial_cb_self = cb_self
  self:_refresh_inertial_params(state)
end

function M:cancel_move_inertial()
  if self.v_inertial then
    self.v_inertial = false
    self.v_char:set_speed_inertial_scale(1)
  end
end

local INERTIAL_STATE_SLOW_DOWN = Config.MOVE_INERTIAL_STATE.SLOW_DOWN
local INERTIAL_STATE_SPEED_UP = Config.MOVE_INERTIAL_STATE.SPEED_UP

function M:_refresh_inertial_params(state)
  local cur_time = self.v_char.time_mgr:get_time()
  local cur_scale = self.v_char:get_speed_inertial_scale()
  local config_time = self.v_char.character_cfg.SpeedBuffer or 1
  if INERTIAL_STATE_SLOW_DOWN == state then
    self.v_inertial_end_time = cur_scale * config_time + cur_time
    if self.v_navigator:is_moving() then
      local target_pos = self.v_navigator:get_target_pos()
      self.v_inertial_target_pos.x = target_pos.x
      self.v_inertial_target_pos.z = target_pos.z
    else
      self.v_inertial_target_pos.x = HUGE
    end
    self.v_inertial_move_type = self.v_char:get_pre_move_type()
  else
    self.v_inertial_end_time = (1 - cur_scale) * config_time + cur_time
  end
  self.v_inertial_start_scale = cur_scale
  self.v_inertial_start_time = cur_time
  self.v_inertial_duration = _max(0.01, self.v_inertial_end_time - cur_time)
end

function M:update_inertial()
  if not self.v_inertial then
    return
  end
  local cur_time = self.v_char.time_mgr:get_time()
  if cur_time >= self.v_inertial_end_time then
    if self.v_inertial_state == INERTIAL_STATE_SLOW_DOWN then
      self.v_char:set_speed_inertial_scale(0)
      self.v_inertial_state = INERTIAL_STATE_SPEED_UP
      self:_refresh_inertial_params(self.v_inertial_state)
      if self.v_inertial_cb then
        self.v_inertial_cb(self.v_inertial_cb_self)
      end
    else
      self:cancel_move_inertial()
    end
    return
  end
  local s = self.v_inertial_start_time
  local dt = cur_time - s
  local ratio
  if self.v_inertial_state == INERTIAL_STATE_SLOW_DOWN then
    ratio = Mathx.lerp_number(self.v_inertial_start_scale, 0, dt / self.v_inertial_duration)
  else
    ratio = Mathx.lerp_number(self.v_inertial_start_scale, 1, dt / self.v_inertial_duration)
  end
  self.v_char:set_speed_inertial_scale(ratio)
end

function M:move_by_dir(dirx, dirz)
  if not (self:_can_move() and dirx) or not dirz then
    return
  end
  self:_update_dir(dirx, dirz)
  self.v_moveby_dir = true
  self.v_is_raw = false
end

function M:set_move_by_skill(pram, target)
  self.v_move_by_skill = pram
  self.v_skill_move_target = target
  if pram then
    self.v_navigator:stop()
  end
end

function M:set_fixed_time_shift_data(fixed_time_shift_data)
  self.fixed_time_shift_data = fixed_time_shift_data
end

function M:set_fixed_time_shift_step(move_step, last_step)
  self.fixed_time_shift_move_step = move_step
  self.need_stop_fixed_time_shift = last_step
end

function M:set_skill_move_speed(speed, acc_speed, move_trace, start_speed)
  self.v_skill_move_speed = speed
  self.v_skill_move_acc_speed = acc_speed
  self.v_skill_move_trace = move_trace
  self.v_skill_start_speed = start_speed
end

function M:set_skill_move_param(deg, move_type)
  self.v_skill_move_deg = deg
  self.v_skill_move_type = move_type
end

function M:set_skill_break_config(break_config)
  self.v_skill_move_break_config = break_config
end

function M:move_to_target(target)
  self.v_is_raw = false
  self.v_navigator:move_to_target(target)
end

function M:move_to_postion(target_pos)
  self.v_is_raw = false
  self.v_navigator:move_to_pos(target_pos)
end

function M:on_behit(dir, missile_cfg, missile, is_in_armor)
  if missile_cfg.HitBackSpeed <= 0 and not is_in_armor then
    return
  end
  if missile_cfg.SAHitBackSpeed <= 0 and is_in_armor then
    return
  end
  if self.v_char.state_manager:is_stun_state() and not self.v_char.character_cfg.CanHitBackOnStun then
    return
  end
  local cfg = {
    speed = missile_cfg.HitBackSpeed,
    dir = dir,
    time = 0,
    cfg = missile_cfg
  }
  if is_in_armor and missile_cfg.SAHitBackSpeed > 0 then
    cfg.speed = missile_cfg.SAHitBackSpeed
  end
  if self.v_hitback_ratio_speed ~= nil then
    cfg.speed = cfg.speed * self.v_hitback_ratio_speed
  end
  self.v_behit = cfg
  self.is_in_armor = is_in_armor
end

function M:on_behitfly(dir, speed_cfg, acc_cfg, fall_acc, missile_cfg)
  self.v_behitfly_dir = dir
  self.v_behitfly_up_acc = acc_cfg
  self.v_behitfly_fall_acc = fall_acc
  self.v_behitfly_idx = 1
  self.v_behitfly_time = 0
  self.v_behitfly_total_time = 0
  local ran_mult_upper = speed_cfg[3]
  local ran_mult_lower = speed_cfg[4]
  self.v_ran_mult = 1
  if ran_mult_upper and ran_mult_lower then
    if ran_mult_upper < ran_mult_lower then
      ran_mult_upper = speed_cfg[4]
      ran_mult_lower = speed_cfg[3]
    end
    ran_mult_lower = math.floor(ran_mult_lower * 100)
    ran_mult_upper = math.floor(ran_mult_upper * 100)
    self.v_ran_mult = math.random(ran_mult_lower, ran_mult_upper) / 100
  end
  self.v_behitfly_h_speed = speed_cfg[1] * self.v_ran_mult
  self.v_behitfly_v_speed = speed_cfg[2] * self.v_ran_mult
  self.v_behitfly_h_acc = acc_cfg[1] * self.v_ran_mult
  self.v_behitfly_v_acc = acc_cfg[2] * self.v_ran_mult
  self.v_behitfly_up_end = self.v_behitfly_v_speed < 0
  self.v_finish_rebound = false
  if not self.v_rebound_cfg then
    self.v_finish_rebound = true
  end
  self.v_in_rebound = false
  self.v_rebound_idx = 1
end

function M:get_behitfly_hspeed()
  return self.v_behitfly_h_speed
end

function M:get_behitfly_vspeed()
  return self.v_behitfly_v_speed
end

function M:raw_update_dir(dirx, dirz)
  if not dirx or not dirz then
    return
  end
  self:_update_dir(dirx, dirz)
  self.v_is_raw = true
end

function M:disable_raw_move()
  self.v_is_raw = false
end

function M:_cacul_rad(move_type, move_step, target_pos, self_pos)
  local rad
  local r = vec3.Distance(self_pos, target_pos)
  if move_type == MOVE_TYPE.left then
    rad = move_step / r
  elseif move_type == MOVE_TYPE.right then
    rad = -move_step / r
  end
  self.v_cache_sin_rad = _sin(rad)
  self.v_cache_cos_rad = _cos(rad)
end

function M:_cacul_target_move(target_pos, move_step, move_type)
  local self_pos = self.v_char:get_pos_vec3()
  self:_cacul_rad(move_type, move_step, target_pos, self_pos)
  local tx, tz = target_pos.x - self_pos.x, target_pos.z - self_pos.z
  local vx = tx * self.v_cache_cos_rad - tz * self.v_cache_sin_rad
  local vz = tx * self.v_cache_sin_rad + tz * self.v_cache_cos_rad
  return vx - tx, vz - tz
end

function M:_cacul_dir_move(move_type, move_step, dirx, dirz)
  local rad
  if move_type == MOVE_TYPE.left then
    rad = half_pi
  elseif move_type == MOVE_TYPE.right then
    rad = -half_pi
  end
  rad = rad + _atan(dirz, dirx)
  return move_step * _cos(rad), move_step * _sin(rad)
end

function M:get_dist_to_target(target)
  local target_pos
  if target then
    target_pos = target:get_pos_vec3()
  elseif self.v_navigator:is_moving() then
    target_pos = self.v_navigator:get_target_pos()
  end
  if target_pos then
    return vec3.Distance(self.v_char:get_pos_vec3(), target_pos)
  end
  return 1
end

function M:_cacul_move_dt(move_step)
  local is_inertial_slowdown = self.v_inertial and self.v_inertial_state == INERTIAL_STATE_SLOW_DOWN
  local dirx, dirz, move_type
  if is_inertial_slowdown then
    dirx, dirz = self.v_inertial_dir_x, self.v_inertial_dir_z
    move_type = self.v_inertial_move_type
  else
    dirx, dirz = self.v_dirx, self.v_dirz
    move_type = self.v_char:get_move_type()
  end
  if move_type == MOVE_TYPE.forward or move_type == MOVE_TYPE.run then
    return dirx * move_step, dirz * move_step
  elseif move_type == MOVE_TYPE.back then
    return dirx * -move_step, dirz * -move_step
  end
  local target_pos
  if is_inertial_slowdown and self.v_inertial_target_pos.x ~= HUGE then
    target_pos = self.v_inertial_target_pos
  else
    target_pos = self.v_navigator:get_target_pos()
  end
  if target_pos then
    return self:_cacul_target_move(target_pos, move_step, move_type)
  else
    return self:_cacul_dir_move(move_type, move_step, dirx, dirz)
  end
end

function M:_update_dir(dirx, dirz)
  self.v_dirx, self.v_dirz = Util.normalize2(dirx, dirz)
  if _abs(self.v_dirx) < 1.0E-5 and _abs(self.v_dirz) < 1.0E-5 then
    return
  end
  self.v_move_dir = _atan(dirx, dirz) * rad2deg % 360
  self.v_char:set_target_dir(self.v_move_dir)
end

function M:update_fixed_time_shift()
  local temp = self.v_char.state_manager:is_attack_state()
  if not (temp and self.fixed_time_shift_data) or not self.fixed_time_shift_move_step then
    return
  end
  local last_move_disp = self.fixed_time_shift_data.total_disp
  local cur_move_disp = self.fixed_time_shift_move_step - last_move_disp
  self.fixed_time_shift_data.total_disp = self.fixed_time_shift_move_step
  if 0 == self.fixed_time_shift_move_step then
    return
  end
  Log.Info("位移", cur_move_disp, "时间", self.fixed_time_shift_data.total_time)
  local face_vec = self.v_char:get_dir_vec()
  local dx, dz = face_vec.x * cur_move_disp, face_vec.z * cur_move_disp
  self.v_char:move(dx, dz)
  if self.need_stop_fixed_time_shift then
    self:set_fixed_time_shift_data(nil)
  end
end

local function _get_next_pos2(self, face_vec, skill_move_speed, dt)
  local move_step = skill_move_speed * dt
  local cx, cz = self.v_char:get_pos2()
  local dx, dz = face_vec.x * move_step, face_vec.z * move_step
  return dx + cx, dz + cz
end

function M:_check_skill_stop_by_break_config(skill, face_vec, move_step)
  local can_shift, end_step
  local break_config = self.v_skill_move_break_config
  local ReferAngle = break_config.ReferAngle
  local AngleRange = break_config.AngleRange
  local ContinueMove = break_config.ContinueMove
  local Direction = break_config.Direction
  local Dist_type = break_config.Dist_type
  local BreakDist = break_config.BreakDist
  if break_config.BreakDist <= 0 then
    can_shift = CAN_SHIFT_TYPE.CONTINUE
    return can_shift
  end
  local self_radius = 0
  local target_radius = 0
  if break_config.CalSelfRadius then
    self_radius = self_radius + self.v_char.radius
  end
  if break_config.CalTargetRadius then
    target_radius = skill:get_target_radius()
    BreakDist = math.max(BreakDist - target_radius, target_radius)
  end
  local cur_x, cur_y, cur_z = self.v_char:get_pos()
  local role_face_vec = self.v_char:get_dir_vec()
  local face_x, face_z = role_face_vec.x, role_face_vec.z
  local offset_x, offset_z = break_config.OffsetX, break_config.OffsetZ
  local dx, dz = face_x * offset_z, face_z * offset_z
  local rx, rz = face_z * offset_x, -face_x * offset_x
  cur_x = cur_x + dx + rx
  cur_z = cur_z + dz + rz
  local act_ctrl = self.v_char.act_ctrl
  if act_ctrl then
    local anim_x, anim_z = act_ctrl:get_cur_frame_offset()
    cur_x, cur_z = cur_x + anim_x, cur_z + anim_z
  end
  local tx, _, tz = skill:get_target_pos():Get()
  local dist
  local tp_dir_x, tp_dir_z = tx - cur_x, tz - cur_z
  local face_x, face_z = face_vec.x, face_vec.z
  local isApproach = Direction == DIRECTION_TYPE.CLOSE
  local breakDist = BreakDist + self_radius + target_radius
  local isInRange
  if Dist_type == DISTANCE_TYPE.LINE then
    dist = vec3.DistanceA(cur_x, 0, cur_z, tx, 0, tz)
    isInRange = breakDist > dist
    if not (not isApproach or isInRange) or not isApproach and isInRange then
      return CAN_SHIFT_TYPE.CONTINUE
    end
  else
    dist = vec3.SignedProjectLen(face_x, 0, face_z, tp_dir_x, 0, tp_dir_z)
    if not isApproach then
      breakDist = -breakDist
    end
    isInRange = dist < breakDist
    if not isInRange then
      return CAN_SHIFT_TYPE.CONTINUE
    end
  end
  local role_face_vec = self.v_char:get_dir_vec()
  local rota_x, rota_z = Mathx.rotate_vec2(role_face_vec.x, role_face_vec.z, ReferAngle)
  local angle = Mathx.get_positibe_angle(Mathx.get_vec2_angle(cur_x, cur_z, tx, tz, cur_x + rota_x, cur_z + rota_z))
  if AngleRange >= angle then
    can_shift = ContinueMove and CAN_SHIFT_TYPE.PAUSE or CAN_SHIFT_TYPE.END_SETP
    end_step = 1
    return can_shift, end_step, 0, 0
  else
    return CAN_SHIFT_TYPE.CONTINUE
  end
end

function M:_before_update_skill_shift(skill, face_vec)
  if not skill then
    return CAN_SHIFT_TYPE.STOP
  end
  local move_type, stop_dist, break_x, break_z = skill:get_check_move_param()
  local dt = self.v_char.time_mgr:get_dt_time()
  local skill_move_speed = self.v_skill_move_speed + self.v_skill_move_acc_speed * dt
  if self.v_skill_move_break_config then
    local move_step = skill_move_speed * dt
    local shift_type, end_step, nx, nz = self:_check_skill_stop_by_break_config(skill, face_vec, move_step)
    self.v_skill_move_speed = skill_move_speed
    return shift_type, end_step, nx, nz
  end
  if move_type == SKILL_MOVE_TYPE.TO_TARGET then
    self.v_skill_move_speed = skill_move_speed
    return CAN_SHIFT_TYPE.CONTINUE
  end
  local move_step = skill_move_speed * dt
  local dir = skill_move_speed * -1
  local dist = skill:get_cur_dist()
  local tpos = skill:get_target_pos()
  local cx, cz = self.v_char:get_pos2()
  local break_lenth = stop_dist or 0.01
  local end_step
  local dx, dz = face_vec.x * move_step, face_vec.z * move_step
  local tp_dir_x, tp_dir_z = tpos.x - cx, tpos.z - cz
  Util.VEC3_TEMP:Set1(dx, 0, dz)
  Util.VEC3_TEMP_1:Set1(tp_dir_x, 0, tp_dir_z)
  local temp_tx, temp_ty, temp_tz = Util.VEC3_TEMP_1:SetNormalize():Get()
  Util.VEC3_TEMP:Set(vec3.ProjectA(dx, 0, dz, temp_tx, temp_ty, temp_tz))
  local dir_move_step = Util.VEC3_TEMP:Magnitude()
  break_x, break_z = tpos.x + break_x * break_lenth, tpos.z + break_z * break_lenth
  local end_line_dist = Mathx.distance2(break_x, break_z, cx, cz)
  vec3.GetRotatedVector(0, self.v_char:get_dir(), 0, vec3.forward, Util.VEC3_TEMP)
  local act_ctrl = self.v_char.act_ctrl
  local next_x, next_z = cx + dx, cz + dz
  local anim_x, anim_z
  if act_ctrl then
    anim_x, anim_z = act_ctrl:get_cur_frame_offset()
    dir_move_step = dir_move_step + Mathx.distance2(anim_x, anim_z, 0, 0)
    next_x, next_z = next_x + anim_x, next_z + anim_z
  end
  if dir_move_step and end_line_dist < dir_move_step then
    end_step = end_line_dist
  else
    local tar2next_x, _, tar2next_z = vec3.NormalizeA(break_x - next_x, 0, break_z - next_z)
    local cur2tar_x, _, cur2tar_z = vec3.NormalizeA(break_x - cx, 0, break_z - cz)
    if vec3.AngleRawA(cur2tar_x, _, cur2tar_z, tar2next_x, _, tar2next_z) >= 90 then
      end_step = end_line_dist
    end
  end
  local can_shift = dir >= 0 and dist < break_lenth or dir <= 0 and dist > break_lenth
  if self.v_skill_move_trace then
    if not can_shift or end_step then
      self.v_skill_move_speed = 0
      return CAN_SHIFT_TYPE.CONTINUE
    elseif 0 == self.v_skill_move_speed then
      self.v_skill_move_speed = self.v_skill_start_speed
    end
  elseif not can_shift then
    return CAN_SHIFT_TYPE.STOP
  end
  if end_step and break_lenth >= 0 then
    self.v_skill_move_speed = end_step / dt
  else
    self.v_skill_move_speed = skill_move_speed
  end
  return can_shift and CAN_SHIFT_TYPE.CONTINUE or CAN_SHIFT_TYPE.STOP, end_step
end

function M:_update_skill_shift()
  if not self.v_char.state_manager:is_attack_state() or not self.v_move_by_skill then
    return
  end
  local skill = self.v_char.skill_mgr:get_cur_skill()
  if not skill then
    self:set_move_by_skill(false)
    return
  end
  local face_vec
  if self.v_skill_move_target then
    local tx, tz = self.v_skill_move_target:get_pos2()
    local posx, posz = self.v_char:get_pos2()
    self:_update_dir(tx - posx, tz - posz)
    face_vec = self.v_char:get_dir_vec()
  elseif self.v_skill_move_deg then
    local deg = self.v_skill_move_deg + self.v_char:get_dir()
    local rad = deg * deg2rad
    local x = _sin(rad)
    local z = _cos(rad)
    face_vec = vec3.New(x, 0, z)
  else
    face_vec = self.v_char:get_dir_vec()
  end
  local shift_type, end_step, nx, nz = self:_before_update_skill_shift(skill, face_vec)
  if shift_type == CAN_SHIFT_TYPE.PAUSE then
    skill:pause_skill_shift(true)
    return
  elseif shift_type == CAN_SHIFT_TYPE.STOP then
    skill:stop_skill_shift()
    return
  end
  skill:pause_skill_shift(false)
  local move_step = self.v_skill_move_speed * self.v_char.time_mgr:get_dt_time()
  if 0 == move_step then
    return
  end
  local dx, dz = nx or face_vec.x * move_step, nz or face_vec.z * move_step
  self.v_char:move(dx, dz)
  if shift_type == CAN_SHIFT_TYPE.END_SETP then
    skill:stop_skill_shift()
  end
  if end_step then
    self:set_move_by_skill(false)
  end
end

function M:stop_skill_joystick()
  self.v_skill_speed_val = nil
  self:set_move_by_skill_joystick(false)
end

function M:forced_reduce_skill_joystick_speed()
  self.is_skill_joystick_forced_reduce = true
end

function M:set_move_by_skill_joystick(pram)
  if self.v_skill_speed_val then
    pram = true
  end
  self.v_move_by_skill_joystick = pram
  if not pram then
    self:set_joystick_dir(0, 0)
  end
end

function M:set_skill_joystick_speed_val(max_speed, fade_in_time, fade_out_time)
  self.v_joystick_move_max_speed = max_speed
  self.v_skill_accel_val = 0 ~= fade_in_time and max_speed / fade_in_time * Global.delta_time or 0
  self.v_skill_fade_out_time = fade_out_time or 0
  self.v_skill_reduce_val = nil
  self.v_skill_speed_val = 0
  self.is_skill_joystick_forced_reduce = false
end

function M:set_joystick_dir(dirx, dirz)
  self.is_skill_joystick_add = 0 ~= dirx or 0 ~= dirz
  if not self.is_skill_joystick_add then
    if not self.v_move_by_skill_joystick then
      self.v_joystick_dirx = 0
      self.v_joystick_dirz = 0
    end
    return
  end
  self.v_joystick_dirx = dirx
  self.v_joystick_dirz = dirz
end

function M:_update_skill_joystick_move()
  if not self.v_char.state_manager:is_attack_state() or not self.v_move_by_skill_joystick then
    return
  end
  if 0 == self.v_joystick_dirx and 0 == self.v_joystick_dirx and 0 == self.v_skill_speed_val then
    return
  end
  local dirx = self.v_joystick_dirx
  local dirz = self.v_joystick_dirz
  local skill_speed_val
  if self.is_skill_joystick_add and not self.is_skill_joystick_forced_reduce then
    self.v_skill_speed_val = 0 ~= self.v_skill_accel_val and self.v_skill_speed_val + self.v_skill_accel_val or self.v_joystick_move_max_speed
    self.v_skill_speed_val = math.min(self.v_skill_speed_val, self.v_joystick_move_max_speed)
    skill_speed_val = self.v_skill_speed_val
    self.v_skill_reduce_val = nil
  elseif not self.is_skill_joystick_add or self.is_skill_joystick_forced_reduce then
    if 0 ~= self.v_skill_fade_out_time and not self.v_skill_reduce_val then
      self.v_skill_reduce_val = self.v_skill_speed_val / self.v_skill_fade_out_time * Global.delta_time
    end
    self.v_skill_speed_val = self.v_skill_reduce_val and self.v_skill_speed_val - self.v_skill_reduce_val or 0
    self.v_skill_speed_val = math.max(self.v_skill_speed_val, 0)
    skill_speed_val = self.v_skill_speed_val
    if self.v_skill_speed_val <= 0 and self.is_skill_joystick_forced_reduce then
      self:stop_skill_joystick()
    end
  end
  local move_speed = skill_speed_val * self.v_char.time_mgr:get_dt_time()
  local move_step = move_speed + self.v_change_speed_percent * move_speed
  dirx, dirz = Util.normalize2(dirx, dirz)
  local dx, dz = dirx * move_step, dirz * move_step
  self.v_char:move(dx, dz)
end

function M:set_force_shift(speed, dir_flag, break_lenth, pos, force_dir, ignore_armor, armor_atk_lv, acceleration, allow_slide, caster_uuid, magic_id)
  break_lenth = math.max(break_lenth, 0.01)
  if not self:can_force_shift(speed, dir_flag, break_lenth, pos) then
    return
  end
  self:set_force_shift_param(allow_slide, true, speed, dir_flag, break_lenth, pos, force_dir, ignore_armor, armor_atk_lv, acceleration, caster_uuid, magic_id)
end

function M:set_force_shift_param(allow_slide, force_shift, speed, dir_flag, break_lenth, pos, force_dir, ignore_armor, armor_atk_lv, acceleration, caster_uuid, magic_id)
  self.v_allow_slide = allow_slide
  self.v_force_shift = force_shift
  self.v_force_shift_speed = speed
  self.v_force_shift_dir_flag = dir_flag
  self.v_break_lenth = break_lenth
  self.v_force_shift_caster_pos = pos
  self.v_force_dir = force_dir
  self.v_ignore_armor = ignore_armor
  self.v_force_armor_atk_lv = armor_atk_lv
  self.v_force_shift_a = acceleration or 0
  self.v_force_shift_caster = caster_uuid
  self.v_force_shift_magic_id = magic_id
end

function M:can_force_shift(speed, dir_flag, break_lenth, pos, move_step)
  local dir = speed * dir_flag
  local dist = vec3.Distance(self.v_char:get_pos_vec3(), pos)
  local end_step
  local end_line_dist = _abs(dist - break_lenth)
  if move_step and move_step > end_line_dist then
    end_step = end_line_dist
  end
  return dir >= 0 and break_lenth > dist or dir <= 0 and break_lenth < dist, end_step
end

function M:stop_force_shift()
  if self.v_force_shift then
    local caster = self.v_force_shift_caster and SceneMgr:pick_by_uuid(self.v_force_shift_caster) or nil
    if Util.is_destroy(caster) then
      caster = nil
    end
    local force_shift_magic_id = self.v_force_shift_magic_id
    local has_force_shift = self.v_has_force_shift
    
    local function next_frame_cb(event_name, force_shift_caster, char, magic_id, force_shift)
      if SceneMgr:check_main_scene() then
        return
      end
      BehaviorMgr:call_event_fun(event_name, force_shift_caster, char, magic_id, force_shift)
    end
    
    NextFrameMgr:add(next_frame_cb, BehaviorMgr.EVENTS.ON_FORCE_SHIFT_END, caster, self.v_char, force_shift_magic_id, has_force_shift)
  end
  self.v_force_shift = false
  self.v_allow_slide = false
  self.v_has_force_shift = nil
end

function M:can_slipout()
  return self.v_force_shift and self.v_allow_slide or true
end

function M:_update_force_shift()
  if not self.v_force_shift then
    return
  end
  if self.v_char:is_in_armor(self.v_force_armor_atk_lv) and self.v_ignore_armor ~= IS_IGNORE then
    return
  end
  local tar_pos = self.v_force_shift_caster_pos
  local dt = self:_get_shift_or_hit_dt()
  self.v_force_shift_speed = self.v_force_shift_speed + self.v_force_shift_a * dt
  local move_step = self.v_force_shift_speed * dt
  local self_x, self_z = self.v_char:get_pos2()
  local tar_x, tar_z = tar_pos.x, tar_pos.z
  local flag = self.v_force_shift_dir_flag
  local dir_x, dir_z
  if not self.v_force_dir then
    dir_x, dir_z = Util.normalize2(self_x - tar_x, self_z - tar_z)
  else
    dir_x, dir_z = self.v_force_dir.x, self.v_force_dir.z
  end
  local can_continue, end_step = self:can_force_shift(self.v_force_shift_speed, self.v_force_shift_dir_flag, self.v_break_lenth, tar_pos, move_step)
  move_step = end_step or move_step
  if not can_continue or end_step then
    self:stop_force_shift()
  end
  self.v_has_force_shift = true
  local dx, dz = dir_x * move_step * flag, dir_z * move_step * flag
  self.v_char:move(dx, dz)
end

function M:_get_shift_or_hit_dt()
  return self.v_char.time_mgr:get_igonre_forece_move() and Global.delta_time or self.v_char.time_mgr:get_dt_time()
end

function M:update()
  if not self.v_enable then
    return
  end
  self:_update_force_shift()
  self:_update_behit()
  self:_update_behitfly()
  self:_update_skill_shift()
  self:_update_skill_joystick_move()
  self:_update_bezier_move()
  if self.v_is_raw or not self:_can_move() then
    return
  end
  self:update_inertial()
  if self.v_navigator:is_moving() then
    self:_update_dir_by_target()
  end
  if Mathx.almost_zero2(self.v_dirx, self.v_dirz) then
    return
  end
  if self.v_char.state_manager:role_can_remove() then
    self.v_char.state_manager:to_move_state()
  end
  local run_speed = self.v_char:is_hero() and self.v_char.state_manager:get_counter_to_run_speed() or self.v_char:get_speed()
  if Global.debug_move_speed then
    local Behavior = require("manager.fight.behavior")
    Behavior.log_on_npc(self.v_char, run_speed, true)
  end
  local delta_time = self.v_char.time_mgr:get_dt_time()
  local move_step = run_speed * delta_time
  local dx, dz = self:_cacul_move_dt(move_step)
  self:incline_move()
  if self.v_char.state_manager and self.v_char.state_manager:check_correct_dir() and not Util.almost_zero(dx) and not Util.almost_zero(dz) then
    dx, dz = self.v_char.state_manager:get_after_correct_dir_x_y(dx, dz)
  end
  local rvo_controller = self.v_char.rvo_controller
  local rvo_controller_enabled = self.v_char.rvo_controller_enabled
  if rvo_controller and rvo_controller_enabled then
    local posx, posy, posz = self.v_char:get_pos()
    rvo_controller:SetTargetA(posx + dx * 100, posy, posz + dz * 100, run_speed, run_speed)
    if self.v_char:is_monster() then
      local delta_x, _, delta_z = rvo_controller:CalculateMovementDeltaA(posx, posy, posz, delta_time)
      self.v_char:move(delta_x, delta_z)
      return
    end
  end
  self.v_char:move(dx, dz)
end

function M:_update_behit()
  if not self.v_behit then
    return false
  end
  if self.v_char.state_manager:is_stun_state() and not self.v_char.character_cfg.CanHitBackOnStun then
    self.v_behit = nil
    return false
  end
  local dt = self:_get_shift_or_hit_dt()
  local behit = self.v_behit
  local cfg = behit.cfg
  local speed = behit.speed
  local dist = speed * dt
  local acceleration = cfg.HitBackAcceleration
  if self.is_in_armor and cfg.SAHitBackAcceleration > 0 then
    acceleration = cfg.SAHitBackAcceleration
  end
  if nil ~= self.v_hitback_ratio_acceleration then
    acceleration = acceleration * self.v_hitback_ratio_acceleration
  end
  behit.speed = _max(behit.speed + acceleration * dt, 0)
  local dx, dz = behit.dir.x * dist, behit.dir.z * dist
  self.v_char:move(dx, dz)
  behit.time = behit.time + dt
  local movetime = cfg.HitBackMoveTime
  if self.is_in_armor and cfg.SAHitBackMoveTime > 0 then
    movetime = cfg.SAHitBackMoveTime
  end
  if nil ~= self.v_hitback_ratio_movetime then
    movetime = movetime * self.v_hitback_ratio_movetime
  end
  if movetime < behit.time then
    self.v_behit = nil
  end
  return true
end

function M:_on_hit_down_end()
  self.v_behitfly_dir = nil
  self.v_behitfly_up_acc = nil
end

function M:exit_behitfly_state()
  self.v_behitfly_dir = nil
  self.v_behitfly_up_acc = nil
end

function M:_update_behitfly()
  if not self.v_behitfly_up_acc then
    return false
  end
  local dt = self:_get_shift_or_hit_dt()
  local horizontal_acc, vertical_acc = self:_get_acc()
  if horizontal_acc then
    self.v_behitfly_h_acc = horizontal_acc
    self.v_behitfly_v_acc = vertical_acc
  end
  local speedx = _max(self.v_behitfly_h_speed + dt * self.v_behitfly_h_acc, 0)
  local speedy = self.v_behitfly_v_speed + dt * self.v_behitfly_v_acc
  if speedy < 0 and not self.v_behitfly_up_end and not self.v_in_rebound then
    speedy = 0
  end
  local now_height = self.v_char:get_air_height()
  if self.v_behitfly_v_speed ~= speedy and speedy <= 0 and self.v_behitfly_v_speed > 0 and not self.v_in_rebound then
    self.v_behitfly_highest = now_height
  end
  if self.v_behitfly_up_end and speedy > 0 then
    speedy = 0
  end
  local dy = speedy * dt
  local is_end = false
  self.v_char:set_land_ray_dis(now_height)
  if speedy <= 0 and dy + now_height <= 0.001 then
    dy = -now_height
    is_end, speedx, speedy = self:_do_rebound(speedx, speedy)
    self.v_finish_rebound = is_end
  end
  self.v_behitfly_h_speed = speedx
  self.v_behitfly_v_speed = speedy
  local disth = speedx * dt
  local dx, dz = disth * self.v_behitfly_dir.x, disth * self.v_behitfly_dir.z
  if self.v_behit_fly_height_limit and self.v_behit_fly_height_limit > 0 then
    local new_air_height = now_height + dy
    if new_air_height > self.v_behit_fly_height_limit then
      dy = self.v_behit_fly_height_limit - now_height
    end
  end
  self.v_char:add_pos_height(dy)
  self.v_char:move(dx, dz)
  self.v_behitfly_time = self.v_behitfly_time + dt
  self.v_behitfly_total_time = self.v_behitfly_total_time + dt
  if is_end and speedx <= 0 then
    self.v_behitfly_dir = nil
    self.v_behitfly_up_acc = nil
    self.v_char:set_land_ray_dis(0)
    local behitfly_state = self.v_char.state_manager:get_behitfly_state()
    if behitfly_state then
      behitfly_state:to_on_falldown()
    end
  end
  return not self.v_finish_rebound
end

function M:_get_acc()
  local idx = self.v_behitfly_idx
  local horizontal_acc, vertical_acc, acc_cfg
  if not self.v_behitfly_up_end then
    acc_cfg = self.v_behitfly_up_acc
  else
    acc_cfg = self.v_behitfly_fall_acc
  end
  local ran_mult = self.v_ran_mult or 1
  while true do
    local start = (idx - 1) * 3
    local time = acc_cfg[start + 3]
    if not time then
      self.v_behitfly_up_end = true
      self.v_behitfly_idx = 1
      self.v_behitfly_time = 0
      break
    end
    if self.v_behitfly_time <= time * ran_mult then
      horizontal_acc = acc_cfg[start + 1] * ran_mult
      vertical_acc = acc_cfg[start + 2] * ran_mult
      break
    end
    self.v_behitfly_time = 0
    self.v_behitfly_idx = self.v_behitfly_idx + 1
    idx = self.v_behitfly_idx
  end
  return horizontal_acc, vertical_acc
end

function M:_do_rebound(speedx, speedy)
  local ret = true
  if self.v_behitfly_highest and self.v_behitfly_highest >= Config.MINIMUM_REBOUND_HEIGHT and self.v_rebound_cfg then
    local rebound_idx = (self.v_rebound_idx - 1) * 2 + 1
    local rebound_x = self.v_rebound_cfg[rebound_idx]
    local rebound_y = self.v_rebound_cfg[rebound_idx + 1]
    self.v_rebound_idx = self.v_rebound_idx + 1
    if rebound_x and rebound_y then
      self.v_in_rebound = true
      local ran_mult = self.v_ran_mult or 1
      speedx = speedx * rebound_x * ran_mult
      speedy = -speedy * rebound_y * ran_mult
      self.v_behitfly_up_end = false
      self.v_behitfly_time = 0
      self.v_behitfly_idx = 1
      self.v_char.state_manager:on_rebound()
      ret = false
    end
  end
  return ret, speedx, speedy
end

function M:_is_need_to_idle_state()
  local skill_mgr = self.v_char.skill_mgr
  local is_skill_move = skill_mgr:is_skill_move_default_now()
  if is_skill_move then
    return false
  end
  return true
end

function M:_update_dir_by_target()
  local tx, tz = self.v_navigator:get_cur_step_pos()
  if not tx then
    Log.Error("this role has no target or targetpos")
    return
  end
  local posx, posz = self.v_char:get_pos2()
  local is_arrive = self.v_navigator:is_arrive()
  if is_arrive then
    if not self.v_moveby_dir then
      self.v_dirx = 0
      self.v_dirz = 0
      if self:_is_need_to_idle_state() then
        self.v_char.state_manager:to_idle_state()
      end
    end
    self.v_navigator:stop()
    return
  end
  self:_update_dir(tx - posx, tz - posz)
end

function M:stop_move()
  self.v_dirx, self.v_dirz = 0, 0
  self.v_moveby_dir = false
  self.v_navigator:stop()
  self:cancel_move_inertial()
end

function M:get_dirx()
  return self.v_dirx
end

function M:get_dirz()
  return self.v_dirz
end

function M:is_active_moving()
  return 0 ~= self.v_dirx or 0 ~= self.v_dirz
end

function M:finish_rebound()
  return self.v_finish_rebound
end

function M:_can_move()
  local state_manager = self.v_char.state_manager
  if self.v_char.playing_cg then
    return false
  end
  return state_manager:can_move()
end

function M:on_obj_leave(msg)
  local uuid = msg.mm_obj
  if self.v_navigator:get_target_uuid() == uuid then
    self.v_navigator:stop()
  end
end

function M:set_change_speed_percent(change_percent)
  self.v_change_speed_percent = self.v_change_speed_percent + change_percent
end

function M:incline_move()
  local joy_dir = self.v_move_dir
  local face_dir = self.v_char:get_dir()
  local diff_val = joy_dir - face_dir
  local offset = 30
  local result = 0
  local length = 180 - offset
  if diff_val >= offset and diff_val <= 360 - offset then
    if diff_val <= 180 then
      result = diff_val - offset
      local part = 1 / length
      result = result * part
    else
      result = diff_val - 180
      local part = 1 / length
      result = result * part - 1
    end
  elseif diff_val <= -offset and diff_val >= -(360 - offset) then
    if diff_val >= -180 then
      result = diff_val + offset
      local part = 1 / length
      result = result * part
    else
      result = diff_val + 180
      local part = 1 / length
      result = result * part + 1
    end
  end
  self.v_char:refresh_run_angle(result)
end

function M:_try_flash_to_pos(x, y, z, check_layer, trigger_area_event)
  local has_terrain, height = Util.raycast(x, z, LAND_LAYER, y + 2, 4)
  if not has_terrain then
    return false
  end
  local ty = height + self.v_char:get_collider_offset_y()
  local is_collided = SceneMgr:check_wall_collision(self.v_char, x, z, ty)
  local is_success = false
  if not is_collided then
    if self.v_char:is_super_ghost() then
      is_success = true
    else
      local cur_x, cur_y, cur_z = self.v_char:get_pos()
      Util.VEC3_TEMP:Set(x - cur_x, y - cur_y, z - cur_z)
      Util.VEC3_TEMP:SetNormalize()
      local dir = Util.VEC3_TEMP
      local distance = self.v_flash_distance
      local is_hit, hit_x, hit_y, hit_z = CSHelper.RayCast2(cur_x, cur_y, cur_z, dir.x, dir.y, dir.z, distance, check_layer)
      if not is_hit then
        is_success = true
        goto lbl_83
      else
        self.v_flash_distance = vec3.DistanceA(hit_x, hit_y, hit_z, cur_x, cur_y, cur_z) + 0.1
      end
    end
  end
  ::lbl_83::
  if is_success then
    if not self.v_temp_vec3_0 then
      self.v_temp_vec3_0 = vec3.New()
      self.v_temp_vec3_1 = vec3.New()
    end
    self.v_temp_vec3_0:SetA(self.v_char:get_pos_vec3())
    self.v_temp_vec3_1:Set(x, height, z)
    self.v_char:set_pos(x, height, z)
    if trigger_area_event then
      local scene_logic = SceneMgr:get_scene_logic()
      if scene_logic then
        scene_logic:trigger_area_event_on_path(self.v_char, self.v_char.v_area_mask, self.v_temp_vec3_0, self.v_temp_vec3_1)
      end
    end
    return true
  else
    return false
  end
end

local FLASH_STEP = 0.5

function M:flash_to_pos(target_x, target_z, target_y, only_check_boundar, trigger_area_event)
  local cur_x, cur_y, cur_z = self.v_char:get_pos()
  local dist = vec3.DistanceA(target_x, target_y or cur_y, target_z, cur_x, cur_y, cur_z)
  if Util.almost_zero(dist) then
    return
  end
  local amend_y = cur_y + Config.FLASH_TO_POS_Y_OFFSET
  target_y = target_y or amend_y
  local dir_x, dir_z = cur_x - target_x, cur_z - target_z
  dir_x, dir_z = Mathx.normalize2(dir_x, dir_z)
  local step_x, step_z = dir_x * FLASH_STEP, dir_z * FLASH_STEP
  local distance = vec3.DistanceA(target_x, target_y, target_z, cur_x, amend_y, cur_z)
  local new_x, new_y, new_z = target_x, target_y, target_z
  self.v_flash_distance = distance
  local time = 10
  local check_layer = only_check_boundar and Layer.LayerMask.BoundaryBlock or Layer.obstacle_mask
  while time > 0 do
    local is_valid = self:_try_flash_to_pos(new_x, new_y, new_z, check_layer, trigger_area_event)
    if is_valid or Util.almost_zero(self.v_flash_distance) then
      self.v_flash_distance = nil
      return
    end
    new_x, new_z = new_x + step_x, new_z + step_z
    local new_dir_x, new_dir_z = cur_x - new_x, cur_z - new_z
    local dot = new_dir_x * dir_x + new_dir_z * dir_z
    if dot < 0 then
      self.v_flash_distance = nil
      return
    end
    time = time - 1
  end
end

function M:skill_move_by_joystick(max_speed, fade_in_time, fade_out_time, duration)
  self:set_move_by_skill_joystick(true)
  self:set_skill_joystick_speed_val(max_speed, fade_in_time, fade_out_time)
  if duration > 0 then
    local function cb()
      self:forced_reduce_skill_joystick_speed()
      
      self.joystick_move_timer = nil
    end
    
    if self.joystick_move_timer then
      Timer:remove_timer(self.joystick_move_timer)
      self.joystick_move_timer = nil
    end
    self.joystick_move_timer = Timer:add_timer(nil, duration, cb)
  end
end

function M:on_before_destroy()
  if self.joystick_move_timer then
    Timer:remove_timer(self.joystick_move_timer)
  end
end

function M:is_behitfly_up_end()
  return self.v_behitfly_up_end
end

function M:start_bezier_move(spline_file_path, align_curve, wait_time_list)
  local origin_pos = vec3.New(self.v_char:get_pos())
  local origin_dir = self.v_char:get_dir()
  self.v_bezier_move_data = self.v_bezier_move_data or {
    move_time = 0,
    wait_time_list = wait_time_list,
    spline_file_path = spline_file_path,
    align_curve = align_curve,
    origin_pos = origin_pos,
    dir = origin_dir
  }
  local data = self.v_bezier_move_data
  self.v_spline_cfg = ShareRes.get_spline_file(spline_file_path)
  if not data.spline_bezier then
    data.spline_bezier = spline_bezier:new(self.v_spline_cfg)
  else
    data.spline_bezier = spline_bezier:new(self.v_spline_cfg)
  end
  data.spline_bezier:set_local_coordinate(origin_pos.x, origin_pos.y, origin_pos.z, origin_dir)
end

function M:_update_bezier_move()
  if not self.v_bezier_move_data then
    return
  end
  local data = self.v_bezier_move_data
  local last_frame_move_time = data.move_time or 0
  data.move_time = data.move_time + self.v_char.time_mgr:get_dt_time()
  local dx, _, dz, tx, ty, tz = data.spline_bezier:get_displacement_over_time(last_frame_move_time, data.move_time, data.align_curve)
  self.v_char:move(dx, dz)
  if data.align_curve then
    Util.VEC3_TEMP:Set(tx, ty, tz)
    local euler_y = vec3.AngleAroundAxis(vec3.forward, Util.VEC3_TEMP, vec3.up)
    self.v_char:set_target_dir(euler_y, true)
  end
  if UNITY_EDITOR and Global.spline_debug then
    data.spline_bezier:debug()
  end
end

function M:stop_bezier_move()
  if self.v_bezier_move_data then
    self.v_bezier_move_data.spline_bezier:on_destroy()
    self.v_bezier_move_data = nil
  end
end

return M
