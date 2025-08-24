local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local TYPE_TO_MAP_NAME = {
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EVENT] = "v_illustrated_event_map",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT] = "v_illustrated_ability_map",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.ORNAMENT] = "v_illustrated_ornament_map",
  [Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.EQUATION] = "v_illustrated_equation_map"
}
local POINT_STATE_ENUM = {OPEN = 1, CLOSE = 2}
M.START_STEP_NAME = {
  CHECK_INTIAL_EQUATION = "CHECK_INTIAL_EQUATION",
  CHECK_EQUATION_OPERATION = "CHECK_EQUATION_OPERATION",
  CHECK_INTIAL_OPTION = "CHECK_INTIAL_OPTION",
  CHECK_OPTION_OPERATION = "CHECK_OPTION_OPERATION",
  OPEN_FATE_BOOK_VIEW = "OPEN_FATE_BOOK_VIEW"
}
M.START_STEP = {
  [M.START_STEP_NAME.CHECK_INTIAL_EQUATION] = 1,
  [M.START_STEP_NAME.CHECK_EQUATION_OPERATION] = 2,
  [M.START_STEP_NAME.CHECK_INTIAL_OPTION] = 3,
  [M.START_STEP_NAME.CHECK_OPTION_OPERATION] = 4,
  [M.START_STEP_NAME.OPEN_FATE_BOOK_VIEW] = 5
}
M.START_STEP_FUNC_MAP = {
  [M.START_STEP[M.START_STEP_NAME.CHECK_INTIAL_EQUATION]] = "check_intial_equation",
  [M.START_STEP[M.START_STEP_NAME.CHECK_EQUATION_OPERATION]] = "check_equation_operation",
  [M.START_STEP[M.START_STEP_NAME.CHECK_INTIAL_OPTION]] = "check_intial_option",
  [M.START_STEP[M.START_STEP_NAME.CHECK_OPTION_OPERATION]] = "check_option_operation",
  [M.START_STEP[M.START_STEP_NAME.OPEN_FATE_BOOK_VIEW]] = "open_fate_book_view"
}

function M:init_sys()
  Base.init_sys(self)
  self:reset_map()
  self.v_curse_chapter_map = {}
  self.v_curse_node_map = {}
  self.v_curse_condition_map = {}
  self.v_equation_data_map = {}
  self.v_equation_drop_data_queue = {}
  self:load_redpoint_info()
  self:check_illustrated_redpoint()
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.check_curse_course_is_red, self)
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.check_illustrated_redpoint, self)
  self:sys_mq_bind(Const.MSG_ON_FATE_BOOK_CHECK_NEXT_START_STEP, self.check_next_start_step, self)
  self:reset_start_step_data()
end

function M:exit_tower()
  self.v_curse_options_data = nil
  self.v_equation_data_map = {}
  self.v_equation_drop_data_queue = {}
  self.v_temp_select_equation = nil
  self:reset_start_step_data()
end

function M:reset_map()
  for key, map_name in pairs(TYPE_TO_MAP_NAME) do
    self[map_name] = {}
  end
end

function M:reset_start_step_data()
  self.v_start_step_suc_data = {}
  self.v_cur_start_step_id = 1
  for _, step_num in pairs(M.START_STEP) do
    self.v_start_step_suc_data[step_num] = false
  end
end

function M:check_next_start_step()
  if self.v_start_step_suc_data[self.v_cur_start_step_id] == false then
    local wait_step_suc = false
    while not wait_step_suc do
      local func_name = M.START_STEP_FUNC_MAP[self.v_cur_start_step_id]
      if func_name then
        wait_step_suc = self[func_name](self)
      else
        Log.Error("获取环初始化方法失败, 错误的步骤：", self.v_cur_start_step_id, debug.traceback())
        return
      end
    end
  end
end

