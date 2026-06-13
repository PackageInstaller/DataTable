local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local SubMagicList = require("gamelogic.fight.sub_magic_list")
local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TMP_Sprite_Color_Template = "<sprite index=%s color=%s>"
local TMP_Sprite_Template = "<sprite=%s>"
local TOWER_TASK_TYPE = Config.CommonDefine.TOWER_TASK_TYPE
local TimingOfLinkSystemsCheck = ShareRes.get_comm_string_value("TimingOfLinkSystemsCheck")
local TimingOfLinkSystemsCheckLimit = ShareRes.get_comm_string_value("TimingOfLinkSystemsCheckLimit")
local Math = require("base.mathx")
M.FIGHT_UI_DATA_NAME = {
  v_skill_id_gray_params = "gray_params",
  v_skill_charged_data = "skill_charged_data",
  v_time_charged_data = "time_charged_data",
  v_magic_charged_data = "magic_charged_data",
  v_special_bar_data = "special_bar_data",
  v_ult_skill_data = "ult_skill_data",
  v_active_button_effect = "active_button_effect",
  v_button_drag_status = "button_drag_status"
}
local BATTLE_EVENT_NAME = {
  [Const.MSG_HERO_ATTR_CHANGE] = "on_hero_attr_change",
  [Const.MSG_ON_GAME_PAUSE] = "on_game_pause",
  [Const.MSG_ROLE_DEAD] = "on_role_dead"
}

function M:bind_battle_event()
  for event_name, func_name in pairs(BATTLE_EVENT_NAME) do
    if self[func_name] then
      self.v_battle_msg_handles[event_name] = self:sys_mq_bind(event_name, self[func_name], self)
    end
  end
end

function M:unbind_battle_event()
  for event_name, handle in pairs(self.v_battle_msg_handles) do
    self:sys_mq_unbind(handle)
    self.v_battle_msg_handles[event_name] = nil
  end
end

function M:clear_fight_data(uuid)
  self:clear_hp_visible_data_by_uuid(uuid)
  self:clear_npc_phase_data_by_uuid(uuid)
end

function M:exit_tower()
  self.v_fight_ui_data = {}
  self.v_hp_visible_data = {}
  self.v_npc_phase_data = {}
  self.v_skill_link_damage = {}
  self.v_color_tmp_string_cache = {}
  self.v_tmp_string_cache = {}
  self.v_tmp_number_cache = {}
  self.v_record_damage_trigger = false
  self.v_tower_task_data = {}
  self.v_listen_dead_role_map = {}
  self.v_damage_hud_random_data = nil
  self.v_fight_timer_ui_enable = nil
  self.v_last_monster_dead_pos = nil
  self.v_monster_born_magic_list = nil
  self.v_pause_start_time = nil
  self.v_link_duration_list = nil
  self.v_link_dura_over_list = nil
  self:unbind_battle_event()
  self:stop_fight_timer()
  self:release_all_magic_sub_list()
  self:clear_cache_keyframe_cfg()
  self:clear_walkable_position()
end

function M:enter_tower()
  self:init_skill_link_duration()
  self:create_latest_hero_pos()
  self:bind_battle_event()
end

function M:init_sys()
  Base.init_sys(self)
  self.v_timer_listen_index = 0
  self.v_battle_msg_handles = {}
  self.v_skill_link_damage = {}
  self.v_record_damage_trigger = false
  self.v_fight_ui_data = {}
  self.v_hp_visible_data = {}
  self.v_npc_phase_data = {}
  self.v_color_tmp_string_cache = {}
  self.v_tmp_string_cache = {}
  self.v_tmp_number_cache = {}
  self.v_tower_task_data = {}
  self.v_listen_dead_role_map = {}
  self.v_listen_timer_cb_data_list = {}
  self.v_use_time = 0
  self.v_pause_total_time = 0
  self.v_sub_magic_list_pool = LuaObjPoolMgr.get_pool("sub_magic_list_pool") or LuaObjPoolMgr.register("sub_magic_list_pool", 100, SubMagicList)
  self:enter_tower()
end

