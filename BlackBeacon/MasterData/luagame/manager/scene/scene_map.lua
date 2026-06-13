local Region = require("manager.scene.scene_region")
local SceneObstacle = require("manager.scene.scene_obstacle")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local MathX = require("base.mathx")
local Navigator = require("manager.role_mgr.role_move_navigator")
local CompExtensions = _ENV.CompExtensions
local SyncTransforms = UnityEngine.Physics.SyncTransforms
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local CSHelper = _ENV.CSHelper
local UnityFind = _ENV.UnityFind
local TypeUnityCollider = typeof(UnityEngine.Collider)
local CSResLoader = CS.ResLoader
local AstarHelper = CS.Game.AstarHelper
local TypeAstarPath = typeof(CS.AstarPath)
local AstarSerializer = CS.Pathfinding.Serialization.AstarSerializer
local Layer = require("utils.layer")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local OBSTACLE_MASK = Layer.obstacle_mask
local _huge = math.huge
local SCENE_ROOT = "Root"
local GROUP_CTRL_OBJ = "GroupCtrlObj"
local PLAT_OFFSET_X = 1000
local PLAT_OFFSET_Z = 1000
local PLAT_GAP = 100
local M = Util.create_class()
local FindPathCbItem = Util.create_class()

function FindPathCbItem:_init(cb, cb_self, param1, param2)
  self.cb = cb
  self.cb_self = cb_self
  self.param1 = param1
  self.param2 = param2
end

function FindPathCbItem:on_destroy()
  self.cb = nil
  self.cb_self = nil
  self.param1 = nil
  self.param2 = nil
end

function M:_init(map_path, map_name, logic)
  self.v_logic = logic
  self.v_map_name = map_name
  self.v_map_path = map_path
  self.v_base_region = nil
  self.v_plat_regions = {}
  self.v_area_dic = {}
  self.v_area_name_list = {}
  self.v_collider_cid_map = {}
  self.v_obstacle_map = {}
  self.v_plat_offset_idx = -1
  self.v_path_cb_dic = {}
  self.v_path_cb_pool = LuaObjPoolMgr.get_pool("find_path_cb_pool") or LuaObjPoolMgr.register("find_path_cb_pool", 30, FindPathCbItem)
end

function M:_init_scene_container()
  local root = UnityFind(SCENE_ROOT)
  if root then
    self.v_scene_root_obj = root
    local container = root:GetComponent(TypeSceneContainer)
    self.v_root_scene_container = container
  end
  local group_ctrl = UnityFind(GROUP_CTRL_OBJ)
  if group_ctrl then
    self.v_group_ctrl_obj = group_ctrl
    local container = group_ctrl:GetComponent(TypeSceneContainer)
    self.v_group_ctrl_scene_container = container
  end
end

function M:_create_point_graph()
  local astar = CS.AstarPath.active
  local graph = AstarHelper.CreatePointGraph()
  astar:Scan(graph)
  self.v_point_graph = graph
  self.v_pg_point_map = {}
  AstarHelper.AddWorkItem3(function()
    local cnt, offset = 1, 10
    local tmpVec = Vec3.New(0, 0, 0)
    local cs_node_start, cs_node_end, start_point, end_point
    for _, region in pairs(self.v_plat_regions) do
      for _, link in ipairs(region.origin_link_list) do
        tmpVec.y = cnt * offset
        cs_node_start = AstarHelper.AddPointNode(graph, tmpVec)
        start_point = link:get_start_point()
        start_point:set_pg_point(cs_node_start, tmpVec.y)
        cnt = cnt + 1
        self.v_pg_point_map[tmpVec.y] = start_point
        tmpVec.y = cnt * offset
        cs_node_end = AstarHelper.AddPointNode(graph, tmpVec)
        end_point = link:get_end_point()
        end_point:set_pg_point(cs_node_end, tmpVec.y)
        cnt = cnt + 1
        self.v_pg_point_map[tmpVec.y] = end_point
        local dis = start_point:get_tf_dis_to_another(end_point)
        cs_node_start:AddConnection(cs_node_end, dis)
        cs_node_end:AddConnection(cs_node_start, dis)
      end
    end
  end)
  astar:FlushWorkItems()
  local plat_mgr = SceneMgr:get_plat_mgr()
  plat_mgr:init_plat_link_connections()
