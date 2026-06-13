local Math = require("base.mathx")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local FindPathPoint = require("manager.role_mgr.find_path_point")
local Vec3 = require("base.vec3")
local AstarHelper = CS.Game.AstarHelper
local RecordItem = Util.create_class()

function RecordItem:_init(start_x, start_y, start_z, end_x, end_y, end_z, region)
  self.start_x = start_x
  self.start_y = start_y
  self.start_z = start_z
  self.end_x = end_x
  self.end_y = end_y
  self.end_z = end_z
  self.region = region
end

function RecordItem:on_destroy()
  self.region = nil
end

local SubTaskItem = Util.create_class()

function SubTaskItem:_init(path, region)
  self.path = path
  self.region = region
  self.set = false
end

function SubTaskItem:on_destroy()
  self.path = nil
  self.region = nil
  self.set = false
end

local M = Util.create_class()
local _tinsert = table.insert
local s_unique_id = 0

local function _next_unique_id()
  s_unique_id = s_unique_id + 1
  return s_unique_id
end

function M:_init(navigator, start_pos, end_pos, is_same_region, start_region, end_region, start_link_point, end_link_point, radius, start_world_pos, end_world_pos)
  self.v_navigator = navigator
  self.v_start_pos = self.v_start_pos or Vec3.New(0, 0, 0)
  self.v_end_pos = self.v_end_pos or Vec3.New(0, 0, 0)
  self.v_start_pos:SetA(start_pos)
  self.v_end_pos:SetA(end_pos)
  self.v_start_world_pos = self.v_start_world_pos or Vec3.New(0, 0, 0)
  self.v_end_world_pos = self.v_end_world_pos or Vec3.New(0, 0, 0)
  self.v_start_world_pos:SetA(start_world_pos)
  self.v_end_world_pos:SetA(end_world_pos)
  self.v_radius = radius
  self.v_is_same_region = is_same_region
  self.v_start_region = start_region
  self.v_end_region = end_region
  self.v_start_link_point = start_link_point
  self.v_end_link_point = end_link_point
  self.v_task_id = _next_unique_id()
  self.v_fail = false
  self.v_is_destroy = false
  self.v_is_calc_finished = false
  self.v_is_valid_path = false
  self.v_sub_path_list = self.v_sub_path_list or {}
  self.v_sub_path_finish_cnt = 0
  self.v_direct_fst_point = false
  self.v_direct_region = nil
  self.v_direct_x = 0
  self.v_direct_z = 0
  local map = SceneMgr:get_scene_map()
  if is_same_region then
    self.v_sub_path_cnt = 1
    local pool = self:_get_sub_task_item_pool()
    local sub_task = pool:new_obj(nil, start_region)
    self.v_sub_path_list[1] = sub_task
    map:find_grid_graph_path(start_pos.x, start_pos.y, start_pos.z, end_pos.x, end_pos.y, end_pos.z, start_region:get_gg(), navigator:get_body_size(), self._on_grid_path_complete, self, self.v_task_id, 1)
  else
    self.v_sub_path_cnt = 0
    map:find_point_graph_path(start_link_point, end_link_point, self._on_point_path_complete, self, self.v_task_id)
  end
end

function M:_get_record_item_pool()
  if self.v_record_item_pool then
    return self.v_record_item_pool
  end
  self.v_record_item_pool = LuaObjPoolMgr.get_pool("find_path_task_record_pool") or LuaObjPoolMgr.register("find_path_task_record_pool", 100, RecordItem)
  return self.v_record_item_pool
end

function M:_get_sub_task_item_pool()
  if self.v_sub_task_item_pool then
    return self.v_sub_task_item_pool
  end
  self.v_sub_task_item_pool = LuaObjPoolMgr.get_pool("find_path_task_sub_task_pool") or LuaObjPoolMgr.register("find_path_task_sub_task_pool", 100, SubTaskItem)
  return self.v_sub_task_item_pool
end

function M:_clear_path_list()
  for i = 1, self.v_sub_path_cnt do
    local sub_task_item = self.v_sub_path_list[i]
    if sub_task_item.path then
      local obj = self.v_navigator:get_gameobj()
      if obj and not obj:IsNull() then
        sub_task_item.path:Release(obj.gameObject)
      end
    end
    self.v_sub_task_item_pool:destroy_obj(sub_task_item)
  end
  UtilTable.clear_map(self.v_sub_path_list)
  self.v_sub_path_cnt = 0
