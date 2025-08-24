local Base = require("manager.fight.movement.missile_movement")
local M = Util.create_child_mt(Base)
local WORLD_TIME = 1
local CHAR_TIME = 2

function M:_init(missile, lineparams)
  Base._init(self, missile)
  self.v_target = self.v_missile:get_target()
  self.v_line_param = lineparams or self.missile_cfg.lineparams
  self:set_params(self.v_line_param)
  self.v_missle_trans = missile.transform
end

function M:set_params(params)
  local is_self_point = nil == params[7] or 0 == params[7]
  if is_self_point then
    self.v_pos_transfrom = self.v_char:get_setting_point(params[1])
  else
    self.v_pos_transfrom = self.v_char.weapon_mgr:get_attach_point_obj(params[1])
  end
  if self.v_target:is_missile() then
    self.v_end_transfrom = self.v_target.transform
  else
    self.v_end_transfrom = self.v_target:get_setting_point(params[2])
  end
  self.v_distance_offset = params[3] or 0
  self.v_max_dist = params[4] or 0
  self.v_out_dist_type = params[5] or 1
  self.v_out_dist_livetime = params[6] or 3
  self.v_out_dist_time = 0
  if not self.v_pos_transfrom then
    Log.Error("not find attach point ", self.v_missile.missile_id, params[1], self.v_missile.missile_id)
  end
  if not self.v_end_transfrom then
    Log.Error("not find attach point ", self.v_missile.missile_id, params[2], self.v_target.id)
  end
end

function M:change_move_params(attach_point1, attach_point2)
  local is_self_point = self.v_line_param[7] == nil or 0 == self.v_line_param[7]
  if is_self_point then
    self.v_pos_transfrom = self.v_char:get_setting_point(attach_point1)
  else
    self.v_pos_transfrom = self.v_char.weapon_mgr:get_attach_point_obj(attach_point1)
  end
  self.v_end_transfrom = self.v_target:get_setting_point(attach_point2)
end

function M:update()
  if not (not self.v_target:is_destroy() and not self.v_target:is_die() and not (self.v_out_dist_time > self.v_out_dist_livetime) and self.v_pos_transfrom) or not self.v_end_transfrom then
    self.v_missile:stop()
    return
  end
  local x, y, z = self.v_pos_transfrom:GetPositionA()
  local tx, ty, tz = self.v_end_transfrom:GetPositionA()
  local px, py, pz = (x + tx) / 2, (y + ty) / 2, (z + tz) / 2
  self.v_missle_trans:SetPositionA(px, py, pz)
  self.v_missle_trans:LookAtA(tx, ty, tz)
  local distance = Util.get_transform_dist(self.v_pos_transfrom, self.v_end_transfrom)
  distance = distance + self.v_distance_offset
  if distance > self.v_max_dist then
    local dt = 0
    if self.v_out_dist_type == WORLD_TIME then
      dt = Global.delta_time
    elseif self.v_out_dist_type == CHAR_TIME and not self.v_char:is_destroy() then
      dt = self.v_char:get_missile_dt()
    end
    self.v_out_dist_time = self.v_out_dist_time + dt
  else
    self.v_out_dist_time = 0
  end
  self.v_missile:set_transform_scale(1, 1, distance)
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

return M