function M:check_intial_equation()
  if self:check_equation_dorp_data() then
    return true
  end
  self:set_step_suc(M.START_STEP[M.START_STEP_NAME.CHECK_INTIAL_EQUATION])
end

function M:check_equation_operation()
  if self.v_equation_drop_data_queue[1] and self.v_have_start_equation_drop then
    return true
  end
  self:set_step_suc(M.START_STEP[M.START_STEP_NAME.CHECK_EQUATION_OPERATION])
end

function M:check_curse_options_in_continue_tower()
  local data = self.v_curse_options_data
  if not data or not data.is_open then
    return
  end
  if not Util.is_more_than_zero(data.choose_options_id) then
    UIMgr:try_show_ui("fate_book_initial_option")
    return
  end
  local choose_data = data.ability_drop_data and data.ability_drop_data.ability_drop
  if not UtilTable.is_empty(choose_data) then
    local copy_data = UtilTable.copy_table(self.v_curse_options_data)
    copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.OPTION_ABILITY
    copy_data.uuid = data.ability_drop_data.uuid
    ChallengeRingPlusMgr:drop_award_data_enqueue(copy_data)
    ChallengeRingPlusMgr:try_choose_drop_award()
    return
  end
  choose_data = data.ornaments_drop_data and data.ornaments_drop_data.choose_ornamets
  if not UtilTable.is_empty(choose_data) and not data.ornaments_drop_data.is_finish then
    local copy_data = UtilTable.copy_table(self.v_curse_options_data)
    copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.OPTION_ORNAMENT
    copy_data.uuid = data.ornaments_drop_data.uuid
    ChallengeRingPlusMgr:drop_award_data_enqueue(copy_data)
    ChallengeRingPlusMgr:try_choose_drop_award()
    return
  end
end

function M:check_intial_option()
  if self:check_need_select_curse_options() and not Util.is_more_than_zero(self.v_curse_options_data.choose_options_id) then
    UIMgr:try_show_ui("fate_book_initial_option")
    return true
  end
  self:set_step_suc(M.START_STEP[M.START_STEP_NAME.CHECK_INTIAL_OPTION])
end

function M:check_option_operation()
  local data = self.v_curse_options_data
  if self:check_need_select_curse_options() then
    local choose_data = data.ability_drop_data and data.ability_drop_data.ability_drop
    if not UtilTable.is_empty(choose_data) then
      local copy_data = UtilTable.copy_table(self.v_curse_options_data)
      copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.OPTION_ABILITY
      copy_data.uuid = data.ability_drop_data.uuid
      ChallengeRingPlusMgr:drop_award_data_enqueue(copy_data)
      ChallengeRingPlusMgr:try_choose_drop_award()
      return true
    end
    choose_data = data.ornaments_drop_data and data.ornaments_drop_data.choose_ornamets
    if not UtilTable.is_empty(choose_data) and not data.ornaments_drop_data.is_finish then
      local copy_data = UtilTable.copy_table(self.v_curse_options_data)
      copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.OPTION_ORNAMENT
      copy_data.uuid = data.ornaments_drop_data.uuid
      ChallengeRingPlusMgr:drop_award_data_enqueue(copy_data)
      ChallengeRingPlusMgr:try_choose_drop_award()
      return true
    end
  end
  self:set_step_suc(M.START_STEP[M.START_STEP_NAME.CHECK_OPTION_OPERATION])
end

function M:open_fate_book_view()
  UIMgr:get_ui("challenge_ring_plus"):ui_show()
  self:set_step_suc(M.START_STEP[M.START_STEP_NAME.OPEN_FATE_BOOK_VIEW])
  return true
end

function M:set_step_suc(step_id)
  self.v_start_step_suc_data[step_id] = true
  self.v_cur_start_step_id = step_id + 1
end

function M:on_curse_illustrated_list(data)
  self:reset_map()
  for k, illustrated in pairs(data.illustrateds) do
    self:update_illustrated_data(illustrated)
  end
  self:save_redpoint_info()
  self:check_illustrated_redpoint()
