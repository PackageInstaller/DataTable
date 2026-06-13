local Base = require("gamelogic.base_system")
local BUILDING_CONFIG = require("uimodule.building.building_config")
local LocalStorage = require("utils.localstorage")
local ADVENTRUE_CLUE_SELECT_KEY = "ADVENTRUE_CLUE_SELECT"
local BUILDING_LOCAL_REDPOINT = "BUILDING_LOCAL_REDPOINT"
local BUILDING_LOCAL_STORAGE_DATA = "BUILDING_LOCAL_STORAGE_DATA"
local Math = require("base.mathx")
local M = Util.create_child_mt(Base)
local CommonDefine = Config.CommonDefine
local BUILDING_DISPATCH_TASK_TYPE = BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE
local ONE_HOUR_SECONDS = 3600
local BUILDING_TYPE_TO_LEVEL_UP_RED = {
  [CommonDefine.BUILDING_TYPE.TOWER] = RedEnum.TOWER_LV_UP,
  [CommonDefine.BUILDING_TYPE.ADVENTURE] = RedEnum.ADVENTURE_LV_UP,
  [CommonDefine.BUILDING_TYPE.FACTORY] = RedEnum.FACTORY_LV_UP,
  [CommonDefine.BUILDING_TYPE.STAMINA] = RedEnum.STAMINA_LV_UP,
  [CommonDefine.BUILDING_TYPE.COMBINE] = RedEnum.COMBINE_LV_UP
}
local BUILDING_USE_ITEM = BUILDING_CONFIG.BUILDING_USE_ITEM

local function start_time_sort_func(a, b)
  if a.start_time ~= b.start_time then
    return a.start_time < b.start_time
  else
    return false
  end
end

local function _check_adventrue_team_limit(limit_cfg, compare_map, show_tips)
  local args = limit_cfg.Arg
  local suc
  if limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_ID then
    suc = compare_map[args[1]] and compare_map[args[1]] >= 1
    if not suc and show_tips then
      Util.show_message_tip(2057)
    end
  elseif limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_ELEMENT then
    suc = compare_map[args[1]] and compare_map[args[1]] >= args[2]
    if not suc and show_tips then
      Util.show_message_tip(2058)
    end
  elseif limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_JOB then
    suc = compare_map[args[1]] and compare_map[args[1]] >= args[2]
    if not suc and show_tips then
      Util.show_message_tip(2059)
    end
  end
  return suc
end

function M:on_enter_tower()
  self:clear_redpoint_check_timer()
end

function M:on_exit_tower()
  self:check_all_building_redpoint()
end

function M:bind_item_update_event()
  local temp_event_list = {}
  for _, item_id in pairs(BUILDING_USE_ITEM) do
    local event_id = Util.get_update_event_id_by_item_id(item_id)
    if event_id and not temp_event_list[event_id] then
      temp_event_list[event_id] = true
      self:sys_mq_bind(event_id, self.on_item_update, self)
    end
  end
end

function M:pass_update()
  if self.v_building_scene_mgr then
    self.v_building_scene_mgr:update()
  end
end

function M:init_sys()
  Base.init_sys(self)
  self:bind_item_update_event()
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.on_task_group_update, self)
  self:reset_data()
end

function M:on_reconnect()
  self:clear_redpoint_check_timer()
  self:reset_data()
end

function M:reset_data()
  self.v_building_data_map = {}
  self.v_suc_condition_list = {}
  self.v_clue_data_uuid_map = {}
  self.v_clue_data_id_map = {}
  self.v_clue_data_count_map = {}
  self.v_dispatch_char_map = {}
  self.v_dispatch_help_char_map = {}
  self.v_adventrue_task_map = {}
  self.v_select_clue_count_map = nil
  self.v_adventrue_task_award_data = nil
  self.v_building_local_storage_data = {}
  self:load_local_storage()
end

function M:on_item_update()
  self:check_all_building_redpoint()
end

function M:on_task_group_update()
  self:check_task_redpoint()
end

function M:check_task_redpoint()
  local misc_cfg = ShareRes.get_building_misc_cfg()
  if not Util.is_more_than_zero(misc_cfg.TaskGroupId) then
    return
  end
  local task_group_id = misc_cfg.TaskGroupId
  local is_red = TaskMgr:get_task_group_red(task_group_id)
  RedPointMgr:enable_redpoint(RedEnum.BUILDING_TASK, is_red)
end

function M:check_all_building_redpoint()
  for key, building_type in pairs(CommonDefine.BUILDING_TYPE) do
    self:check_building_redpoint_by_type(building_type)
  end
end

function M:check_building_level_up_redpoint(building_type)
  local building_data = self.v_building_data_map[building_type]
  local max_level = ShareRes.get_building_max_level(building_type)
  local cur_level = nil ~= building_data and building_data.level or 0
  local red_id = BUILDING_TYPE_TO_LEVEL_UP_RED[building_type]
  if max_level > cur_level then
    local check_level = math.min(cur_level + 1, max_level)
    local check_pass = self:building_level_up_check(building_type, check_level)
    if red_id then
      RedPointMgr:enable_dynamic_redpoint(check_level, red_id, check_pass)
    end
  end
end

function M:_check_adventrue_task_redpoint(task_data)
  local cur_time = Date.server_time()
  local explore_time
  local is_red = false
  local suc_time
  if task_data then
    if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.INIT then
      if (task_data.type == BUILDING_DISPATCH_TASK_TYPE.BRANCH or task_data.type == BUILDING_DISPATCH_TASK_TYPE.BOX) and self:check_local_storage_redpoint(task_data.id) then
        is_red = true
      elseif task_data.type == BUILDING_DISPATCH_TASK_TYPE.SPECIAL then
        local type_cfg = ShareRes.get_building_adventure_type(task_data.type)
        if type_cfg and type_cfg.ClueCount <= self:get_all_clue_count() then
          is_red = self:check_local_storage_redpoint(task_data.id .. "enough")
        elseif self:check_local_storage_redpoint(task_data.id .. "first") then
          is_red = true
        end
      end
      if is_red then
        is_red = self:_get_init_task_dispatch_red_state(task_data)
      end
    elseif task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY then
      local task_quality_cfg = ShareRes.get_adventrue_task_quality_cfg_by_task_id(task_data.id)
      if task_quality_cfg then
        explore_time = task_quality_cfg.Time * ONE_HOUR_SECONDS
        suc_time = task_data.explore_time + explore_time
        if task_data.explore_time ~= nil and cur_time > suc_time then
          is_red = true
          suc_time = nil
        end
      else
        Log.Error("获取派遣任务品质配置失败， 任务id", task_data.id, debug.traceback())
      end
    end
  end
  RedPointMgr:enable_dynamic_redpoint(tonumber(task_data.type .. task_data.index), RedEnum.ADVENTURE, is_red)
  return suc_time