end

function M:_get_next_plat_offset()
  self.v_plat_offset_idx = self.v_plat_offset_idx + 1
  return self.v_plat_offset_idx
end

do
  local TypeFunnelModifier = typeof(CS.Pathfinding.FunnelModifier)
  local TypeRadiusModifier = typeof(CS.Pathfinding.RadiusModifier)
  local TypeSimpleModifier = typeof(CS.Pathfinding.SimpleSmoothModifier)
  
  function M:_create_finder()
    if M.s_has_init_cs_finder then
      return
    end
    local full_res_path = CSResLoader.GetFullPath("FindPath")
    local go = ResMgr:load_gameobj(full_res_path, nil, true)
    go:GetComponent(TypeAstarPath)
    M.s_has_init_cs_finder = true
    CS.Pathfinding.BodyRadiusTraversalProvider.SetMaxSize(30)
    M.v_path_modifier = go:AddComponent(TypeSimpleModifier)
    M.v_finder_go = go
  end
  
  function M:_load_tagged_collider(container)
    if not container then
      return
    end
    local missile_block_objs = container and container.MissileBlockObjs
    if missile_block_objs then
      for i = 0, missile_block_objs.Length - 1 do
        local gameobj = missile_block_objs[i]
        if gameobj and not gameobj:IsNull() then
          self.v_collider_cid_map[gameobj:GetInstanceID()] = gameobj
        end
      end
    end
  end
  
  function M:_build_area_dic()
    table.sort(self.v_area_name_list)
    local len = #self.v_area_name_list
    if len > 64 then
      Log.Error("场景区域太多")
    end
    for i = 1, len do
      local key_name = self.v_area_name_list[i]
      self.v_area_dic[key_name] = i - 1
    end
  end
  
  function M:_create_region(region_path, plat_obj, logic, is_plat)
    local path = region_path .. ".size"
    local size_config = ShareRes.create(path)
    path = region_path .. ".area"
    local area_config = ShareRes.create(path)
    path = region_path .. ".position"
    local pos_config = ShareRes.create(path)
    local region = Region:new(size_config, area_config, pos_config, plat_obj, logic, is_plat, self.v_area_name_list, self)
    return region, size_config
  end
  
  function M:_create_base_region(logic)
    local region, size_config = self:_create_region(self.v_map_path, nil, logic, false)
    self.v_base_region = region
    self.v_is_layer_grid = size_config.IsLayerGraph
    if size_config.PathFindCfg and size_config.PathFindCfg ~= "" then
      local scene_name = SceneMgr:get_scene_cfg().MapName
      local file_name = string.format("world/%s/ScenePrefab/%s.bytes", scene_name, size_config.PathFindCfg)
      local is_layer_gg = size_config.IsLayerGraph
      ResMgr:load_text_asset(file_name, function(bytes)
        local astar = CS.AstarPath.active
        astar.data:DeserializeGraphs(bytes)
        local gg = is_layer_gg and astar.data.layerGridGraph or astar.data.gridGraph
        region:set_grid_graph_info(gg, gg.center)
        self.v_base_height = gg.center.y
        local text_path = string.format("assets/product/%s", file_name)
        ResMgr:unload_res(text_path)
      end)
    else
      local w, h = region:get_cell_size()
      local x, y, z = region:get_pos2()
      local meter_per_cell = region:get_meter_per_cell()
      local center_x = x + w * 0.5 * meter_per_cell
      local center_z = z + h * 0.5 * meter_per_cell
      self.v_base_height = y + 0.5
      local max_climb = 0
      local max_slope = 60
      local check_collision = true
      local collision_type = 0
      local collision_diameter = 0.5
      local check_height = true
      local ray_length = 10
      local height_mask = 256
      local is_thick_raycast = true
      local thick_raycast_diameter = 5
      local is_unwalk_no_ground = true
      local astar = CS.AstarPath.active
      local gg = astar.data.gridGraph
      local center = Vec3.New(center_x, self.v_base_height, center_z)
      gg = gg or AstarHelper.CreateGridGraph(w, h, meter_per_cell, center, meter_per_cell, OBSTACLE_MASK)
      gg.center = center
      gg:SetDimensions(w, h, meter_per_cell)
      gg.maxClimb = max_climb
      gg.maxSlope = max_slope
      gg.erodeIterations = 1
      AstarHelper.SetGridGraphCollisionType(gg, collision_type)
      AstarHelper.SetGridGraphHeightMask(gg, height_mask)
      local collision = gg.collision
      collision.collisionCheck = check_collision
      collision.diameter = collision_diameter
      collision.heightCheck = check_height
      collision.fromHeight = ray_length
      collision.thickRaycast = is_thick_raycast
      collision.thickRaycastDiameter = thick_raycast_diameter
      collision.unwalkableWhenNoGround = is_unwalk_no_ground
      local offset_vec = Vec3.New(x, 0, z)
      region:set_grid_graph_info(gg, offset_vec)
    end
  end
  
  function M:scan_regions()
    local plat_mgr = SceneMgr:get_plat_mgr()
    plat_mgr:set_terrain_enable(false)
    SyncTransforms()
    self.v_base_region:scan_grid_graph()
    plat_mgr:set_terrain_enable(true)
    for _, region in pairs(self.v_plat_regions) do
      region:scan_grid_graph()
    end
  end
  
  function M:_create_platforms(logic)
    local has_platforms = self.v_base_region:has_platforms()
    if not has_platforms then
      return
    end
    local path = self.v_map_path .. ".platform"
    local plat_config = ShareRes.create(path)
    local plat_folder = self.v_map_path .. ".Platform."
    local plat_mgr = SceneMgr:get_plat_mgr()
    for plat_name, plat_gameobj_name in pairs(plat_config) do
      path = plat_folder .. plat_name
      local area_prefab = self.v_base_region:get_plat_scene_prefab(plat_name)
      if not area_prefab then
        Log.Error("平台预制获取失败，平台名：", plat_name, "  路径：", path)
      end
      local region = self:_create_region(path, area_prefab, logic, true)
      region:set_plat_info(plat_name, plat_gameobj_name)
      local plat = plat_mgr:create_platform(region)
      self.v_plat_regions[plat_name] = region
      region:set_plat(plat)
      local idx = self:_get_next_plat_offset()
      local offset_x = PLAT_OFFSET_X * idx + PLAT_GAP
      local offset_z = PLAT_OFFSET_Z
      local w, h = region:get_cell_size()
      local meter_per_cell = region:get_meter_per_cell()
      local center_x = offset_x + w * 0.5 * meter_per_cell
      local center_z = offset_z + h * 0.5 * meter_per_cell
      local center = Vec3.New(center_x, self.v_base_height, center_z)
      local gg = AstarHelper.CreateGridGraph(w, h, meter_per_cell, center, meter_per_cell, OBSTACLE_MASK)
      gg.name = region:get_plat_name()
      local offset_vec = Vec3.New(offset_x, 0, offset_z)
      region:set_grid_graph_info(gg, offset_vec)
      region:scan_grid_graph()
    end
  end
  
  function M:_get_region_at_pos(x, z)
    local plat_mgr = SceneMgr:get_plat_mgr()
    local cid, region = plat_mgr:get_region_at_pos(x, z)
    return region or self.v_base_region, cid
  end
