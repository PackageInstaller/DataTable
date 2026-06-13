local BehaviorLoader = require("utils.behavior_loader")
local SceneBehaviorLoader = require("utils.scene_behavior_loader")
local common_manager = require("common.common_manager")
local LuaBehaviorConst = require("common.lua_behavior_const")
local MISSILE_EVT_TYPE = LuaBehaviorConst.MISSILE_EVT_TYPE
local MAGIC_EVT_TYPE = LuaBehaviorConst.MAGIC_EVT_TYPE
local BUTTON_EVT_TYPE = LuaBehaviorConst.BUTTON_EVT_TYPE
local CUSTOM_EVENT_TYPE = LuaBehaviorConst.CUSTOM_EVENT_TYPE
local M = {}
local SCOPE_GLOBAL = {}
M.SCOPE_GLOBAL = SCOPE_GLOBAL
local TBNAME_PREFIX = "v_%ss"
local UPDATE_INTERVAL = 0.05
local HERO_BEHAVIOR_VALUE = Config.HERO_BEHAVIOR_VALUE
local AUTO_LOCK_TYPE = Config.SETTING.AUTO_LOCK_TYPE
local EVENT_NAME_CACHE = {}
local EVENT2_NAME_CACHE = {}
local EVENTS = {
  "on_frame",
  "on_frame_background",
  "on_frame_ground",
  ON_INPUT = "on_input",
  ON_TOUCH_UP = "on_touch_up",
  ON_SKILL_BEGIN = "on_skill_begin",
  ON_SKILL_HIT = "on_skill_hit",
  ON_BEFORE_SKILL_END = "on_before_skill_end",
  ON_SKILL_END = "on_skill_end",
  ON_MISSILE_COLLIDE = "on_missile_collide",
  ON_NPC_REMOVED = "on_npc_removed",
  ON_SKILL_BEFORE_TIME = "on_skill_before_time",
  ON_SKILL_CAST_TIME = "on_skill_cast_time",
  ON_BEFORE_NPC_HP_ZERO = "on_before_npc_hp_zero",
  ON_NPC_HP_ZERO = "on_npc_hp_zero",
  ON_HERO_SHOWUP_OR_BACK = "on_hero_showup_or_back",
  ON_CAMERA_OPERATION = "on_camera_operation",
  BEFORE_DAMAGE = "before_damage",
  AFTER_DAMAGE = "after_damage",
  BEFORE_HEAL = "before_heal",
  AFTER_HEAL = "after_heal",
  ON_HERO_REBORN = "on_hero_reborn",
  ON_ROOM_CHANGE = "on_room_change",
  ON_SCENE_CHANGE = "on_scene_change",
  ON_PART_HIT = "on_part_hit",
  ON_PART_DAMAGE = "on_part_damage",
  ON_BORN_BEHAVIOR = "on_born_behavior",
  ON_NPC_BEATTACK_COLLIDER = "on_npc_beattack_collider",
  ON_GET_BATTLE_SKILL = "on_get_battle_skill",
  ON_CRITICAL = "on_critical",
  EFFECT_ABORN_MAGIC = "effect_aborn_magic",
  ON_MAGIC_BEGIN = "on_magic_begin",
  ON_MAGIC_END = "on_magic_end",
  ON_MISSILE_BEGIN_POS = "on_missile_begin_pos",
  ON_MISSILE_END_POS = "on_missile_end_pos",
  ON_RECONNECT = "on_reconnect",
  ON_FINISH_GUIDE = "on_finish_guide",
  ON_CLICK_FIGHT_STORY = "on_click_fight_story",
  ON_TEXTURE_GUIDE_FINISH = "on_texture_guide_finish",
  ON_STORY_FINISH = "on_story_finish",
  ON_SKILL_TEACH_TIPS_CLOSE = "on_skill_teach_tips_close",
  ON_FLOOR_START = "on_floor_start",
  ON_FLOOR_FINISHED = "on_floor_finished",
  ON_HERO_BORN_ANIM_END = "on_hero_born_anim_end",
  ON_ENTER_AREA = "on_enter_area",
  ON_LEAVE_AREA = "on_leave_area",
  ON_NPC_DEAD = "on_npc_dead",
  ON_TIMELINE_END = "on_timeline_end",
  ON_TIMELINE_BEGIN = "on_timeline_begin",
  ON_NPC_GROUP_CLEAR = "on_npc_group_clear",
  ON_VIDEO_PLAY_END = "on_video_play_end",
  REMOVE_BUFF = "remove_buff",
  REMOVE_CURSE = "remove_curse",
  ON_ROLE_LEVEL_CHANGE = "on_role_level_change",
  ON_NPC_BORN = "on_npc_born",
  ON_ROOM_PASS = "on_room_pass",
  ON_ENTER_ROOM = "on_enter_room",
  ON_TOUGHNESS_CHANGE = "on_toughness_change",
  ON_STORY_BEGIN = "on_story_begin",
  ON_ELEMENT_ABORN_START = "on_element_aborn_start",
  ON_ELEMENT_ABORN_END = "on_element_aborn_end",
  ON_FATE_BOOK_BATTLE_START = "on_fate_book_battle_start",
  ON_MINESWEEPER_BATTLE_START = "on_minesweeper_battle_start",
  ON_ALL_AI_DEAD = "on_all_ai_dead",
  ON_HERO_ENTER_GROUND_STATE = "on_hero_enter_ground_state",
  BEFORE_ABNORMAL_DAMAGE = "before_abnormal_damage",
  AFTER_ABNORMAL_DAMAGE = "after_abnormal_damage",
  ON_BEFORE_SKILL_LINK_END = "on_before_skill_link_end",
  ON_SKILL_LINK_START = "on_skill_link_start",
  ON_SKILL_LINK_TIMER_END = "on_skill_link_timer_end",
  BEFORE_SHIELD = "before_shield",
  BEFORE_SHIELD_TARGET = "before_shield_target",
  BEFORE_SHIELD_SELF = "before_shield_self",
  AFTER_SHIELD = "after_shield",
  AFTER_SHIELD_TARGET = "after_shield_target",
  AFTER_SHIELD_SELF = "after_shield_self",
  ON_TP_ROOM_FINISH = "on_tp_room_finish",
  ON_ROLE_BEHIT_STATE_CHANGE = "on_role_behit_state_change",
  ON_GOD_BORN = "on_god_born",
  ON_CONTROLLER_CHANGE = "on_controller_change",
  ON_KEYFRAME_ACTION = "on_keyframe_action",
  ON_TREASURE_CHEST_GUIDE_STATE_UPDATE = "on_treasure_chest_guide_state_update",
  ON_ACTIVATE_POV_CAMERA = "on_activate_pov_camera",
  ON_DEACTIVATE_POV_CAMERA = "on_deactivate_pov_camera",
  ON_FORCE_SHIFT_END = "on_force_shift_end",
  ON_SKILL_SHIFT_PAUSE = "on_skill_shift_pause"
}
M.EVENTS = EVENTS