end

function M:on_curse_illustrated_update(data)
  local illustrated = data.illustrated
  self:update_illustrated_data(illustrated)
  self:save_redpoint_info()
  self:check_illustrated_redpoint()
end

function M:update_illustrated_data(illustrated)
  local map_name, map
  map_name = TYPE_TO_MAP_NAME[illustrated.type]
  self[map_name] = self[map_name] or {}
  map = self[map_name]
  for key, id in pairs(illustrated.id_list) do
    map[id] = true
  end
end

function M:get_illustrated_data(map_type)
  local map_name = TYPE_TO_MAP_NAME[map_type]
  if map_name then
    return self[map_name]
  end
end

function M:check_illustrated_is_unlock(map_type, id)
  local map_name = TYPE_TO_MAP_NAME[map_type]
  if map_name then
    return self[map_name] and self[map_name][id]
  end
  return false
end

function M:on_curse_chapter_list(data)
  for key, chapter_data in pairs(data.curse_chapter_list) do
    self:update_curse_chapter_date(chapter_data)
  end
  self:check_curse_course_is_red()
end

function M:on_curse_chapter_update(data)
  self:update_curse_chapter_date(data.curse_chapter)
  self:check_curse_course_is_red()
end

function M:update_curse_chapter_date(chapter_data)
  local node_map
  local chapter_id = chapter_data.chapter_id
  self.v_curse_chapter_map[chapter_id] = self.v_curse_chapter_map[chapter_id] or {}
  node_map = self.v_curse_chapter_map[chapter_id]
  for key, node_id in pairs(chapter_data.node_list) do
    node_map[node_id] = true
    self.v_curse_node_map[node_id] = true
  end
  for key, condition in pairs(chapter_data.condition_list) do
    self.v_curse_condition_map[condition] = true
  end
end

function M:on_curse_options_data(data)
  self.v_curse_options_data = data
end

function M:check_need_select_curse_options()
  local data = self.v_curse_options_data
  return nil ~= data and data.is_open
end

function M:get_curse_options_group_id()
  local data = self.v_curse_options_data
  return data and data.options_group_id
end

function M:get_curse_node_completed_count()
  local cfg
  local count = 0
  for node_id, value in pairs(self.v_curse_node_map) do
    cfg = ShareRes.get_curse_course_node_cfg(node_id)
    if TaskMgr:check_task_received(cfg.TaskId) then
      count = count + 1
    end
  end
  return count
end

function M:check_curse_chpater_is_unlock(curse_chpater_id)
  return self.v_curse_chapter_map[curse_chpater_id] ~= nil
end

function M:check_curse_node_is_unlock(curse_node_id)
  return self.v_curse_node_map[curse_node_id] ~= nil
end

function M:check_course_condition_pass(condition)
  return self.v_curse_condition_map[condition] ~= nil
end

function M:check_curse_chpater_is_red(curse_chpater_id)
  local chapter_data = self.v_curse_chapter_map[curse_chpater_id]
  local node_cfg
  if chapter_data then
    for node_id, is_unlock in pairs(chapter_data) do
      node_cfg = ShareRes.get_curse_course_node_cfg(node_id)
      if not self:check_curse_node_is_unlock(node_id) then
        for key, condition in pairs(node_cfg.Condition) do
          if not self:check_course_condition_pass(condition) then
            return false
          end
        end
      end
      if TaskMgr:check_task_can_receive(node_cfg.TaskId) then
        return true
      end
    end
  end
  return false
end