end

function M:check_adventrue_task_redpoint()
  local suc_time, check_time
  for type, type_data in pairs(self.v_adventrue_task_map) do
    for key, task_data in pairs(type_data) do
      suc_time = self:_check_adventrue_task_redpoint(task_data)
      if Util.is_more_than_zero(suc_time) then
        if not check_time then
          check_time = suc_time
        else
          check_time = math.min(check_time, suc_time)
        end
      end
    end
  end
  if Util.is_more_than_zero(check_time) then
    self:add_redpoint_check_timer(check_time)
  end
end

function M:check_stamina_warehouse_redpoint(building_type)
  local building_data = self.v_building_data_map[building_type]
  if not building_data then
    return
  end
  local building_level = building_data.level
  local cfg = ShareRes.get_stamina_warehouse_level_cfg(building_level)
  if cfg and Util.is_more_than_zero(cfg.StaminaExchangeId) then
    local exchange_config = ShareRes.get_item_exchange_cfg(cfg.StaminaExchangeId)
    if exchange_config then
      local cost_item = exchange_config.Material[1]
      local item_cfg = ShareRes.get_item_cfg(cost_item)
      if item_cfg then
        local currnet_count = BagMgr:get_item_num(cost_item)
        local is_red = currnet_count >= cfg.Capacity
        RedPointMgr:enable_redpoint(RedEnum.STAMINA, is_red)
        if not is_red then
          BagMgr:request_item_recover_time(cost_item, function(resp)
            if resp.errcode and 0 == resp.errcode then
              local RecoveryTime = item_cfg.RecoveryTime
              local through_time = Date.server_time() - resp.last_recover_time
              local differ_force = cfg.Capacity - BagMgr:get_item_num(item_cfg.Id)
              local remain_time = differ_force * RecoveryTime - through_time
              if Util.is_more_than_zero(remain_time) then
                self:add_redpoint_check_timer(remain_time + Date.server_time())
              end
            end
          end)
        end
      end
    end
  end
end

function M:check_factory_redpoint(building_type)
  local building_data = self.v_building_data_map[building_type]
  if not building_data then
    return
  end
  local factory_list = building_data.factory_list
  if factory_list then
    local material_cfg, cur_count, max_count, fill_time, check_time
    local is_red = false
    for key, factory_data in pairs(factory_list) do
      if Util.is_more_than_zero(factory_data.material_id) then
        material_cfg = ShareRes.get_factory_material_cfg(factory_data.material_id)
        local level = math.min(building_data.level, material_cfg.MaxLevelInfo.Level)
        max_count = material_cfg.LevelInfo[level].Capacity
        cur_count = self:cal_factory_material_count(factory_data.id)
        if max_count <= cur_count then
          is_red = true
          break
        else
          fill_time = self:get_fill_factory_slot_time(factory_data.id)
          if not check_time then
            check_time = fill_time
          else
            check_time = math.min(fill_time, check_time)
          end
        end
      end
    end
    if Util.is_more_than_zero(check_time) then
      self:add_redpoint_check_timer(check_time + Date.server_time())
    end
    RedPointMgr:enable_redpoint(RedEnum.FACTORY, is_red)
  end
end

function M:check_building_redpoint_by_type(building_type)
  self:check_building_level_up_redpoint(building_type)
  if building_type == CommonDefine.BUILDING_TYPE.ADVENTURE then
    self:check_adventrue_task_redpoint(building_type)
  elseif building_type == CommonDefine.BUILDING_TYPE.STAMINA then
    self:check_stamina_warehouse_redpoint(building_type)
  elseif building_type == CommonDefine.BUILDING_TYPE.FACTORY then
    self:check_factory_redpoint(building_type)
  end
end

function M:add_redpoint_check_timer(time)
  time = time + 1
  if self.v_redpoint_refresh_time and time >= self.v_redpoint_refresh_time then
    return
  end
  self:clear_redpoint_check_timer()
  local remain_time = time - Date.server_time()
  if remain_time <= 0 then
    return
  end
  self.v_redpoint_refresh_time = time
  self.v_redpoint_check_timer = Timer:add_timer("redpoint_check_timer", remain_time, function()
    self:clear_redpoint_check_timer()
    self:check_all_building_redpoint()
  end)
end

function M:clear_redpoint_check_timer()
  if self.v_redpoint_check_timer then
    Timer:remove_timer(self.v_redpoint_check_timer)
    self.v_redpoint_check_timer = nil
  end
end

function M:_get_init_task_dispatch_red_state(task_data)
  local task_id, task_type, target_clue_id = task_data.id, task_data.type, task_data.target_clue_id
  local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
  local task_type_cfg = ShareRes.get_building_adventure_type(task_type)
  local has_clue_count = self:get_all_clue_count()
  if task_type_cfg.ClueCount and has_clue_count < task_type_cfg.ClueCount then
    return false
  end
  local task_quality_cfg = ShareRes.get_adventrue_task_quality_cfg(task_cfg.Quality)
  local temp_char_list = self:get_sort_char_list_by_task_id(task_id, target_clue_id, nil, nil, true)
  local can_use_buddy_count = #temp_char_list
  if task_quality_cfg and can_use_buddy_count > task_quality_cfg.BuddyCount then
    local limit_info = task_cfg.LimitInfo
    if limit_info then
      local element_limit = limit_info.ElementLimit and UtilTable.copy_table(limit_info.ElementLimit)
      local job_limit = limit_info.JobLimit and UtilTable.copy_table(limit_info.JobLimit)
      local buddy_count = limit_info.BuddyCount
      for _, data in ipairs(temp_char_list) do
        if not self:check_char_is_dispatch(data.id) then
          local cfg = ShareRes.get_buddy_cfg(data.id)
          if Util.is_more_than_zero(buddy_count) and limit_info.BuddyLimit and limit_info.BuddyLimit[data.id] then
            buddy_count = buddy_count - 1
          end
          if element_limit and element_limit[cfg.Element] then
            element_limit[cfg.Element] = element_limit[cfg.Element] - 1
            if element_limit[cfg.Element] <= 0 then
              element_limit[cfg.Element] = nil
            end
          end
          if job_limit and job_limit[cfg.Job] then
            job_limit[cfg.Job] = job_limit[cfg.Job] - 1
            if job_limit[cfg.Job] <= 0 then
              job_limit[cfg.Job] = nil
            end
          end
          if not Util.is_more_than_zero(buddy_count) and UtilTable.is_empty(element_limit) and UtilTable.is_empty(job_limit) then
            return true
          end
        end
      end
    else
      return true
    end
  end
  return false
