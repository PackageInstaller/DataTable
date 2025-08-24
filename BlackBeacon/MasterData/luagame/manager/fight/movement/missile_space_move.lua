local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local M = Util.create_child_mt(Base)

function M:_init(missile, is_rebound, speed, acc)
  Base._init(self, missile)
  self.v_dir = nil
  if is_rebound and type(is_rebound) ~= "table" then
    self.v_speed = speed or 0
    self.v_acc = acc or 0
    return
  end
  self.v_line_param = is_rebound or self.missile_cfg.lineparams
  self:set_params(self.v_line_param)
end

function M:set_params(params)
  self.v_speed = params[1] or 0
  self.v_acc = params[2] or 0
  self.v_face_to_target = nil == params[3] or 0 == params[3]
end

local temp_vec3 = Vec3.New()

function M:update()
  local pos = self.v_missile:get_pos_vec3()
  local dt = GlobalTimeMgr:get_dt_time()
  if not self.v_dir then
    local dir = self.v_missile:get_space_move_dir(self.v_face_to_target)
    self.v_dir = dir
  end
  temp_vec3:SetA(self.v_dir)
  temp_vec3:Mul(dt * self:_get_speed())
  temp_vec3:Add(pos)
  self.v_missile:set_pos_vec(temp_vec3)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:_get_speed()
  return (self.v_speed + self.v_acc * self.v_missile:get_time()) * self.v_time_scale * self.v_missile:get_owner_time_scale()
end

function M:set_speed(speed)
  self.v_speed = speed
end

return M