function M:check_curse_course_is_red()
  local node_cfg
  for chapter_id, chapter_data in pairs(self.v_curse_chapter_map) do
    for node_id, is_unlock in pairs(chapter_data) do
      node_cfg = ShareRes.get_curse_course_node_cfg(node_id)
      if not self:check_curse_node_is_unlock(node_id) then
        for key, condition in pairs(node_cfg.Condition) do
          if not self:check_course_condition_pass(condition) then
            break
          end
        end
      end
      if TaskMgr:check_task_can_receive(node_cfg.TaskId) then
        RedPointMgr:enable_redpoint(RedEnum.CURSE_COURSE_ENTER, true)
        return
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CURSE_COURSE_ENTER, false)
end

function M:check_illustrated_redpoint()
  local map, red_map, task_group_id
  for map_type, map_name in pairs(TYPE_TO_MAP_NAME) do
    map = self[map_name]
    if map then
      for id, value in pairs(map) do
        red_map = self.v_redpoint_state_map[map_name]
        if red_map and red_map[id] and not red_map[id] then
          RedPointMgr:enable_redpoint(RedEnum.CURSE_ILLUSTRATED_ENTER, true)
          return
        end
      end
      task_group_id = ShareRes.get_curse_illustrated_task_group_by_type_id(map_type)
      if TaskMgr:get_task_group_red(task_group_id) then
        RedPointMgr:enable_redpoint(RedEnum.CURSE_ILLUSTRATED_ENTER, true)
        return
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CURSE_ILLUSTRATED_ENTER, false)
end

function M:get_red_state(map_type, id)
  local map_name = self:get_map_name(map_type)
  if not map_name then
    return
  end
  local map = self[map_name]
  local state_map = self.v_redpoint_state_map[map_name]
  return (nil == state_map or nil == state_map[id]) and true == map[id]
end

function M:close_redpoint(map_type, id, is_save)
  local map_name = self:get_map_name(map_type)
  if not map_name then
    return
  end
  local map = self.v_redpoint_state_map[map_name]
  if map and not map[id] then
    map[id] = POINT_STATE_ENUM.CLOSE
    if is_save then
      self:save_redpoint_info()
      self:check_illustrated_redpoint()
    end
  end
end

function M:get_map_name(map_type)
  local map_name = TYPE_TO_MAP_NAME[map_type]
  if not map_name then
    Log.Error("图鉴类型传入错误", debug.traceback())
    return
  end
  return map_name
end

function M:save_redpoint_info()
  LocalStorage:save_table(Config.ILLUSTRATED_REDPOINT_KEY, self.v_redpoint_state_map, true)
end

function M:load_redpoint_info()
  self.v_redpoint_state_map = LocalStorage:load_table(Config.ILLUSTRATED_REDPOINT_KEY, true)
  if not self.v_redpoint_state_map then
    self.v_redpoint_state_map = {}
    for key, map_name in pairs(TYPE_TO_MAP_NAME) do
      self.v_redpoint_state_map[map_name] = {}
    end
    self:save_redpoint_info()
  end
end

function M:request_set_options_id(option_id, cb)
  Network:protect_call("c2gs_curse_set_options_id", {id = option_id}, function(ok, resp)
    if ok then
      if cb then
        cb(resp)
      end
      self:set_step_suc(M.START_STEP[M.START_STEP_NAME.CHECK_INTIAL_OPTION])
      MsgGame:mq_publish2(Const.MSG_ON_FATE_BOOK_CHECK_NEXT_START_STEP)
      if TowerMgr:check_continue_tower() then
        self:check_curse_options_in_continue_tower()
      end
    end
  end)
end

function M:set_last_type_select_group_and_point(group_data, point_data)
  self.v_last_type_select_group = group_data
  self.v_last_type_select_point = point_data
end

function M:get_last_type_select_group_and_point()
  return self.v_last_type_select_group, self.v_last_type_select_point
end