local function _get_event_key(event_name)
  local event_key, event_key2 = EVENT_NAME_CACHE[event_name], EVENT2_NAME_CACHE[event_name]
  if not event_key then
    event_key = string.format(TBNAME_PREFIX, event_name)
    EVENT_NAME_CACHE[event_name] = event_key
  end
  if not event_key2 then
    event_key2 = event_key .. "2"
    EVENT2_NAME_CACHE[event_name] = event_key2
  end
  return event_key, event_key2
end

function M:init()
  self.v_modules = {}
  self.v_event_lock = {}
  self.v_wait_insert = {}
  self.v_wait_load_count = 0
  local event_key, event_key2
  for _, event_name in pairs(EVENTS) do
    event_key, event_key2 = _get_event_key(event_name)
    self[event_key] = {}
    self[event_key2] = {}
    self.v_event_lock[event_name] = false
  end
  Util.bind_msg(self, Const.MSG_ON_ROLE_ATTR_CHANGE, self.on_role_attr_change, self)
  self.v_char_to_behaviors = setmetatable({}, Config.KEY_WEAK_METATABLE)
  self.v_char_scopes = setmetatable({}, Config.KEY_WEAK_METATABLE)
  self.v_wait_load = {}
  self.v_fun_call_count = {}
  self.v_last_update_time = 0
  self.v_mqs = {}
  self.v_hero_behavior_list = {}
  self.v_wait_load_maneger = {}
  self.v_file_to_manager = setmetatable({}, Config.WEAK_METATABLE)
end

function M:on_enter_tower()
  self:create_common_manager()
end

function M:preload_behavior_file(file)
  self:get_behavior_module(file)
end

function M:get_behavior_module(file)
  local module = self.v_modules[file]
  if not module then
    module = BehaviorLoader.load_behavior_file(file)()
    self.v_modules[file] = module
  end
  return module
end

function M:load_manager(file)
  if self.frame_update_start then
    if not self.v_wait_load_maneger[file] then
      self.v_wait_load_count = self.v_wait_load_count + 1
    end
    self.v_wait_load_maneger[file] = true
    return
  end
  if self.v_file_to_manager[file] and UNITY_EDITOR then
    Log.Error("管理器已存在，不可重复创建", file, debug.traceback())
    return
  end
  local module = self:get_behavior_module(file)
  local instance = module:new(file, SCOPE_GLOBAL)
  self.v_file_to_manager[file] = instance
  if instance.on_start then
    instance:on_start()
  end
  self:_add_event_listener(instance)
  return instance
end

function M:load(file, char, callback)
  if self.frame_update_start then
    if not self.v_wait_load[char] then
      self.v_wait_load_count = self.v_wait_load_count + 1
    else
      Log.Error("缓存创建行为脚本将被覆盖， 需检查是否正确， 原先脚本:", self.v_wait_load[char].file, "覆盖脚本：", file, debug.traceback())
    end
    self.v_wait_load[char] = {file = file, callback = callback}
    return
  end
  local module = self:get_behavior_module(file)
  if not module then
    Log.Error("行为文件：" .. file .. "创建失败")
  end
  if not module._init then
    Log.Error("行为文件：" .. file .. "缺少_init函数")
  end
  local char_scope = self.v_char_scopes[char]
  if not char_scope then
    char_scope = {}
    self.v_char_scopes[char] = char_scope
  end
  local instance = module:new(char, file, char_scope, SCOPE_GLOBAL)
  instance.file_id = file
  instance.npc = char
  if instance.on_start then
    instance:on_start()
  end
  self:_add_event_listener(instance)
  local char_behaviors = self.v_char_to_behaviors[char]
  if not char_behaviors then
    char_behaviors = {}
    self.v_char_to_behaviors[char] = char_behaviors
  end
  if char_behaviors[file] then
    Log.Error("行为脚本将被覆盖， 需检查是否正确， 原先脚本:", char_behaviors[file].file_id, "覆盖脚本：", file, debug.traceback())
  end
  char_behaviors[file] = instance
  if char:is_hero() then
    self.v_hero_behavior_list[file] = instance
    if not Util.is_client_only() then
      local is_open = BattleSettingMgr:get_auto_lock_type()
      if is_open == AUTO_LOCK_TYPE.CLOSE then
        self:set_hero_behaviour_value(HERO_BEHAVIOR_VALUE.LOCK_AND_TURN_SETTING, is_open)
      elseif is_open == AUTO_LOCK_TYPE.OPEN then
        self:set_hero_behaviour_value(HERO_BEHAVIOR_VALUE.LOCK_AND_TURN_SETTING, is_open)
      end
    end
  end
  if callback then
    callback(char, instance)
  end
  return instance
end

function M:_add_event_listener(instance)
  local event_key, event_key2
  for _, event_name in pairs(EVENTS) do
    if instance[event_name] then
      event_key, event_key2 = _get_event_key(event_name)
      if self.v_event_lock[event_name] then
        self[event_key2][instance] = true
        if not self.v_wait_insert[event_name] then
          self.v_wait_insert[event_name] = true
        end
      else
        self[event_key][instance] = true
      end
    end
  end