end

function M:get_dispatch_red_state()
  local building_data = self.v_building_data_map[CommonDefine.BUILDING_TYPE.ADVENTURE]
  if not building_data then
    return
  end
  local BUILDING_WORK_TAG = BUILDING_CONFIG.BUILDING_WORK_TAG
  local cur_time = Date.server_time()
  local explore_time, has_can_dispatch, has_dispatching, red_state
  for _, type_data in pairs(self.v_adventrue_task_map) do
    for _, task_data in pairs(type_data) do
      if task_data and task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY then
        has_dispatching = true
        local task_cfg = ShareRes.get_adventrue_task_cfg(task_data.id)
        local task_quality_cfg = ShareRes.get_adventrue_task_quality_cfg(task_cfg.Quality)
        if task_quality_cfg then
          explore_time = task_quality_cfg.Time * ONE_HOUR_SECONDS
          if task_data.explore_time ~= nil and cur_time > task_data.explore_time + explore_time then
            red_state = BUILDING_WORK_TAG.CAN_GET_SOMETHING
            break
          end
        end
      elseif task_data.state == CommonDefine.ADVENTURE_TASK_STATE.INIT then
        has_can_dispatch = self:_get_init_task_dispatch_red_state(task_data)
        if has_can_dispatch then
          break
        end
      end
    end
  end
  if red_state ~= BUILDING_WORK_TAG.CAN_GET_SOMETHING then
    if has_can_dispatch then
      red_state = BUILDING_WORK_TAG.UNWORKING
    elseif has_dispatching then
      red_state = BUILDING_WORK_TAG.WORKING
    end
  end
  return red_state or BUILDING_WORK_TAG.NONE
end

function M:get_factory_red_state()
  local building_data = self.v_building_data_map[CommonDefine.BUILDING_TYPE.FACTORY]
  if not building_data then
    return
  end
  local BUILDING_WORK_TAG = BUILDING_CONFIG.BUILDING_WORK_TAG
  local not_in_factory, in_factory, red_state
  for factory_id, factory_data in pairs(building_data.factory_list) do
    local factory_cfg = ShareRes.get_factory_cfg(factory_id)
    if self:check_condition(factory_cfg.Condition) then
      if Util.is_more_than_zero(factory_data.material_id) then
        in_factory = true
        if self:factory_is_full(factory_id) then
          red_state = BUILDING_WORK_TAG.CAN_GET_SOMETHING
          break
        end
      else
        not_in_factory = true
      end
    end
  end
  if red_state ~= BUILDING_WORK_TAG.CAN_GET_SOMETHING then
    if not_in_factory then
      red_state = BUILDING_WORK_TAG.UNWORKING
    elseif in_factory then
      red_state = BUILDING_WORK_TAG.WORKING
    end
  end
  return red_state or BUILDING_WORK_TAG.NONE
end

function M:on_building_list(data)
  RedPointMgr:set_root_node_enable(RedEnum.BUILDING, false)
  local condition_list = data.condition_list
  for key, condition_id in pairs(condition_list) do
    self.v_suc_condition_list[condition_id] = true
  end
  self.v_building_data_map = {}
  self.v_adventrue_task_map = {}
  self.v_dispatch_char_map = {}
  local building_list = data.building_list
  for _, building_data in pairs(building_list) do
    self.v_building_data_map[building_data.type] = building_data
    if building_data.type == CommonDefine.BUILDING_TYPE.ADVENTURE then
      self:on_adventrue_task_update()
    end
    self:check_building_redpoint_by_type(building_data.type)
  end
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_DATA_UPDATE)
end

function M:on_building_update(data)
  local building_data = data.building
  self.v_building_data_map[building_data.type] = building_data
  if building_data.type == CommonDefine.BUILDING_TYPE.ADVENTURE then
    self:on_adventrue_task_update()
  end
  self:check_building_redpoint_by_type(building_data.type)
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_DATA_UPDATE)
end

function M:on_building_condition_finish(data)
  local condition_id = data.condition_id
  self.v_suc_condition_list[condition_id] = true
  self:check_all_building_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_DATA_UPDATE)
end

function M:get_building_data(building_type)
  local data = self.v_building_data_map[building_type]
  return data
end

function M:get_building_level(building_type)
  local data = self.v_building_data_map[building_type]
  return data and data.level or 0
end

function M:check_building_is_unlock(building_type, show_tips)
  local is_unlock = self.v_building_data_map[building_type] ~= nil and Util.is_more_than_zero(self.v_building_data_map[building_type].level)
  if not is_unlock and show_tips then
    local level_cfg = ShareRes.get_building_level_cfg(building_type, 1)
    Condition:check_condition_list(level_cfg.Condition, show_tips)
  end
  return is_unlock
end

function M:building_level_up_check(building_type, level, show_tips)
  if not level then
    local cur_level = self:get_building_level(building_type)
    level = cur_level + 1
  end
  local max_level = ShareRes.get_building_max_level(building_type)
  if level > max_level then
    return false
  end
  local cfg = ShareRes.get_building_level_cfg(building_type, level)
  if not cfg then
    Log.Error("获取建筑等级配置失败", building_type, level, debug.traceback())
    return false
  end
  local condition_pass = self:check_condition_list(cfg.Condition, show_tips)
  if not condition_pass then
    return false
  end
  local cost_id = cfg.ConsumeItemId
  if Util.is_more_than_zero(cost_id) then
    local cost_count = cfg.ConsumeItemCount
    if Util.is_more_than_zero(cost_count) then
      local enough = Util.check_item_cost_enough(cost_id, cost_count)
      if not enough and show_tips then
        Util.show_message_tip(2314, Util.get_item_name(cost_id))
      end
      return enough
    end
  end
  return true
