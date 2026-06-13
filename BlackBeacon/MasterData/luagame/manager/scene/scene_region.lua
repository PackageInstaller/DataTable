local Vec3 = require("base.vec3")
local Layer = require("utils.layer")
local MathX = require("base.mathx")
local FightConfig = require("uimodule.fight.fight_config")
local METER_PER_CELL = Config.METER_PER_CELL
local UNIT_PER_CELL = 32
local _floor = math.floor
local _atan = math.atan
local _abs = math.abs
local _rad2deg = 180 / math.pi
local TypeUnityRigidbody = typeof(UnityEngine.Rigidbody)
local TypeUnityBoxCollider = typeof(UnityEngine.BoxCollider)
local TypeUVAnimation = typeof(CS.UVAnimation)
local TypeText = TypeUnityUIText
local UnityDestroy = _ENV.UnityDestroy
local TAG_NAME = {TP = "tp", EMPTY_WALL = "emptywall"}
local CompExtensions = _ENV.CompExtensions
local _tinsert = table.insert
local CSHelper = _ENV.CSHelper
local CHECK_SIZE = 2
local _uid = 1

local function _next_uid()
  _uid = _uid + 1
  return _uid
end

local M = Util.create_class()

function M:_init(size_config, area_config, pos_config, plat_scene_obj, logic, is_plat, area_name_list, map)
  self.v_scene_logic = logic
  self.v_is_plat = is_plat
  self.v_map = map
  self.v_debug_objs = {}
  self.v_size_config = size_config
  self.v_area_config = area_config
  self.v_pos_config = pos_config
  self.v_cell_width = 0
  self.v_cell_height = 0
  self.v_map_min_x = 0
  self.v_map_min_y = 0
  self.v_map_max_x = 0
  self.v_map_max_y = 0
  self.v_map_height = 0
  self.v_area_map = {}
  self.v_area_cmap = {}
  self.v_area_collider_map = {}
  self.v_tp_map = {}
  self.v_empty_wall_cid_map = {}
  self.v_empty_wall_cid_group = {}
  self.v_position_map = {}
  self.v_scan_dirty = false
  self.v_gg = nil
  self.v_gg_offset = nil
  self.v_has_platforms = false
  self.v_plat = nil
  self.v_plat_name = nil
  self.v_plat_gameobj_name = nil
  self.origin_link_list = {}
  self.v_temp_link_dic = {}
  self.v_region_link_flag = _next_uid()
  self.v_link_flag_dirty = false
  self:_load_size()
  if not self.v_is_plat then
    self:_load_scene_prefab()
  else
    self.v_scene_prefab = plat_scene_obj
    self.v_scene_prefab:SetActive(true)
  end
  self:_load_area(area_name_list)
  self:_do_create_empty_border_collider()
  self:_load_postions()
  self:_load_corner_and_edge()
end

function M:_cell_to_grid_xy(cell)
  local x = cell >> 16 & 65535
  local y = cell & 65535
  return x, y
end

function M:_load_size()
  local size_info = self.v_size_config
  if size_info.Ratio and 0 ~= size_info.Ratio then
    self.v_meter_per_cell = size_info.Ratio
  else
    self.v_meter_per_cell = METER_PER_CELL
  end
  self.v_meter_per_cell_m = 1 / self.v_meter_per_cell
  self.v_unit_per_cell = UNIT_PER_CELL
  self.v_meter_per_unit = self.v_meter_per_cell / self.v_unit_per_cell
  self.v_cell_width = size_info.CellWidth
  self.v_cell_height = size_info.CellHeight
  self.v_map_min_x = size_info.Offset[1]
  self.v_map_min_y = size_info.Offset[3]
  self.v_map_z = size_info.Offset[2]
  local width = self.v_cell_width * self.v_meter_per_cell
  local height = self.v_cell_height * self.v_meter_per_cell
  self.v_map_max_x = self.v_map_min_x + width
  self.v_map_max_y = self.v_map_min_y + height
  self.v_map_half_width = width * 0.5
  self.v_map_half_height = height * 0.5
  self.v_map_width = width
  self.v_map_height = height
  self.v_has_platforms = size_info.HasPlatform
end