end

function M:on_enter()
  self:_init_scene_container()
  self:_create_finder()
  self:_create_base_region(self.v_logic)
  self:_create_platforms(self.v_logic)
  self:_build_area_dic()
  self:_load_tagged_collider(self.v_root_scene_container)
  self:_load_tagged_collider(self.v_group_ctrl_scene_container)
  self:_create_point_graph()
end

function M:on_after_role_set_pos()
  self:create_bound_effect()
end

function M:late_update()
  self.v_base_region:late_update()
  for _, region in pairs(self.v_plat_regions) do
    region:late_update()
  end
  for obstacle in pairs(self.v_obstacle_map) do
    obstacle:late_update()
  end
end

function M:release()
  if self.v_point_graph then
    local astar = CS.AstarPath.active
    local data = astar.data
    data:RemoveGraph(self.v_point_graph)
    self.v_point_graph = nil
  end
  for _, region in pairs(self.v_plat_regions) do
    region:release()
  end
  if self.v_base_region then
    self.v_base_region:release()
  end
  self.v_base_region = nil
  for obstacle in pairs(self.v_obstacle_map) do
    obstacle:release()
  end
  self.v_plat_regions = {}
  self.v_obstacle_map = {}
  for _, cb_item in pairs(self.v_path_cb_dic) do
    self.v_path_cb_pool:destroy_obj(cb_item)
  end
  self.v_path_cb_dic = {}
  self.v_scene_root_obj = nil
  self.v_root_scene_container = nil
  Navigator.clear_cache()
  self:destroy_finder()
