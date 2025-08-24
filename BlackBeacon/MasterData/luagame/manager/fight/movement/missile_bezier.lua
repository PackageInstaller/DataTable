local Base = require("manager.fight.movement.missile_movement")
local spline_bezier = require("gamelogic.splines.spline_bezier")
local vec3 = require("base.vec3")
local util = require("utils.util")
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  local params = lineparams or self.missile_cfg.lineparams
  self:set_params(params)
end

function M:update()
  local live_time = self.v_missile:get_time()
  if live_time > self.missile_cfg.LiveTime then
    self.v_missile:stop()
    return
  end
  local segment_index, normalized_t = self.v_spline_bezier:get_bounding_index(live_time)
  local x, y, z = self.v_spline_bezier:evaluate_position_in_worldspace(segment_index, normalized_t)
  self.v_missile:set_pos(x, y, z)
  if self.v_align_curve then
    local tangent_x, tangent_y, tangent_z = self.v_spline_bezier:evaluate_tangent_in_worldspace(segment_index, normalized_t)
    util.VEC3_TEMP:Set(tangent_x, tangent_y, tangent_z)
    local euler_y = vec3.AngleAroundAxis(vec3.forward, util.VEC3_TEMP, vec3.up)
    self.v_missile:set_target_dir(euler_y, true)
  end
  if UNITY_EDITOR and Global.spline_debug then
    self.v_spline_bezier:debug()
  end
end

function M:set_params(params)
  self.v_spline_file_path = params[1]
  self.v_align_curve = params[2]
  self.v_spline_cfg = ShareRes.get_spline_file(self.v_spline_file_path)
  if not self.v_spline_bezier then
    self.v_spline_bezier = spline_bezier:new(self.v_spline_cfg)
  else
    self.v_spline_bezier:init_data(self.v_spline_cfg)
  end
  local rotation_y = self.v_missile:get_dir()
  local root_pos = self.v_missile:get_origin_pos()
  self.v_spline_bezier:set_local_coordinate(root_pos.x, root_pos.y, root_pos.z, rotation_y)
end

return M
