local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ENEMY_BAR_ITEM_CLASS = require("uimodule.fight.bar.enemy_bar_item")
local PART_BAR_ITEM_CLASS = require("uimodule.fight.bar.part_bar_item")
local StaticSV = require("ui.widget.static_scroll_view")
local SUB_ENEMY_BAR_KEY = "SUB_ENEMY_BAR_KEY"
local MAIN_ENEMY_BAR_KEY = "MAIN_ENEMY_BAR_KEY"
local ELITE_ENEMY_BAR_KEY = "ELITE_ENEMY_BAR_KEY"
local MULTI_ENEMY_BAR_KEY = "MULTI_ENEMY_BAR_KEY"
local WEAKENESS_TEMP_KEY = "WEAKENESS_TEMP_KEY"
local INTERVAL_TEMP_KEY = "INTERVAL_TEMP_KEY"
local HP_WIDTH = 670
local EB_SCALE_X = 1.002
local MAX_RIGHT_X = 668
local MIN_RIGHT_X = 2
local INTERVAL_RIGHT_X = MAX_RIGHT_X - MIN_RIGHT_X
local ELITE_HP_WIDTH = 181
local ELITE_MAX_RIGHT_X = 189
local ELITE_MIN_RIGHT_X = 2
local ELITE_INTERVAL_RIGHT_X = ELITE_MAX_RIGHT_X - ELITE_MIN_RIGHT_X
local MULTI_HP_WIDTH = 372
local MULTI_EB_SCALE_X = 0.5553
local MULTI_MAX_RIGHT_X = 380
local MULTI_MIN_RIGHT_X = 2
local MULTI_INTERVAL_RIGHT_X = MULTI_MAX_RIGHT_X - MULTI_MIN_RIGHT_X
local FADE_ALPHA = 0
local SHOW_ALPHA = 1
local SHOW_TIME = 0.5
local FADE_TIME = 0.25
local INIT_X = -194
local TARGET_X = 0
local SUB_ENEMY_BAR_TYPE = {
  DEFAULT = 1,
  FOLLOWER = 2,
  PART = 3
}
local BOSS_BREAK_MAGIC = ShareRes.get_comm_string_value("BossToughBreakMagic")
local ELITE_BREAK_MAGIC = ShareRes.get_comm_string_value("EliteToughBreakMagic")
local BOSS_TOUGH_BREAK_MAGIC_MAP = {}
for key, magic in pairs(BOSS_BREAK_MAGIC) do
  if Util.is_table(magic) then
    for _, magic_id in pairs(magic) do
      BOSS_TOUGH_BREAK_MAGIC_MAP[magic_id] = true
    end
  elseif Util.is_number(magic) then
    BOSS_TOUGH_BREAK_MAGIC_MAP[magic] = true
  end
end
local ELITE_BREAK_MAGIC_MAP = {}
for key, magic in pairs(ELITE_BREAK_MAGIC) do
  if Util.is_table(magic) then
    for _, magic_id in pairs(magic) do
      ELITE_BREAK_MAGIC_MAP[magic_id] = true
    end
  elseif Util.is_number(magic) then
    ELITE_BREAK_MAGIC_MAP[magic] = true
  end
end
local TOUGH_CHANGE_FUNC = {
  [Config.TOUGH_CHANGE_TYPE.RESET_TOUGH_PARAM] = function(self, msg)
    self:_on_npc_tough_param_reset(msg)
  end,
  [Config.TOUGH_CHANGE_TYPE.TOUGH_LV_DOWN] = function(self, msg)
    self:_on_npc_tough_lv_down(msg)
  end,
  [Config.TOUGH_CHANGE_TYPE.TOUGH_LV_UP] = function(self, msg)
    self:_on_npc_tough_lv_up(msg)
  end,
  [Config.TOUGH_CHANGE_TYPE.TOUGH_CLEAR] = function(self, msg)
    self:_on_npc_tough_clear(msg)
  end,
  [Config.TOUGH_CHANGE_TYPE.TOUGH_RECOVER_DONE] = function(self, msg)
    self:_on_npc_tough_recover_done(msg)
  end,
  [Config.TOUGH_CHANGE_TYPE.TOUGH_RECOVER_START] = function(self, msg)
    self:_on_npc_tough_recover_start(msg)
  end
}