function M:_load_scene_prefab()
  local pf_name = self.v_scene_logic:get_scene_prefab()
  if not pf_name then
    Log.Error("_load_scene_prefab failure, prefab name = ", pf_name)
    return
  end
  local game_object = ResPoolMgr:get_world_model(pf_name)
  game_object.name = pf_name
  game_object.transform.position = Vec3.New(0, 0, 0)
  self.v_scene_prefab = game_object
  for i = 0, game_object.transform.childCount - 1 do
    game_object.transform:GetChild(i):SetActive(true)
  end
  self:_do_create_border_collider()
end

function M:_load_area(area_name_list)
  local area_info = self.v_area_config
  for _, v in pairs(area_info.Areas) do
    if type(v.Key) ~= "string" then
    else
      if not v.TagMap then
        local TagMap = {}
        TagMap[v.Key] = v.Key
        if "string" == type(v.Tag) then
          local list = Util.split_str(v.Tag, ",")
          for _, tag in pairs(list) do
            TagMap[tag] = tag
          end
        end
        v.TagMap = TagMap
      end
      local area_obj = self:_get_scene_obj(v.Key, true)
      if area_obj.layer ~= Layer.Layer.WalkBlock then
        self:_disable_area_collider(area_obj)
      end
      v.area_obj = area_obj
      v.area_tra = area_obj.transform
      v.origin_pos = v.Position
      v.box_collider = area_obj:GetComponent(TypeUnityBoxCollider)
      local center_pos = v.box_collider.center
      v.box_center = Vec3.New(center_pos.x, center_pos.y, center_pos.z)
      v.box_half_size = {
        x = v.Size[1] / 2,
        y = v.Size[2] / 2,
        z = v.Size[3] / 2
      }
      v.box_check_size = {
        x = v.Size[1] / 2 + CHECK_SIZE,
        y = v.Size[2] / 2 + CHECK_SIZE,
        z = v.Size[3] / 2 + CHECK_SIZE
      }
      v.is_obstacle = nil
      self.v_area_map[v.Key] = v
      if v.Tag == TAG_NAME.TP then
        self.v_tp_map[v.Key] = v
      elseif "string" == type(v.Tag) and string.find(v.Tag, TAG_NAME.EMPTY_WALL) then
        local cid = area_obj:GetInstanceID()
        self.v_empty_wall_cid_map[cid] = v
        if v.Group then
          self.v_empty_wall_cid_group[v.Group] = self.v_empty_wall_cid_group[v.Group] or {}
          self.v_empty_wall_cid_group[v.Group][cid] = v
        end
      end
      _tinsert(area_name_list, v.Key)
    end
  end
end

function M:_get_scene_obj(key, is_area)
  local child_path = is_area and "Areas/" .. key or "Positions/" .. key
  local obj = self.v_scene_prefab:FindChild(child_path)
  if nil == obj then
    Log.Error("can't find child in ", self.v_scene_prefab.gameObject.name, ", child path is:", child_path)
  end
  return obj
end

function M:_load_postions()
  local position_info = self.v_pos_config
  for _, v in pairs(position_info.Positions) do
    local obj = self:_get_scene_obj(v.Key)
    Util.assert(obj, "缺失点位：", v.Key)
    local trans = obj.transform
    local info = {
      Key = v.Key,
      Tag = v.Tag,
      Trans = trans,
      X = trans.position.x,
      Y = trans.position.y,
      Z = trans.position.z
    }
    self.v_position_map[v.Key] = info
  end
end

function M:_load_corner_and_edge()
  local c1 = Vec3.New(self.v_map_min_x, 0, self.v_map_min_y)
  local c2 = Vec3.New(self.v_map_min_x, 0, self.v_map_max_y)
  local c3 = Vec3.New(self.v_map_max_x, 0, self.v_map_max_y)
  local c4 = Vec3.New(self.v_map_max_x, 0, self.v_map_min_y)
  self.v_edges = {
    {c1, c2},
    {c2, c3},
    {c3, c4},
    {c4, c1}
  }
end

function M:_enable_area_collider(colliderObj, layer)
  layer = layer or Layer.Layer.WalkBlock
  local collider = colliderObj:GetComponent(TypeUnityBoxCollider)
  colliderObj:SetActive(true)
  collider.enabled = true
  collider.isTrigger = false
  colliderObj.layer = layer
  local rigidbody = collider:GetComponent(TypeUnityRigidbody)
  if not rigidbody or rigidbody:IsNull() then
    local new_rigid = colliderObj:AddComponent(TypeUnityRigidbody)
    new_rigid.useGravity = false
    new_rigid.isKinematic = true
  end