function M:on_hero_attr_change(msg)
  if not TowerMgr then
    return
  end
  local attr_type = msg.mm_x
  if not Config.HP_ATTR_TYPE[attr_type] then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  local total_hp, total_hp_max = 0, 0
  local hp, hp_max
  for key, hero in pairs(hero_list) do
    if not Util.is_destroy(hero) then
      hp = hero.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_HP)
      hp_max = hero.attr_mgr:get_attr(Config.CHAR_ATTR_TYPE.CHAR_HP_MAX)
      total_hp = total_hp + hp
      total_hp_max = total_hp_max + hp_max
    end
  end
  TowerMgr:check_tower_task_update(TOWER_TASK_TYPE.BUDDY_HP_RATIO, false, total_hp / total_hp_max)
end

function M:on_game_pause(msg)
  local is_pause = msg.mm_x
  if self.v_fight_timer_open then
    self:set_fight_timer_pause(is_pause)
  end
end

function M:on_role_dead(msg)
  local obj = msg.mm_obj
  if obj then
    if obj:is_monster() and (self.v_listen_dead_role_map[0] or self.v_listen_dead_role_map[obj:get_npc_id()]) then
      TowerMgr:check_tower_task_update(TOWER_TASK_TYPE.DIED_MONSTER, false, 1)
    end
    if obj:is_com_monster() then
      self.v_last_monster_dead_pos = self.v_last_monster_dead_pos or Util.VEC3_TEMP:New()
      self.v_last_monster_dead_pos:Set(obj:get_pos())
    end
  end
end

function M:init_fight_ui_data()
  self.v_fight_ui_data = self.v_fight_ui_data or {}
  for key, name in pairs(self.FIGHT_UI_DATA_NAME) do
    self.v_fight_ui_data[name] = self.v_fight_ui_data[name] or {}
  end
end

function M:get_fight_ui_data()
  return self.v_fight_ui_data
end

function M:set_hp_visible_state(uuid, show_big, show_elite, show_small, show_hero)
  self.v_hp_visible_data[uuid] = self.v_hp_visible_data[uuid] or {}
  if nil ~= show_big then
    self.v_hp_visible_data[uuid].show_big = show_big
  end
  if nil ~= show_elite then
    self.v_hp_visible_data[uuid].show_elite = show_elite
  end
  if nil ~= show_small then
    self.v_hp_visible_data[uuid].show_small = show_small
  end
  if nil ~= show_hero then
    self.v_hp_visible_data[uuid].show_hero = show_hero
  end
end

function M:get_hp_visible_state(uuid)
  return self.v_hp_visible_data[uuid]
end

function M:clear_hp_visible_data_by_uuid(uuid)
  if self.v_hp_visible_data[uuid] then
    UtilTable.clear_map(self.v_hp_visible_data[uuid])
  end
end

function M:set_npc_phase_data(uuid, phase_num)
  if not Util.is_more_than_zero(phase_num) then
    return
  end
  if not self.v_npc_phase_data[uuid] then
    self.v_npc_phase_data[uuid] = {}
  end
  local phase_data = self.v_npc_phase_data[uuid]
  if not Util.is_more_than_zero(phase_num) then
    return
  end
  for phase = 1, phase_num do
    phase_data[phase] = true
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_NPC_PHASE_STATE)
  msg.mm_x = uuid
end

function M:change_npc_phase_state(uuid, phase_num, phase_state)
  if not self.v_npc_phase_data[uuid] or self.v_npc_phase_data[uuid][phase_num] == nil then
    return
  end
  local old_state = self.v_npc_phase_data[uuid][phase_num]
  self.v_npc_phase_data[uuid][phase_num] = phase_state
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_NPC_PHASE_STATE)
  msg.mm_x = uuid
  if true == old_state and false == phase_state then
    msg.mm_y = true
    msg.mm_obj = phase_num
  end
end

function M:get_npc_phase_data(uuid)
  return self.v_npc_phase_data[uuid]
end

function M:clear_npc_phase_data_by_uuid(uuid)
  if self.v_npc_phase_data[uuid] then
    self.v_hp_visible_data[uuid] = nil
  end
end

function M:clear_npc_phase_data()
  UtilTable.clear_map(self.v_npc_phase_data)
end

function M:set_record_damage_trigger(open)
  if self.v_record_damage_trigger ~= open then
    MsgGame:mq_publish2(Const.MSG_RECORD_STATE_CHANGE)
  end
  self.v_record_damage_trigger = open
end

function M:is_record_damage_trigger_open()
  return self.v_record_damage_trigger
end