end

function M:get_build_lv_up_red_id(building_type)
  return BUILDING_TYPE_TO_LEVEL_UP_RED[building_type]
end

function M:check_condition(condition_id)
  return 0 == condition_id or self.v_suc_condition_list[condition_id] == true
end

function M:check_condition_list(condition_list, show_tips)
  for key, condition_id in pairs(condition_list) do
    if not self:check_condition(condition_id) then
      if show_tips then
        local desc = ShareRes.get_condition_desc(condition_id)
        Util.show_message_tip(desc)
      end
      return false
    end
  end
  return true
end

function M:requst_building_lv_up(building_type, cb)
  local proto_name = "c2gs_building_up_level"
  local request = {type = building_type}
  local lv = math.min(self:get_building_level(building_type) + 1, ShareRes.get_building_max_level(building_type))
  Network:protect_call(proto_name, request, function(ok, response)
    if ok then
      if lv > 0 then
        local red_id = BUILDING_TYPE_TO_LEVEL_UP_RED[building_type]
        RedPointMgr:enable_dynamic_redpoint(lv, red_id, false)
      end
      if cb then
        cb(response)
      end
      MsgGame:mq_publish2(Const.MSG_ON_BUILDING_LEVEL_UP)
    end
  end)
end

function M:on_building_clue_list(data)
  self.v_clue_data_id_map = {}
  self.v_clue_data_count_map = {}
  for _, clue in pairs(data.clues) do
    self:add_clue_data(clue)
  end
  self:check_all_clue_is_expier(true)
  self:check_building_redpoint_by_type(CommonDefine.BUILDING_TYPE.ADVENTURE)
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_CLUE_DATA_UPDATE)
end

function M:on_building_clue_update(data)
  self:add_clue_data(data.clue)
  self:check_all_clue_is_expier(true)
  self:check_building_redpoint_by_type(CommonDefine.BUILDING_TYPE.ADVENTURE)
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_CLUE_DATA_UPDATE)
end

function M:add_clue_data(clue)
  self.v_clue_data_id_map[clue.id] = self.v_clue_data_id_map[clue.id] or {}
  self.v_clue_data_id_map[clue.id][clue.uuid] = clue
  self.v_clue_data_count_map[clue.id] = (self.v_clue_data_count_map[clue.id] or 0) + 1
  self.v_clue_data_uuid_map[clue.uuid] = clue
end

function M:on_building_clue_delete(data)
  for _, uuid in pairs(data.clue_list) do
    self:remove_clue_data(uuid)
  end
  MsgGame:mq_publish2(Const.MSG_ON_BUILDING_CLUE_DATA_UPDATE)
end

function M:remove_clue_data(uuid)
  local delete_cule = self.v_clue_data_uuid_map[uuid]
  if delete_cule then
    if self.v_clue_data_count_map[delete_cule.id] then
      self.v_clue_data_count_map[delete_cule.id] = self.v_clue_data_count_map[delete_cule.id] - 1
    end
    if self.v_clue_data_count_map[delete_cule.id] <= 0 then
      self.v_clue_data_id_map[delete_cule.id] = nil
    elseif self.v_clue_data_id_map[delete_cule.id] then
      self.v_clue_data_id_map[delete_cule.id][uuid] = nil
    end
    self.v_clue_data_uuid_map[uuid] = nil
  end
end

function M:get_clue_data_id_map()
  return self.v_clue_data_id_map
end

function M:get_clue_data_count(clue_id)
  return self.v_clue_data_count_map[clue_id] or 0
end

function M:get_all_clue_count()
  local total_count = 0
  for _, count in pairs(self.v_clue_data_count_map) do
    total_count = total_count + count
  end
  return total_count
end