function ui:bind_mq()
  self:bind_auto_mq(Const.MSG_REMOVE_MAGIC, self._remove_buff, self)
  self:bind_auto_mq(Const.MSG_ADD_MAGIC, self._update_buff_list, self)
  self:bind_auto_mq(Const.MSG_ON_ELEMENT_MAGIC_COUNT_CHANGE, self._update_buff_level, self)
  self:bind_auto_mq(Const.MSG_ADD_MAGIC, self._on_magic_change, self)
  self:bind_auto_mq(Const.MSG_REMOVE_MAGIC, self._on_magic_change, self)
  self:bind_auto_mq(Const.MSG_TOUGHNESS_CHANGE, self._on_toughness_change, self)
  self:bind_auto_mq(Const.MSG_ON_ELEMENT_TIMER_REMOVE, self._on_element_timer_remove, self)
  self:bind_auto_mq(Const.MSG_NPC_ELEMENT_VALUE_CHANGE, self._on_element_value_change, self)
  self:bind_auto_mq(Const.MSG_ON_ELEMENT_STATE_CHANGE, self._on_element_state_change, self)
  self:bind_auto_mq(Const.MSG_ON_ELEMENT_TIMER_START, self._on_element_timer_start, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_NPC_PHASE_STATE, self._on_change_npc_phase_state, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_HEAL, self._on_role_heal, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_ATTR_CHANGE, self._on_role_hp_value_change, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_SHIELD_CHANGE, self._on_role_shield_change, self)
  self:bind_auto_mq(Const.MSG_ON_ABNORMAL_FLAG_CHANGE, self._on_abnormal_flag_change, self)
  self:bind_auto_mq(Const.MSG_ON_GAME_PAUSE, self._on_game_pause_state_change, self)
end

function ui:ui_finish_load()
  self.v_last_target_count = 0
  self.v_main_blood_list_cg = self:get_canvas_group(nil, self.v_uiobjects.MainEnemyBloodList).component
  self.v_multi_blood_list_cg = self:get_canvas_group(nil, self.v_uiobjects.DoubleEnemyBloodList).component
  self:register_exist_auto_template(MAIN_ENEMY_BAR_KEY, self.v_uiobjects.EnemyBloodObj, self.v_uiobjects.MainEnemyBloodList)
  self:register_exist_auto_template(SUB_ENEMY_BAR_KEY, self.v_uiobjects.EnemyBloodObj, self.v_uiobjects.SubEnemyBloodList)
  self:register_exist_auto_template(ELITE_ENEMY_BAR_KEY, self.v_uiobjects.EliteBloodObj, self.v_uiobjects.EliteEnemyBloodList)
  self:register_exist_auto_template(MULTI_ENEMY_BAR_KEY, self.v_uiobjects.MultiEnemyBloodItem, self.v_uiobjects.DoubleEnemyBloodList)
  self:register_exist_auto_template(WEAKENESS_TEMP_KEY, self.v_uiobjects.WeaknessTem, self.v_uiobjects.EnemyBarTemRoot)
  self:register_exist_auto_template(INTERVAL_TEMP_KEY, self.v_uiobjects.Interval, self.v_uiobjects.EnemyBarTemRoot)
  self.EnemyDataList = {}
  self.v_element_effect_map = {}
  self.v_temp_register_item_count = 0
  self.v_elite_hp_bar_list = {}
  self.v_multi_hp_bar_map = {}
  self.v_enemy_bar_map = {}
end

function ui:preload()
  local room = TowerMgr:get_cur_room()
  local room_preload_cfg = room:get_room_preload_cfg()
  if room_preload_cfg.monster then
    local character_cfg, hp_type
    local show_ui_count = 0
    for id, num in pairs(room_preload_cfg.monster) do
      character_cfg = ShareRes.get_character_cfg(id)
      if not character_cfg then
        Log.Error("获取单位配置失败, 怪物id:", id, debug.traceback())
      else
        hp_type = character_cfg.ShowSmallHpType
        local _, show_elite_bar, show_big_bar = Util.check_show_hp_bar_type(hp_type)
        if show_elite_bar then
          self:_preload_bar_obj(ELITE_ENEMY_BAR_KEY, num)
        elseif show_big_bar then
          self:_preload_bar_obj(MAIN_ENEMY_BAR_KEY, num)
          show_ui_count = show_ui_count + num
        end
        local FightDefine = Config.FightDefine
        for _, open_state in pairs(FightDefine.ABNORMAL_DEFAULT_STATUS) do
          if open_state ~= FightDefine.ABNORMAL_STATUS.CLOSE then
            self:get_auto_cache(WEAKENESS_TEMP_KEY)
          end
        end
      end
    end
    if show_ui_count >= 2 then
      self:_preload_bar_obj(MULTI_ENEMY_BAR_KEY, 2)
    end
    self:give_back_auto_cache(WEAKENESS_TEMP_KEY)
    self:give_back_auto_cache(MULTI_ENEMY_BAR_KEY)
    self:give_back_auto_cache(MAIN_ENEMY_BAR_KEY)
    self:give_back_auto_cache(ELITE_ENEMY_BAR_KEY)
  end
