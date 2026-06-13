local Base = require("manager.fight.movement.missile_movement")
local Math = require("base.mathx")
local M = Util.create_child_mt(Base)
local POSTYPE_RATIO = 1
local POSTYPE_FIXED = 2

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self:set_params(params)
  self.v_target = self.v_missile:get_target()
end

function M:set_params(params)
  self.v_pos_type = params[1] or 1
  self.v_pos_value = params[2] or 0
  self.v_out_dist_break = 1 == params[3]
  self.v_start_attach_point = params[4]
  self.v_end_attach_point = params[5]
end

function M:should_stop()
  return not self.v_target or self.v_target:is_destroy() or not self.v_char or self.v_char:is_destroy()
end

local function _get_point_pos(char, attach_point)
  if nil == attach_point then
    return char.transform:GetPositionA()
  end
  local p = char:get_setting_point(attach_point)
  if nil == p then
    return char.transform:GetPositionA()
  end
  return p:GetPositionA()
end

function M:update()
  if self:should_stop() then
    self.v_missile:stop()
    return
  end
  local x, y, z = _get_point_pos(self.v_char, self.v_start_attach_point)
  local tx, ty, tz = _get_point_pos(self.v_target, self.v_end_attach_point)
  local dx, dy, dz = tx - x, ty - y, tz - z
  local ndx, ndy, ndz = Math.normalize(dx, dy, dz)
  local trans = self.v_missile.transform
  local value = self.v_pos_value
  if self.v_pos_type == POSTYPE_RATIO then
    trans:SetPositionA(x + dx * value, y + dy * value, z + dz * value)
  elseif self.v_pos_type == POSTYPE_FIXED then
    local dist = Math.dist_vec3A(dx, dy, dz, 0, 0, 0)
    if value > dist and self.v_out_dist_break then
      self.v_missile:stop()
      return
    end
    trans:SetPositionA(x + ndx * value, y + ndy * value, z + ndz * value)
  end
  trans:LookAtA(tx, ty, tz)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

return M