end

function M:_disable_area_collider(colliderObj)
  local collider = colliderObj:GetComponent(TypeUnityBoxCollider)
  colliderObj:SetActive(true)
  collider.enabled = false
end

function M:_do_create_border_collider()
  if self.v_is_plat then
    return
  end
  local layer = Layer.Layer.WalkBlock
  self.v_border_collider_map = {}
  for i = 1, 4 do
    local key = "wall" .. i
    local go = self:_get_scene_obj(key, true)
    self:_disable_area_collider(go)
    local cid = go:GetInstanceID()
    self.v_border_collider_map[cid] = go
  end
end

function M:_do_create_empty_border_collider()
  if self.v_is_plat then
    return
  end
  for cid, v in pairs(self.v_empty_wall_cid_map) do
    self:_disable_area_collider(v.area_obj)
    self.v_border_collider_map[cid] = v.area_obj
  end
end

function M:_destroy_border_collider()
  if self.v_border_collider_map then
    for _, go in pairs(self.v_border_collider_map) do
      self:_disable_area_collider(go)
    end
  end
  self.v_border_collider_map = nil
end

function M:_xy_to_cell_in_local(x, y)
  x = x * self.v_meter_per_cell_m
  y = y * self.v_meter_per_cell_m
  x = _floor(x)
  y = _floor(y)
  return x << 16 | y
end

function M:_xy_to_cell(x, y)
  x = x - self.v_map_min_x
  y = y - self.v_map_min_y
  return self:_xy_to_cell_in_local(x, y)
end

function M:_cell_to_xy_in_local(cell)
  local x = cell >> 16 & 65535
  local y = cell & 65535
  x = x * self.v_meter_per_cell
  y = y * self.v_meter_per_cell
  return x, y
end

function M:_cell_to_xy(cell)
  local x, y = self:_cell_to_xy_in_local(cell)
  x = x + self.v_map_min_x
  y = y + self.v_map_min_y
  return x, y
end

function M:_create_area_collider(area)
  local layer = Layer.Layer.WalkBlock
  self:_enable_area_collider(area.area_obj, layer)
  local go = area.area_obj
  if self.v_is_plat then
    local x, y, z = area.origin_pos[1], area.origin_pos[2], area.origin_pos[3]
    local offset_x, offset_z = self.v_gg_offset.x, self.v_gg_offset.z
    local position = {
      x + offset_x,
      y,
      z + offset_z
    }
    go = self:_copy_area(area.area_tra.parent, position, area.box_center, area.Size)
    go.name = area.Key .. "(Copy)"
    self:_enable_area_collider(go, layer)
  end
  local cid = go:GetInstanceID()
  self.v_area_collider_map[cid] = true
  self.v_area_cmap[area] = go
end

function M:_copy_area(parent, position, center, size)
  local go = ResPoolMgr:get_pure_box_collider()
  go:ResetAttr()
  local transform = go.transform
  transform.parent = parent
  transform:SetPositionA(position[1], position[2], position[3])
  local collider = go:GetComponent(TypeUnityBoxCollider)
  collider.center = center
  collider.size = Vec3.New(size[1], size[2], size[3])
  return go
end

function M:_clear_links()
  for _, link in ipairs(self.origin_link_list) do
    link:clear()
  end
end

function M:_destroy_area_collider(area)
  local go = self.v_area_cmap[area]
  if not go then
    return
  end
  local cid = go:GetInstanceID()
  if self.v_is_plat then
    ResPoolMgr:release(go)
  else
    self:_disable_area_collider(go)
  end
  self.v_area_collider_map[cid] = nil
  self.v_area_cmap[area] = nil
end

function M:_set_scene_prefab_parent(area, parent)
  area.parent = parent
  if not area.is_obstacle then
    area.area_tra:AttachTo(parent.transform, true)
  else
    area.area_tra:DetachTrans()
  end
end

function M:_refresh_link_flag()
  if not self.v_link_flag_dirty then
    return
  end
  self.v_link_flag_dirty = false
  local new_flag = _next_uid()
  self.v_region_link_flag = new_flag
  for link in pairs(self.v_temp_link_dic) do
    local plat = link:get_plat()
    local region = plat:get_region()
    region:set_link_flag(new_flag)
  end
end