function M:on_curse_equation_list(data)
  self.v_equation_data_map = {}
  for _, equation in pairs(data.equations) do
    self:check_need_select_branch(equation, true)
    self.v_equation_data_map[equation.id] = equation
  end
  local has_drop
  for _, drop_data in pairs(data.equation_drops) do
    drop_data.operation_type = curse_com_def.EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION
    self:enqueue_equation_drop_data(drop_data)
    has_drop = true
  end
  if has_drop then
    local is_in_start = ChallengeRingPlusMgr:is_in_start_room() and (not TowerMgr:check_continue_tower() or not TowerMgr:is_fight_end())
    if is_in_start then
      self.v_have_start_equation_drop = true
    else
      self:check_equation_dorp_data()
    end
  end
end

function M:on_curse_equation_update(data)
  local equation = data.equation
  self:check_need_select_branch(equation)
  self.v_equation_data_map[equation.id] = equation
end

function M:check_need_select_branch(equation, skip_pop)
  local equation_id = equation.id
  local copy_data
  local is_temp_select = self.v_temp_select_equation and self.v_temp_select_equation[equation_id]
  local can_pop = not skip_pop and not is_temp_select
  if not self.v_equation_data_map[equation_id] and can_pop then
    copy_data = UtilTable.copy_table(equation)
    copy_data.operation_type = curse_com_def.EQUATION_OPERATION_TYPE.SHOW_GET_EQUATION
  elseif self:get_equation_level(equation_id) < equation.level then
    if 1 == equation.level and 0 == equation.branch_id then
      copy_data = UtilTable.copy_table(equation)
      copy_data.operation_type = curse_com_def.EQUATION_OPERATION_TYPE.CHOOSE_BRANCH_ACTIVE
    elseif can_pop then
      copy_data = UtilTable.copy_table(equation)
      copy_data.operation_type = curse_com_def.EQUATION_OPERATION_TYPE.SHOW_BRANCH_LEVEL_UP
    end
  end
  if is_temp_select then
    self.v_temp_select_equation[equation_id] = nil
  end
  if copy_data then
    self:enqueue_equation_drop_data(copy_data)
    self:check_equation_dorp_data()
  end
end

function M:on_curse_equation_drop_update(data)
  local drop_data = data.equation_drop
  drop_data.operation_type = curse_com_def.EQUATION_OPERATION_TYPE.CHOOSE_DROP_EQUATION
  self:enqueue_equation_drop_data(drop_data)
  self:check_equation_dorp_data()
end

function M:enqueue_equation_drop_data(drop_data)
  local len = #self.v_equation_drop_data_queue
  if drop_data.uuid then
    local comp_drop_data
    for i = len, 1, -1 do
      comp_drop_data = self.v_equation_drop_data_queue[i]
      if comp_drop_data.uuid == drop_data.uuid then
        return
      end
    end
  end
  self.v_equation_drop_data_queue[len + 1] = drop_data
end

function M:dequeue_equation_drop_data()
  local drop_data = self.v_equation_drop_data_queue[1]
  if drop_data and not drop_data.uuid then
    table.remove(self.v_equation_drop_data_queue, 1)
  end
  if self.v_have_start_equation_drop then
    MsgGame:mq_publish2(Const.MSG_ON_FATE_BOOK_CHECK_NEXT_START_STEP)
    self.v_have_start_equation_drop = nil
  end
  return drop_data
end

function M:replate_quation_drop_data(drop_data)
  if not drop_data or not drop_data.uuid then
    return
  end
  local len = #self.v_equation_drop_data_queue
  local comp_drop_data
  for i = len, 1, -1 do
    comp_drop_data = self.v_equation_drop_data_queue[i]
    if comp_drop_data.uuid == drop_data.uuid then
      self.v_equation_drop_data_queue[i] = drop_data
      return
    end
  end
end

function M:remove_quation_drop_data(uuid)
  local len = #self.v_equation_drop_data_queue
  local drop_data
  for i = len, 1, -1 do
    drop_data = self.v_equation_drop_data_queue[i]
    if uuid == drop_data.uuid then
      table.remove(self.v_equation_drop_data_queue, i)
      return
    end
  end
end