function M:fill_select_clue_by_count(select_clue_map, count, temp_select_map)
  if count <= 0 then
    return
  end
  for uuid in pairs(self.v_clue_data_uuid_map) do
    if not temp_select_map[uuid] then
      select_clue_map[#select_clue_map + 1] = uuid
      temp_select_map[uuid] = true
      count = count - 1
      if count <= 0 then
        break
      end
    end
  end
end

function M:check_clue_is_expire(uuid)
  if not self.v_clue_data_uuid_map[uuid] then
    return
  end
  local cur_time = Date.server_time()
  local check_clue = self.v_clue_data_uuid_map[uuid]
  if cur_time >= check_clue.expire_time then
    self:remove_clue_data(uuid)
    return true
  end
  return false
end

function M:check_all_clue_is_expier(add_check_timer)
  local min_remain_time = 0
  local cur_time = Date.server_time()
  local remain_time
  local remove_suc = false
  for uuid, data in pairs(self.v_clue_data_uuid_map) do
    remain_time = data.expire_time - cur_time
    if remain_time <= 0 then
      remove_suc = true
      self:remove_clue_data(uuid)
    elseif add_check_timer then
      min_remain_time = math.max(min_remain_time, remain_time)
    end
  end
  if add_check_timer then
    if remove_suc then
      MsgGame:mq_publish2(Const.MSG_ON_BUILDING_CLUE_DATA_UPDATE)
    end
    self:remove_check_all_clue_expier_timer()
    if min_remain_time > 0 then
      self.v_check_all_clue_expier_timer = Timer:add_timer("check_all_clue_is_expier", min_remain_time + 1, self.check_all_clue_is_expier, self, add_check_timer)
    end
  end
end

function M:remove_check_all_clue_expier_timer()
  if self.v_check_all_clue_expier_timer then
    Timer:remove_timer(self.v_check_all_clue_expier_timer)
    self.v_check_all_clue_expier_timer = nil
  end
end

function M:set_select_clue_map(select_clue_map)
  self.v_select_clue_count_map = select_clue_map
end

function M:get_select_clue_map()
  return self.v_select_clue_count_map
end

function M:select_clue_map_to_use_clue_list(show_tips)
  self:check_all_clue_is_expier()
  local temp_list
  
  local function sort(a, b)
    if a.expire_time ~= b.expire_time then
      return a.expire_time < b.expire_time
    else
      return false
    end
  end
  
  local clue_list = {}
  local clue_count
  if self.v_select_clue_count_map then
    for clue_id, count in pairs(self.v_select_clue_count_map) do
      temp_list = {}
      clue_count = 0
      for key, clue_data in pairs(self.v_clue_data_id_map[clue_id]) do
        clue_count = clue_count + 1
        temp_list[#temp_list + 1] = clue_data
      end
      if count > clue_count and show_tips then
        Util.show_message_tip(2060)
        return
      else
        table.sort(temp_list, sort)
        for index = 1, count do
          clue_list[#clue_list + 1] = temp_list[index].uuid
        end
      end
    end
  end
  return clue_list
end

function M:get_select_clue_count()
  self:check_all_clue_is_expier()
  local clue_count = 0
  if self.v_select_clue_count_map then
    for _, count in pairs(self.v_select_clue_count_map) do
      clue_count = clue_count + count
    end
  end
  return clue_count
end

function M:on_adventrue_task_update()
  local building_data = self.v_building_data_map[CommonDefine.BUILDING_TYPE.ADVENTURE]
  if not building_data then
    return
  end
  self.v_dispatch_help_char_map = {}
  self.v_dispatch_char_map = {}
  local task_type, task_map
  for _, adventure_data in pairs(building_data.adventure_data_list) do
    task_type = adventure_data.type
    task_map = self.v_adventrue_task_map[task_type]
    if not task_map then
      self.v_adventrue_task_map[task_type] = {}
      task_map = self.v_adventrue_task_map[task_type]
    end
    for _, task_data in pairs(adventure_data.current_task_list) do
      task_map[task_data.index] = task_data
      self:_record_dispatch_char(task_data)
    end
    for _, task_data in pairs(adventure_data.history_task_list) do
      task_data.is_history = true
      task_map[task_data.index] = task_data
      self:_record_dispatch_char(task_data)
    end
  end
end

function M:get_adventrue_type_data(task_type)
  return self.v_adventrue_task_map[task_type]
end

function M:get_adventrue_task_data(task_type, task_index)
  return self.v_adventrue_task_map[task_type] and self.v_adventrue_task_map[task_type][task_index]
end

function M:_record_dispatch_char(task_data)
  if task_data.buddy_list then
    for _, buddy_data in pairs(task_data.buddy_list) do
      if not buddy_data.is_help_fight then
        self.v_dispatch_char_map[buddy_data.buddy_id] = true
      else
        local role_uuid = buddy_data.role_uuid .. buddy_data.buddy_id
        self.v_dispatch_help_char_map[tonumber(role_uuid)] = true
      end
    end
  end
end

function M:check_char_is_dispatch(id)
  return self.v_dispatch_char_map[id] ~= nil or nil ~= self.v_dispatch_help_char_map[id]
end

function M:get_help_char_count(id)
  return UtilTable.hash_lenth(self.v_dispatch_help_char_map[id])
end

function M:check_adventrue_task_can_get_award(task_type, task_index)
  local task_data = self:get_adventrue_task_data(task_type, task_index)
  if task_data and task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY then
    return self:check_adventrue_task_explore_time(task_data.id, task_data.explore_time)
  end
  return false
end

function M:check_adventrue_type_can_get_award(task_type)
  if self.v_adventrue_task_map and self.v_adventrue_task_map[task_type] then
    for key, task_data in pairs(self.v_adventrue_task_map[task_type]) do
      if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY and self:check_adventrue_task_explore_time(task_data.id, task_data.explore_time) then
        return true
      end
    end
  end
  return false
end

function M:get_task_type_in_progress(task_type)
  if self.v_adventrue_task_map and self.v_adventrue_task_map[task_type] then
    for key, task_data in pairs(self.v_adventrue_task_map[task_type]) do
      if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY then
        return true
      end
    end
  end
  return false
end

function M:check_adventrue_type_have_red(task_type)
  if self.v_adventrue_task_map and self.v_adventrue_task_map[task_type] then
    for key, task_data in pairs(self.v_adventrue_task_map[task_type]) do
      if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.INIT then
        if task_type == BUILDING_DISPATCH_TASK_TYPE.SPECIAL then
          if self:check_local_storage_redpoint(task_data.id .. "first") then
            return true
          end
          local type_cfg = ShareRes.get_building_adventure_type(task_type)
          if type_cfg.ClueCount <= self:get_all_clue_count() and self:check_local_storage_redpoint(task_data.id .. "enough") then
            return true
          end
        elseif task_type == BUILDING_DISPATCH_TASK_TYPE.BRANCH and self:check_local_storage_redpoint(task_data.id) then
          return true
        end
      elseif task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY and self:check_adventrue_task_explore_time(task_data.id, task_data.explore_time) then
        return true
      end
    end
  end
  return false
end

function M:check_adventrue_type_can_accept(task_type)
  if self.v_adventrue_task_map and self.v_adventrue_task_map[task_type] then
    for key, task_data in pairs(self.v_adventrue_task_map[task_type]) do
      if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.INIT then
        return true
      end
    end
  end
  return false
end

function M:check_adventrue_can_get_award()
  for _, task_type in pairs(BUILDING_DISPATCH_TASK_TYPE) do
    if self:check_adventrue_type_can_get_award(task_type) then
      return true
    end
  end
  return false
end

function M:check_adventrue_task_explore_time(task_id, start_time)
  local explore_time
  local cur_time = Date.server_time()
  local task_quality_cfg = ShareRes.get_adventrue_task_quality_cfg_by_task_id(task_id)
  if task_quality_cfg then
    explore_time = task_quality_cfg.Time * ONE_HOUR_SECONDS
    return nil ~= start_time and explore_time <= cur_time - start_time
  else
    Log.Error("获取派遣任务品质配置失败， 任务id", task_id, debug.traceback())
    return false
  end
end

function M:check_adventrue_team_limit(task_id, char_list, show_tips)
  local cfg = ShareRes.get_adventrue_task_cfg(task_id)
  if cfg then
    if not self:_check_advantrue_buddy_count(cfg.Quality, char_list, show_tips) then
      return false
    end
    if not self:_check_advantrue_buddy_limit(cfg.TeamLimitId, char_list, show_tips) then
      return false
    end
    return true
  else
    Log.Error("获取派遣任务配置失败， 派遣任务id：", task_id, debug.traceback())
  end
  return false
end

function M:_check_advantrue_buddy_count(quality, char_list, show_tips)
  local quality_cfg = ShareRes.get_adventrue_task_quality_cfg(quality)
  if quality_cfg then
    local misc_cfg = ShareRes.get_building_misc_cfg()
    local buddy_count = 0
    local help_count = 0
    for _, data in pairs(char_list) do
      buddy_count = buddy_count + 1
      if data.help_buddy_element_id then
        help_count = help_count + 1
      end
    end
    if help_count + BuildingMgr:get_help_char_count() > misc_cfg.BorrowCount then
      if show_tips then
        Util.show_message_tip(2061)
      end
      return false
    end
    if buddy_count < quality_cfg.BuddyCount then
      if show_tips then
        Util.show_message_tip(2062)
      end
      return false
    end
    return true
  end
  return false
end

function M:_check_advantrue_buddy_limit(team_limit_id_list, char_list, show_tips)
  if team_limit_id_list then
    for _, limit_id in pairs(team_limit_id_list) do
      if limit_id > 0 then
        local limit_cfg = ShareRes.get_building_buddy_limit_cfg(limit_id)
        if limit_cfg then
          local compare_map = {}
          for _, data in ipairs(char_list) do
            local buddy_cfg = ShareRes.get_buddy_cfg(data.buddy_id)
            if limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_ID then
              compare_map[data.buddy_id] = (compare_map[data.buddy_id] or 0) + 1
            elseif limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_ELEMENT then
              compare_map[buddy_cfg.Element] = (compare_map[buddy_cfg.Element] or 0) + 1
            elseif limit_cfg.Type == CommonDefine.BUILDING_BUDDY_LIMIT.BUDDY_JOB then
              compare_map[buddy_cfg.Job] = (compare_map[buddy_cfg.Job] or 0) + 1
            end
          end
          if not _check_adventrue_team_limit(limit_cfg, compare_map, show_tips) then
            return false
          end
        else
          Log.Error("获取上阵限制配置失败， id：", limit_id, debug.traceback())
        end
      end
    end
  end
  return true
end

function M:record_adventrue_task_award(data)
  self.v_adventrue_task_award_data = data
end

function M:try_show_adventrue_task_award()
  if UtilTable.is_empty(self.v_adventrue_task_award_data) then
    return
  end
  UIMgr:get_ui("award_show_panel"):ui_show(self.v_adventrue_task_award_data)
end

function M:record_adventrue_clue_select(task_type, task_index, clue_id)
  local clue_select = self:get_local_storage(ADVENTRUE_CLUE_SELECT_KEY) or {}
  local select_data = clue_select[task_type] or {}
  select_data[task_index] = clue_id
  clue_select[task_type] = select_data
  self:save_local_storage(ADVENTRUE_CLUE_SELECT_KEY, clue_select)
end

function M:get_adventrue_clue_select(task_type, task_index)
  local task_data = self:get_adventrue_task_data(task_type, task_index)
  if task_data and task_data.state ~= CommonDefine.ADVENTURE_TASK_STATE.INIT then
    return task_data.target_clue_id
  end
  local clue_select = self:get_local_storage(ADVENTRUE_CLUE_SELECT_KEY)
  local select_data = clue_select and clue_select[task_type]
  return select_data and select_data[task_index] or nil
end

function M:get_local_storage(key)
  return self.v_building_local_storage_data[key]
end

function M:save_local_storage(key, value)
  self.v_building_local_storage_data[key] = value
  LocalStorage:save_table(BUILDING_LOCAL_STORAGE_DATA, self.v_building_local_storage_data, true)
end

function M:load_local_storage()
  self.v_building_local_storage_data = LocalStorage:load_table(BUILDING_LOCAL_STORAGE_DATA, true)
  if not self.v_building_local_storage_data then
    self.v_building_local_storage_data = {}
    return
  end
end

function M:check_local_storage_redpoint(redpoint_key)
  local redpoint_map = self:get_local_storage(BUILDING_LOCAL_REDPOINT)
  return not redpoint_map or nil == redpoint_map[redpoint_key]
end

function M:close_local_storage_redpoint(redpoint_key)
  if self:check_local_storage_redpoint(redpoint_key) then
    local redpoint_map = self:get_local_storage(BUILDING_LOCAL_REDPOINT) or {}
    redpoint_map[redpoint_key] = 1
    self:save_local_storage(BUILDING_LOCAL_REDPOINT, redpoint_map)
  end
end

function M:try_show_adventrue_task_award()
  if UtilTable.is_empty(self.v_adventrue_task_award_data) then
    return
  end
  UIMgr:get_ui("award_show_panel"):ui_show(self.v_adventrue_task_award_data)
end

function M:get_branch_next_refresh_time()
  local building_data = self.v_building_data_map[CommonDefine.BUILDING_TYPE.ADVENTURE]
  if not building_data or not building_data.adventure_data_list then
    return
  end
  for _, adventure_data in pairs(building_data.adventure_data_list) do
    if adventure_data.type == BUILDING_DISPATCH_TASK_TYPE.BRANCH then
      return adventure_data.next_refresh_time
    end
  end
end

function M:get_task_count_by_type(task_type)
  local receive_count, can_get_award_count, total_count = 0, 0, 0
  local task_map = self.v_adventrue_task_map[task_type]
  if task_map then
    for _, task_data in pairs(task_map) do
      if task_data.state == CommonDefine.ADVENTURE_TASK_STATE.INIT then
        receive_count = receive_count + 1
      elseif task_data.state == CommonDefine.ADVENTURE_TASK_STATE.UNDER_WAY and self:check_adventrue_task_explore_time(task_data.id, task_data.explore_time) then
        can_get_award_count = can_get_award_count + 1
      end
      total_count = total_count + 1
    end
  end
  return receive_count, can_get_award_count, total_count
end

local designated_role_map, designated_element_map, designated_job_map, weight_list, target_clue_id

local function _char_list_sort_func(a, b)
  local a_cfg, b_cfg = ShareRes.get_buddy_cfg(a.id), ShareRes.get_buddy_cfg(b.id)
  local a_used, b_used = BuildingMgr:check_char_is_dispatch(a.id), BuildingMgr:check_char_is_dispatch(b.id)
  if a_used ~= b_used then
    return not a_used
  end
  local v1 = designated_role_map[a.id] or designated_element_map[a_cfg.Element] or designated_job_map[a_cfg.Job] or 0
  local v2 = designated_role_map[b.id] or designated_element_map[b_cfg.Element] or designated_job_map[b_cfg.Job] or 0
  local w1, w2 = 0, 0
  if target_clue_id then
    local a_btc_cfg = ShareRes.get_building_buddy_to_clue_cfg(a.id)
    local b_btc_cfg = ShareRes.get_building_buddy_to_clue_cfg(b.id)
    w1 = a_btc_cfg and a_btc_cfg[target_clue_id] and weight_list[a_cfg.Quality] or 0
    w2 = b_btc_cfg and b_btc_cfg[target_clue_id] and weight_list[b_cfg.Quality] or 0
  end
  if v1 ~= v2 then
    return v1 > v2
  end
  if w1 ~= w2 then
    return w1 > w2
  end
  if a_cfg.Quality ~= b_cfg.Quality then
    return a_cfg.Quality > b_cfg.Quality
  end
  if a_cfg.Element ~= b_cfg.Element then
    return a_cfg.Element < b_cfg.Element
  end
  return a.id > b.id
end

function M:get_sort_char_list_by_task_id(task_id, clue_id, is_assist, buddy_list, check_dispatched)
  local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
  if task_cfg then
    local misc_cfg = ShareRes.get_building_misc_cfg()
    weight_list = misc_cfg.AddWeight
    target_clue_id = clue_id
    designated_role_map, designated_element_map, designated_job_map = {}, {}, {}
    local limit_info = task_cfg.LimitInfo
    if limit_info then
      if limit_info.BuddyLimit then
        for buddy_id in pairs(limit_info.BuddyLimit) do
          designated_role_map[buddy_id] = 3
        end
      end
      if limit_info.ElementLimit then
        for element_id in pairs(limit_info.ElementLimit) do
          designated_element_map[element_id] = 2
        end
      end
      if limit_info.JobLimit then
        for job_id in pairs(limit_info.JobLimit) do
          designated_job_map[job_id] = 1
        end
      end
    end
    local temp_show_list = buddy_list or is_assist and AssistMgr:get_buddy_list(true) or CharacterMgr:get_buddy_list_show()
    local show_list = {}
    UtilTable.list_walk(temp_show_list, function(_, value)
      if is_assist and not value.uuid then
        return
      end
      local need_insert = true
      if check_dispatched then
        local check_key = is_assist and value.uuid .. value.id or value.id
        need_insert = not self:check_char_is_dispatch(check_key)
      end
      if need_insert then
        show_list[#show_list + 1] = {
          id = value.id,
          uuid = value.uuid,
          index = value.index,
          element = value.element
        }
      end
    end)
    table.sort(show_list, _char_list_sort_func)
    return show_list
  end
end

function M:requst_adventure_accept_task(task_type, index, buddy_list, using_clue_ids, target_clue_id, cb)
  local proto_name = "c2gs_building_adventure_accept_task"
  local request = {
    type = task_type,
    index = index,
    buddy_list = buddy_list,
    using_clue_ids = using_clue_ids,
    target_clue_id = target_clue_id
  }
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_adventure_gain_task_reward(task_type, index, is_history, cb)
  local proto_name = "c2gs_building_adventure_gain_task_reward"
  local request = {
    type = task_type,
    index = index,
    is_history = is_history
  }
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_building_adventure_task_flush(task_type, index, cb)
  local proto_name = "c2gs_building_adventure_task_flush"
  local request = {type = task_type, index = index}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_building_adventure_batch_accept_task(task_list, cb)
  local proto_name = "c2gs_building_adventure_batch_accept_task"
  local request = {task_list = task_list}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_building_batch_adventure_gain_task_reward(task_type, cb)
  local proto_name = "c2gs_building_batch_adventure_gain_task_reward"
  local request = {}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:get_factory_data(factory_id)
  local data = self:get_building_data(CommonDefine.BUILDING_TYPE.FACTORY)
  return data and data.factory_list[factory_id]
end

function M:get_factory_start_time(factory_id)
  local data = self:get_factory_data(factory_id)
  return data and data.start_time
end

function M:get_factory_is_in_product(factory_id)
  local data = self:get_factory_data(factory_id)
  return Util.is_more_than_zero(data.material_id)
end

function M:factory_room_can_recive(factory_id)
  local level_info = self:get_factory_material_level_info(factory_id)
  if not level_info then
    return false
  end
  local time_unit = level_info.TimeUnit
  return Date.server_time() - self:get_factory_start_time(factory_id) >= time_unit * 60
end

function M:factory_is_full(factory_id)
  local cur_count = self:cal_factory_material_count(factory_id)
  local level_info = self:get_factory_material_level_info(factory_id)
  if not level_info then
    return false
  end
  local max_count = level_info.Capacity
  return cur_count >= max_count
end

function M:check_has_factory_is_full()
  local data = self:get_building_data(CommonDefine.BUILDING_TYPE.FACTORY)
  if not data then
    return false
  end
  for factory_id in pairs(data.factory_list) do
    if self:factory_is_full(factory_id) then
      return true
    end
  end
  return false
end

function M:cal_factory_material_count(factory_id, minute_fill)
  local building_type = CommonDefine.BUILDING_TYPE.FACTORY
  local building_data = self.v_building_data_map[building_type]
  local factory_data = building_data and building_data.factory_list and building_data.factory_list[factory_id]
  if not factory_data then
    return 0
  end
  local level_info = self:get_factory_material_level_info(factory_id)
  if not level_info then
    return 0
  end
  local normal_speed = level_info.SpeedUnit
  local end_time = Date.server_time()
  local start_time = factory_data.start_time
  local result_count, progress = self:cal_single_factory_material_count(start_time, end_time, normal_speed, level_info.TimeUnit, minute_fill)
  result_count = math.min(level_info.Capacity, result_count)
  return result_count, progress
end

function M:cal_for_a_while_factory_material_count(factory_id, end_time)
  local building_type = CommonDefine.BUILDING_TYPE.FACTORY
  local building_data = self.v_building_data_map[building_type]
  local factory_data = building_data and building_data.factory_list and building_data.factory_list[factory_id]
  if not factory_data then
    return 0
  end
  local level_info = self:get_factory_material_level_info(factory_id)
  if not level_info then
    return 0
  end
  local normal_speed = level_info.SpeedUnit
  local start_time = factory_data.start_time
  local result_count = self:cal_single_factory_material_count(start_time, end_time, normal_speed, level_info.TimeUnit)
  return math.min(level_info.Capacity, result_count)
end

function M:cal_single_factory_material_count(start_time, end_time, normal_speed, time_unit, minute_fill)
  local total_factory_time = end_time - start_time
  local _, unit_count = Math.get_almost_intger(time_unit * normal_speed)
  local suc, result = Math.get_almost_intger(total_factory_time / 60 * normal_speed)
  local intger, float, result_count, result_progress
  if suc then
    intger, float = result, 0
  else
    intger, float = math.modf(result)
  end
  local remainder = intger % unit_count
  result_count = intger - remainder
  result_progress = remainder + float
  return result_count, result_progress
end

function M:get_fill_factory_slot_time(factory_id)
  local level_info = self:get_factory_material_level_info(factory_id)
  local fill_time = 0
  if not level_info then
    return fill_time
  end
  local cur_factory_count, progress = self:cal_factory_material_count(factory_id)
  cur_factory_count = cur_factory_count + progress
  local need_fill_count = level_info.Capacity - cur_factory_count
  if need_fill_count <= 0 then
    return fill_time
  end
  local time_unit = level_info.TimeUnit * 60
  local total_fill_time = level_info.Capacity / level_info.SpeedUnit * 60
  local intger, float = math.modf(total_fill_time / time_unit)
  total_fill_time = (Util.almost_zero(float) and intger or intger + 1) * time_unit
  fill_time = fill_time + (total_fill_time - cur_factory_count / level_info.SpeedUnit * 60)
  return math.floor(fill_time)
end

function M:get_max_use_fast_count(factory_id)
  local level_info = self:get_factory_material_level_info(factory_id)
  if not level_info then
    return 0
  end
  local cur_factory_count, progress = self:cal_factory_material_count(factory_id)
  cur_factory_count = cur_factory_count + progress
  local remain_count = level_info.Capacity - cur_factory_count
  local one_fast_factory_count = level_info.SpeedUnit * level_info.SpeedUpDuration * 60
  local use_count = math.ceil(remain_count / one_fast_factory_count)
  return use_count
end

function M:get_factory_material_level_info(factory_id)
  local building_data = self.v_building_data_map[CommonDefine.BUILDING_TYPE.FACTORY]
  local factory_data = building_data and building_data.factory_list and building_data.factory_list[factory_id]
  if factory_data then
    local material_id = factory_data.material_id
    if Util.is_more_than_zero(material_id) then
      local material_cfg = ShareRes.get_factory_material_cfg(material_id)
      local level = math.min(building_data.level, material_cfg.MaxLevelInfo.Level)
      return material_cfg.LevelInfo[level]
    end
  end
end

function M:requst_factory_working(id, material_id, cb)
  local proto_name = "c2gs_building_factory_working"
  local request = {id = id, material_id = material_id}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_factory_fast(id, fast_count, cb)
  local proto_name = "c2gs_building_factory_fast"
  local request = {id = id, fast_count = fast_count}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_factory_gain_award(id, cb)
  local proto_name = "c2gs_building_factory_gain_award"
  local request = {id = id}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:requst_factory_change_material(id, material_id, cb)
  local proto_name = "c2gs_building_factory_change_material"
  local request = {id = id, material_id = material_id}
  Network:protect_call(proto_name, request, function(ok, response)
    if ok and cb then
      cb(response)
    end
  end)
end

function M:get_replace_item_combine_id(combine_id)
  local cfgs = ShareRes.get_building_combine_cfg(combine_id)
  if cfgs then
    local building_level = self:get_building_level(CommonDefine.BUILDING_TYPE.COMBINE)
    if cfgs[building_level] then
      return cfgs[building_level].AfterRepleceId
    end
  end
end

function M:open_building_scene(load_done_cb)
  if not self.v_building_scene_mgr then
    local clz = "gamelogic.building.building_scene_mgr"
    local cls_obj = require(clz):new("BuildingSceneMgr")
    cls_obj:init_sys()
    self.v_building_scene_mgr = cls_obj
    self.v_building_scene_mgr:on_init_sys()
    self.v_building_scene_mgr:set_can_update(false)
  end
  self.v_building_scene_mgr:create_build_scene(load_done_cb)
end

function M:release_building_scene()
  if self.v_building_scene_mgr then
    self.v_building_scene_mgr:on_destroy()
    self.v_building_scene_mgr = nil
  end
end

function M:get_building_scene_obj(obj_name)
  if self.v_building_scene_mgr then
    return self.v_building_scene_mgr:get_building_scene_obj(obj_name)
  end
end

function M:get_ui_binding_pos_map()
  if self.v_building_scene_mgr then
    return self.v_building_scene_mgr:get_ui_binding_pos_map()
  end
end

function M:get_building_scene_camera()
  if self.v_building_scene_mgr then
    return self.v_building_scene_mgr:get_building_scene_camera()
  end
end

function M:set_scene_visible(visible)
  if self.v_building_scene_mgr then
    self.v_building_scene_mgr:set_scene_visible(visible)
    if not visible then
      local scene_effect_obj = UnityFind("SceneEffect")
      if not scene_effect_obj then
        return
      end
      local scene_illumination = scene_effect_obj:GetComponent(typeof(CS.SceneIllumination))
      CS.SceneIllumination.Instance = scene_illumination
      scene_illumination:ApplySceneEffect()
    end
    UnityEngine.QualitySettings.shadowDistance = visible and 300 or 150
  end
end

function M:GM_REFRESH_ui_binding_pos_map()
  if self.v_building_scene_mgr then
    self.v_building_scene_mgr:GM_REFRESH_ui_binding_pos_map()
  end
end

return M