do
  local BOUND_EFFECT = "Fx_Linjie01"
  local BOUND_EFFECT_EULERY = {
    90,
    90,
    0,
    0
  }
  
  local function _create_bound_effect(self, name, pos_x, pos_z, angle, len)
    local function callback(game_object)
      game_object.transform:SetLocalScaleA(1, 1, len)
      
      local uv_object = game_object:FindChild("Bianjie_101")
      local uv_animation = uv_object:GetComponent(TypeUVAnimation)
      uv_animation:SetTextOffsetXY(1, len)
    end
    
    local height = Global.hero:get_pos_height()
    self.v_scene_logic:create_gameobj(BOUND_EFFECT, name, pos_x, height, pos_z, angle, callback)
  end
  
  function M:_create_rect_bound_effect()
    local length_x = self.v_map_max_x - self.v_map_min_x
    local length_y = self.v_map_max_y - self.v_map_min_y
    local len, pos_x, pos_z
    for i = 1, 4 do
      if 1 == i then
        len = length_x
        pos_x = self.v_map_min_x + length_x / 2
        pos_z = self.v_map_min_y - 0.5
      elseif 2 == i then
        len = length_x
        pos_x = self.v_map_min_x + length_x / 2
        pos_z = self.v_map_max_y + 0.5
      elseif 3 == i then
        len = length_y
        pos_x = self.v_map_min_x - 0.5
        pos_z = self.v_map_min_y + length_y / 2
      elseif 4 == i then
        len = length_y
        pos_x = self.v_map_max_x + 0.5
        pos_z = self.v_map_min_y + length_y / 2
      end
      _create_bound_effect(self, BOUND_EFFECT .. i, pos_x, pos_z, BOUND_EFFECT_EULERY[i], len)
    end
  end
  
  function M:_create_segment_bound_effect(name)
    local container = self.v_map:get_scene_container()
    if nil == container then
      Log.Error("场景缺少SceneContainer脚本")
      return
    end
    local list = container:GetLineListByName(name)
    if nil == list then
      Log.Error("缺少场景边界数据")
      return
    end
    for i = 0, list.Count - 1 do
      local line = list[i]
      local start_tf = line.Start
      local end_tf = line.End
      if nil == start_tf or nil == end_tf then
        Log.Error("边界线段端点缺失")
      else
        local start_pos_x, _, start_pos_z = start_tf:GetPositionA()
        local end_pos_x, _, end_pos_z = end_tf:GetPositionA()
        local len = MathX.distance2(start_pos_x, start_pos_z, end_pos_x, end_pos_z)
        local pos_x = (start_pos_x + end_pos_x) * 0.5
        local pos_z = (start_pos_z + end_pos_z) * 0.5
        local dir_x, dir_z = start_pos_x - end_pos_x, start_pos_z - end_pos_z
        dir_x, dir_z = Util.normalize2(dir_x, dir_z)
        local angle = _atan(dir_x, dir_z) * _rad2deg % 360
        _create_bound_effect(self, BOUND_EFFECT .. i, pos_x, pos_z, angle, len)
      end
    end
  end
end

function M:release()
  self.v_is_released = true
  if self.v_root_draw then
    UnityDestroy(self.v_root_draw)
  end
  if #self.v_debug_objs > 0 then
    for _, v in pairs(self.v_debug_objs) do
      UnityDestroy(v)
    end
  end
  if self.v_gg then
    local astar = CS.AstarPath.active
    local data = astar.data
    data:RemoveGraph(self.v_gg)
    self.v_gg = nil
  end
  if self.v_scene_prefab then
    if not self.v_is_plat then
      ResPoolMgr:release(self.v_scene_prefab)
    end
    self.v_scene_prefab = nil
  end
  self:_clear_links()
  self:_destroy_border_collider()
  self.v_map = nil
end

function M:late_update()
  if self.v_scan_dirty then
    self.v_scan_delay_cnt = self.v_scan_delay_cnt - 1
    if self.v_scan_delay_cnt <= 0 then
      self:scan_grid_graph()
      self.v_scan_dirty = false
    end
  end
  self:_refresh_link_flag()
end

function M:has_active_obstacle_collider(cid)
  return self.v_area_collider_map[cid]
end

function M:has_wall_collider(cid)
  return self.v_border_collider_map[cid] ~= nil
end

