local PlatformCls = require("manager.scene.scene_platform")
local Layer = require("utils.layer")
local Time = require("manager.time.time")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local AstarHelper = CS.Game.AstarHelper
local PLATFORM_LAYERMASK = Layer.LayerMask.Terrain
local UPDATE_GRAPH_TYPE = {ADD_CONNECTION = 1, REMOVE_CONNECTION = 2}
local COLLIDER_CHECK_HEGHT = 4
local UpdateGraphAction = Util.create_class()

function UpdateGraphAction:_init(type, point1, point2, dis)
  self.v_type = type
  self.v_point1 = point1
  self.v_point2 = point2
  self.v_dis = dis
end

function UpdateGraphAction:excute()
  if self.v_type == UPDATE_GRAPH_TYPE.ADD_CONNECTION then
    self.v_point1:AddConnection(self.v_point2, self.v_dis)
    self.v_point2:AddConnection(self.v_point1, self.v_dis)
  else
    self.v_point1:RemoveConnection(self.v_point2)
    self.v_point2:RemoveConnection(self.v_point1)
  end
end

function UpdateGraphAction:on_destroy()
  self.v_type = nil
  self.v_point1 = nil
  self.v_point2 = nil
  self.v_dis = nil
end

local M = Util.create_class()

function M:_init()
  self.v_plat_dic = {}
  self.v_cid_dic = {}
  self.time_mgr = Time:new(self)
  self.v_pg_action_list = {n = 0}
  self.v_pg_action_pool = LuaObjPoolMgr.get_pool("pg_update_action_pool") or LuaObjPoolMgr.register("pg_update_action_pool", 300, UpdateGraphAction)
end

function M:_get_plat(name)
  assert(name)
  local plat = self.v_plat_dic[name]
  if nil == plat then
    local map = SceneMgr:get_scene_map()
    if map then
      map:log_map_path()
    end
  end
  Util.assert(plat, "not exist platform, name : ", name)
  return plat
end

function M:clear()
  for _, plat in pairs(self.v_plat_dic) do
    plat:clear()
  end
  if self.time_mgr then
    self.time_mgr:on_destroy()
  end
  self.v_plat_dic = {}
  self.v_cid_dic = {}
  self.v_pg_action_list.n = 0
  if self.v_pg_action_pool then
    self.v_pg_action_pool:release_active_objs()
  end
  self.v_pg_action_pool = nil
end

function M:on_time_scale(time_scale, pause, is_global_scale, impact_sound_type, impact_sound_volume)
  for _, plat in pairs(self.v_plat_dic) do
    plat:set_time_scale(time_scale)
  end
end

function M:create_platform(region)
  local map = SceneMgr:get_scene_map()
  local container = map:get_scene_container()
  if nil == container then
    Log.Error("初始化移动平台失败")
    return
  end
  local plat = PlatformCls.create(container, region, self)
  if plat then
    self.v_plat_dic[tostring(plat:get_name())] = plat
  end
  return plat
end

function M:check_overlap_plats(collider, old_dic, on_remove, on_add, obstacle)
  for _, plat in pairs(self.v_plat_dic) do
    local is_overlap = plat:is_overlap_with(collider)
    if is_overlap then
      if not old_dic[plat] then
        on_add(obstacle, plat)
      end
    elseif old_dic[plat] then
      on_remove(obstacle, plat)
    end
  end
end

function M:update()
  if self.time_mgr then
    self.time_mgr:update()
  end
  for _, plat in pairs(self.v_plat_dic) do
    plat:update()
  end
end

function M:late_update()
  self:_batch_update_point_graph()
  for _, plat in pairs(self.v_plat_dic) do
    plat:late_update()
  end
end

function M:_get_plat_at_pos(x, z, y, check_height)
  y = y or Global.hero:get_pos_height()
  local y_offset = 1
  check_height = check_height or COLLIDER_CHECK_HEGHT
  local has, _, cid = Util.raycast(x, z, PLATFORM_LAYERMASK, y + y_offset, check_height + y_offset)
  if has then
    return cid, self.v_cid_dic[cid]
  end
  return cid
end

function M:get_region_at_pos(x, z, y, check_height)
  local cid, plat = self:_get_plat_at_pos(x, z, y, check_height)
  if plat then
    return cid, plat:get_region()
  end
  return cid
