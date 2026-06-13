local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local Vec2 = require("base.vec2")
local Mathx = require("base.mathx")
local Layer = require("utils.layer")
local SceneObstacle = require("manager.scene.scene_obstacle")
local ScenePlatLink = require("manager.scene.scene_plat_link")
local CSHelper = _ENV.CSHelper
local Util = _ENV.Util
local Log = _ENV.Log
local TypeUnityCollider = typeof(UnityEngine.Collider)
local TypeAnimation = typeof(UnityEngine.Animation)
local TypeScenePlatLink = typeof(CS.Game.ScenePlatLink)
local TERRAIN_LAYER = Layer.Layer.Terrain
local SCENEBLOCK_LAYER = Layer.Layer.SceneBlock
local WALKBLOCK_LAYER = Layer.Layer.WalkBlock
local MOVED_TIME_SCALE = 1
local CONFIG = {MAX_LINK_UPDATE_CNT_PER_FRAME = 2}
local _tinsert = table.insert
local M = Util.create_class()

function M.create(container, region, mgr)
  local root_name = region:get_plat_gameobj_name()
  local obj = container:Get(root_name)
  if nil == obj or obj:IsNull() then
    Log.Error("场景编辑器里面的平台，在scene里面不存在， name = ", root_name)
    return
  end
  return M:new(obj, region, mgr)
end

function M:_init(root, region, mgr)
  self.v_mgr = mgr
  self.v_gameobj = root
  self.v_transform = root.transform
  self.v_region = region
  self.v_name = region:get_plat_name()
  region:attach_all_scene_prefab(self.v_gameobj)
  self.v_collider_list = {}
  self.v_is_active = true
  self.v_is_moving = false
  self.v_movement = Vec3.New(0, 0, 0)
  self.v_position = Vec3.New(self.v_transform:GetPositionA())
  self.v_old_position = Vec3.New(self.v_position:Get())
  self.v_now_rotation = Quat.New(self.v_transform:GetRotationA())
  self.v_old_rotation = Quat.New(self.v_now_rotation:Get())
  self.v_local_position = Vec3.New(self.v_transform:GetLocalPositionA3())
  self.v_gameobj:SetActiveEx(true)
  self:_init_collider()
  self:_init_links()
  self.v_update_link_idx = 1
  self.v_anim = self.v_gameobj:GetComponent(TypeAnimation)
end

function M:_init_links()
  local link_comp = self.v_gameobj:GetComponent(TypeScenePlatLink)
  Util.assert(link_comp, "平台缺少ScenePlatLink, ", self.v_gameobj.name)
  local arr = link_comp.Links
  for i = 0, arr.Count - 1 do
    local linkobj = arr[i]
    local link = ScenePlatLink:new(linkobj, self)
    _tinsert(self.v_region.origin_link_list, link)
  end
end

function M:_do_update_one_link()
  local region = self.v_region
  local len = #region.origin_link_list
  local idx = self.v_update_link_idx
  idx = len < idx and 1 or idx
  local link = region.origin_link_list[idx]
  if nil == link then
    return
  end
  local end_point = link:get_end_point()
  end_point:check_region()
  local start_point = link:get_start_point()
  start_point:check_init()
  self.v_update_link_idx = idx + 1
end

function M:_update_links()
  for _ = 1, CONFIG.MAX_LINK_UPDATE_CNT_PER_FRAME do
    self:_do_update_one_link()
  end
end

function M:_init_collider()
  local colliders = self.v_gameobj:GetComponentsInChildren(TypeUnityCollider, true)
  if nil == colliders then
    return
  end
  for i = 0, colliders.Length - 1 do
    local collider = colliders[i]
    local layer = collider.gameObject.layer
    if layer == TERRAIN_LAYER then
      local cid = collider:GetInstanceID()
      self.v_mgr:regist(cid, self)
      self.v_collider_list[i + 1] = collider
    elseif layer == SCENEBLOCK_LAYER or layer == WALKBLOCK_LAYER then
      SceneObstacle.add(collider, true)
    end
  end