function M:scan_grid_graph()
  local astar = CS.AstarPath.active
  astar:Scan(self.v_gg)
end

function M:has_platforms()
  return self.v_has_platforms
end

function M:is_plat()
  return self.v_is_plat
end

function M:set_plat(plat)
  self.v_plat = plat
end

function M:set_grid_graph_info(gg, offset_vec)
  self.v_gg = gg
  self.v_gg_offset = offset_vec
end

function M:get_gg_offset()
  return self.v_gg_offset
end

function M:get_gg()
  return self.v_gg
end

function M:transform_pos_for_gg(world_pos_x, world_pos_z)
  if not self.v_is_plat then
    return world_pos_x, world_pos_z
  end
  local platx, platz = self.v_plat:get_pos2()
  local localx, localz = world_pos_x - platx, world_pos_z - platz
  return self.v_gg_offset.x + localx, self.v_gg_offset.z + localz
end

function M:get_plat_scene_prefab(plat_name)
  return self.v_scene_prefab:FindChild(plat_name)
end

function M:set_plat_info(plat_name, plat_gameobj_name)
  self.v_plat_name = plat_name
  self.v_plat_gameobj_name = plat_gameobj_name
end

function M:attach_all_scene_prefab(parent)
  for _, v in pairs(self.v_area_map) do
    self:_set_scene_prefab_parent(v, parent)
  end
  for _, v in pairs(self.v_position_map) do
    local obj = self:_get_scene_obj(v.Key)
    obj.transform:AttachTo(parent.transform, true)
  end
end

function M:get_plat_name()
  return self.v_plat_name
end

function M:get_plat_gameobj_name()
  return self.v_plat_gameobj_name
end

function M:get_cell_size()
  return self.v_cell_width, self.v_cell_height
end

function M:transform_center_to_leftdown(x, z)
  return x - self.v_map_half_width, z - self.v_map_half_height
end

function M:transform_leftdown_to_center(x, z)
  return x + self.v_map_half_width, z + self.v_map_half_height
end

function M:get_size()
  return self.v_map_width, self.v_map_height
end

function M:get_pos2()
  return self.v_map_min_x, self.v_map_z, self.v_map_min_y
end

function M:set_pos(x, z)
  self.v_map_min_x = x
  self.v_map_min_y = z
  self.v_map_max_x = self.v_map_min_x + self.v_map_width
  self.v_map_max_y = self.v_map_min_y + self.v_map_height
  for _, v in pairs(self.v_position_map) do
    v.X = v.Trans.position.x
    v.Y = v.Trans.position.y
    v.Z = v.Trans.position.z
  end
end

function M:get_meter_per_cell()
  return self.v_meter_per_cell
end

function M:check_in_collision(x, y, z, radius)
  local collide = false
  local missile_uuid, collider_info, collide_border_type
  if not self.v_is_plat then
    if x > self.v_map_max_x - radius then
      collide_border_type = FightConfig.BOUNDARY_COLLISION_TYPE.RIGHT_X
    elseif x < self.v_map_min_x + radius then
      collide_border_type = FightConfig.BOUNDARY_COLLISION_TYPE.LEFT_X
    end
    if z > self.v_map_max_y - radius then
      collide_border_type = FightConfig.BOUNDARY_COLLISION_TYPE.TOP_Z
    elseif z < self.v_map_min_y + radius then
      collide_border_type = FightConfig.BOUNDARY_COLLISION_TYPE.BOTTOM_Z
    end
    if collide_border_type then
      collide = true
      return collide, nil, nil, collide_border_type
    end
  end
  local collide_len = Util.overlap_sphere(x, y, z, radius, true)
  if 0 ~= collide_len then
    collide = true
    for i = 0, collide_len - 1 do
      local cid = CompExtensions.GetOverlapSphereColliderID(i)
      local obj = SceneMgr:pick_by_cid(cid)
      local cur_missile_uuid
      if obj and obj:is_missile() then
        cur_missile_uuid = obj.id
        missile_uuid = cur_missile_uuid
      end
      if self.v_empty_wall_cid_map[cid] ~= nil then
        collider_info = self.v_empty_wall_cid_map[cid]
        return collide, cur_missile_uuid, collider_info
      end
    end
    return collide, missile_uuid
  end
  return collide
end