end

function M:regist(cid, plat)
  self.v_cid_dic[cid] = plat
end

function M:get_plat_by_cid(cid)
  if nil == cid then
    return
  end
  return self.v_cid_dic[cid]
end

function M:update_plat_movement(name, is_move, anim)
  assert(name)
  local plat = self:_get_plat(name)
  if not plat then
    Log.Error("update_plat_movement, plat not exist, name = ", name)
    return
  end
  plat:update_plat_movement(is_move, anim)
end

function M:update_plat_moved(name, anim)
  assert(name)
  local plat = self:_get_plat(name)
  if not plat then
    Log.Error("update_plat_moved, plat not exist, name = ", name)
    return
  end
  plat:update_plat_moved(anim)
end

function M:set_is_moving(name)
  assert(name)
  local plat = self:_get_plat(name)
  if not plat then
    Log.Error("update_plat_moved, plat not exist, name = ", name)
    return
  end
  plat:set_is_moving()
end

function M:set_terrain_enable(is_enable)
  for _, plat in pairs(self.v_plat_dic) do
    plat:set_terrain_enable(is_enable)
  end
end

function M:pause_time(pause)
  if self.time_mgr then
    self.time_mgr:pause_time(pause)
  end
end

function M:_cache_pg_action(action)
  self.v_pg_action_list.n = self.v_pg_action_list.n + 1
  local idx = self.v_pg_action_list.n
  self.v_pg_action_list[idx] = action
end

