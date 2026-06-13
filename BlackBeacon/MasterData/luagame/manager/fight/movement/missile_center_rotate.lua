local Base = require("manager.fight.movement.missile_movement")
local mathx = require("base.mathx")
local Quat = require("base.quat")
local deg2rad = mathx.Deg2Rad
local _sin = math.sin
local _cos = math.cos
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self.v_line_param = params
  self:set_params(params)
  self.v_elapse = 0
  self.v_cur_time = 0
  self.cur_index = 1
end

function M:set_params(params)
  local start_deg = params[1]
  start_deg = start_deg + self.v_char:get_dir()
  self.v_cur_rotate_deg = start_deg
  self.v_cur_rad = start_deg * deg2rad
  self.v_raduis = params[2]
  if params[2] < 0 then
    local self_x, self_z = self.v_missile:get_pos2()
    local owner_x, owner_z = self.v_char:get_pos2()
    self.v_raduis = mathx.dist_vec2A(self_x, self_z, owner_x, owner_z)
  else
    self.v_raduis = params[2]
  end
  self.v_times = params[3]
  self.v_speeds = params[4]
  self.v_accs = params[5]
  self.v_use_born_y = Util.is_more_than_zero(params[6])
end

local function _get_param_index(self)
  local time = 0
  for index = 1, #self.v_times do
    time = time + self.v_times[index]
    if time >= self.v_elapse then
      return index
    end
  end
  return #self.v_times
end

local function _check_cur_time(self, index)
  if self.cur_index ~= index then
    self.v_cur_time = 0
  end
  self.cur_index = index
end

local function _get_speed(self)
  local index = _get_param_index(self)
  _check_cur_time(self, index)
  return (self:_get_base_speed(index) + self:_get_acc(index) * self.v_cur_time) * self.v_time_scale * self.v_missile:get_owner_time_scale()
end

local function _radius_rotate(self, dt)
  self.v_cur_rad = self.v_cur_rad + dt * _get_speed(self) * deg2rad
  local dx = _sin(self.v_cur_rad) * self.v_raduis
  local dz = _cos(self.v_cur_rad) * self.v_raduis
  local role = self.v_missile:get_bind_targer() or self.v_char
  local sx, sy, sz = role:get_pos()
  if self.v_use_born_y then
    sy = self.v_missile:get_born_pos().y
  end
  self.v_missile:set_pos(dx + sx, sy, dz + sz)
end

local function _self_rotate(self, dt)
  self.v_cur_rotate_deg = self.v_cur_rotate_deg + dt * _get_speed(self)
  self.v_missile.transform:SetLocalEulerY(self.v_cur_rotate_deg)
end

function M:update()
  local dt = GlobalTimeMgr:get_dt_time()
  self.v_elapse = self.v_elapse + dt
  self.v_cur_time = self.v_cur_time + dt
  if self.v_raduis > 0 then
    _radius_rotate(self, dt)
  else
    _self_rotate(self, dt)
  end
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:_get_acc(index)
  return self.v_accs[index]
end

function M:_get_base_speed(index)
  return self.v_speeds[index]
end

return M