function M:check_equation_dorp_data()
  if self.v_equation_drop_data_queue[1] then
    local ui_name = "choose_equation_view"
    local ui = UIMgr:try_get_visible_ui(ui_name)
    if not ui then
      UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Fight_Tips, ui_name)
      return true
    end
  end
  return false
end

function M:get_equation_data_map()
  return self.v_equation_data_map
end

function M:get_equation_data(equation_id)
  return self.v_equation_data_map[equation_id]
end

function M:get_equation_level(equation_id)
  return self.v_equation_data_map[equation_id] and self.v_equation_data_map[equation_id].level or 0
end

function M:is_equation_unlock(equation_id)
  return self.v_equation_data_map[equation_id] ~= nil
end

function M:is_recommend_genres(genres_id)
  local is_recommend = false
  local can_lv_up = false
  for _, equation_data in pairs(self.v_equation_data_map) do
    local sect_info_list, equation_cfg, branch_cfg, check_level, max_level, ability_count, dif
    if equation_data.branch_id > 0 then
      max_level = ShareRes.get_curse_equation_branch_max_level(equation_data.branch_id)
      if max_level <= equation_data.level then
        goto lbl_89
      end
      check_level = math.min(equation_data.level + 1, max_level)
      branch_cfg = ShareRes.get_curse_equation_branch_cfg(equation_data.branch_id, check_level)
      sect_info_list = branch_cfg.Sect
    end
    if not sect_info_list then
      equation_cfg = ShareRes.get_curse_equation_cfg(equation_data.id)
      sect_info_list = equation_cfg.Sect
    end
    local need_genres_count = 0
    local max_ability_count = 0
    for _, sect_info in pairs(sect_info_list) do
      ability_count = GenresMgr:get_ability_count(sect_info.Sect)
      dif = sect_info.Count - ability_count
      if dif > 0 then
        need_genres_count = need_genres_count + 1
      end
      if sect_info.Sect == genres_id and dif > 0 then
        is_recommend = true
        max_ability_count = math.max(max_ability_count, dif)
      end
    end
    if not can_lv_up and 1 == need_genres_count and 1 == max_ability_count then
      can_lv_up = true
    end
    if is_recommend and can_lv_up then
      return is_recommend, can_lv_up
    end
    ::lbl_89::
  end
  return is_recommend, can_lv_up
end

function M:_set_temp_select_equation(equation_id)
  self.v_temp_select_equation = self.v_temp_select_equation or {}
  self.v_temp_select_equation[equation_id] = true
end

function M:get_equation_level_change_sect_info(equation_id, target_level, level_up)
  local data = self.v_equation_data_map[equation_id]
  if not data then
    return
  end
  local cur_level = data.level
  target_level = target_level or level_up and cur_level + 1 or cur_level - 1
  local max_level
  local equation_cfg = ShareRes.get_curse_equation_cfg(equation_id)
  if target_level < 0 then
    return
  elseif 0 == target_level then
    if not equation_cfg then
      Log.Error("获取方程配置失败", debug.traceback())
      return
    end
    return equation_cfg.Sect
  elseif not Util.is_more_than_zero(data.branch_id) then
    return
  else
    local all_branch_cfg = ShareRes.get_curse_equation_branch_cfg(data.branch_id)
    max_level = #all_branch_cfg
    if cur_level >= max_level then
      return
    end
    local branch_cfg = all_branch_cfg[target_level]
    if not branch_cfg then
      Log.Error("获取方程分支配置失败", debug.traceback())
      return
    end
    return branch_cfg and branch_cfg.Sect
  end
end

function M:request_curse_select_equation(equation_drop_uuid, index, equation_id, cb)
  self:_set_temp_select_equation(equation_id)
  Network:protect_call("c2gs_curse_select_equation", {equation_drop_uuid = equation_drop_uuid, index = index}, function(ok, resp)
    if ok then
      self:remove_quation_drop_data(equation_drop_uuid)
      if cb then
        cb(resp)
      end
    end
  end)