function M:record_skill_link_damage(uuid, damage)
  if self.v_skill_link_damage[uuid] ~= damage then
    self.v_skill_link_damage[uuid] = (self.v_skill_link_damage[uuid] or 0) + damage
    MsgGame:mq_publish2(Const.MSG_RECORD_DAMAGE_CHANGE)
  end
end

function M:get_skill_link_damage(uuid)
  return self.v_skill_link_damage[uuid]
end

function M:clear_skill_link_damage(uuid)
  self.v_skill_link_damage[uuid] = nil
  if self.v_record_damage_trigger then
    MsgGame:mq_publish2(Const.MSG_RECORD_DAMAGE_CHANGE)
  end
end

function M:get_color_tmp_string(damage, color, offset)
  local length
  if damage >= 10 then
    damage = math.floor(damage)
    length = #tostring(damage)
    for i = 1, length do
      local index1 = (i - 1) * 2 + 1
      local index2 = index1 + 1
      local number = 10 ^ (length - i)
      self.v_tmp_number_cache[index1] = math.floor(damage / number % 10 + offset)
      self.v_tmp_number_cache[index2] = color
    end
  else
    length = 1
    self.v_tmp_number_cache[1] = math.floor(damage + offset)
    self.v_tmp_number_cache[2] = color
  end
  if not self.v_color_tmp_string_cache[length] then
    local temp_table = {}
    for index = 1, length do
      temp_table[index] = TMP_Sprite_Color_Template
    end
    self.v_color_tmp_string_cache[length] = table.concat(temp_table)
  end
  local templete_string = self.v_color_tmp_string_cache[length]
  return string.format(templete_string, table.unpack(self.v_tmp_number_cache))
end

function M:get_tmp_string(damage, offset)
  local length
  damage = math.floor(damage)
  if damage >= 10 then
    length = #tostring(damage)
    for i = 1, length do
      local number = 10 ^ (length - i)
      self.v_tmp_number_cache[i] = math.floor(damage / number % 10 + offset)
    end
  else
    length = 1
    self.v_tmp_number_cache[1] = damage + offset
  end
  if not self.v_tmp_string_cache[length] then
    local temp_table = {}
    for index = 1, length do
      temp_table[index] = TMP_Sprite_Template
    end
    self.v_tmp_string_cache[length] = table.concat(temp_table)
  end
  local templete_string = self.v_tmp_string_cache[length]
  return string.format(templete_string, table.unpack(self.v_tmp_number_cache))
end

function M:set_damage_hud_random_range_data(min, max, interval, blood_type)
  self.v_damage_hud_random_data = self.v_damage_hud_random_data or {}
  self.v_damage_hud_random_data[blood_type] = self.v_damage_hud_random_data[blood_type] or {}
  local random_data = self.v_damage_hud_random_data[blood_type]
  random_data.min = min
  random_data.max = max
  random_data.interval = interval
  self:reset_damage_hud_random_angle(blood_type)
end

function M:remove_damage_hud_random_angle(angle, blood_type)
  if not self.v_damage_hud_random_data or not self.v_damage_hud_random_data[blood_type] then
    return
  end
  local random_data = self.v_damage_hud_random_data[blood_type]
  if random_data.interval then
    return
  end
  local section = math.floor(angle / random_data.interval)
  if random_data.random_angle[section] then
    random_data.random_angle[section] = nil
    random_data.max_count = random_data.max_count + 1
  end
end

function M:try_get_damage_hud_random_angle(blood_type)
  if not self.v_damage_hud_random_data or not self.v_damage_hud_random_data[blood_type] then
    return 0
  end
  local random_data = self.v_damage_hud_random_data[blood_type]
  if random_data.max_count < 0 then
    self:reset_damage_hud_random_angle(blood_type)
  end
  local min = random_data.min
  local max = random_data.max
  local interval = random_data.interval
  local random_angle = math.random(min, max)
  local random_section
  random_section = math.floor(random_angle / interval)
  local count = 1
  local map = random_data.random_angle
  while count <= 5 and map[random_section] do
    random_angle = math.random(min, max)
    random_section = math.floor(random_angle / interval)
    count = count + 1
  end
  random_data.random_angle[random_section] = true
  random_data.max_count = random_data.max_count - 1
  return random_angle
end

function M:reset_damage_hud_random_angle(blood_type)
  if not self.v_damage_hud_random_data or not self.v_damage_hud_random_data[blood_type] then
    return
  end
  local random_data = self.v_damage_hud_random_data[blood_type]
  local min = random_data.min
  local max = random_data.max
  local interval = 2
  if min and max and interval then
    random_data.max_count = (max - min) // interval
  else
    random_data.max_count = 0
  end
  random_data.random_angle = {}