end

function ui:_preload_bar_obj(cache_key, num)
  for _ = 1, num do
    self:get_auto_cache(cache_key)
  end
end

function ui:_on_magic_change(msg)
  local magic_id = msg.mm_y
  local char = msg.mm_x
  local uuid = char.uuid
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item and (BOSS_TOUGH_BREAK_MAGIC_MAP and BOSS_TOUGH_BREAK_MAGIC_MAP[magic_id] or ELITE_BREAK_MAGIC_MAP and ELITE_BREAK_MAGIC_MAP[magic_id]) then
    bar_item:on_tough_break_magic_change()
  end
end

function ui:_on_toughness_change(msg)
  local type = msg.mm_y
  if TOUGH_CHANGE_FUNC[type] then
    TOUGH_CHANGE_FUNC[type](self, msg)
  end
  self:_on_npc_tough_value_change(msg)
end

function ui:_on_element_value_change(msg)
  if self:is_destroy() then
    return
  end
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    local element_id = msg.mm_x
    bar_item:on_element_value_change(uuid, element_id)
  end
end

function ui:_on_element_timer_remove(msg)
  if self:is_destroy() then
    return
  end
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    local element_id = msg.mm_x
    bar_item:on_element_timer_remove(uuid, element_id)
  end
end

function ui:_on_element_state_change(msg)
  if self:is_destroy() then
    return
  end
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_element_state_change(uuid)
  end
end

function ui:_on_element_timer_start(msg)
  if self:is_destroy() then
    return
  end
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    local element_id = msg.mm_x
    bar_item:on_element_timer_start(uuid, element_id)
  end
end