end

function M:request_curse_refresh_equation(equation_drop_uuid, cb)
  Network:protect_call("c2gs_curse_refresh_equation", {equation_drop_uuid = equation_drop_uuid}, function(ok, resp)
    if ok then
      self:replate_quation_drop_data(resp.equation_drop)
      if cb then
        cb(resp)
      end
    end
  end)
end

function M:request_curse_select_branch(equation_id, equation_branch_id, cb)
  Network:protect_call("c2gs_curse_select_branch", {equation_id = equation_id, equation_branch_id = equation_branch_id}, function(ok, resp)
    if ok and cb then
      cb(resp)
    end
  end)
end

function M:on_activity_curse_save_data(data)
  self.v_activity_curse_save_data = data.curse_save_datas
  MsgGame:mq_publish2(Const.MSG_ON_CURSE_SAVE_DATA_UPDATE)
end

function M:on_activity_curse_save_data_update(data)
  local curse_save_data = data.curse_save_data
  local save_id = curse_save_data.id
  self.v_activity_curse_save_data[save_id] = curse_save_data
  if curse_save_data.temp_save_data and not curse_save_data.temp_save_data.name then
    local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
    curse_save_data.temp_save_data.name = main_cfg.NewFileName
  end
  MsgGame:mq_publish2(Const.MSG_ON_CURSE_SAVE_DATA_UPDATE)
end

function M:get_fate_book_save_data(save_id)
  return self.v_activity_curse_save_data[save_id]
end

function M:get_fate_book_file_data(save_id, file_index)
  if self.v_activity_curse_save_data[save_id] then
    return self.v_activity_curse_save_data[save_id].save_list[file_index]
  end
end

function M:get_fate_book_temp_save_data(save_id)
  if self.v_activity_curse_save_data[save_id] then
    return self.v_activity_curse_save_data[save_id].temp_save_data
  end
end

function M:check_fate_book_has_file_data(save_id)
  return self.v_activity_curse_save_data[save_id] ~= nil and not UtilTable.is_empty(self.v_activity_curse_save_data[save_id].save_list)
end

function M:set_quick_fight_challenge_multiple(multiple)
  self.v_quick_fight_challenge_multiple = multiple
end

function M:get_quick_fight_challenge_multiple()
  return self.v_quick_fight_challenge_multiple or 1
end

function M:request_activity_curse_change_name(save_id, file_index, name, cb)
  Network:protect_call("c2gs_activity_curse_change_name", {
    save_id = save_id,
    save_idx = file_index,
    name = name
  }, function(ok, resp)
    if ok and cb then
      cb(ok, resp)
    end
  end)
end

function M:request_activity_curse_set_save_data(save_id, file_index, cb)
  Network:protect_call("c2gs_activity_curse_set_save_data", {save_id = save_id, save_idx = file_index}, function(ok, resp)
    if ok and cb then
      cb(ok, resp)
    end
  end)
end

function M:request_activity_curse_set_save_id(file_index, cb)
  Network:protect_call("c2gs_activity_curse_set_save_id", {save_idx = file_index}, function(ok, resp)
    if ok and cb then
      cb(ok, resp)
    end
  end)
end

function M:request_activity_curse_remove_save_data(save_id, file_index, cb)
  Network:protect_call("c2gs_activity_curse_remove_save_data", {save_id = save_id, save_idx = file_index}, function(ok, resp)
    if ok and cb then
      cb(ok, resp)
    end
  end)
end

function M:request_battle_curse_repeat_ability(ability_ids, cb)
  Network:protect_call("c2gs_battle_curse_repeat_ability", {ability_ids = ability_ids}, function(ok, resp)
    if ok then
      ChallengeRingPlusMgr:set_ability_remodel_count(resp.remoduling_count)
      if cb then
        cb(ok, resp)
      end
    end
  end)
end

return M