end

local function UPDATE_ADDITION_FUNC(self, task_type, value)
  self.v_tower_task_data[task_type] = self.v_tower_task_data[task_type] + value
end

local function UPDATE_ASSIGNMENT_FUNC(self, task_type, value)
  self.v_tower_task_data[task_type] = value
end

local UPDATE_TOWER_TASK_FUNC = {
  [TOWER_TASK_TYPE.PASS_FLOOR_NUM] = UPDATE_ASSIGNMENT_FUNC,
  [TOWER_TASK_TYPE.TOWER_BLOW_CNT] = UPDATE_ADDITION_FUNC,
  [TOWER_TASK_TYPE.BUDDY_HP_RATIO] = UPDATE_ASSIGNMENT_FUNC,
  [TOWER_TASK_TYPE.FIGHT_TIME] = UPDATE_ASSIGNMENT_FUNC,
  [TOWER_TASK_TYPE.FORMAT_LIMIT] = UPDATE_ASSIGNMENT_FUNC,
  [TOWER_TASK_TYPE.NO_SKILL] = UPDATE_ADDITION_FUNC,
  [TOWER_TASK_TYPE.FIGHT_TIME_NOT_USE_HELP_BUDDY] = UPDATE_ASSIGNMENT_FUNC,
  [TOWER_TASK_TYPE.DIED_MONSTER] = UPDATE_ADDITION_FUNC
}

function M:create_tower_task_data(task_data)
  local task_type = task_data.task_type
  if not self.v_tower_task_data[task_type] then
    self.v_tower_task_data[task_type] = 0
    if task_type == TOWER_TASK_TYPE.DIED_MONSTER then
      local cfg = ShareRes.get_point_star_condition_cfg(task_data.task_id)
      local arg2 = cfg.Arg[2]
      if UtilTable.is_empty(arg2) then
        self.v_listen_dead_role_map[0] = true
      elseif type(arg2) == "table" then
        for key, role_id in pairs(arg2) do
          self.v_listen_dead_role_map[role_id] = true
        end
      end
    end
  end
end

function M:update_tower_task_data(task_type, cover, ...)
  local func = cover and UPDATE_ASSIGNMENT_FUNC or UPDATE_TOWER_TASK_FUNC[task_type]
  if func then
    local before_value = self.v_tower_task_data[task_type]
    func(self, task_type, ...)
    if before_value ~= self.v_tower_task_data[task_type] then
      MsgGame:mq_publish2(Const.MSG_ON_TOWER_DATA_UPDATE)
    end
  end
end

function M:get_tower_task_data(task_type)
  return self.v_tower_task_data[task_type] or 0
end

function M:set_fight_timer_open(is_open)
  self.v_fight_timer_open = is_open
end

function M:set_fight_timer_ui_enable(enable)
  if self.v_fight_timer_ui_enable ~= enable then
    if enable then
      GeCaoBattleMgr:start_timer(self:get_use_time(), true)
    else
      GeCaoBattleMgr:stop_timer(true)
    end
  end
  self.v_fight_timer_ui_enable = enable
end

function M:set_use_default_start_timer(is_use)
  self.v_use_default_start_timer = is_use
end

function M:set_use_default_end_timer(is_use)
  self.v_use_default_end_timer = is_use
end

function M:is_fight_timer_ui_enable()
  return self.v_fight_timer_ui_enable
end

function M:is_use_default_start_timer()
  return self.v_use_default_start_timer
end

function M:is_use_default_end_timer()
  return self.v_use_default_end_timer
end

function M:on_timer_refresh()
  for _, cb_data in pairs(self.v_listen_timer_cb_data_list) do
    cb_data.callback(cb_data.arg1, cb_data.arg2)
  end
end

function M:start_fight_timer(use_time)
  local is_fight_end = TowerMgr and TowerMgr:is_fight_end()
  self:set_fight_timer_open(not is_fight_end)
  self.v_use_time = use_time or 0
  self.v_start_time = Date.server_time() - self.v_use_time
  self:add_ct_timer()
end

function M:set_fight_timer_pause(is_pause)
  if is_pause then
    self.v_game_pause_start_time = Date.server_time()
    self:remove_ct_timer()
  else
    self:add_ct_timer()
  end