do
  local _cs_is_path_possible = CS.Pathfinding.PathUtilities.IsPathPossible
  
  function M:on_add_link_to_plat(link, relate_region)
    local p1 = link:get_end_point()
    local p1_pg, p1_gg = link:get_end_point():get_points()
    if not p1_gg then
      Log.Error("lack p1_gg on add")
      return
    end
    local region = relate_region
    local origin_link_list = region.origin_link_list
    for _, origin_link in ipairs(origin_link_list) do
      if origin_link ~= link then
        local p2 = origin_link:get_start_point()
        local p2_pg, p2_gg = p2:get_points()
        if p2_gg and _cs_is_path_possible(p1_gg, p2_gg) then
          local dis = p1:get_tf_dis_to_another(p2)
          local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.ADD_CONNECTION, p1_pg, p2_pg, dis)
          self:_cache_pg_action(action)
        end
      end
    end
    local temp_link_dic = region:get_temp_link_dic()
    for temp_link in pairs(temp_link_dic) do
      if temp_link ~= link and not temp_link:is_same_plat(link) then
        local p2 = temp_link:get_end_point()
        local p2_pg, p2_gg = p2:get_points()
        if p2_gg and _cs_is_path_possible(p1_gg, p2_gg) then
          local dis = p1:get_tf_dis_to_another(p2)
          local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.ADD_CONNECTION, p1_pg, p2_pg, dis)
          self:_cache_pg_action(action)
        end
      end
    end
  end
  
  function M:on_remove_link_from_plat(link, relate_region)
    local p1 = link:get_end_point()
    local p1_pg = p1:get_points()
    local region = relate_region
    local origin_link_list = region.origin_link_list
    for _, origin_link in ipairs(origin_link_list) do
      if origin_link ~= link then
        local p2 = origin_link:get_start_point()
        local p2_pg = p2:get_pg_point()
        local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.REMOVE_CONNECTION, p1_pg, p2_pg)
        self:_cache_pg_action(action)
      end
    end
    local temp_link_dic = region:get_temp_link_dic()
    for temp_link in pairs(temp_link_dic) do
      if temp_link ~= link then
        local p2 = temp_link:get_end_point()
        local p2_pg = p2:get_pg_point()
        local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.REMOVE_CONNECTION, p1_pg, p2_pg)
        self:_cache_pg_action(action)
      end
    end
  end
  
  function M:_check_link_connection(link1, is_origin1, link2, is_origin2, is_excute)
    if link1 == link2 then
      return
    end
    if not self.v_pg_action_pool then
      Log.Warning("_check_link_connection: v_pg_action_pool is nil, trying to reinitialize")
      self:_ensure_action_pool()
      if not self.v_pg_action_pool then
        Log.Error("_check_link_connection: failed to reinitialize v_pg_action_pool")
        return
      end
    end
    local p1, p2
    if is_origin1 then
      p1 = link1:get_start_point()
    else
      p1 = link1:get_end_point()
    end
    if is_origin2 then
      p2 = link2:get_start_point()
    else
      p2 = link2:get_end_point()
    end
    local p1_pg, p1_gg = p1:get_points()
    local p2_pg, p2_gg = p2:get_points()
    if not _cs_is_path_possible(p1_pg, p2_pg) and p1_gg and p2_gg and _cs_is_path_possible(p1_gg, p2_gg) then
      local dis = p1:get_tf_dis_to_another(p2)
      local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.ADD_CONNECTION, p1_pg, p2_pg, dis)
      if is_excute then
        action:excute()
        self.v_pg_action_pool:destroy_obj(action)
      else
        self:_cache_pg_action(action)
      end
      return
    end
    if _cs_is_path_possible(p1_pg, p2_pg) and (not (p1_gg and p2_gg) or not _cs_is_path_possible(p1_gg, p2_gg)) then
      local action = self.v_pg_action_pool:new_obj(UPDATE_GRAPH_TYPE.REMOVE_CONNECTION, p1_pg, p2_pg)
      if is_excute then
        action:excute()
        self.v_pg_action_pool:destroy_obj(action)
      else
        self:_cache_pg_action(action)
      end
    end
  end
  
  function M:refresh_link_connection_in_plat(plat, is_excute)
    local region = plat:get_region()
    local origin_link_list = region.origin_link_list
    local temp_link_dic = region:get_temp_link_dic()
    for _, origin_link_1 in ipairs(origin_link_list) do
      for _, origin_link_2 in ipairs(origin_link_list) do
        self:_check_link_connection(origin_link_1, true, origin_link_2, true, is_excute)
      end
      for temp_link in pairs(temp_link_dic) do
        self:_check_link_connection(origin_link_1, true, temp_link, false, is_excute)
      end
    end
    for temp_link_1 in pairs(temp_link_dic) do
      for temp_link_2 in pairs(temp_link_dic) do
        self:_check_link_connection(temp_link_1, false, temp_link_2, false, is_excute)
      end
    end
  end
  
  function M:init_plat_link_connections()
    if not self.v_pg_action_pool then
      Log.Warning("init_plat_link_connections: v_pg_action_pool is nil, trying to reinitialize")
      self:_ensure_action_pool()
      if not self.v_pg_action_pool then
        Log.Error("init_plat_link_connections: failed to reinitialize v_pg_action_pool")
        return
      end
    end
    for _, plat in pairs(self.v_plat_dic) do
      local region = plat:get_region()
      local origin_link_list = region.origin_link_list
      for _, origin_link in ipairs(origin_link_list) do
        origin_link:get_start_point():check_init()
      end
    end
    for _, plat in pairs(self.v_plat_dic) do
      self:refresh_link_connection_in_plat(plat, false)
    end
  end
  
  function M:_batch_update_point_graph()
    if self.v_pg_action_list.n <= 0 then
      return
    end
    AstarHelper.AddWorkItem3(function()
      if self.v_pg_action_list.n <= 0 then
        return
      end
      local len = self.v_pg_action_list.n
      for i = 1, len do
        local action = self.v_pg_action_list[i]
        action:excute()
      end
      self.v_pg_action_list.n = 0
      self.v_pg_action_pool:release_active_objs()
    end)
  end
end

function M:set_plat_time_scale(plat_name, time_scale)
  if not plat_name then
    Log.Error("update_plat_moved, plat not exist, name is nil")
    return
  end
  local plat = self:_get_plat(plat_name)
  if not plat then
    Log.Error("update_plat_moved, plat not exist, name = ", plat_name)
    return
  end
  plat:set_time_scale(time_scale)
end

function M:_ensure_action_pool()
  if not self.v_pg_action_pool then
    self.v_pg_action_pool = LuaObjPoolMgr.get_pool("pg_update_action_pool") or LuaObjPoolMgr.register("pg_update_action_pool", 300, UpdateGraphAction)
    if self.v_pg_action_pool then
      Log.Warning("_ensure_action_pool: reinitialized v_pg_action_pool successfully")
    else
      Log.Error("_ensure_action_pool: failed to reinitialize v_pg_action_pool")
    end
  end
end

return M