end

function M:_remove_event_listener(instance)
  local event_key, event_key2
  for _, event_name in pairs(EVENTS) do
    event_key, event_key2 = _get_event_key(event_name)
    self[event_key][instance] = nil
    self[event_key2][instance] = nil
  end
end

function M:_remove_listen(char)
  for type, mqs in pairs(self.v_mqs) do
    for tag, tag_mqs in pairs(mqs) do
      local npc_mqs = tag_mqs[char]
      UtilTable.clear_map(npc_mqs)
    end
  end
end

function M:remove_manager(file)
  if self.v_wait_load_maneger[file] then
    self.v_wait_load_maneger[file] = nil
    self.v_wait_load_count = self.v_wait_load_count - 1
  end
  local instance = self.v_file_to_manager[file]
  if not instance then
    return
  end
  self:_remove_event_listener(instance)
  if instance.on_remove then
    instance:on_remove()
  end
  self.v_file_to_manager[file] = nil
end

function M:remove(file, char)
  if self.v_wait_load[char] then
    self.v_wait_load[char] = nil
    self.v_wait_load_count = self.v_wait_load_count - 1
  end
  local char_behaviors = self.v_char_to_behaviors[char]
  if not char_behaviors then
    return
  end
  local instance = char_behaviors[file]
  if not instance then
    return
  end
  self:_remove_event_listener(instance)
  if instance.on_remove then
    instance:on_remove()
  end
  if char:is_destroy() then
    self:_remove_listen(char)
  end
  char_behaviors[file] = nil
end

function M:get_module_map()
  return self.v_modules
end

function M:switch_char_behavior(file, char)
  self:_inner_destroy_obj(char, char.uuid)
  local cb
  if char:is_role() and char._on_load_file_finish then
    cb = char._on_load_file_finish
  end
  self:load(file, char, cb)
end

function M:clear_all(is_clear_scene)
  if is_clear_scene then
    self.v_char_to_behaviors = {}
  end
  local CommonManager = M.SCOPE_GLOBAL.ComnMgr
  UtilTable.clear_map(M.SCOPE_GLOBAL)
  UtilTable.clear_map(self.v_char_scopes)
  self.v_modules = {}
  self.v_wait_load = {}
  self.v_wait_load_maneger = {}
  self.v_wait_load_count = 0
  self.v_hero_behavior_list = {}
  self.v_mqs = {}
  self.v_event_lock = {}
  self.v_wait_insert = {}
  local event_key, event_key2
  for _, event_name in pairs(EVENTS) do
    event_key, event_key2 = _get_event_key(event_name)
    self[event_key] = {}
    self[event_key2] = {}
  end
  BehaviorLoader:clear_all()
  SceneBehaviorLoader:clear_all()
  if Util.is_client_only() and CommonManager then
    self:remove_manager(CommonManager.file_id)
    UtilTable.clear_map(self.v_file_to_manager)
    self:create_common_manager()
  end
  self:clear_all_manager()
  if is_clear_scene then
    self:destroy_all_manager()
  end
  EVENT_NAME_CACHE = {}
  EVENT2_NAME_CACHE = {}
end

function M:reload_all()
  local char_behaviors = self.v_char_to_behaviors
  self:clear_all()
  local temp_file_map = {}
  for char, behaviors in pairs(char_behaviors) do
    for file, _ in pairs(behaviors) do
      temp_file_map[file] = char
      behaviors[file] = nil
    end
  end
  for file, char in pairs(temp_file_map) do
    local born_magic = char.character_cfg.BornMagic and char.character_cfg.BornMagic[1]
    local cb
    if born_magic == file then
      cb = char._on_load_file_finish
    end
    self:load(file, char, cb)
  end
end

function M:on_destroy_obj(char)
  if not self.v_char_to_behaviors then
    return
  end
  if not self.v_char_to_behaviors[char] then
    return
  end
  NextFrameMgr:add_next_update(self._inner_destroy_obj, self, char, char.uuid)
end

function M:_inner_destroy_obj(char, uuid)
  if char.uuid ~= uuid then
    return
  end
  if not self.v_char_to_behaviors then
    return
  end
  local behaviors = self.v_char_to_behaviors[char]
  if behaviors then
    for _, behavior in pairs(behaviors) do
      self:remove(behavior.file_id, char)
    end
  end
  self.v_char_to_behaviors[char] = nil
end

function M:create_common_manager()
  local manager_path = "common.common_manager"
  self:load_manager(manager_path)
end

function M:destroy_all_manager()
  if not self.v_file_to_manager then
    return
  end
  for _, instance in pairs(self.v_file_to_manager) do
    if instance.on_destroy_mamager then
      instance:on_destroy_mamager()
    end
  end
  UtilTable.clear_map(self.v_file_to_manager)
end

function M:clear_all_manager()
  if not self.v_file_to_manager then
    return
  end
  for _, instance in pairs(self.v_file_to_manager) do
    if instance.on_clear_manager then
      instance:on_clear_manager()
    end
  end
end