end

function M:stop_fight_timer()
  self:set_fight_timer_open(false)
  self:clear_timer_cb_data()
  self:remove_ct_timer()
  self:remove_resume_timer()
  self.v_use_time = 0
  self.v_pause_total_time = 0
  self.v_pause_start_time = nil
  self.v_game_pause_start_time = nil
end

function M:get_start_time()
  return self.v_start_time or 0
end

function M:get_use_time()
  return math.max(self.v_use_time, 0)
end

function M:listen_timer_refresh(cb, arg1, arg2)
  self.v_timer_listen_index = self.v_timer_listen_index + 1
  local index = self.v_timer_listen_index
  self.v_listen_timer_cb_data_list = self.v_listen_timer_cb_data_list or {}
  self.v_listen_timer_cb_data_list[index] = {
    index = index,
    callback = cb,
    arg1 = arg1,
    arg2 = arg2
  }
  return index
end

function M:remove_timer_refresh_listen(index)
  if self.v_listen_timer_cb_data_list[index] then
    self.v_listen_timer_cb_data_list[index] = nil
  end
end

function M:add_ct_timer()
  if not self.v_fight_timer then
    if self.v_pause_start_time then
      self.v_pause_total_time = self.v_pause_total_time + (Date.server_time() - self.v_pause_start_time)
      self.v_pause_start_time = nil
    end
    if self.v_game_pause_start_time then
      self.v_pause_total_time = self.v_pause_total_time + (Date.server_time() - self.v_game_pause_start_time)
      self.v_game_pause_start_time = nil
    end
    self.v_fight_timer = Global.ct_timer:add_timer("fight_timer", 86400, function()
      if Global.scene_mgr and Global.scene_mgr:get_game_pause() then
        local msg = MsgGame:mq_publish2(Const.MSG_ON_GAME_PAUSE)
        msg.mm_x = true
      else
        self.v_use_time = Date.server_time() - self.v_start_time - self.v_pause_total_time
        self:on_timer_refresh()
      end
    end)
    local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_DEFAULT_TIMER_PAUSE)
    msg.mm_x = false
  end
end

function M:remove_ct_timer(ignore_notice_show)
  if self.v_fight_timer then
    Global.ct_timer:remove_timer(self.v_fight_timer)
    self.v_fight_timer = nil
    local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_DEFAULT_TIMER_PAUSE)
    msg.mm_x = true
    msg.mm_y = ignore_notice_show
  end
end

function M:set_timer_pause(is_pause, ignore_notice_show)
  local func_name = is_pause and "pause_timer" or "restart_timer"
  local set_timer_pause_suc = UIMgr:try_call_ui_func("ui_ct_timer", func_name)
  if not self.v_fight_timer_open then
    if ignore_notice_show then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_TIMER_PAUSE_NOTICE_HIDE)
      msg.mm_x = true
    elseif not is_pause then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_TIMER_PAUSE_NOTICE_HIDE)
      msg.mm_x = false
    end
    if set_timer_pause_suc then
      if is_pause and self.v_pause_start_time then
        return
      end
      self.v_pause_start_time = is_pause and Date.server_time() or nil
      local rpc_name = is_pause and "combine_suspend_fight_time" or "combine_continue_fight_time"
      SceneMgr:c2gs_call_scene(rpc_name, Date.server_time())
    end
    return
  end
  if is_pause and self.v_pause_start_time then
    self:add_resume_timer()
    return
  end
  if is_pause then
    self:add_resume_timer()
    if self.v_fight_timer then
      self.v_pause_start_time = Date.server_time()
      self:remove_ct_timer(ignore_notice_show)
      SceneMgr:c2gs_call_scene("combine_suspend_fight_time", Date.server_time())
    end
  else
    self:remove_resume_timer()
    self:add_ct_timer()
    SceneMgr:c2gs_call_scene("combine_continue_fight_time", Date.server_time())
  end
end

function M:add_resume_timer(ignore_notice_show)
  if not self.v_fight_timer_open then
    return
  end
  self:remove_resume_timer()
  local resume_time = ShareRes.get_comm_value("FightPauseResumeTime")
  self.v_pause_timer = Timer:add_timer("resume_timer", resume_time, function()
    Log.Error("resume timer done, place check resume pause state logic", SceneMgr:get_hero_id_list(), debug.traceback())
    if not self.v_fight_timer and self.v_fight_timer_open then
      self:set_timer_pause(false, ignore_notice_show)
    end
    self:remove_resume_timer()
  end, nil, nil, nil, true)
