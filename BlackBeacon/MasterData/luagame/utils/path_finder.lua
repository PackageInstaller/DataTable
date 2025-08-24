local PathFinderC = require("pathfinder.c")
local PathDebug = require("system.gamelogic.debug_mgr.path_debug")
local Math = require("base.mathx")
local UnityLoad = UnityEngine.Resources.Load
local UnityUnLoad = UnityEngine.Resources.UnloadAsset
local UnityAssetBundle = UnityEngine.AssetBundle
local _insert = table.insert
local M = Util.create_class()
local MAX_SEARCH_DEPTH = 100000

function M:_init(map_name, pathpoint)
  self:init_map(map_name, pathpoint)
end

function M:init_map(map_name, pathpoint)
  local res_name = "block_texture/" .. map_name .. ".bytes"
  self.v_res_name = res_name
  local path_point_name = "block_texture/" .. pathpoint .. ".bytes"
  local map_data = ResMgr:load_res(res_name, UnityEngine.TextAsset)
  local path_point_data = ResMgr:load_res(path_point_name, UnityEngine.TextAsset)
  self:_do_init(map_data.bytes, path_point_data.bytes)
  ResMgr:unload_res(res_name, UnityEngine.TextAsset)
  ResMgr:unload_res(path_point_name, UnityEngine.TextAsset)
end