end

function M:_on_task_fail(...)
  self.v_fail = true
  self.v_is_calc_finished = true
end

function M:_on_grid_path_complete(path, task_id, sub_task_idx)
  local obj = self.v_navigator:get_gameobj()
  if self.v_is_destroy then
    self:_on_task_fail("task is destroy", task_id, sub_task_idx)
    return
  end
  if task_id ~= self.v_task_id then
    self:_on_task_fail("task unmatched", task_id, sub_task_idx)
    return
  end
  if self.v_fail or Util.is_nil(obj) then
    self:_on_task_fail("task is fail", task_id, self.v_task_id, sub_task_idx)
    return
  end
  if nil == path or path.error then
    self:_on_task_fail("grid path error", task_id, sub_task_idx)
    return
  end
  self.v_sub_path_finish_cnt = self.v_sub_path_finish_cnt + 1
  local sub_path = self.v_sub_path_list[sub_task_idx]
  sub_path.path = path
  sub_path.set = true
  path:Claim(obj.gameObject)
  if self.v_sub_path_finish_cnt >= self.v_sub_path_cnt then
    self.v_is_calc_finished = true
    self:_on_all_path_finished()
  end
end

function M:_get_link_point_in_path(map, path, i)
  local valid, _, y, _ = AstarHelper.GetPathPoint(path, i)
  assert(valid)
  return map:get_pg_point_by_y(y)
end

function M:_on_point_path_complete(path, task_id)
  if self.v_is_destroy or task_id ~= self.v_task_id then
    return
  end
  if nil == path or path.error then
    self:_on_task_fail("point path error")
    return
  end
  local list = path.vectorPath
  if list.Count < 2 then
    self:_on_task_fail("point cnt error")
    return
  end
  local len = list.Count - 1
  local map = SceneMgr:get_scene_map()
  local last_link_point = self:_get_link_point_in_path(map, path, len)
  if last_link_point ~= self.v_end_link_point then
    self:_on_task_fail("point path fail")
    return
  end
  local sub_task_list = {}
  local start_x, start_y, start_z, end_x, end_y, end_z, link_point, next_link_point, start_point_region, next_region, region
  start_point_region = self.v_start_region
  start_x, start_y, start_z = self.v_start_pos.x, self.v_start_pos.y, self.v_start_pos.z
  for i = 0, len do
    link_point = self:_get_link_point_in_path(map, path, i)
    if i == len then
      region = link_point:get_dynamic_region()
      if region ~= self.v_end_region then
        self:_clear_record_items(sub_task_list)
        self:_on_task_fail("final link point is not right")
        return
      end
      self:_add_sub_task(sub_task_list, start_x, start_y, start_z, self.v_end_pos.x, self.v_end_pos.y, self.v_end_pos.z, self.v_end_region)
    else
      next_link_point = self:_get_link_point_in_path(map, path, i + 1)
      next_region = next_link_point:get_dynamic_region()
      if nil == next_region then
        self:_clear_record_items(sub_task_list)
        self:_on_task_fail("link next_region is nil")
        return
      end
      if next_region ~= start_point_region then
        end_x, end_y, end_z = link_point:get_pos_in_region(start_point_region)
        local is_add_task = true
        if 0 == i and link_point:get_link() == next_link_point:get_link() then
          local next_point_x, _, next_point_z = next_link_point:get_pos_in_region(next_region)
          local cur_world_x, cur_world_z = self.v_start_world_pos.x, self.v_start_world_pos.z
          local next_pt_world_x, next_pt_world_z = next_link_point:get_tf_world_pos2()
          local start_pt_world_x, start_pt_world_z = link_point:get_tf_world_pos2()
          local dis_e_c = Math.square_distance2(cur_world_x, cur_world_z, next_pt_world_x, next_pt_world_z)
          local dis_s_e = Math.square_distance2(start_pt_world_x, start_pt_world_z, next_pt_world_x, next_pt_world_z)
          if dis_e_c < dis_s_e then
            is_add_task = false
            self.v_direct_fst_point = true
            self.v_direct_region = next_region
            self.v_direct_x = next_point_x
            self.v_direct_z = next_point_z
          end
        end
        if is_add_task then
          self:_add_sub_task(sub_task_list, start_x, start_y, start_z, end_x, end_y, end_z, start_point_region)
        end
        start_point_region = next_region
        start_x, start_y, start_z = next_link_point:get_pos_in_region(next_region)
      end
    end
  end
  local body_size = self.v_navigator:get_body_size()
  self.v_sub_path_cnt = #sub_task_list
  local sub_task_pool = self:_get_sub_task_item_pool()
  for i, sub_task in ipairs(sub_task_list) do
    local sub_task_item = sub_task_pool:new_obj(nil, sub_task.region)
    self.v_sub_path_list[i] = sub_task_item
    map:find_grid_graph_path(sub_task.start_x, sub_task.start_y, sub_task.start_z, sub_task.end_x, sub_task.end_y, sub_task.end_z, sub_task.region:get_gg(), body_size, self._on_grid_path_complete, self, self.v_task_id, i)
  end
  self:_clear_record_items(sub_task_list)
