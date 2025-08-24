local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)
local UnityVector3 = UnityVector3()

function M:_init(missile, is_rebound, speed, acc)
  Base._init(self, missile)
  if is_rebound and type(is_rebound) ~= "table" then
    self.v_speed = speed or 0
    self.v_acc = acc or 0
    return
  end
  self.v_line_param = is_rebound or self.missile_cfg.lineparams
  self:set_params(self.v_line_param)
end

function M:change_move_params(speed, acc)
  self.v_speed = speed
  self.v_acc = acc
end

function M:update()
  local dt = GlobalTimeMgr:get_dt_time()
  local speed = self:_get_speed()
  local dist = dt * speed
  if 0 ~= dist then
    local pos = self.v_missile:get_pos_vec3()
    local dir = self.v_missile:get_dir_vec()
    Util.VEC3_TEMP:SetA(dir)
    Util.VEC3_TEMP:Mul(dt * speed)
    Util.VEC3_TEMP:Add(pos)
    self.v_missile:set_pos_vec(Util.VEC3_TEMP)
  end
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:_get_speed()
  local speed = (self.v_speed + self.v_acc * self.v_missile:get_time()) * self.v_time_scale * self.v_missile:get_owner_time_scale()
  if self.v_can_reverse then
    return speed
  else
    return math.max(speed, 0)
  end
end

function M:set_speed(speed)
  self.v_speed = speed
end

function M:set_params(params)
  self.v_speed = params[1] or 0
  self.v_acc = params[2] or 0
  self.v_can_reverse = Util.is_more_than_zero(params[3])
end

return M