end

function M:remove_resume_timer()
  if self.v_pause_timer then
    Timer:remove_timer(self.v_pause_timer)
    self.v_pause_timer = nil
  end
end

function M:clear_timer_cb_data()
  self.v_listen_timer_cb_data_list = {}
end

function M:get_last_monster_dead_pos()
  return self.v_last_monster_dead_pos
end

function M:clear_last_monster_dead_pos()
  self.v_last_monster_dead_pos = nil
end

function M:add_monster_born_magic(magic_id, level)
  self.v_monster_born_magic_list = self.v_monster_born_magic_list or {}
  self.v_monster_born_magic_list[magic_id] = level
end

function M:remove_monster_born_magic(magic_id)
  if not self.v_monster_born_magic_list then
    return
  end
  self.v_monster_born_magic_list[magic_id] = nil
end

function M:get_monster_born_magic_list()
  return self.v_monster_born_magic_list
end

function M:remove_invalid_sub_magic(target_magic_id)
  if not (self.v_sub_magic_list_map and self.v_sub_magic_list_map[target_magic_id]) or not self.v_invalid_sub_magic then
    return
  end
  local list = self.v_sub_magic_list_map[target_magic_id]
  for magic_id in pairs(self.v_invalid_sub_magic) do
    list:remove_magic(magic_id)
    self.v_invalid_sub_magic[magic_id] = nil
  end
end

function M:add_invalid_magic(magic_id)
  self.v_invalid_sub_magic = self.v_invalid_sub_magic or {}
  self.v_invalid_sub_magic[magic_id] = true
end

local function _check_sub_magic(self, magic_id, sub_magic_id)
  if magic_id == sub_magic_id then
    Log.Error(string.format("Magic: %s 不可作为自己的子Magic", sub_magic_id), debug.traceback())
    return false
  end
  if self.v_sub_magic_list_map then
    if self.v_sub_magic_list_map[sub_magic_id] then
      Log.Error(string.format("Magic: %s 已作为其他Magic的子Magic, 不可对其再添加子Magic", sub_magic_id), debug.traceback())
      return false
    end
    local sub_magic_list = self.v_sub_magic_list_map[magic_id]
    if sub_magic_list then
      if sub_magic_list.magic_effect_time_map[sub_magic_id] then
        Log.Error(string.format("Magic: %s 已作为Magic: %s的子Magic, 不可重复添加", sub_magic_id, magic_id), debug.traceback())
        return false
      end
      if sub_magic_list:get_magic_count() > 10 then
        Log.Error(string.format("Magic: %s 子magic数量不可超过10", sub_magic_id), debug.traceback())
        return false
      end
    end
  end
  local magic_cfg = ShareRes.get_magic_cfg(sub_magic_id)
  if not magic_cfg or not magic_cfg.logic then
    Log.Error(string.format("子Magic: %s 配置不存在", sub_magic_id), debug.traceback())
    return false
  end
  if magic_cfg.logic.IsReceive ~= Config.MagicDefine.MAGIC_BROARDCAST_TYPE.NONE then
    Log.Error(string.format("子Magic: %s IsReceive字段只能为0（即不发送任何通知）", sub_magic_id), debug.traceback())
    return false
  end
  return true
end

function M:add_sub_magic(magic_id, sub_magic_id, effect_time)
  if not (magic_id and sub_magic_id) or effect_time and 0 == effect_time then
    Log.Error("传入magic_id 或 sub_magic_id 为空", debug.traceback())
    return
  end
  if not _check_sub_magic(self, magic_id, sub_magic_id) then
    return
  end
  self.v_sub_magic_list_map = self.v_sub_magic_list_map or {}
  if not self.v_sub_magic_list_map[magic_id] then
    self.v_sub_magic_list_map[magic_id] = self.v_sub_magic_list_pool:new_obj(sub_magic_id, effect_time)
  else
    self.v_sub_magic_list_map[magic_id]:add_magic(sub_magic_id, effect_time)
  end
end

function M:remove_sub_magic(magic_id, sub_magic_id)
  if not (magic_id and sub_magic_id and self.v_sub_magic_list_map) or not self.v_sub_magic_list_map[magic_id] then
    return
  end
  self.v_sub_magic_list_map[magic_id]:remove_magic(sub_magic_id)