end

function M:_update_move()
  if not self.v_is_moving then
    return
  end
  local x, y, z = self.v_transform:GetPositionA()
  local dx, dy, dz = self.v_transform:GetLocalPositionA3()
  local pos = self.v_position
  local local_pos = self.v_local_position
  self.v_movement.x, self.v_movement.y, self.v_movement.z = dx - local_pos.x, dy - local_pos.y, dz - local_pos.z
  pos:Set(x, y, z)
  local_pos:Set(dx, dy, dz)
  self.v_old_rotation:Set(self.v_now_rotation:Get())
  self.v_now_rotation:Set(self.v_transform:GetRotationA())
  self.v_old_position:Set(self.v_position:Get())
  self.v_region:set_pos(x, z)
end

function M:clear()
  self.v_mgr = nil
  self.v_contianer = nil
  self.v_region = nil
  self:stop_move()
end

function M:set_terrain_enable(is_enable)
  for _, collider in ipairs(self.v_collider_list) do
    collider.enabled = is_enable
  end
end

function M:update()
  self:_update_links()
end

function M:late_update()
  self:_update_move()
end

function M:is_overlap_with(target_collider)
  local is_overlap
  for _, collider in ipairs(self.v_collider_list) do
    is_overlap = CSHelper.IsColliderIntersects2D(collider, target_collider)
    if is_overlap then
      return true
    end
  end
  return false
end

function M:get_movement()
  return self.v_movement.x, self.v_movement.y, self.v_movement.z, self.v_old_position, self.v_position, self.v_old_rotation, self.v_now_rotation
end

function M:set_time_scale(scale)
  if self.v_anim and not self.v_anim:IsNull() and self.v_anim_name then
    local state = self.v_anim:get_Item(self.v_anim_name)
    if state then
      state.speed = scale
      if scale < 0 and 0 == state.time then
        state.time = state.clip.length
      end
    end
  end
end

function M:update_plat_movement(is_move, anim)
  self.v_is_moving = is_move
  self.v_anim_name = anim
  if is_move then
    if self.v_anim == nil or self.v_anim:IsNull() then
      Log.Error("平台没有配置Animation", self.v_name)
      return
    end
    self.v_anim:Play(anim)
  else
    self:stop_move()
  end
end

function M:update_plat_moved(anim)
  self.v_is_moving = true
  self.v_anim_name = anim
  if self.v_anim == nil or self.v_anim:IsNull() then
    Log.Error("平台没有配置Animation", self.v_name)
    return
  end
  self:set_time_scale(MOVED_TIME_SCALE)
  self.v_anim:Play(anim)
end

function M:set_is_moving()
  self.v_is_moving = true
end

function M:stop_move()
  self.v_is_moving = false
  self.v_movement:Set(0, 0, 0)
  self.v_now_rotation:Set(self.v_transform:GetRotationA())
  self.v_old_rotation:Set(self.v_now_rotation:Get())
  self.v_old_position:Set(self.v_position:Get())
  if self.v_anim and not self.v_anim:IsNull() then
    self.v_anim:Stop()
  end
end

function M:is_moving()
  return self.v_is_moving
end

function M:set_active(is_active)
  self.v_is_active = is_active
  self.v_gameobj:SetActiveEx(is_active)
  self:stop_move()
end

function M:is_active()
  return self.v_is_active
end

function M:get_name()
  return self.v_name
end

function M:get_region()
  return self.v_region
end

function M:get_pos2()
  return self.v_position.x, self.v_position.z
end

function M:is_include_pos(x, z)
  local w, h = self.v_region:get_size()
  local min_x, min_z = self.v_position.x, self.v_position.z
  local max_x, max_z = self.v_position.x + w, self.v_position.z + h
  if x < min_x or x > max_x or z < min_z or z > max_z then
    return false
  end
  return true
end

return M