function M:actvie_obstacle(key, tag, is_active)
  if Util.is_client_only() then
    return
  end
  local is_change = false
  for _, v in pairs(self.v_area_map) do
    local tag_map = v.TagMap
    if key and tag_map[key] or tag and tag_map[tag] then
      local pre = v.is_obstacle
      if pre ~= is_active then
        v.is_obstacle = is_active
        if is_active then
          self:_create_area_collider(v)
        else
          self:_destroy_area_collider(v)
        end
        is_change = true
      end
    end
  end
  if is_change then
    self.v_scan_delay_cnt = 2
    self.v_scan_dirty = true
  end
end

function M:remove_area(key, tag)
  for k, v in pairs(self.v_area_map) do
    local tag_map = v.TagMap
    if key and tag_map[key] or tag and tag_map[tag] then
      self.v_area_map[k] = nil
    end
  end
end

function M:set_empty_wall_visible(tag, is_visible)
  if not self.v_empty_wall_cid_map then
    return
  end
  for _, v in pairs(self.v_empty_wall_cid_map) do
    if tag == v.Tag then
      if is_visible then
        local layer = Layer.Layer.WalkBlock
        self:_enable_area_collider(v.area_obj, layer)
      else
        self:_disable_area_collider(v.area_obj)
      end
    end
  end
end

function M:set_empty_wall_group_visible(group, is_visible)
  group = tonumber(group)
  if not group then
    return
  end
  if not self.v_empty_wall_cid_group or not self.v_empty_wall_cid_group[group] then
    return
  end
  for key, empty_wall in pairs(self.v_empty_wall_cid_group[group]) do
    if is_visible then
      local layer = Layer.Layer.WalkBlock
      self:_enable_area_collider(empty_wall.area_obj, layer)
    else
      self:_disable_area_collider(empty_wall.area_obj)
    end
  end
end

function M:get_area_position(key)
  return self.v_position_map[key]
end

function M:test_set_all_area_obstacle()
  for _, v in pairs(self.v_area_map) do
    self:actvie_obstacle(v.Key, nil, true)
  end
end

function M:draw_areas()
end

function M:create_bound_effect()
  local size_info = self.v_size_config
  local is_show_line = size_info.IsShowLine
  if false == is_show_line then
    return
  end
  local line_config_name = size_info.LineConfig
  if nil == line_config_name or "" == line_config_name or type(line_config_name) == "table" then
    self:_create_rect_bound_effect()
  else
    self:_create_segment_bound_effect(line_config_name)
  end
end

function M:show_scene_position()
  if #self.v_debug_objs > 0 then
    for _, v in pairs(self.v_debug_objs) do
      UnityDestroy(v)
    end
    return
  end
  for _, v in pairs(self.v_position_map) do
    local pos = self:get_area_position(v.Key)
    self.v_scene_logic:create_gameobj("Fx_Transmit", v.Key, pos.X, pos.Y, pos.Z, nil, function(gameObj)
      gameObj.transform:SetLocalScaleA(0.05, 1, 0.05)
      local canvas_tra = gameObj.transform:FindChild("Canvas")
      canvas_tra:SetActive(true)
      local text = gameObj.transform:FindChild("Canvas/Text"):GetComponent(TypeText)
      text.text = v.Key
      table.insert(self.v_debug_objs, gameObj)
    end)
  end
end