end

function M:get_magic_sub_list(magic_id)
  return self.v_sub_magic_list_map and self.v_sub_magic_list_map[magic_id]
end

function M:release_sub_magic_list(magic_id)
  if not (magic_id and self.v_sub_magic_list_map) or not self.v_sub_magic_list_map[magic_id] then
    return
  end
  self.v_sub_magic_list_pool:destroy_obj(self.v_sub_magic_list_map[magic_id])
end

function M:release_all_magic_sub_list()
  if not self.v_sub_magic_list_pool then
    return
  end
  self.v_sub_magic_list_pool:release_active_objs()
  self.v_sub_magic_list_pool:release_free_objs()
  self.v_sub_magic_list_map = nil
  self.v_invalid_sub_magic = nil
end

local function _get_cache_keyframe_cfg(keys, keyframe_cfg)
  for _, key in ipairs(keys) do
    local frame = key[1]
    local data = keyframe_cfg[frame]
    if not data then
      data = {}
      keyframe_cfg[frame] = data
    end
    table.insert(data, key)
  end
end

function M:get_cache_keyframe_cfg(skill_id, fashion_id)
  self.v_cache_keyframe_cfg = self.v_cache_keyframe_cfg or {}
  if self.v_cache_keyframe_cfg[skill_id] then
    return self.v_cache_keyframe_cfg[skill_id]
  end
  local cfg = ShareRes.get_skill_keyframe_cfg(skill_id)
  if not cfg then
    return
  end
  local keyframe_cfg = {}
  _get_cache_keyframe_cfg(cfg.Key, keyframe_cfg)
  if fashion_id and cfg.SpecialKey and cfg.SpecialKey[fashion_id] then
    _get_cache_keyframe_cfg(cfg.SpecialKey[fashion_id], keyframe_cfg)
  end
  self.v_cache_keyframe_cfg[skill_id] = keyframe_cfg
  return keyframe_cfg
end

function M:clear_cache_keyframe_cfg()
  self.v_cache_keyframe_cfg = nil
end

function M:cache_walkable_position(x, y, z)
  self.walkable_pos = self.walkable_pos or Util.VEC3_TEMP.New()
  self.walkable_pos:Set(x, y, z)
end

function M:update_walkable_position_y(y)
  if not self.walkable_pos then
    return
  end
  self.walkable_pos.y = y
end

function M:clear_walkable_position()
  self.walkable_pos = nil
end

function M:create_latest_hero_pos()
  self.latest_hero_pos = self.latest_hero_pos or Util.VEC3_TEMP.New()
end

function M:init_skill_link_duration()
  self.v_link_duration_list = {}
  self.v_link_dura_over_list = {}
  for key, value in pairs(TimingOfLinkSystemsCheck) do
    self.v_link_dura_over_list[key] = 0
    self.v_link_duration_list[key] = value
  end
end

function M:change_skill_link_duration(stage, delta)
  if not (self.v_link_duration_list and self.v_link_duration_list[stage] and delta) or 0 == delta then
    return
  end
  local limit = TimingOfLinkSystemsCheckLimit[stage]
  local cur_duration = self.v_link_duration_list[stage]
  if delta > 0 then
    local result = cur_duration + delta
    if limit < result then
      self.v_link_dura_over_list[stage] = result - limit
      delta = limit - self.v_link_duration_list[stage]
      Log.Error("change_skill_link_duration 设置时间超出上限", debug.traceback())
    end
  elseif delta < 0 then
    if self.v_link_dura_over_list[stage] then
      local result = self.v_link_dura_over_list[stage] + delta
      if result < 0 then
        self.v_link_dura_over_list[stage] = 0
        delta = result
      else
        delta = 0
      end
    end
    local result = cur_duration + delta
    if result <= 0 then
      Log.Error("change_skill_link_duration 设置时间超出上限", debug.traceback())
      self.v_link_duration_list[stage] = 0
      return
    end
  end
  self.v_link_duration_list[stage] = Math.Clamp(self.v_link_duration_list[stage] + delta, 0, limit)
  if cur_duration ~= self.v_link_duration_list[stage] then
    local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
    if fight then
      local ult_skill_view = fight:get_panel("ult_skill_view")
      ult_skill_view:set_duration_change()
    end
  end
end

function M:get_link_duration_list()
  return self.v_link_duration_list
end

return M