function M:update()
  local dt = Global.delta_time
  self.v_last_update_time = self.v_last_update_time + dt
  if self.v_last_update_time < UPDATE_INTERVAL then
    return
  end
  self:update_scene_logic_behavior()
  dt = dt > UPDATE_INTERVAL and dt or UPDATE_INTERVAL
  self.v_last_update_time = self.v_last_update_time - dt
  if not Global.is_cg_active_lua or Global.stop_behavior then
    return
  end
  self.frame_update_start = true
  for instance in pairs(self.v_on_frames) do
    if not instance.npc.in_background and not instance.npc.in_ground then
      instance:on_frame(dt)
    elseif instance.on_frame_background and instance.npc.in_background then
      instance:on_frame_background(dt)
    elseif instance.on_frame_ground and instance.npc.in_ground then
      instance:on_frame_ground(dt)
    end
  end
  if M.SCOPE_GLOBAL.ComnMgr then
    M.SCOPE_GLOBAL.ComnMgr:on_frame_update(dt)
  end
  self.frame_update_start = false
  if self.v_wait_load_count > 0 then
    for char, v in pairs(self.v_wait_load) do
      self:load(v.file, char, v.callback)
      self.v_wait_load[char] = nil
      self.v_wait_load_count = self.v_wait_load_count - 1
    end
    for file in pairs(self.v_wait_load_maneger) do
      self:load_manager(file)
      self.v_wait_load_maneger[file] = nil
      self.v_wait_load_count = self.v_wait_load_count - 1
    end
  end
  local event_key, event_key2
  for event_name in pairs(self.v_wait_insert) do
    event_key, event_key2 = _get_event_key(event_name)
    for instance in pairs(self[event_key2]) do
      self[event_key][instance] = true
      self[event_key2][instance] = nil
    end
    self.v_wait_insert[event_name] = nil
  end
end

function M:update_scene_logic_behavior()
  local scene_logic = SceneMgr and SceneMgr:get_scene_logic()
  local scene_logic_runner = scene_logic and scene_logic:get_scene_logic_runner()
  if scene_logic_runner then
    scene_logic_runner:on_frame()
  end
end

function M:set_hero_behaviour_value(set_type, ...)
  local value = {
    ...
  }
  if set_type == HERO_BEHAVIOR_VALUE.LOCK_AND_TURN_SETTING then
    for _, file in pairs(self.v_hero_behavior_list) do
      local type = value[1]
      if type == AUTO_LOCK_TYPE.CLOSE then
        file.lock_setting = 1
        file.turn_setting = 1
      elseif type == AUTO_LOCK_TYPE.OPEN then
        file.lock_setting = 1
        file.turn_setting = 0
      end
    end
  end
end

function M:call_event_fun(fun_name, ...)
  local call_count = self.v_fun_call_count[fun_name] or 0
  call_count = call_count + 1
  self.v_fun_call_count[fun_name] = call_count
  if call_count > 5 then
    Log.Error("环形堆栈调用函数:" .. fun_name .. " tracback " .. debug.traceback())
    return
  end
  self.v_event_lock[fun_name] = true
  self[fun_name](self, ...)
  self.v_event_lock[fun_name] = false
  self.v_fun_call_count[fun_name] = 0
end

function M:call_behavior_fun(role, fun_name, ...)
  if Util.is_destroy(role) then
    return
  end
  local behaviors = self.v_char_to_behaviors[role]
  if not behaviors then
    return
  end
  local call_count = self.v_fun_call_count[fun_name] or 0
  call_count = call_count + 1
  self.v_fun_call_count[fun_name] = call_count
  if call_count > 5 then
    Log.Error("环形堆栈调用函数:" .. fun_name .. " tracback " .. debug.traceback())
    return
  end
  self.v_event_lock[fun_name] = true
  for _, behavior in pairs(behaviors) do
    local func = behavior[fun_name]
    if func then
      func(behavior, ...)
    end
  end
  self.v_event_lock[fun_name] = false
  self.v_fun_call_count[fun_name] = 0
end

function M:call_scene_logic_event_fun(fun_name, ...)
  local call_count = self.v_fun_call_count[fun_name] or 0
  call_count = call_count + 1
  self.v_fun_call_count[fun_name] = call_count
  if call_count > 5 then
    Log.Error("环形堆栈调用函数:" .. fun_name .. " tracback " .. debug.traceback())
    return
  end
  self.v_event_lock[fun_name] = true
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  local result1, result2
  if scene_logic_runner then
    result1, result2 = scene_logic_runner:run_event(fun_name, ...)
  end
  self.v_event_lock[fun_name] = false
  self.v_fun_call_count[fun_name] = 0
  return result1, result2
end

function M:on_input(input_id, force)
  local hero_processed
  for instance in pairs(self.v_on_inputs) do
    if not instance.is_role_behavior then
      instance:on_input(input_id)
    elseif not hero_processed and (instance.npc.in_control or force) then
      hero_processed = true
      instance:on_input(input_id)
    end
  end
end

function M:on_touch_up(output_id, iscancle, input_time, source_type)
  local hero_processed
  for instance in pairs(self.v_on_touch_ups) do
    if not instance.is_role_behavior then
      instance:on_touch_up(output_id, iscancle, input_time, source_type)
    elseif not hero_processed and instance.npc.in_control then
      hero_processed = true
      instance:on_touch_up(output_id, iscancle, input_time, source_type)
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type, skill_cfg)
  for instance in pairs(self.v_on_skill_begins) do
    instance:on_skill_begin(npc, skill_id, skill_type, skill_cfg)
  end
end

function M:on_skill_before_time(skill_id)
  for instance in pairs(self.v_on_skill_before_times) do
    instance:on_skill_before_time(skill_id)
  end
end

function M:on_skill_cast_time(skill_id)
  for instance in pairs(self.v_on_skill_cast_times) do
    instance:on_skill_cast_time(skill_id)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  for instance in pairs(self.v_on_skill_hits) do
    instance:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  end
end

function M:on_before_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  for instance in pairs(self.v_on_before_skill_ends) do
    instance:on_before_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  for instance in pairs(self.v_on_skill_ends) do
    instance:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  for instance in pairs(self.v_on_missile_collides) do
    if m2_owner == instance.npc or m2_cfg.Id < m1_cfg.Id then
      instance:on_missile_collide(m2_owner, m1_owner, m2, m1, m2_cfg, m1_cfg)
    else
      instance:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
    end
  end
end

function M:on_npc_removed(npc, skill_id)
  for instance in pairs(self.v_on_npc_removeds) do
    instance:on_npc_removed(npc, skill_id)
  end
end

function M:on_before_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  for instance in pairs(self.v_on_before_npc_hp_zeros) do
    instance:on_before_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  end
end