end

function M:_clear_record_items(sub_task_list)
  for _, record in ipairs(sub_task_list) do
    self.v_record_item_pool:destroy_obj(record)
  end
end

function M:_add_sub_task(sub_task_list, start_x, start_y, start_z, end_x, end_y, end_z, cur_region)
  local pool = self:_get_record_item_pool()
  local new_record = pool:new_obj(start_x, start_y, start_z, end_x, end_y, end_z, cur_region)
  _tinsert(sub_task_list, new_record)
end

function M:_add_last_sub_task(sub_task_list, start_x, start_z)
  local pool = self:_get_record_item_pool()
  local new_record = pool:new_obj(start_x, start_z, self.v_end_pos.x, self.v_end_pos.z, self.v_end_region)
  _tinsert(sub_task_list, new_record)
end

function M:_on_all_path_finished()
  self.v_is_valid_path = true
end

function M:on_destroy()
  self.v_is_destroy = true
  self:_clear_path_list()
end

function M:is_calc_finished()
  return self.v_is_calc_finished
end

function M:is_valid_path()
  return self.v_is_valid_path
end

function M:fill_points(list)
  list.n = 0
  local map = SceneMgr:get_scene_map()
  if self.v_direct_fst_point then
    local point = FindPathPoint.create(self.v_direct_region, self.v_direct_x, self.v_direct_z)
    list.n = list.n + 1
    list[list.n] = point
  end
  for j = 1, self.v_sub_path_cnt do
    local sub_task = self.v_sub_path_list[j]
    local path = sub_task.path
    if nil == path and sub_task.set then
      Log.Error("err, path released ...")
    end
    map:modifier_path(path, self.v_radius)
    local vec_list = path.vectorPath
    local len = vec_list.Count - 1
    for i = 0, len do
      local valid, x, y, z = AstarHelper.GetPathPoint(path, i)
      assert(valid)
      local point = FindPathPoint.create(sub_task.region, x, z, y)
      list.n = list.n + 1
      list[list.n] = point
    end
  end
end

function M:_draw_link_point_path(path)
  Util.draw_one_point(self.v_start_link_point:get_tf().position, 0.5, "start_link_point")
  Util.draw_one_point(self.v_end_link_point:get_tf().position, 0.5, "end_link_point")
  local list = path.vectorPath
  local len = list.Count - 1
  local map = SceneMgr:get_scene_map()
  for i = 0, len do
    local _, _, y, _ = AstarHelper.GetPathPoint(path, i)
    local link_point = map:get_pg_point_by_y(y)
    Util.draw_one_point(link_point:get_tf().position, 0.7 ^ i, "link_" .. i)
  end
end

function M:_print_point_path(path)
  local map = SceneMgr:get_scene_map()
  local list = path.vectorPath
  local len = list.Count - 1
  local str = {}
  for i = 0, len do
    local link_point = self:_get_link_point_in_path(map, path, i)
    table.insert(str, link_point:get_y())
  end
  Log.Error("point path start : ", self.v_start_link_point:get_y())
  Log.Error("point path end : ", self.v_end_link_point:get_y())
  Log.Error("point path : ", table.concat(str, ", "))
end

return M
