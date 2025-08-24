local Base = require("manager.fight.movement.missile_movement")
local Quat = require("base.quat")
local Math = require("base.mathx")
local Vec3 = require("base.vec3")
local _sin = math.sin
local _cos = math.cos
local _atan = math.atan
local deg2rad = Math.Deg2Rad
local rad2deg = Math.Rad2Deg
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  self.v_dir_rad = missile:get_dir() * deg2rad
  local params = lineparams or self.missile_cfg.lineparams
  self:set_params(params)
end

function M:set_params(params)
  self.v_speed = params[1] or 0
  self.v_start_height = (params[2] or 0) + self.v_char:get_pos_height()
  self.v_gravity = params[3] or 0
  self.v_end_height = (params[4] or 0) + self.v_char:get_pos_height()
  local use_tar_pos = 1 == params[6]
  self.v_not_rotate = 1 == params[7]
  local missile = self.v_missile
  if use_tar_pos then
    local cx, cz = missile:get_pos2()
    local tar_pos = missile:get_pos_or_target_pos()
    self.v_dist = Math.distance2(cx, cz, tar_pos.x, tar_pos.z)
    self.v_speed = self.v_dist / self.missile_cfg.LiveTime
    self.v_dir_rad = _atan(tar_pos.x - cx, tar_pos.z - cz)
    self.v_missile:set_dir(self.v_dir_rad * rad2deg)
  else
    self.v_dist = tonumber(params[5])
  end
  local t = self.v_dist / self.v_speed
  local s = self.v_end_height - self.v_start_height
  self.v_start_speed_h = s / t - 0.5 * self.v_gravity * t
  self.v_st_x, self.v_st_y, self.v_st_z = self.v_missile:get_pos()
  self.v_missile_trans = self.v_missile:get_effect_trans()
end

function M:update()
  local missile = self.v_missile
  local cur_live_time = missile:get_time()
  local dir = self.v_dir_rad
  local at = self.v_gravity * cur_live_time
  local cur_dist = self.v_speed * cur_live_time
  if cur_dist >= self.v_dist then
    missile:stop()
    return
  end
  local height = self.v_start_height + self.v_start_speed_h * cur_live_time + 0.5 * at * cur_live_time
  missile:set_pos(_sin(dir) * cur_dist + self.v_st_x, height, _cos(dir) * cur_dist + self.v_st_z)
  if not self.v_not_rotate then
    local cur_x_deg = _atan(self.v_start_speed_h + at, self.v_speed) * rad2deg
    self.v_missile_trans:SetLocalEuler(-cur_x_deg, 0, 0)
  end
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:change_move_params(speed, gravity)
  self.v_speed = speed
  self.v_gravity = gravity
end

return M