function M:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower and npc:is_hero() then
      local tower_id = tower:get_tower_id()
      local reborn_cfg = ShareRes.get_reborn_id_by_tower_id(tower_id)
      reborn_cfg = reborn_cfg or ShareRes.get_chapter_reborn_cfg(Config.REBORN_TYPE.NORMAL)
      if reborn_cfg.Id == Config.REBORN_TYPE.INFINITE_FREE then
        npc.magic_mgr:add_magic(npc, 4010160)
        return
      end
    end
  end
  for instance in pairs(self.v_on_npc_hp_zeros) do
    instance:on_npc_hp_zero(npc, attacker, magic_id, missile_id, missile)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  for instance in pairs(self.v_on_hero_showup_or_backs) do
    instance:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  end
end

function M:on_camera_operation(type, time)
  for instance in pairs(self.v_on_camera_operations) do
    instance:on_camera_operation(type, time)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, camp, change_tough, magic_level, owner_skill_id, owner_missile)
  for instance in pairs(self.v_before_damages) do
    instance:before_damage(npc, target, magic_id, damage_sign, damage_type, camp, change_tough, magic_level, owner_skill_id, owner_missile)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_hurt, element_hurt, owner_skill_id, owner_missile)
  for instance in pairs(self.v_after_damages) do
    instance:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_hurt, element_hurt, owner_skill_id, owner_missile)
  end
end

function M:before_abnormal_damage(caster, attacker, npc, magic_id)
  for instance in pairs(self.v_before_abnormal_damages) do
    instance:before_abnormal_damage(caster, attacker, npc, magic_id)
  end
end

function M:after_abnormal_damage(caster, attacker, npc, magic_id)
  for instance in pairs(self.v_after_abnormal_damages) do
    instance:after_abnormal_damage(caster, attacker, npc, magic_id)
  end
end

function M:on_critical(npc, target, magic_cfg, magic_id)
  for instance in pairs(self.v_on_criticals) do
    instance:on_critical(npc, target, magic_cfg, magic_id)
  end
end

function M:before_heal(npc, target, magic_id)
  for instance in pairs(self.v_before_heals) do
    instance:before_heal(npc, target, magic_id)
  end
end

function M:after_heal(npc, target, magic_id, heal_val)
  for instance in pairs(self.v_after_heals) do
    instance:after_heal(npc, target, magic_id, heal_val)
  end
end

function M:on_room_change(npc)
  for instance in pairs(self.v_on_room_changes) do
    instance:on_room_change(npc)
  end
end

function M:on_floor_start(npc1, npc2, npc3, level)
  for instance in pairs(self.v_on_floor_starts) do
    instance:on_floor_start(npc1, npc2, npc3, level)
  end
end

function M:on_floor_finished(npc1, npc2, npc3, level)
  for instance in pairs(self.v_on_floor_finisheds) do
    instance:on_floor_finished(npc1, npc2, npc3, level)
  end
end

function M:on_hero_reborn(reborned_hero)
  for instance in pairs(self.v_on_hero_reborns) do
    instance:on_hero_reborn(reborned_hero)
  end
end

function M:on_scene_change()
  for instance in pairs(self.v_on_scene_changes) do
    instance:on_scene_change()
  end
end

function M:on_part_hit(npc, target, part_id)
  for instance in pairs(self.v_on_part_hits) do
    if target == instance.npc or npc == instance.npc then
      instance:on_part_hit(npc, target, part_id)
    end
  end
end

function M:on_part_damage(npc, target, part_id, cur_hp, is_crit, damage_val, magic_id)
  for instance in pairs(self.v_on_part_damages) do
    if target == instance.npc or npc == instance.npc then
      instance:on_part_damage(npc, target, part_id, cur_hp, is_crit, damage_val, magic_id)
    end
  end
end

function M:on_born_behavior(npc)
  for instance in pairs(self.v_on_born_behaviors) do
    if instance.npc == npc then
      instance:on_born_behavior()
    end
  end
end

function M:on_all_born_behavior()
  for instance in pairs(self.v_on_born_behaviors) do
    instance:on_born_behavior()
  end
end

function M:on_npc_beattack_collider(npc, hero, collider_npc, hit_wall_cfg)
  for instance in pairs(self.v_on_npc_beattack_colliders) do
    instance:on_npc_beattack_collider(npc, hero, collider_npc, hit_wall_cfg)
  end
end

function M:on_get_battle_skill(npc, magic_id)
  for instance in pairs(self.v_on_get_battle_skills) do
    instance:on_get_battle_skill(npc, magic_id)
  end
end

function M:effect_aborn_magic(npc, target, element)
  for instance in pairs(self.v_effect_aborn_magics) do
    instance:effect_aborn_magic(npc, target, element)
  end
end

local _def_magic_tag = "DEF_MAGIC_TAG"

local function call_magic_mq(self, type, magic_id, ...)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag_mqs = mqs[_def_magic_tag]
  if not tag_mqs then
    return
  end
  for _, npc_mqs in pairs(tag_mqs) do
    local magic_mqs = npc_mqs[magic_id]
    if magic_mqs then
      for instance, callback in pairs(magic_mqs) do
        callback(instance, ...)
      end
    end
  end
end

function M:on_magic_begin_msg(npc, target, magic_id, magic_kind, magic_type)
  call_magic_mq(self, MAGIC_EVT_TYPE.BEGIN, magic_id, npc, target, magic_id, magic_kind, magic_type)
end

function M:on_magic_end_msg(npc, target, magic_id, magic_kind, magic_type, is_break)
  call_magic_mq(self, MAGIC_EVT_TYPE.END, magic_id, npc, target, magic_id, magic_kind, magic_type, is_break)
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level, magic_kind, magic_type)
  if not is_self then
    for instance in pairs(self.v_on_magic_begins) do
      instance:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
    end
  else
    local npc_behavior = self.v_char_to_behaviors[npc]
    if npc_behavior then
      local born_magic = npc:get_born_magics()
      local instance = npc_behavior[born_magic]
      instance:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
    end
  end
end

