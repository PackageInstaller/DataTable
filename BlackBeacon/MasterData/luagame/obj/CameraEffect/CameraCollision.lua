local Vec3 = require("base.vec3")
local config = require("config")
local PINCH_TYPE = {FREE = 1, GEAR = 2}
local CSCameraCollisonType = typeof(CS.Game.CameraCollision)
local M = Util.create_class()

function M:_init(camera_lua)
  self.v_camera = camera_lua
  self.v_camera_transform = camera_lua.v_camera_transform
  self.v_focal_point = camera_lua.v_focal_point
  self.v_char = camera_lua.v_char
  self.v_cs_camera_collsion = camera_lua.v_camera_obj:GetComponent(CSCameraCollisonType)
end

function M:init_camera_cfg(camera_cfg)
  self.v_camera_cfg = camera_cfg
end

local camera_dir = Vec3.New()

function M:get_camera_collision_component()
  return self.v_cs_camera_collsion
end

function M:get_camera_hit_distance()
  if not self.v_camera_cfg then
    return 0
  end
  local pinch_type = self.v_camera_cfg.CameraPinchType
  local start_pos
  local x, y, z = self.v_camera_transform:GetPositionA()
  local distance
  if pinch_type == PINCH_TYPE.GEAR and self.v_char then
    local char_pos = self.v_char:get_pos_vec3()
    start_pos = char_pos
    camera_dir.x = x - char_pos.x
    camera_dir.y = y - char_pos.y
    camera_dir.z = z - char_pos.z
    distance = self.v_camera.v_target_val
  else
    start_pos, camera_dir, distance = self:get_check_hit_info()
  end
  local norm_dir = camera_dir:SetNormalize()
  local max_distance = 99999
  local need_check_obstacle = SceneMgr:check_obstacle_missile()
  local hit_distance = self.v_cs_camera_collsion:GetClosestCollidedDistance(start_pos.x, start_pos.y, start_pos.z, norm_dir.x, norm_dir.y, norm_dir.z, distance, need_check_obstacle or false, self.v_camera.v_camera_mode == config.CAMERA_VIEW_TYPE.SHOULDER)
  return hit_distance > 0 and max_distance > hit_distance and hit_distance or 0
end

local vec = Vec3.New()
local focal_pos = Vec3.New()

function M:get_check_hit_info()
  focal_pos.x, focal_pos.y, focal_pos.z = self.v_focal_point:GetPositionA()
  local camera_pos_x, camera_pos_y, camera_pos_z = self.v_camera_transform:GetPositionA()
  vec.x = camera_pos_x - focal_pos.x
  vec.y = camera_pos_y - focal_pos.y
  vec.z = camera_pos_z - focal_pos.z
  local pinch_distance = self.v_camera.v_pinch_val or self.v_camera_cfg.DefaultDistance
  local check_distance = math.max(self.v_camera_cfg.DefaultDistance, pinch_distance)
  return focal_pos, vec, check_distance
end

return M