function M:_do_init(map_data, path_point_data)
  self.map_data = map_data
  local _, _, width, height, c_pos_x, c_pos_z, scale, block_data = string.find(map_data, [[
(%d+)
(%d+)
([%+%-%d%.]+)
([%+%-%d%.]+)
(%d+)
(.*)]])
  print("init_map:", self.v_res_name, width, height, c_pos_x, c_pos_z, scale, #map_data, #block_data)
  PathFinderC.init_map_data(block_data, path_point_data, width, height, c_pos_x, c_pos_z, scale)
  self.is_inited = true
end

function M:release_map(additive)
  if additive then
    self.last_map_data = self.map_data
  end
  PathFinderC.release_map_data()
  self.is_inited = false
  self.map_data = nil
end

function M:restore_pre_map()
  self:release_map(false)
  self:_do_init(self.last_map_data)
  self.last_map_data = nil
end

function M:get_neighbour_movable(sx, sz, tx, tz, mask)
  mask = mask or Config.BLOCK_MASK
  return PathFinderC.get_neighbour_movable(sx, sz, tx, tz, mask)
end

function M:is_block(x, z, mask)
  if not Global.block then
    return false
  end
  mask = mask or self.search_mask or Config.BLOCK_MASK
  return PathFinderC.is_mask_set(x, z, mask)
end

function M:begin_search_role()
  self.search_mask = Config.ROLE_SEARCH_MASK
end

function M:end_search_role()
  self.search_mask = Config.BLOCK_MASK
end

function M:find_path(sx, sz, tx, tz)
  local ret, path_points = PathFinderC.find_path(sx, sz, tx, tz, MAX_SEARCH_DEPTH, self.search_mask or Config.BLOCK_MASK)
  if path_points then
    _insert(path_points, tx)
    _insert(path_points, tz)
  end
  return path_points
end

function M:is_direct_path(sx, sz, tx, tz, mask)
  if not Global.block then
    return true
  end
  return PathFinderC.is_direct_path(sx, sz, tx, tz, mask)
end

function M:mark_area(x, z, length, width, dirx, dirz, mask)
  dirx = dirx or 0
  dirz = dirz or 0
  PathFinderC.mark_area(x, z, length, width, dirx, dirz, mask, true)
end

function M:unmark_area(x, z, length, width, dirx, dirz, mask)
  dirx = dirx or 0
  dirz = dirz or 0
  PathFinderC.mark_area(x, z, length, width, dirx, dirz, mask, false)
end

function M:find_point_path(sx, sz, tx, tz)
  local distance = Math.distance2(sx, sz, tx, tz)
  if distance <= 30 and PathFinderC.is_direct_path(sx, sz, tx, tz, Config.BLOCK_MASK) then
    return {
      sx,
      sz,
      tx,
      tz
    }
  end
  local tbl = {}
  local ret, start_point_id, to_start_points = PathFinderC.find_path_to_nearest_point(sx, sz, 3000, Config.BLOCK_MASK)
  if not ret then
    return self:find_path(sx, sz, tx, tz)
  end
  local ret, end_point_id, to_end_points = PathFinderC.find_path_to_nearest_point(tx, tz, 3000, Config.BLOCK_MASK)
  if not ret then
    return self:find_path(sx, sz, tx, tz)
  end
  local ret, point_paths = PathFinderC.find_point_path(start_point_id, end_point_id, Config.BLOCK_MASK)
  if not ret then
    return self:find_path(sx, sz, tx, tz)
  end
  local need_break = false
  local start_idx = 1
  local point_paths_len = #point_paths
  for i = 1, point_paths_len - 2, 2 do
    local idx = point_paths_len - i
    local curx, curz = point_paths[idx], point_paths[idx + 1]
    local nextx, nextz = point_paths[idx - 2], point_paths[idx - 1]
    start_idx = i
    if Math.dot(sx, sz, curx, curz, nextx, nextz) <= 0 then
      need_break = true
      break
    end
  end
  if not need_break then
    start_idx = start_idx + 2
  end
  if 1 ~= start_idx then
    if point_paths_len > start_idx then
      local idx = point_paths_len - start_idx
      local px, pz = point_paths[idx], point_paths[idx + 1]
      local ret, points = PathFinderC.find_path(sx, sz, px, pz, MAX_SEARCH_DEPTH, Config.BLOCK_MASK)
      if not ret then
        return self:find_path(sx, sz, tx, tz)
      else
        for i = 3, #points - 2, 2 do
          _insert(tbl, points[i])
          _insert(tbl, points[i + 1])
        end
      end
    end
  else
    for i = 1, #to_start_points, 2 do
      _insert(tbl, to_start_points[i])
      _insert(tbl, to_start_points[i + 1])
    end
  end
  local end_idx = 1
  need_break = false
  for i = 1, point_paths_len - 2, 2 do
    local curx, curz = point_paths[i], point_paths[i + 1]
    local nextx, nextz = point_paths[i + 2], point_paths[i + 3]
    end_idx = i
    if Math.dot(tx, tz, curx, curz, nextx, nextz) <= 0 then
      need_break = true
      break
    end
  end
  if not need_break then
    end_idx = end_idx + 2
  end
  for i = point_paths_len - start_idx, end_idx, -2 do
    _insert(tbl, point_paths[i])
    _insert(tbl, point_paths[i + 1])
  end
  if 1 ~= end_idx then
    if point_paths_len > end_idx then
      local px, pz = point_paths[end_idx], point_paths[end_idx + 1]
      local ret, points = PathFinderC.find_path(px, pz, tx, tz, MAX_SEARCH_DEPTH, Config.BLOCK_MASK)
      if not ret then
        return self:find_path(sx, sz, tx, tz)
      else
        for i = 3, #points, 2 do
          _insert(tbl, points[i])
          _insert(tbl, points[i + 1])
        end
      end
    end
  else
    for i = #to_end_points, 1, -2 do
      _insert(tbl, to_end_points[i - 1])
      _insert(tbl, to_end_points[i])
    end
  end
  if not tbl[1] then
    return self:find_path(sx, sz, tx, tz)
  end
  return tbl
end

function M:get_path_length(sx, sz, tx, tz)
  local path = self:find_point_path(sx, sz, tx, tz)
  if path then
    local lx, lz
    lx = path[1]
    lz = path[2]
    local length = 0
    for i = 3, #path, 2 do
      local nx, nz = path[i], path[i + 1]
      local dx, dz = nx - lx, nz - lz
      length = length + math.sqrt(dx * dx + dz * dz)
      lx = nx
      lz = nz
    end
    return length
  end
end

function M:set_search_obj_uuid(uuid)
  self.v_search_obj_uuid = uuid
end

function M:get_search_obj_uuid()
  if self.v_search_obj_uuid then
    local obj = Global.scene_mgr:pick_by_uuid(self.v_search_obj_uuid)
    if not obj then
      self.v_search_obj_uuid = nil
    end
    return obj
  end
end

return M