function M:on_magic_end(npc, target, magic_id, is_self, magic_kind, magic_type, is_break)
  if not is_self then
    for instance in pairs(self.v_on_magic_ends) do
      instance:on_magic_end(npc, target, magic_id, magic_kind, magic_type, is_break)
    end
  else
    local npc_behavior = self.v_char_to_behaviors[npc]
    if npc_behavior then
      local born_magic = npc:get_born_magics()
      local instance = npc_behavior[born_magic]
      instance:on_magic_end(npc, target, magic_id, magic_kind, magic_type, is_break)
    end
  end
end

function M:listen_magic_mq(type, npc, magic_id, callback, instance)
  local mqs = self.v_mqs[type]
  if not mqs then
    mqs = {}
    self.v_mqs[type] = mqs
  end
  local tag = _def_magic_tag
  local tag_mqs = mqs[tag]
  if not tag_mqs then
    tag_mqs = {}
    mqs[tag] = tag_mqs
  end
  local npc_mqs = tag_mqs[npc]
  if not npc_mqs then
    npc_mqs = {}
    tag_mqs[npc] = npc_mqs
  end
  local magic_mqs = npc_mqs[magic_id]
  if not magic_mqs then
    magic_mqs = {}
    npc_mqs[magic_id] = magic_mqs
  end
  if magic_mqs[instance] then
    Log.Error("已经绑定过magic_id事件", type, magic_id, debug.traceback())
  end
  magic_mqs[instance] = callback
end

function M:unlisten_magic_mq(npc, type, magic_id, instance)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag = _def_magic_tag
  local tag_mqs = mqs[tag]
  if not tag_mqs then
    Log.Error("没有给NPC绑定过特定tag的magic事件", type, magic_id, debug.traceback())
    return
  end
  local npc_mqs = tag_mqs[npc]
  if not npc_mqs then
    Log.Error("没有给NPC绑定过magic事件", type, magic_id, debug.traceback())
    return
  end
  local magic_mqs = npc_mqs[magic_id]
  if not magic_mqs then
    return
  end
  magic_mqs[instance] = nil
end

function M:get_behavior_by_obj(obj)
  return self.v_char_to_behaviors and self.v_char_to_behaviors[obj]
end

local _def_missile_tag = "DEF_MISSILE_TAG"

local function call_missile_mq(self, type, missile_id, ...)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag_mqs = mqs[_def_missile_tag]
  if not tag_mqs then
    return
  end
  for _, npc_mqs in pairs(tag_mqs) do
    local missile_mqs = npc_mqs[missile_id]
    if missile_mqs then
      for instance, callback in pairs(missile_mqs) do
        callback(instance, ...)
      end
    end
  end
end