function ui:_on_npc_tough_recover_start(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_recover_state_change(uuid, true)
  end
end

function ui:_on_npc_tough_value_change(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_value_change(uuid)
  end
end

function ui:_on_npc_tough_param_reset(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_param_reset(uuid)
  end
end

function ui:_on_npc_tough_lv_down(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_lv_down(msg)
  end
end

function ui:_on_npc_tough_lv_up(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_lv_up(msg)
  end
end

function ui:_on_npc_tough_clear(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_clear(msg)
  end
end

function ui:_on_npc_tough_recover_done(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_npc_tough_recover_state_change(uuid, false)
    bar_item:on_npc_tough_recover_done(msg)
  end
end

function ui:_on_change_npc_phase_state(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_change_npc_phase_state(msg)
  end
end

function ui:_on_role_heal(msg)
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_role_heal(msg)
  end
end

function ui:_on_role_hp_value_change(msg)
  local attr_type = msg.mm_y
  if not Config.HP_ATTR_TYPE[attr_type] then
    return
  end
  local uuid = msg.mm_x
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_role_hp_value_change(uuid)
  end
end

function ui:_on_role_shield_change(msg)
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    bar_item:on_role_hp_value_change(uuid)
  end
end

function ui:_on_abnormal_flag_change(msg)
  if self:is_destroy() then
    return
  end
  local uuid = msg.mm_obj
  local bar_item = self:get_bar_item_by_uuid(uuid)
  if bar_item then
    local element_id = msg.mm_x
    bar_item:on_abnormal_flag_change(uuid, element_id)
  end
end

function ui:_on_game_pause_state_change(msg)
  for key, enemy_bar in pairs(self.v_enemy_bar_map) do
    enemy_bar:on_game_pause_state_change(msg.mm_x)
  end
end

function ui:ui_on_show()
  self:bind_mq()
end

function ui:ui_on_hide()
  self.v_is_end_update_enemy_bar = false
  UtilTable.clear_map(self.v_wrap_uis)
end

function ui:ui_on_destroy()
  self:clear_main_enemy_bar(true)
  self:clear_sub_enemy_bar(true)
  self:clear_elite_hp_bar(true)
  self:release_element_effect()
end

function ui:_remove_buff(msg)
  if msg.mm_obj then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    local target_uuid = msg.mm_x.uuid
    local bar_item = self:get_bar_item_by_uuid(target_uuid)
    if bar_item then
      bar_item:remove_buff(msg.mm_y)
      bar_item:update_buff_list(target)
    end
  end
end

function ui:_update_buff_list(msg)
  if msg.mm_obj then
    local target = msg.mm_x
    if not target or target:is_destroy() then
      return
    end
    local target_uuid = msg.mm_x.uuid
    local bar_item = self:get_bar_item_by_uuid(target_uuid)
    if bar_item then
      bar_item:update_buff_list(target)
    end
  end
end

function ui:_update_buff_level(msg)
  if msg.mm_obj then
    local target_uuid = msg.mm_obj
    local bar_item = self:get_bar_item_by_uuid(target_uuid)
    if bar_item then
      bar_item:update_buff_level()
    end
  end
end

function ui:set_target_uuid_map(map)
  self.v_target_uuid_map = map
end

function ui:set_target_count(count)
  self.v_target_count = count
end

function ui:clear_single_main_target()
  self.v_main_target_uuid = nil
  self:clear_main_enemy_bar()
  self:clear_sub_enemy_bar()
  self:clear_target()
end

function ui:clear_multi_main_target()
  self:give_back_auto_cache(MULTI_ENEMY_BAR_KEY)
  for uuid, item in pairs(self.v_multi_hp_bar_map) do
    item:ui_hide()
    item:ui_destroy()
    self:remove_wrap_ui(item)
    self.v_multi_hp_bar_map[uuid] = nil
    if item == self.v_enemy_bar_map[uuid] then
      self.v_enemy_bar_map[uuid] = nil
    end
  end
end

function ui:change_big_bar_state(target_count)
  local single_bar, multi_bar
  if target_count <= 0 then
    single_bar = false
    multi_bar = false
  elseif 1 == target_count then
    single_bar = true
    multi_bar = false
  else
    single_bar = false
    multi_bar = true
  end
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if 0 ~= self.v_last_target_count then
    self.v_sequence = Util.create_sequence()
    local main_transform = self.v_uiobjects.MainEnemyBloodList.transform
    if single_bar then
      main_transform:SetLocalScaleA(0.5, 1, 1)
      local _, y, z = main_transform:GetLocalPositionA3()
      local x = self.v_is_destroy_left and -INIT_X or INIT_X
      main_transform:SetLocalPositionA(x, y, z)
      self.v_sequence:Join(main_transform:DOScaleX(1, SHOW_TIME))
      self.v_sequence:Join(main_transform:DOLocalMoveX(TARGET_X, SHOW_TIME))
      self.v_main_blood_list_cg.alpha = FADE_ALPHA
      self.v_sequence:Join(self.v_main_blood_list_cg:DOFade(SHOW_ALPHA, SHOW_TIME))
      self:update_ui_visible(self.v_uiobjects.MainEnemyBloodList, single_bar)
    else
      main_transform:SetLocalScaleA(1)
      self.v_main_blood_list_cg.alpha = SHOW_ALPHA
      self.v_sequence:Join(self.v_main_blood_list_cg:DOFade(FADE_ALPHA, FADE_TIME))
    end
    if multi_bar then
      self.v_multi_blood_list_cg.alpha = FADE_ALPHA
      self.v_sequence:Join(self.v_multi_blood_list_cg:DOFade(SHOW_ALPHA, SHOW_TIME))
      self:update_ui_visible(self.v_uiobjects.DoubleEnemyBloodList, multi_bar)
    else
      self.v_multi_blood_list_cg.alpha = SHOW_ALPHA
      self.v_sequence:Join(self.v_multi_blood_list_cg:DOFade(FADE_ALPHA, FADE_TIME))
    end
    self.v_sequence:OnComplete(function()
      self:update_ui_visible(self.v_uiobjects.MainEnemyBloodList, single_bar)
      self:update_ui_visible(self.v_uiobjects.DoubleEnemyBloodList, multi_bar)
      if self.v_sequence then
        self.v_sequence:Kill(false)
        self.v_sequence = nil
      end
      if not single_bar then
        self:clear_single_main_target()
      end
      if not multi_bar then
        self:clear_multi_main_target()
      end
    end)
  else
    if single_bar then
      self.v_uiobjects.MainEnemyBloodList.transform:SetLocalScaleA(1)
    end
    self.v_main_blood_list_cg.alpha = 1
    self.v_multi_blood_list_cg.alpha = 1
    self:update_ui_visible(self.v_uiobjects.MainEnemyBloodList, single_bar)
    self:update_ui_visible(self.v_uiobjects.DoubleEnemyBloodList, multi_bar)
  end
  self.v_is_update_single_bar = single_bar
end

function ui:begin_update_enemy_bar(target_count)
  self.v_is_end_update_enemy_bar = false
  self:update_ui_visible(self.v_uiobjects.EnemyBarList, true)
  if self.v_last_target_count ~= target_count then
    self:change_big_bar_state(target_count)
  end
  if target_count < 2 then
    local target_uuid, _ = next(self.v_target_uuid_map)
    if self.v_main_target_uuid ~= target_uuid then
      local temp_target = SceneMgr:pick_by_uuid(target_uuid)
      if self.v_main_target_uuid then
        self:clear_main_enemy_bar()
      end
      self:create_main_enemy_bar(temp_target)
      self:set_main_target(temp_target)
    end
  else
    for uuid, _ in pairs(self.v_target_uuid_map) do
      self:create_multi_enemy_bar(uuid)
    end
  end
  self.v_target_count = target_count
  self.v_last_target_count = target_count
end

function ui:end_update_enemy_bar()
  if 0 ~= self.v_last_target_count then
    self:change_big_bar_state(0)
  end
  self:update_ui_visible(self.v_uiobjects.EnemyBarList, false)
  self.v_last_target_count = 0
end

function ui:update_elite_enemy_hp_bar()
  for uuid, item in pairs(self.v_elite_hp_bar_list) do
    local target = SceneMgr:get_npc_by_id(uuid)
    if target and not target:is_destroy() and not item:is_destroy() and not Util.is_nil(item:get_object()) and item:visible() then
      item:update_enemy_bar(target)
      item:ui_follow_target(target)
    end
  end
end

function ui:ui_on_low_update()
  local target
  if self.v_main_enemy_bar and not self.v_main_enemy_bar:is_destroy() then
    target = self.v_main_target
    self.v_main_enemy_bar:low_update_enemy_bar(target)
  end
  if self.v_elite_hp_bar_list then
    for uuid, item in pairs(self.v_elite_hp_bar_list) do
      if not item:is_destroy() then
        target = SceneMgr:get_npc_by_id(uuid)
        item:low_update_enemy_bar(target)
      else
        self.v_elite_hp_bar_list[uuid] = nil
        if item == self.v_enemy_bar_map[uuid] then
          self.v_enemy_bar_map[uuid] = nil
        end
      end
    end
  end
  if self.v_multi_hp_bar_map then
    for uuid, item in pairs(self.v_multi_hp_bar_map) do
      if not item:is_destroy() then
        target = SceneMgr:get_npc_by_id(uuid)
        item:low_update_enemy_bar(target)
      else
        self.v_multi_hp_bar_map[uuid] = nil
        if item == self.v_enemy_bar_map[uuid] then
          self.v_enemy_bar_map[uuid] = nil
        end
      end
    end
  end
end

function ui:set_main_target(target)
  self.v_main_target = target
  self.v_main_target_uuid = target.uuid
end

function ui:create_main_enemy_bar(temp_target)
  self:_create_main_enemy_bar()
  local item = self.v_main_enemy_bar
  item:set_bar_type(Config.ENEMY_BAR_TYPE.MAIN_TARGET)
  item:set_width_info(HP_WIDTH, EB_SCALE_X, INTERVAL_RIGHT_X)
  item:set_bar_parent(self.v_uiobjects.MainEnemyBloodList.transform)
  item:set_flash_long_visible(false)
  item:set_target_info(temp_target, temp_target.uuid)
  item:on_npc_tough_param_reset(temp_target.uuid)
  item:update_buff_list(temp_target)
  item:set_scale(1)
  self.v_enemy_bar_map[temp_target.uuid] = item
end

function ui:create_multi_enemy_bar(target_uuid)
  local target = SceneMgr:get_npc_by_id(target_uuid)
  local old_item = self.v_multi_hp_bar_map[target_uuid]
  if Util.is_destroy(target) then
    if old_item then
      old_item:clear_buff_item()
      old_item:ui_hide()
      old_item:ui_destroy()
    end
    return
  end
  if old_item then
    return
  end
  local obj = self:get_auto_cache(MULTI_ENEMY_BAR_KEY)
  obj.transform:SetAsLastSibling()
  local item = ENEMY_BAR_ITEM_CLASS:ui_wrap_ex(self, obj, true)
  item:ui_show()
  item.go = obj
  obj:SetActive(true)
  item:set_bar_type(Config.ENEMY_BAR_TYPE.MULTI_TARGET)
  local is_left = 0 == UtilTable.hash_lenth(self.v_multi_hp_bar_map) % 2
  item:set_left(is_left)
  item:set_width_info(MULTI_HP_WIDTH, MULTI_EB_SCALE_X, MULTI_INTERVAL_RIGHT_X)
  item:set_bar_parent(self.v_uiobjects.DoubleEnemyBloodList.transform)
  item:set_flash_long_visible(false)
  item:set_target_info(target, target.uuid)
  item:on_npc_tough_param_reset(target.uuid)
  item:update_buff_list(target)
  item:set_scale(1)
  self.v_multi_hp_bar_map[target_uuid] = item
  self.v_enemy_bar_map[target_uuid] = item
end

function ui:_create_main_enemy_bar()
  if self.v_main_enemy_bar then
    self.v_main_enemy_bar:clear_buff_item()
  end
  self:give_back_auto_cache(MAIN_ENEMY_BAR_KEY)
  local obj = self:get_auto_cache(MAIN_ENEMY_BAR_KEY)
  local item = ENEMY_BAR_ITEM_CLASS:ui_wrap_ex(self, obj, true)
  item:ui_show()
  item.go = obj
  obj:SetActive(true)
  self.v_main_enemy_bar = item
end

function ui:is_has_part()
  return self.v_main_target:check_has_part()
end

function ui:create_sub_enemy_bar()
  if self.v_sub_enemy_bar_type == SUB_ENEMY_BAR_TYPE.PART then
    self:_create_sub_part_bar()
  else
    self:_create_sub_follower_bar()
  end
end

function ui:clear_sub_enemy_bar()
end

function ui:_create_sub_part_bar()
end

function ui:_create_sub_follower_bar()
end

function ui:clear_main_enemy_bar(is_destroy)
  if self.v_main_enemy_bar then
    if not is_destroy then
      self:give_back_auto_cache(MAIN_ENEMY_BAR_KEY)
    end
    self.v_main_enemy_bar:ui_hide()
    self.v_main_enemy_bar:ui_destroy()
    self:remove_wrap_ui(self.v_main_enemy_bar)
    self.v_main_enemy_bar = nil
  end
end

function ui:clear_sub_enemy_bar(is_destroy)
end

function ui:clear_elite_hp_bar(is_destroy)
  if not self.v_elite_hp_bar_list then
    return
  end
  if not is_destroy then
    self:give_back_auto_cache(ELITE_ENEMY_BAR_KEY)
  end
  for uuid, item in pairs(self.v_elite_hp_bar_list) do
    item:ui_destroy()
    self:remove_wrap_ui(item)
    self.v_elite_hp_bar_list[uuid] = nil
    if item == self.v_enemy_bar_map[uuid] then
      self.v_enemy_bar_map[uuid] = nil
    end
  end
end

function ui:update_main_enemy_bar()
  if self.v_is_end_update_enemy_bar then
    return
  end
  if self.v_is_update_single_bar then
    self:_update_main_enemy_bar()
  else
    self:_update_multi_enemy_bar()
  end
end

function ui:_update_multi_enemy_bar()
  local target
  for uuid, item in pairs(self.v_multi_hp_bar_map) do
    target = SceneMgr:get_npc_by_id(uuid)
    if not Util.is_destroy(target) and not item:is_destroy() and not Util.is_nil(item:get_object()) and item:visible() then
      item:update_enemy_bar(target)
    end
  end
end

function ui:_update_main_enemy_bar()
  if self.v_main_enemy_bar and not self.v_main_enemy_bar:is_destroy() and not Util.is_nil(self.v_main_enemy_bar:get_object()) and self.v_main_enemy_bar:visible() then
    self.v_main_enemy_bar:update_enemy_bar(self.v_main_target)
  end
end

function ui:update_sub_part_bar()
end

function ui:update_sub_follower_bar()
end

function ui:update_part_small_bar(npc, part_obj)
  local part_attr = part_obj.attrs
  local hp_bar_type = npc:get_hp_bar_type()
  local show_ui_hp = Util.check_show_hp_bar_type(hp_bar_type)
  if show_ui_hp then
    npc:update_part_hp_val(part_attr)
  end
end

function ui:is_part_exist(part_obj)
  return part_obj and part_obj.part_uuid
end

function ui:clear_target()
  self.v_main_target = nil
end

function ui:disable_enemy_bar()
  self:update_ui_visible(self.v_uiobjects.EnemyBarList, false)
  self.v_main_target = nil
end

function ui:set_effect_bar_show(is_show)
  if self.v_main_enemy_bar then
    self.v_main_enemy_bar:set_effect_bar_show(is_show)
  end
end

function ui:set_effect_bar_length(percent)
  if self.v_main_enemy_bar then
    self.v_main_enemy_bar:set_effect_bar_length(percent)
  end
end

function ui:create_elite_hp_bar(target)
  if nil == target or target:is_destroy() or not target:is_monster() then
    return
  end
  if self.v_elite_hp_bar_list[target.uuid] then
    return
  end
  local obj = self:get_auto_cache(ELITE_ENEMY_BAR_KEY)
  local item = ENEMY_BAR_ITEM_CLASS:ui_wrap_ex(self, obj, true)
  item:ui_show()
  local rect_component = obj:GetComponent(TypeUnityRectTransform)
  rect_component:SetAnchoredMinMax(0, 0, 0, 0)
  item:set_bar_type(Config.ENEMY_BAR_TYPE.ELITE_TARGET)
  item:set_width_info(ELITE_HP_WIDTH, EB_SCALE_X, INTERVAL_RIGHT_X)
  item:set_bar_parent(self.v_uiobjects.EliteEnemyBloodList.transform)
  item:set_flash_long_visible(false)
  item:set_target_info(target, target.uuid)
  item:on_npc_tough_param_reset(target.uuid)
  item:update_enemy_bar(target)
  item:set_scale(1)
  local dc_view = Global.ui_dynamic_canvas
  if not dc_view then
    dc_view = UIMgr:get_ui("uidynamic_canvas")
    dc_view:ui_show()
  end
  local dc_tf = dc_view:get_tf()
  obj.transform:SetParent(dc_tf, false)
  item.obj = obj
  self.v_elite_hp_bar_list[target.uuid] = item
  self.v_enemy_bar_map[target.uuid] = item
end

function ui:remove_elite_hp_bar(target)
  if not target or not self.v_elite_hp_bar_list[target.uuid] then
    return
  end
  local item = self.v_elite_hp_bar_list[target.uuid]
  local obj = item.obj
  if not Util.is_nil(obj) then
    if not Util.is_nil(self.v_uiobjects.EliteEnemyBloodList) then
      obj.transform:SetParent(self.v_uiobjects.EliteEnemyBloodList.transform)
    end
    self:give_back_auto_cache_obj(ELITE_ENEMY_BAR_KEY, item.obj)
  end
  item:ui_hide()
  item:ui_destroy()
  self:remove_wrap_ui(item)
  self.v_elite_hp_bar_list[target.uuid] = nil
end

function ui:set_big_enemy_item_visible(uuid, visible)
  if self.v_main_enemy_bar and not self.v_main_enemy_bar:is_destroy() and self.v_main_target.uuid == uuid then
    local object = self.v_main_enemy_bar:get_object()
    if not Util.is_nil(object) then
      object:SetActive(visible)
    end
  end
end

function ui:get_big_enemy_item_visible(uuid)
  if self.v_main_enemy_bar and not self.v_main_enemy_bar:is_destroy() and self.v_main_target.uuid == uuid then
    local object = self.v_main_enemy_bar:get_object()
    if not Util.is_nil(object) then
      return object.activeSelf
    end
  end
  if self.v_sub_enemy_bar_list and self.v_sub_enemy_bar_list[uuid] and not self.v_sub_enemy_bar_list[uuid]:is_destroy() then
    local object = self.v_sub_enemy_bar_list[uuid]:get_object()
    if not Util.is_nil(object) then
      return object.activeSelf
    end
  end
end

function ui:set_elite_enemy_item_visible(uuid, visible)
  if self.v_elite_hp_bar_list and self.v_elite_hp_bar_list[uuid] and not self.v_elite_hp_bar_list[uuid]:is_destroy() then
    local object = self.v_elite_hp_bar_list[uuid]:get_object()
    if not Util.is_nil(object) then
      object:SetActive(visible)
    end
  end
end

function ui:get_elite_enemy_item_visible(uuid)
  if self.v_elite_hp_bar_list and self.v_elite_hp_bar_list[uuid] and not self.v_elite_hp_bar_list[uuid]:is_destroy() then
    local object = self.v_elite_hp_bar_list[uuid]:get_object()
    if not Util.is_nil(object) then
      return object.activeSelf
    end
  end
end

function ui:show_elite_enemy_break_effect(uuid)
  if self.v_elite_hp_bar_list and self.v_elite_hp_bar_list[uuid] and not self.v_elite_hp_bar_list[uuid]:is_destroy() then
    local object = self.v_elite_hp_bar_list[uuid]:get_object()
    if not Util.is_nil(object) then
      self.v_elite_hp_bar_list[uuid]:on_enemy_blood_zero()
    end
  end
end

local ENEMY_BAR_ITEM_TEMP_KEY = "ENEMY_BAR_ITEM_TEMP_KEY"

function ui:panel_get_template_key()
  self.v_temp_register_item_count = self.v_temp_register_item_count + 1
  return ENEMY_BAR_ITEM_TEMP_KEY .. self.v_temp_register_item_count
end

function ui:get_bar_item_by_uuid(uuid)
  local bar_item = self.v_enemy_bar_map and self.v_enemy_bar_map[uuid]
  return bar_item
end

function ui:get_cache_element_effect(effect_name, callback)
  self.v_element_effect_map[effect_name] = self.v_element_effect_map[effect_name] or {}
  local effects = self.v_element_effect_map[effect_name]
  local go = next(effects)
  if go then
    effects[go] = nil
    if callback then
      callback(go)
    end
  else
    ResPoolMgr:get_ui_effect_async(effect_name, function(go)
      if Util.is_nil(go) then
        return
      end
      if callback then
        callback(go)
      end
    end)
  end
end

function ui:give_back_element_effect(effect_name, go)
  if Util.is_nil(go) then
    return
  end
  self.v_element_effect_map[effect_name] = self.v_element_effect_map[effect_name] or {}
  self.v_element_effect_map[effect_name][go] = true
  go.transform:SetParent(self.v_uiobjects.WeakEffectRoot.transform)
end

function ui:release_element_effect()
  for key, effects in pairs(self.v_element_effect_map) do
    for obj in pairs(effects) do
      ResPoolMgr:release(obj)
      effects[obj] = nil
    end
  end
end

function ui:reset_flash_visible()
  if self.v_main_enemy_bar then
    self.v_main_enemy_bar:reset_flash_visible()
  end
  if self.v_elite_hp_bar_list then
    for key, item in pairs(self.v_elite_hp_bar_list) do
      item:reset_flash_visible()
    end
  end
end

function ui:reset_weakness()
  if self.v_main_enemy_bar then
    self.v_main_enemy_bar:reset_weakness()
  end
  if self.v_elite_hp_bar_list then
    for key, item in pairs(self.v_elite_hp_bar_list) do
      item:reset_weakness()
    end
  end
end

function ui:set_destroy_left(is_destroy_left)
  self.v_is_destroy_left = is_destroy_left
end

function ui:get_weakness_temp_obj()
  return self:get_auto_cache(WEAKENESS_TEMP_KEY)
end

function ui:give_back_weakness_temp_obj(obj)
  if obj:IsNull() then
    return
  end
  obj.transform:SetParent(self.v_uiobjects.EnemyBarTemRoot.transform)
  self:give_back_auto_cache_obj(WEAKENESS_TEMP_KEY, obj)
end

function ui:get_interval_temp_obj()
  return self:get_auto_cache(INTERVAL_TEMP_KEY)
end

function ui:give_back_interval_temp_obj(obj)
  if self:is_destroy() and obj:IsNull() then
    return
  end
  obj.transform:SetParent(self.v_uiobjects.EnemyBarTemRoot.transform)
  self:give_back_auto_cache_obj(INTERVAL_TEMP_KEY, obj)
end

function ui:set_tough_bar_protect_state(target_uuid, state)
  local item = self:get_bar_item_by_uuid(target_uuid)
  if item then
    item:set_tough_bar_protect_state(state)
  end
end

return ui