do
  local _tmp_vec_start = Vec3.New(0, 0, 0)
  local _tmp_vec_end = Vec3.New(0, 0, 0)
  local _huge = math.huge
  local _tmp_vec_point = Vec3.New(0, 0, 0)
  
  function M:get_min_dis_to_wall(role_x, role_z)
    local min = _huge
    for _, edge in ipairs(self.v_edges) do
      local start_point = edge[1]
      local end_point = edge[2]
      local sp_x, sp_z = role_x - start_point.x, role_z - start_point.z
      local se_x, se_z = end_point.x - start_point.x, end_point.z - start_point.z
      _tmp_vec_start:Set(sp_x, 0, sp_z)
      _tmp_vec_end:Set(se_x, 0, se_z)
      Vec3.ProjectEx(_tmp_vec_start, _tmp_vec_end, _tmp_vec_point)
      _tmp_vec_start:Sub(_tmp_vec_point)
      local dis = _tmp_vec_start:Magnitude()
      if min > dis then
        min = dis
      end
    end
    return min
  end
  
  local function _check_box_contains_point(colliderObj, box_center, box_half_size, position)
    if not colliderObj then
      return
    end
    local x, y, z = colliderObj.transform:GetInverseTransformPointA(position.x, position.y, position.z)
    if math.abs(y - box_center.y) > box_half_size.y then
      return
    end
    if math.abs(x - box_center.x) > box_half_size.x then
      return
    end
    if math.abs(z - box_center.z) > box_half_size.z then
      return
    end
    return 1
  end
  
  function M:check_area_mask(cur_mask, area_dic, position)
    if self.v_is_released then
      return cur_mask, false
    end
    local is_dirty = false
    local enter_area_list, out_area_list
    for _, area in pairs(self.v_area_map) do
      local index = area_dic[area.Key]
      local index_mask = 1 << index
      local is_in_area = cur_mask & index_mask == index_mask
      local cell_num = _check_box_contains_point(area.area_tra, area.box_center, area.box_half_size, position)
      local is_out = not cell_num and is_in_area
      local is_enter = cell_num and not is_in_area
      if is_enter or is_out then
        is_dirty = true
        cur_mask = cur_mask ~ index_mask
      end
      if is_enter then
        enter_area_list = enter_area_list or {}
        enter_area_list[area] = 1
      end
      if is_out then
        out_area_list = out_area_list or {}
        out_area_list[area] = 1
      end
    end
    return cur_mask, is_dirty, enter_area_list, out_area_list
  end
  
  function M:trigger_area_event_on_path(baseobj, cur_mask, area_dic, start_pos, end_pos)
    if not self.v_temp_area_map then
      self.v_temp_area_map = {}
    end
    UtilTable.clear_map(self.v_temp_area_map)
    for key, area in pairs(self.v_area_map) do
      self.v_temp_area_map[key] = area
    end
    for key, area in pairs(self.v_temp_area_map) do
      local collider = area.box_collider
      collider.enabled = true
      local start_x, start_y, start_z = start_pos:Get()
      local end_x, end_y, end_z = end_pos:Get()
      local hit_flag = CSHelper.ColliderLineCast(collider, start_x, start_y, start_z, end_x, end_y, end_z)
      local index = area_dic[area.Key]
      local index_mask = 1 << index
      local is_enter = 1 == hit_flag >> 1 & 1
      if is_enter then
        cur_mask = cur_mask ~ index_mask
        baseobj:trigger_enter_area_event(area)
        baseobj:set_area_mask(cur_mask)
      end
      local is_leave = 1 == hit_flag & 1
      if is_leave then
        cur_mask = cur_mask ~ index_mask
        if self.v_area_map[key] then
          baseobj:trigger_leave_area_event(area)
        end
        baseobj:set_area_mask(cur_mask)
      end
      collider.enabled = false
    end
  end
  
  function M:is_in_tp_area(cur_mask, area_dic, position)
    if self.v_is_released then
      return false, true
    end
    for _, area in pairs(self.v_tp_map) do
      local index = area_dic[area.Key]
      local index_mask = 1 << index
      local is_in_area = cur_mask & index_mask == index_mask
      local cell_num = _check_box_contains_point(area.area_tra, area.box_center, area.box_check_size, position)
      if not (not cell_num or is_in_area) or not cell_num and is_in_area then
        return true, false
      end
    end
  end
  
  function M:add_temp_link(link)
    if self.v_temp_link_dic[link] == nil then
      self.v_temp_link_dic[link] = true
      local plat_mgr = SceneMgr:get_plat_mgr()
      if plat_mgr then
        plat_mgr:on_add_link_to_plat(link, self)
      end
      self.v_link_flag_dirty = true
    end
  end
  
  function M:remove_temp_link(link)
    if self.v_temp_link_dic[link] then
      self.v_temp_link_dic[link] = nil
      local plat_mgr = SceneMgr:get_plat_mgr()
      if plat_mgr then
        plat_mgr:on_remove_link_from_plat(link, self)
      end
      self.v_link_flag_dirty = true
    end
  end
  
  function M:set_link_flag(flag)
    self.v_link_flag_dirty = false
    self.v_region_link_flag = flag
  end
  
  function M:get_link_flag()
    return self.v_region_link_flag
  end
  
  function M:get_temp_link_dic()
    return self.v_temp_link_dic
  end
  
  function M:create_border_collider()
    self:_do_create_border_collider()
  end
  
  function M:get_edges()
    return self.v_edges
  end
end
return M