function M:on_missile_begin_msg(owner, pos_x, pos_z, missile_cfg, missile)
  call_missile_mq(self, MISSILE_EVT_TYPE.BEGIN_POS, missile_cfg.Id, owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_end_msg(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  call_missile_mq(self, MISSILE_EVT_TYPE.END_POS, missile_cfg.Id, owner, pos_x, pos_z, missile_cfg, missile, is_break)
end

function M:on_missile_collide_obstacle_msg(owner, obstacle_type, missile_cfg, missile)
  call_missile_mq(self, MISSILE_EVT_TYPE.COLLIDE_OBSTACLE, missile_cfg.Id, owner, obstacle_type, missile_cfg, missile)
end

function M:on_missile_bound_catch_missile(owner, target_missile_cfg, target_missile, missile_cfg, missile, target_missile_owner)
  call_missile_mq(self, MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, missile_cfg.Id, owner, target_missile_cfg, target_missile, missile_cfg, missile, target_missile_owner)
end

function M:on_missile_bound_release_missile(owner, target_missile, missile_cfg, missile)
  call_missile_mq(self, MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, missile_cfg.Id, owner, target_missile, missile_cfg, missile)
end

function M:on_missile_bound_catch_npc(owner, target_npc, missile_cfg, missile)
  call_missile_mq(self, MISSILE_EVT_TYPE.BOUND_CATCH_NPC, missile_cfg.Id, owner, target_npc, missile_cfg, missile)
end

function M:on_missile_bound_release_npc(owner, target_npc, missile_cfg, missile)
  call_missile_mq(self, MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, missile_cfg.Id, owner, target_npc, missile_cfg, missile)
end

local _def_button_tag = "DEF_BUTTON_TAG"

local function call_button_mq(self, type, ...)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag_mqs = mqs[_def_button_tag]
  if not tag_mqs then
    return
  end
  for _, npc_mqs in pairs(tag_mqs) do
    for instance, callback in pairs(npc_mqs) do
      callback(instance, ...)
    end
  end
end

function M:on_button_drag_state_change(...)
  call_button_mq(self, BUTTON_EVT_TYPE.DRAG_STATE_CHANGE, ...)
end

function M:listen_button_mq(type, npc, callback, instance)
  local mqs = self.v_mqs[type]
  if not mqs then
    mqs = {}
    self.v_mqs[type] = mqs
  end
  local tag = _def_button_tag
  local tag_mqs = mqs[tag]
  if not tag_mqs then
    tag_mqs = {}
    mqs[tag] = tag_mqs
  end
  local npc_mqs = tag_mqs[npc]
  if not npc_mqs then
    npc_mqs = {}
    tag_mqs[npc] = npc_mqs
  end
  if npc_mqs[instance] then
    Log.Error("已经绑定过drag事件", type, npc.id, debug.traceback())
  end
  npc_mqs[instance] = callback
end

function M:unlisten_button_mq(type, npc, instance)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag_mqs = mqs[_def_button_tag]
  if not tag_mqs or not tag_mqs[npc] then
    return
  end
  local npc_mqs = tag_mqs[npc]
  if npc_mqs[instance] then
    npc_mqs[instance] = nil
  end
end

function M:listen_custom_event_mq(event_name, npc, callback, instance)
  local mqs = self.v_mqs[CUSTOM_EVENT_TYPE]
  if not mqs then
    mqs = {}
    self.v_mqs[CUSTOM_EVENT_TYPE] = mqs
  end
  local event_mqs = mqs[event_name]
  if not event_mqs then
    event_mqs = {}
    mqs[event_name] = event_mqs
  end
  local instance_mqs = event_mqs[npc]
  if not instance_mqs then
    instance_mqs = {}
    event_mqs[npc] = instance_mqs
  end
  if instance_mqs[instance] then
    Log.Error("已经绑定过事件", event_name, npc.id, debug.traceback())
  end
  instance_mqs[instance] = callback
end

function M:unlisten_custom_event_mq(event_name, npc, instance)
  local mqs = self.v_mqs[CUSTOM_EVENT_TYPE]
  if not mqs then
    return
  end
  local event_mqs = mqs[event_name]
  if not event_mqs or not event_mqs[npc] then
    return
  end
  local instance_mqs = event_mqs[npc]
  if instance_mqs[instance] then
    instance_mqs[instance] = nil
  end
end

function M:call_custom_event_mq(event_name, npc, ...)
  local mqs = self.v_mqs[CUSTOM_EVENT_TYPE]
  if not mqs then
    return
  end
  local npc_mqs = mqs[event_name]
  if not npc_mqs then
    return
  end
  local instance_mqs = npc_mqs[npc]
  if not instance_mqs then
    return
  end
  for instance, callback in pairs(instance_mqs) do
    callback(instance, npc, ...)
  end
end

function M:on_role_attr_change(msg)
  local change_value = msg.mm_obj
  if 0 == change_value then
    return
  end
  local mq_type = LuaBehaviorConst.ATTR_CHANGE_EVENT_TYPE
  local mqs = self.v_mqs[mq_type]
  if not mqs then
    return
  end
  local uuid = msg.mm_x
  local target = SceneMgr:pick_by_uuid(uuid)
  if Util.is_destroy(target) then
    return
  end
  local attr_type = msg.mm_y
  local npc_mqs = mqs[attr_type]
  if not npc_mqs then
    return
  end
  local instance_mqs = npc_mqs[target]
  if not instance_mqs then
    return
  end
  for instance, callback in pairs(instance_mqs) do
    callback(instance, target, attr_type, change_value)
  end
end

function M:listen_attr_change_mq(npc, attr_type, callback, instance)
  if not instance or Util.is_destroy(npc) then
    return
  end
  local mq_type = LuaBehaviorConst.ATTR_CHANGE_EVENT_TYPE
  local mqs = self.v_mqs[mq_type]
  if not mqs then
    mqs = {}
    self.v_mqs[mq_type] = mqs
  end
  local npc_mqs = mqs[attr_type]
  if not npc_mqs then
    npc_mqs = {}
    mqs[attr_type] = npc_mqs
  end
  local attr_mqs = npc_mqs[npc]
  if not attr_mqs then
    attr_mqs = {}
    npc_mqs[npc] = attr_mqs
  end
  if attr_mqs[instance] then
    Log.Error("已经绑定过属性变化事件", type, npc.id, debug.traceback())
  end
  attr_mqs[instance] = callback
  npc.attr_mgr:add_listener_attr(attr_type)
end

function M:unlisten_attr_change_mq(npc, attr_type, instance)
  if not instance then
    return
  end
  if not Util.is_destroy(npc) then
    npc.attr_mgr:remove_listener_attr(attr_type)
  end
  local mq_type = LuaBehaviorConst.ATTR_CHANGE_EVENT_TYPE
  local mqs = self.v_mqs[mq_type]
  if not mqs then
    return
  end
  local npc_mqs = mqs[attr_type]
  if not npc_mqs then
    return
  end
  local instance_mqs = npc_mqs[npc]
  if not instance_mqs then
    return
  end
  instance_mqs[instance] = nil
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  for instance in pairs(self.v_on_missile_begin_poss) do
    instance:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  for instance in pairs(self.v_on_missile_end_poss) do
    instance:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  end
end

function M:on_reconnect()
  for instance in pairs(self.v_on_reconnects) do
    instance:on_reconnect()
  end
end

function M:on_finish_guide(guide_id, is_click_skip)
  for instance in pairs(self.v_on_finish_guides) do
    instance:on_finish_guide(guide_id, is_click_skip)
  end
end

function M:on_click_fight_story(story_id, branch_id)
  for instance in pairs(self.v_on_click_fight_storys) do
    instance:on_click_fight_story(story_id, branch_id)
  end
end

function M:on_texture_guide_finish(group_id)
  for instance in pairs(self.v_on_texture_guide_finishs) do
    instance:on_texture_guide_finish(group_id)
  end
end

function M:on_story_finish(story_id)
  for instance in pairs(self.v_on_story_finishs) do
    instance:on_story_finish(story_id)
  end
end

function M:on_activate_pov_camera(pov_index)
  for instance in pairs(self.v_on_activate_pov_cameras) do
    instance:on_activate_pov_camera(pov_index)
  end
end

function M:on_deactivate_pov_camera()
  for instance in pairs(self.v_on_deactivate_pov_cameras) do
    instance:on_deactivate_pov_camera()
  end
end

function M:listen_missile_mq(npc, type, missile_id, callback, instance)
  if not missile_id then
    return
  end
  local mqs = self.v_mqs[type]
  if not mqs then
    mqs = {}
    self.v_mqs[type] = mqs
  end
  local tag = _def_missile_tag
  local tag_mqs = mqs[tag]
  if not tag_mqs then
    tag_mqs = {}
    mqs[tag] = tag_mqs
  end
  local npc_mqs = tag_mqs[npc]
  if not npc_mqs then
    npc_mqs = {}
    tag_mqs[npc] = npc_mqs
  end
  local missile_mqs = npc_mqs[missile_id]
  if not missile_mqs then
    missile_mqs = {}
    npc_mqs[missile_id] = missile_mqs
  end
  if missile_mqs[instance] then
    Log.Error("已经绑定过missile事件", type, missile_id, debug.traceback())
  end
  missile_mqs[instance] = callback
end

function M:unlisten_missile_mq(npc, type, missile_id, instance)
  local mqs = self.v_mqs[type]
  if not mqs then
    return
  end
  local tag = _def_missile_tag
  local tag_mqs = mqs[tag]
  if not tag_mqs then
    Log.Error("没有给NPC绑定过特定tag的missile事件", type, missile_id, debug.traceback())
    return
  end
  local npc_mqs = tag_mqs[npc]
  if not npc_mqs then
    Log.Error("没有给NPC绑定过missile事件", type, missile_id, debug.traceback())
    return
  end
  local missile_mqs = npc_mqs[missile_id]
  if not missile_mqs then
    return
  end
  if missile_mqs[instance] then
    missile_mqs[instance] = nil
  end
end

function M:on_skill_teach_tips_close(tips_id)
  for instance in pairs(self.v_on_skill_teach_tips_closes) do
    instance:on_skill_teach_tips_close(tips_id)
  end
end

function M:on_hero_born_anim_end()
  for instance in pairs(self.v_on_hero_born_anim_ends) do
    instance:on_hero_born_anim_end()
  end
end

function M:on_enter_area(npc, area)
  for instance in pairs(self.v_on_enter_areas) do
    instance:on_enter_area(npc, area)
  end
end

function M:on_leave_area(npc, area)
  for instance in pairs(self.v_on_leave_areas) do
    instance:on_leave_area(npc, area)
  end
end

function M:on_npc_dead(npc)
  for instance in pairs(self.v_on_npc_deads) do
    instance:on_npc_dead(npc)
  end
end

function M:on_timeline_end(timeline_name)
  for instance in pairs(self.v_on_timeline_ends) do
    instance:on_timeline_end(timeline_name)
  end
end

function M:on_timeline_begin(timeline_name)
  for instance in pairs(self.v_on_timeline_begins) do
    instance:on_timeline_begin(timeline_name)
  end
end

function M:on_npc_group_clear(group_id)
  for instance in pairs(self.v_on_npc_group_clears) do
    instance:on_npc_group_clear(group_id)
  end
end

function M:on_video_play_end()
  for instance in pairs(self.v_on_video_play_ends) do
    instance:on_video_play_end()
  end
end

function M:remove_buff(buff_id)
  for instance in pairs(self.v_remove_buffs) do
    instance:remove_buff(buff_id)
  end
end

function M:remove_curse(curse_id)
  for instance in pairs(self.v_remove_curses) do
    instance:remove_curse(curse_id)
  end
end

function M:on_role_level_change(npc, level)
  for instance in pairs(self.v_on_role_level_changes) do
    if instance.npc.uuid == npc.uuid then
      instance:on_role_level_change(level)
    end
  end
end

function M:on_npc_born(npc)
  for instance in pairs(self.v_on_npc_borns) do
    instance:on_npc_born(npc)
  end
end

function M:on_room_pass(room_id)
  for instance in pairs(self.v_on_room_passs) do
    instance:on_room_pass(room_id)
  end
end

function M:on_enter_room(room_id, is_first_enter)
  for instance in pairs(self.v_on_enter_rooms) do
    instance:on_enter_room(room_id, is_first_enter)
  end
end

function M:on_toughness_change(npc, camp, change_level, enter_stun)
  for instance in pairs(self.v_on_toughness_changes) do
    instance:on_toughness_change(npc, camp, change_level, enter_stun)
  end
end

function M:on_story_begin(story_id, step_id, branch_id)
  for instance in pairs(self.v_on_story_begins) do
    instance:on_story_begin(story_id, step_id, branch_id)
  end
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  for instance in pairs(self.v_on_element_aborn_starts) do
    instance:on_element_aborn_start(npc, element, skill_id, attacker)
  end
end

function M:on_element_aborn_end(npc, element, attacker)
  for instance in pairs(self.v_on_element_aborn_ends) do
    instance:on_element_aborn_end(npc, element, attacker)
  end
end

function M:on_fate_book_battle_start()
  for instance in pairs(self.v_on_fate_book_battle_starts) do
    instance:on_fate_book_battle_start()
  end
end

function M:on_minesweeper_battle_start()
  for instance in pairs(self.v_on_minesweeper_battle_starts) do
    instance:on_minesweeper_battle_start()
  end
end

function M:on_all_ai_dead()
  for instance in pairs(self.v_on_all_ai_deads) do
    instance:on_all_ai_dead()
  end
end

function M:on_hero_enter_ground_state(hero)
  for instance in pairs(self.v_on_hero_enter_ground_states) do
    if not instance.npc:is_hero() or instance.npc.in_ground then
      instance:on_hero_enter_ground_state(hero)
    end
  end
end

function M:on_before_skill_link_end(hero)
  for instance in pairs(self.v_on_before_skill_link_ends) do
    if instance.npc:is_hero() and instance.npc.in_control then
      instance:on_before_skill_link_end(hero)
    end
  end
end

function M:on_skill_link_start(hero)
  for instance in pairs(self.v_on_skill_link_starts) do
    if instance.npc:is_hero() and instance.npc.in_control then
      instance:on_skill_link_start(hero)
    end
  end
end

function M:on_skill_link_timer_end(stage)
  for instance in pairs(self.v_on_skill_link_timer_ends) do
    if instance.npc:is_hero() then
      instance:on_skill_link_timer_end(stage)
    end
  end
end

function M:before_shield(...)
  for instance in pairs(self.v_before_shields) do
    instance:before_shield(...)
  end
end

function M:after_shield(...)
  for instance in pairs(self.v_after_shields) do
    instance:after_shield(...)
  end
end

function M:on_tp_room_finish()
  for instance in pairs(self.v_on_tp_room_finishs) do
    instance:on_tp_room_finish()
  end
end

function M:on_god_born(god)
  for instance in pairs(self.v_on_god_borns) do
    instance:on_god_born(god)
  end
end

function M:on_force_shift_end(...)
  for instance in pairs(self.v_on_force_shift_ends) do
    instance:on_force_shift_end(...)
  end
end

return M