end

function M:get_meter_per_cell()
  return self.v_base_region:get_meter_per_cell()
end

function M:has_platforms()
  return self.v_base_region:has_platforms()
end

function M:get_base_region()
  return self.v_base_region
end

function M:check_in_collision(x, y, z, radius, check_height)
  local plat_mgr = SceneMgr:get_plat_mgr()
  local cid, region = plat_mgr:get_region_at_pos(x, z, y, check_height)
  if -1 == cid then
    return true, false
  end
  if region then
    return region:check_in_collision(x, y, z, radius)
  end
  return self.v_base_region:check_in_collision(x, y, z, radius)
end

function M:get_region_at_pos(x, z, y)
  local plat_mgr = SceneMgr:get_plat_mgr()
  local cid, region = plat_mgr:get_region_at_pos(x, z, y)
  if -1 == cid then
    return
  end
  return region or self.v_base_region
end

function M:is_in_move_plat(x, z)
  local region = self:get_region_at_pos(x, z)
  return nil ~= region and region:is_plat()
end

do
  local _insert = table.insert
  
  function M:get_drop_areas(x, y, z)
    local result_point = {}
    local xoffset = 2
    local yoffset = 2
    for i = x - xoffset, x + xoffset, xoffset do
      for j = z - yoffset, z + yoffset, yoffset do
        if not self:check_in_collision(i, 0, j, 1) then
          local ret, height = Util.raycast(i, j, Layer.LayerMask.Terrain, y + 1)
          if ret and height > y - 1 then
            _insert(result_point, {x = i, y = j})
          end
        end
      end
    end
    return result_point
  end
  
  function M:remove_area(key, tag)
    for _, plat_region in pairs(self.v_plat_regions) do
      plat_region:remove_area(key, tag)
    end
    self.v_base_region:remove_area(key, tag)
  end
  
  function M:actvie_obstacle(key, tag, is_active)
    for _, plat_region in pairs(self.v_plat_regions) do
      plat_region:actvie_obstacle(key, tag, is_active)
    end
    self.v_base_region:actvie_obstacle(key, tag, is_active)
  end
  
  function M:create_bound_effect()
    self.v_base_region:create_bound_effect()
  end
  
  function M:get_intersect_collider_point(role_x, role_y, role_z, limit, dir_vec, check_layer)
    local is_hit, hit_x, hit_y, hit_z = CSHelper.RayCast2(role_x, role_y, role_z, dir_vec.x, dir_vec.y, dir_vec.z, limit or 10, check_layer or OBSTACLE_MASK)
    if is_hit then
      return true, hit_x, hit_z, hit_y
    end
  end
  
  function M:get_min_dis_to_wall(role_x, role_z)
    return self.v_base_region:get_min_dis_to_wall(role_x, role_z)
  end
  
  function M:get_min_dis_to_collider(role_x, role_y, role_z, limit)
    assert(limit <= 50, "范围太大")
    local len = Util.overlap_sphere(role_x, role_y, role_z, limit, true)
    if len > 0 then
      local collider
      local rlt = _huge
      for i = 0, len - 1 do
        collider = CompExtensions.GetOverlapSphereCollider(i)
        local x, _, z = collider:ClosestPointA(role_x, role_y, role_z)
        local dis = MathX.distance2(x, z, role_x, role_z)
        if rlt > dis then
          rlt = dis
        end
      end
      return rlt
    else
      return _huge
    end
  end
  
  function M:get_area_position(key)
    local ret = self.v_base_region:get_area_position(key)
    if ret then
      return ret
    end
    for _, plat_region in pairs(self.v_plat_regions) do
      ret = plat_region:get_area_position(key)
      if ret then
        return ret
      end
    end
  end
  
  function M:actvie_collider(obj_name, is_active, block_char, block_missile)
    local gameobject = UnityFind(obj_name)
    if not gameobject then
      Log.Error("想激活的碰撞体不存在", obj_name)
      return
    end
    self.v_collider_cid_map[gameobject:GetInstanceID()] = gameobject
    if not block_char and not block_missile then
      is_active = false
    end
    local collider = gameobject:GetComponent(TypeUnityCollider)
    if not collider then
      Log.Error("想激活的碰撞体不带Collider组件", obj_name)
      return
    end
    collider.enabled = is_active
    gameobject.layer = Layer.Layer.SceneBlock
    collider.isTrigger = not block_char
    if is_active and block_char then
      SceneObstacle.add(collider, true)
    end
  end
  
  function M:check_missile_collider(missile, cid)
    if not missile then
      return false
    end
    local gameobj = self.v_collider_cid_map[cid]
    if gameobj then
      return true
    end
    return false
  end
  
  function M:check_missile_collide_unwalkable(missile, cid)
    if self.v_base_region:has_active_obstacle_collider(cid) then
      return true, false, false
    end
    if self.v_base_region:has_wall_collider(cid) then
      return true, false, true
    end
    return self:check_missile_collider(missile, cid), true, false
  end
  
  function M:draw_areas()
    self.v_base_region:draw_areas()
  end
  
  function M:show_scene_position()
    self.v_base_region:show_scene_position()
  end
  
  function M:check_area_mask(cur_mask, position)
    local is_dirty = false
    local dirty
    local enter_list = {}
    local out_list = {}
    for _, region in pairs(self.v_plat_regions) do
      local plat_enter_list, plat_out_list
      cur_mask, dirty, plat_enter_list, plat_out_list = region:check_area_mask(cur_mask, self.v_area_dic, position)
      if dirty then
        is_dirty = true
      end
      if plat_enter_list then
        for area, v in pairs(plat_enter_list) do
          enter_list[area] = v
        end
      end
      if plat_out_list then
        for area, v in pairs(plat_out_list) do
          out_list[area] = v
        end
      end
    end
    local area_enter_list, area_out_list
    cur_mask, dirty, area_enter_list, area_out_list = self.v_base_region:check_area_mask(cur_mask, self.v_area_dic, position)
    if dirty then
      is_dirty = true
    end
    if area_enter_list then
      for area, v in pairs(area_enter_list) do
        enter_list[area] = v
      end
    end
    if area_out_list then
      for area, v in pairs(area_out_list) do
        out_list[area] = v
      end
    end
    return cur_mask, is_dirty, enter_list, out_list
  end
  
  function M:trigger_area_event_on_path(baseobj, mask, start_pos, end_pos)
    for _, region in pairs(self.v_plat_regions) do
      region:trigger_area_event_on_path(baseobj, mask, self.v_area_dic, start_pos, end_pos)
    end
    self.v_base_region:trigger_area_event_on_path(baseobj, mask, self.v_area_dic, start_pos, end_pos)
  end
  
  function M:is_in_tp_area(cur_mask, position)
    for _, region in pairs(self.v_plat_regions) do
      local temp_is_in, is_released = region:is_in_tp_area(cur_mask, self.v_area_dic, position)
      if temp_is_in then
        return true, is_released
      end
    end
    return self.v_base_region:is_in_tp_area(cur_mask, self.v_area_dic, position)
  end
  
  function M:get_edge_center_point(dir)
    local meter_per_cell = self.v_base_region:get_meter_per_cell()
    local unit_per_cell = meter_per_cell / 32
    local cell_width, cell_height = self.v_base_region:get_cell_size()
    local offset_x, offset_y, offset_z = self.v_base_region:get_pos2()
    local sizeX = cell_width * meter_per_cell
    local sizeY = cell_height * meter_per_cell
    local factor_x = 1 == dir % 2 and 0.5 or math.abs(dir - 2) * 0.5
    local factor_y = 0 == dir % 2 and 0.5 or math.abs(dir - 3) * 0.5
    local X = math.floor(factor_x * sizeX * 32 / meter_per_cell) * unit_per_cell + offset_x
    local Z = math.floor(factor_y * sizeY * 32 / meter_per_cell) * unit_per_cell + offset_z
    return {
      x = X,
      y = offset_y,
      z = Z
    }
  end
  
  function M:regist_obstacle(obstacle)
    self.v_obstacle_map[obstacle] = true
  end
  
  function M:unregist_obstacle(obstacle)
    self.v_obstacle_map[obstacle] = nil
  end
  
  local function _on_path_complete(path)
    if not SceneMgr then
      return
    end
    local scene_map = SceneMgr:get_scene_map()
    if not scene_map then
      return
    end
    local dic = scene_map.v_path_cb_dic
    local cb_item = dic[path.pathID]
    if cb_item and cb_item.cb then
      dic[path.pathID] = nil
      cb_item.cb(cb_item.cb_self, path, cb_item.param1, cb_item.param2)
      scene_map.v_path_cb_pool:destroy_obj(cb_item)
    end
  end
  
  function M:get_pg_point_by_y(y)
    y = math.floor(y)
    return self.v_pg_point_map[y]
  end
  
  local _tmp_vec1 = Vec3.New(0, 0, 0)
  local _tmp_vec2 = Vec3.New(0, 0, 0)
  
  function M:find_point_graph_path(start_point, end_point, cb, cb_self, param1)
    _tmp_vec1.x, _tmp_vec1.y, _tmp_vec1.z = 0, start_point:get_y(), 0
    _tmp_vec2.x, _tmp_vec2.y, _tmp_vec2.z = 0, end_point:get_y(), 0
    local path_id = AstarHelper.FindPointGraphPath(_tmp_vec1, _tmp_vec2, self.v_point_graph, _on_path_complete)
    local cb_item = self.v_path_cb_pool:new_obj(cb, cb_self, param1)
    self.v_path_cb_dic[path_id] = cb_item
  end
  
  function M:test_point_graph(start_y, end_y)
    _tmp_vec1.x, _tmp_vec1.y, _tmp_vec1.z = 0, start_y, 0
    _tmp_vec2.x, _tmp_vec2.y, _tmp_vec2.z = 0, end_y, 0
    AstarHelper.FindPointGraphPath(_tmp_vec1, _tmp_vec2, self.v_point_graph, function(path)
      Log.Error("path is error : ", path.error)
      local list = path.vectorPath
      local len = list.Count - 1
      for i = 0, len do
        local _, _, y, _ = AstarHelper.GetPathPoint(path, i)
        Log.Error("point : ", y)
      end
    end)
  end
  
  function M:find_grid_graph_path(start_x, start_y, start_z, end_x, end_y, end_z, graph, body_size, cb, cb_self, param1, param2)
    _tmp_vec1.x, _tmp_vec1.y, _tmp_vec1.z = start_x, start_y, start_z
    _tmp_vec2.x, _tmp_vec2.y, _tmp_vec2.z = end_x, end_y, end_z
    local path_id = AstarHelper.FindBodySizeGridGraphPath(_tmp_vec1, _tmp_vec2, graph, body_size, false, _on_path_complete)
    local cb_item = self.v_path_cb_pool:new_obj(cb, cb_self, param1, param2)
    self.v_path_cb_dic[path_id] = cb_item
  end
  
  function M:modifier_path(path, radius)
    M.v_path_modifier:Apply(path)
  end
  
  function M:get_scene_container()
    return self.v_root_scene_container
  end
  
  function M:_get_hit_pos(src_pos, body_size, dir_magnitude, dir, check_layer)
    local is_hit, x, z, y = self:get_intersect_collider_point(src_pos.x, src_pos.y, src_pos.z, dir_magnitude, dir, check_layer)
    local hit_pos
    if is_hit then
      hit_pos = Vec3.New(x, y, z)
      dir = hit_pos - src_pos
      dir_magnitude = dir:Magnitude()
      hit_pos = src_pos + dir * (dir_magnitude - body_size) / dir_magnitude
    end
    return hit_pos
  end
  
  function M:_half_serach_walkable_pos(src_pos, tar_pos, body_size)
    local region = self:get_region_at_pos(tar_pos.x, tar_pos.z)
    if region then
      return tar_pos
    end
    local dir = tar_pos - src_pos
    local dir_magnitude = dir:Magnitude()
    if dir_magnitude < 0.1 then
      return src_pos + dir * (dir_magnitude - body_size) / dir_magnitude
    end
    local half_pos = src_pos + dir * 0.5
    region = self:get_region_at_pos(half_pos.x, half_pos.z)
    if region then
      return self:_half_serach_walkable_pos(half_pos, tar_pos, body_size)
    else
      return self:_half_serach_walkable_pos(src_pos, half_pos, body_size)
    end
  end
  
  local VEC3_TEMP1 = Util.VEC3_TEMP.New()
  local VEC3_TEMP2 = Util.VEC3_TEMP.New()
  
  function M:get_nearest_walkable_pos(src_pos, tar_pos, body_size, check_ground_dist, check_layer)
    local y_offset = 2
    body_size = math.abs(body_size or 0)
    VEC3_TEMP1:SetA(tar_pos)
    VEC3_TEMP1:Sub(src_pos)
    local hozi_dist = Vec3.DistanceA(tar_pos.x, 0, tar_pos.z, src_pos.x, 0, src_pos.z)
    if Util.almost_zero(hozi_dist) and math.abs(tar_pos.y - src_pos.y) < Config.FLASH_TO_POS_Y_OFFSET then
      return true, src_pos
    end
    local hit_pos = self:_get_hit_pos(src_pos, body_size, VEC3_TEMP1:Magnitude(), VEC3_TEMP1:SetNormalize(), check_layer)
    local region = self:get_region_at_pos(tar_pos.x, tar_pos.z)
    local src_region = self:get_region_at_pos(src_pos.x, src_pos.z)
    local dir = VEC3_TEMP1:SetNormalize()
    if nil == region then
      if nil == src_region then
        local result_pos = self:adjust_position_based_on_ground(src_pos, y_offset, check_ground_dist)
        return false, result_pos
      end
      return self:get_src_region_walkable_pos(hit_pos, dir, body_size, src_region, tar_pos, check_ground_dist, src_pos, y_offset)
    end
    local result_pos = self:calculate_result_position(hit_pos, src_pos, tar_pos, dir, body_size, src_region, check_ground_dist, y_offset)
    tar_pos = VEC3_TEMP2
    local is_in_region = true
    local has_terrain
    if result_pos then
      result_pos, has_terrain = self:adjust_position_based_on_ground(result_pos, y_offset, check_ground_dist)
    end
    if not has_terrain then
      is_in_region = nil ~= src_region
      if is_in_region then
        is_in_region, result_pos = self:_get_nearest_walkable_pos(src_region, tar_pos, src_pos, body_size, hit_pos, check_ground_dist, y_offset)
      end
    end
    return is_in_region, result_pos
  end
  
  function M:_hit_pos_sub_body_size(hit_pos, dir, body_size)
    dir:Mul(-1)
    dir:Set(dir:Get())
    dir:SetNormalize():Mul(body_size)
    hit_pos:Add(dir)
  end
  
  local max_check_time = 6
  
  function M:calculate_result_position(hit_pos, src_pos, tar_pos, dir, body_size, src_region, check_ground_dist, y_offset)
    local tar_x, tar_y, tar_z = tar_pos.x, tar_pos.y, tar_pos.z
    if hit_pos then
      self:_hit_pos_sub_body_size(hit_pos, dir, body_size)
      VEC3_TEMP2:Set(tar_x, tar_y, tar_z)
      return hit_pos
    end
    local src_x, src_y, src_z = src_pos.x, src_pos.y, src_pos.z
    local new_dir_x, new_dir_y, new_dir_z
    local time = 1
    local temp_dir = VEC3_TEMP2
    temp_dir:SetA(dir)
    temp_dir:Mul(-1)
    while time < max_check_time do
      new_dir_x, new_dir_y, new_dir_z = tar_x - src_x, tar_y - src_y, tar_z - src_z
      if time >= max_check_time or Vec3.DotA(new_dir_x, new_dir_y, new_dir_z, dir.x, dir.y, dir.z) < 0 then
        tar_x, tar_y, tar_z = src_pos.x, src_pos.y, src_pos.z
        break
      end
      local check_height = check_ground_dist and check_ground_dist + body_size or body_size + 0.1
      if not self:check_in_collision(tar_x, tar_y + body_size, tar_z, body_size, check_height) then
        break
      end
      temp_dir:SetNormalize():Mul(body_size * 2 * time)
      tar_x, tar_y, tar_z = tar_x + temp_dir.x, tar_y + temp_dir.y, tar_z + temp_dir.z
      time = time + 1
    end
    VEC3_TEMP2:Set(tar_x, tar_y, tar_z)
    local result_pos = Vec3.New(tar_x, tar_y, tar_z)
    return result_pos
  end
  
  function M:adjust_position_based_on_ground(result_pos, y_offset, check_ground_dist)
    local has_terrain, y
    if check_ground_dist then
      has_terrain, y = Util.raycast(result_pos.x, result_pos.z, Layer.LayerMask.Terrain, result_pos.y + y_offset, check_ground_dist + y_offset)
      if has_terrain then
        result_pos.y = y
      end
    else
      has_terrain = true
    end
    return result_pos, has_terrain
  end
  
  function M:get_src_region_walkable_pos(hit_pos, dir, body_size, src_region, tar_pos, check_ground_dist, src_pos, y_offset)
    local is_in_region, result_pos
    if hit_pos then
      self:_hit_pos_sub_body_size(hit_pos, dir, body_size)
      local is_hit
      result_pos, is_hit = self:adjust_position_based_on_ground(hit_pos, y_offset, check_ground_dist)
      if not is_hit then
        is_in_region, result_pos = self:_get_nearest_walkable_pos(src_region, tar_pos, src_pos, body_size, hit_pos, check_ground_dist, y_offset)
      end
    else
      is_in_region, result_pos = self:_get_nearest_walkable_pos(src_region, tar_pos, src_pos, body_size, hit_pos, check_ground_dist, y_offset)
      if self:check_in_collision(result_pos.x, result_pos.y, result_pos.z, body_size) then
        result_pos = src_pos
      end
    end
    return is_in_region, result_pos
  end
  
  function M:_get_nearest_walkable_pos(src_region, tar_pos, src_pos, body_size, hit_pos, check_ground_dist, y_offset)
    local dir, dir_magnitude
    local gg = src_region:get_gg()
    local suc, ox, oy, oz = AstarHelper.GetNearestGrid3(body_size, tar_pos.x, tar_pos.y, tar_pos.z, gg, false, false)
    if suc then
      local pos = Vec3.New(ox, oy, oz)
      local max_edge_lenght = 100
      local half_edge = max_edge_lenght * 0.5
      local x_edge_vec = Vec3.right * half_edge
      local z_edge_vec = Vec3.forward * half_edge
      local is_x_interact, x_interact_pos = Util.is_interact(src_pos, tar_pos, pos + x_edge_vec, pos - x_edge_vec)
      local is_z_interact, z_interact_pos = Util.is_interact(src_pos, tar_pos, pos + z_edge_vec, pos - z_edge_vec)
      if is_x_interact and is_z_interact then
        local dist_x = Vec3.Distance(x_interact_pos, src_pos)
        local dist_z = Vec3.Distance(z_interact_pos, src_pos)
        pos = dist_x < dist_z and x_interact_pos or z_interact_pos
      elseif is_x_interact then
        pos = x_interact_pos
      elseif is_z_interact then
        pos = z_interact_pos
      end
      dir = pos - src_pos
      dir_magnitude = dir:Magnitude()
      pos = src_pos + dir * (dir_magnitude - body_size) / dir_magnitude
      if hit_pos then
        local hit_pos_dist = Vec3.Distance(hit_pos, src_pos)
        pos = dir_magnitude < hit_pos_dist and pos or hit_pos
      end
      pos = self:_half_serach_walkable_pos(src_pos, pos, body_size)
      self:adjust_position_based_on_ground(pos, y_offset, check_ground_dist)
      return false, pos
    else
      return false, src_pos
    end
  end
  
  function M:destroy_finder()
    M.s_has_init_cs_finder = false
    if M.v_finder_go then
      ResMgr:destroy_gameobj(M.v_finder_go)
    end
    M.v_path_modifier = nil
    M.v_finder_go = nil
  end
  
  function M:get_is_layer_grid()
    return self.v_is_layer_grid
  end
  
  function M:log_map_path()
    Log.Info(self.v_map_path)
  end
  
  function M:set_empty_wall_visible(tag, is_visible)
    self.v_base_region:set_empty_wall_visible(tag, is_visible)
  end
  
  function M:set_empty_wall_group_visible(group, is_visible)
    self.v_base_region:set_empty_wall_group_visible(group, is_visible)
  end
  
  function M:is_in_region(x, z, y)
    return self:get_region_at_pos(x, z, y) ~= nil
  end
end
return M
