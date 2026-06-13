local M = {}
local datas = {}
local on = 1
local atk_x, atk_y
local off = 0
local ultimate_skill_code = 62

function M.set_value(tbl, key, value)
  local data = datas[tbl]
  if not data then
    data = {}
    datas[tbl] = data
  end
  data[key] = value
end

function M.get_value(tbl, key)
  local data = datas[tbl]
  if data then
    return data[key]
  end
end

function M.reset_on_enter_room()
end

function M.reset_on_enter_scene()
end

local cache_time = {
  [15] = 0.3,
  [16] = 0.2,
  [17] = 0.2,
  [18] = 0.2,
  [19] = 0.2,
  [20] = 0.2,
  [21] = 0.2,
  [22] = 0.2,
  [23] = 0.2,
  [60] = 0.2,
  [62] = 0.2
}
local remove_key = {}

function M:role_common_init()
  self.counter_timescale_self_timer = 0.1
  self.born_tag = false
  self.target = nil
  self.target_pos = nil
  self.next_target = nil
  self.input_cache = {}
  self.input_time = {}
  self.output_cache = {}
  self.output_time = {}
  self.input_time_last = {}
  self.input_time_last_switch = {}
  self.do_counter_in = 0
  self.res_timer = 0
  self.joystick_turn = false
  self.do_after_list = {}
  self.do_after_timer = {}
  self.do_while_magic_check = {}
  self.do_while_magic_check_func = {}
  self.input_state_list = {}
  self.skill_loc = {
    [18] = {},
    [19] = {},
    [20] = {}
  }
  self.lock_setting = 1
  self.turn_setting = 0
  self.lock_switch = on
  if self.lock_switch == on then
    set_ui_object_visible("fight", "Btn_lock7", true)
  end
  self.force = 0
  self.input_timer = 0
  self.jhsalwe = 1
  self.on_dead_switch_timer = 0
  self.on_dead_switch = off
  self.is_dead_switch = false
  self.qte_switch = on
  self.force_target_switch = false
  self.force_target_last = nil
  self.sheild_1001007_max = 0
  self.sheild_1001007 = 0
  M.set_value("QTE开关", 1, 1)
  M.set_value("怀表收藏品计时器", 6021061, 0)
  self.counter_cutout_timer = 0
  self.press_control = true
  self.press_time = 0
  self.press_time_switch = false
  self.atk_pressing = false
  self.is_range_atk = false
  self.is_range_atk_state = false
  self.atk_x = 0
  self.atk_z = 0
  self.ranged_atk_cancle = false
  self.arrow_atk_cfg = {
    type = 2,
    res = "Fx_skillarea_N2",
    sizex = 1,
    sizey = 4
  }
  self.area_arrow_atk_cfg = {
    type = 1,
    res = "FX_text_kong",
    sizex = 12
  }
  self.arrow_atk_numbs = 2
end

function M:skill_setting(need_to_lookat)
  self.joystick_turn = false
  M.search_target(self)
  if 0 == self.lock_setting then
  elseif 1 == self.lock_setting then
    local force_target = get_force_target()
    if not force_target then
      M.joystick_search_target(self)
    end
  end
  if 1 == self.force then
    return
  end
  local force_target = get_force_target()
  if 0 == self.turn_setting then
    if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
      lookat_npc(self.npc, self.target, 1)
    end
  elseif 1 == self.turn_setting then
    local joystick_target = get_joystick_target_pos(self.npc)
    if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
      if 0 == joystick_target.x and 0 == joystick_target.z then
        lookat_npc(self.npc, self.target, 1)
      else
        local target1 = search_joystick_npc(self.npc, 4, 8, 80)
        if target1 == self.target or force_target then
          lookat_npc(self.npc, self.target, 1)
        else
          lookat_position(self.npc, joystick_target.x, joystick_target.z, 1)
          self.joystick_turn = true
        end
      end
    elseif 0 == joystick_target.x and 0 == joystick_target.z then
    else
      lookat_position(self.npc, joystick_target.x, joystick_target.z, 1)
    end
  elseif 2 == self.turn_setting then
    local joystick_target = get_joystick_target_pos(self.npc)
    if self.target and check_npc_distance(self.npc, self.target, 15, 0) then
      if 0 == joystick_target.x and 0 == joystick_target.z then
        lookat_npc(self.npc, self.target, 1)
      elseif force_target then
        lookat_npc(self.npc, force_target, 1)
      else
        lookat_position(self.npc, joystick_target.x, joystick_target.z, 1)
        self.joystick_turn = true
      end
    else
      lookat_position(self.npc, joystick_target.x, joystick_target.z, 1)
      self.joystick_turn = true
    end
  end
end

function M:hit_screen_effect()
  self.hurt_hp = get_npc_attr(self.npc, 1)
  if self.hurt_hp < self.current_hp then
    cast_magic(self.npc, self.npc, 1999084, 0)
  end
  self.current_hp = self.hurt_hp
end

function M:dying_screen_effect()
  local hp_current = get_npc_attr(self.npc, 1)
  local hp_max = get_npc_attr(self.npc, 4)
  if self.npc then
    if hp_current / hp_max <= 0.2 then
      if not check_magic(self.npc, 1999085) then
        cast_magic(self.npc, self.npc, 1999085, 0)
      end
    elseif check_magic(self.npc, 1999085) then
      abort_magic_by_id(self.npc, 1999085)
    end
  end
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if teammate1 and check_magic(teammate1, 1999085) then
    abort_magic_by_id(teammate1, 1999085)
  end
  if teammate2 and check_magic(teammate2, 1999085) then
    abort_magic_by_id(teammate2, 1999085)
  end
end

function M:get_input(input_id)
  local input_cache = self.input_cache[input_id]
  if cache_time[input_id] and input_cache and input_cache > get_npc_time(self.npc) then
    return input_cache
  else
  end
end

function M:clear_input(input_id)
  self.input_cache[input_id] = nil
end

function M:get_output(input_id)
  local output_cache = self.output_cache[input_id]
  if cache_time and output_cache and output_cache > get_npc_time(self.npc) then
    return output_cache
  end
end

function M:clear_output(input_id)
  self.output_cache[input_id] = nil
end

function M:clear_target()
  self.target = nil
  self.target_pos = nil
  set_npc_target(self.npc, nil)
end

function M:set_target(target)
  if M.get_value("共用目标", 20220125) then
    self.target = M.get_value("共用目标", 20220125)
    M.set_value("共用目标", 20220125, nil)
  else
    self.target = target
  end
  self.target_pos = get_npc_pos(self.target)
  set_npc_target(self.npc, self.target)
  M.set_value("共同目标", 1011302, self.target)
end

function M:get_target()
  local target = M.get_value("共同目标", 1011302)
  if target then
    return target
  end
end

function M:search_target(distance)
  if self.target and check_magic(self.target, Const.LOCK_MASK) then
    abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
    M.clear_target(self)
    return
  end
  local target_force = get_force_target()
  if target_force then
    if self.force_target_switch == true then
      if check_npc_die(target_force) then
        self.force_target_switch = true
        if check_magic(target_force, 1999091) then
          abort_magic_by_id(target_force, 1999091)
        end
        return
      end
      self.force_target_switch = false
      self.target = target_force
      self.force_target_last = self.target
      set_npc_target(self.npc, self.target)
      cast_magic(self.npc, self.target, Const.LOCK_ON_TAG, 0)
      cast_magic(self.npc, self.target, 1999091, 0)
    elseif self.force_target_last ~= target_force then
      self.force_target_switch = true
      if check_magic(self.target, 1999091) then
        abort_magic_by_id(self.target, 1999091)
      end
      if check_magic(self.target, Const.LOCK_ON_TAG) then
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
      end
    end
    return
  end
  local target = search_npc(self.npc, 4, distance or 10, 0, 1)
  if not target then
    if self.target then
      abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
    end
    M.clear_target(self)
  end
  if not self.target then
    if check_npc_status(self.npc, 2) then
      return
    end
    if not target or check_magic(target, Const.LOCK_MASK) then
      M.clear_target(self)
      return
    end
    M.set_target(self, target)
    if self.target then
      cast_magic(self.npc, self.target, Const.LOCK_ON_TAG, 0)
    end
  else
    if not check_npc_distance(self.npc, self.target, distance or 10, true) then
      if not target then
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
        return
      end
      if target ~= self.target then
        clear_force_target()
        abort_magic_by_id(self.target, 1999091)
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
        M.set_target(self, target)
        cast_magic(self.npc, self.target, Const.LOCK_ON_TAG, 0)
        return
      end
    else
      if not target then
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
        return
      end
      if target ~= self.target then
        clear_force_target()
        abort_magic_by_id(self.target, 1999091)
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
        M.set_target(self, target)
        cast_magic(self.npc, self.target, Const.LOCK_ON_TAG, 0)
        return
      end
    end
    if not get_can_searched(self.target) then
      abort_magic_by_id(self.target, 1999091)
      abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
      M.clear_target(self)
      return
    end
    if not target_force then
      if check_magic(self.target, 1999091) then
        abort_magic_by_id(self.target, 1999091)
      end
      return
    end
  end
end

function M:joystick_search_target()
  if get_force_target() or not self.target then
    return false
  end
  local joystick_target = search_joystick_npc(self.npc, 4, 10, 80)
  local joystick_offset = get_joystick_target_pos(self.npc)
  if joystick_target and check_magic(joystick_target, Const.LOCK_MASK) then
    return false
  else
    if self.target and joystick_target and 0 ~= joystick_offset.x and 0 ~= joystick_offset.z and joystick_target ~= self.target then
      abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
      self.target = joystick_target
      M.magic_with_check(self, self.npc, self.target, Const.LOCK_ON_TAG)
      set_npc_target(self.npc, self.target)
      return true
    end
    return false
  end
end

local function show_up_hero(hero, keycode)
  if not hero or check_npc_die(hero) then
    return
  end
  show_hero_by_keycode(keycode, true)
  return true
end

function M:on_dead_switch_timing()
  if get_npc_time(self.npc) > self.on_dead_switch_timer and self.on_dead_switch == on then
    self.on_dead_switch = off
    local teammate1 = get_scene_hero_by_poskey(21)
    local teammate2 = get_scene_hero_by_poskey(22)
    if not show_up_hero(teammate1, 21) then
      show_up_hero(teammate2, 22)
    end
  end
end

function M:on_dead_hero_common()
  if (check_magic(self.npc, 6020017) or check_magic(self.npc, 6020032) or check_magic(self.npc, 6030016)) and 0 == self.death_set then
    self.death_set = 1
    return
  end
  for k, v in pairs(cache_time) do
    self.output_cache[k] = nil
  end
  self.on_dead_switch_timer = get_npc_time(self.npc) + 1.5
  self.on_dead_switch = on
end

function M:magic_with_check(npc, target, skill_id)
  if not check_magic(npc, skill_id) then
    cast_magic(npc, target, skill_id, 0)
  end
end

function M:abort_magic_with_check(npc, skill_id)
  if check_magic(npc, skill_id) then
    abort_magic_by_id(npc, skill_id)
  end
end

function M:team_add_magic(magic_id)
  if magic_id then
    for key, value in pairs(self.team_hero_list) do
      if value then
        cast_magic(self.npc, value, magic_id, 0)
      end
    end
  end
end

function M:team_abort_magic(magic_id)
  if magic_id then
    for key, value in pairs(self.team_hero_list) do
      if value then
        abort_magic_by_id(value, magic_id, 1)
      end
    end
  end
end

function M:role_status_check()
  if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
    return true
  end
end

function M:role_counter_reset()
  if M.counter_out_check(self) then
    M.counter_out(self, true)
  end
end

function M:counter_timecount(skill_type, counter_type)
  if 2 == skill_type then
    local time = 0.35
    if 2 == counter_type then
      time = 0.5
    end
    self.counter_cutout_timer = get_npc_time(self.npc) + time
  else
    self.counter_cutout_timer = -1
  end
end

function M:indicator_input(input_id, skill_id, magic_id, area, indi, dis, slowdown, skill_abort_level)
  if check_npc_status(self.npc, 5) then
    return
  end
  if self.indicator_timer[input_id] and get_time() > self.indicator_timer[input_id] and self.indicator_switch[input_id] then
    self.indicator_switch[input_id] = false
    skill_abort_level = skill_abort_level or 99
    if M.role_status_check(self) or is_cast_skill_time(self.npc) and skill_abort_level <= self.skill_abort_level then
      return
    end
    if get_npc_attr(self.npc, 2) < get_skill_cfg(skill_id).BattleResCost or get_npc_cd_charge(self.npc, skill_id) < get_skill_cfg(skill_id).CdChargePerCost then
      M.magic_with_check(self, self.npc, self.npc, magic_id)
      return
    end
    update_skill_indicator(input_id, area, indi, 0.5)
    self.indicator_active[input_id] = true
    dis = dis or 7
    if self.target and check_npc_distance(self.npc, self.target, dis, 0) then
      set_indicator_active(input_id, true, true)
    else
      set_indicator_active(input_id, true, false)
    end
    if slowdown and not is_cast_skill_time(self.npc) then
      M.indicator_slowdown_on(self)
    end
  end
end

function M:indicator_active(input_id, is_active, lock_tar, extra_pos_x, extra_pos_z)
  set_indicator_active(input_id, is_active, lock_tar, extra_pos_x, extra_pos_z)
  self.indicator_active[input_id] = is_active
  M.indicator_slowdown_off(self)
end

function M:indicator_slowdown_on()
  cast_magic(self.npc, self.npc, Const.INDICATOR.SLOMO, 1)
  cast_magic(self.npc, self.npc, Const.INDICATOR.DARKEN, 1)
end

function M:indicator_slowdown_off()
  abort_magic_by_id(self.npc, Const.INDICATOR.SLOMO)
  abort_magic_by_id(self.npc, Const.INDICATOR.DARKEN)
end

function M:counter_cutout(skill_id)
  local now_time = get_npc_time(self.npc)
  if now_time >= self.counter_cutout_timer and self.counter_cutout_timer > 0 and is_cast_skill_time(self.npc, skill_id, 1) then
    return true
  end
end

function M:common_counter(npc, hit_target, hit_type, missile_cfg, godmod)
  if 5 == missile_cfg.MissileTypeTag then
    M.magic_with_check(self, hit_target, hit_target, 1999127)
    M.magic_with_check(self, hit_target, hit_target, 1999128)
  else
    M.magic_with_check(self, hit_target, hit_target, 1999125)
    M.magic_with_check(self, hit_target, hit_target, 1999126)
  end
  change_skill_cd(self.npc, 18, 1, 1999191)
  self.do_counter_in = 1
  if godmod then
    M.magic_with_check(self, hit_target, hit_target, 1999095)
  end
  self.ex_missile_owner = npc
  self.self_timer = get_npc_time(self.npc) + 0.1
  self.self_break_timer = get_time() + 0.8
  self.self_break_timer_switch = 1
  self.self_break_timer_red = get_time() + 3
  self.self_break_timer_switch_red = 1
  self.self_timer_switch = 1
  self.counter_npc = hit_target
end

function M:counter_in()
  if 1 == self.self_timer_switch and self.self_timer < get_npc_time(self.npc) then
    self.self_timer_switch = 0
  end
  if 1 == self.self_break_timer_switch and self.self_break_timer < get_time() then
    abort_magic_by_id(self.npc, 1999125)
    abort_magic_by_id(self.npc, 1999126)
    self.self_break_timer_switch = 0
  end
  if 1 == self.self_break_timer_switch_red and self.self_break_timer_red < get_time() then
    abort_magic_by_id(self.npc, 1999125)
    abort_magic_by_id(self.npc, 1999126)
    self.self_break_timer_switch_red = 0
  end
end

function M:counter_out(noeffect)
  self.do_counter_in = 0
  cast_magic(self.npc, self.npc, 1999095, 0)
  if nil == noeffect or not noeffect then
    cast_magic(self.npc, self.npc, 1999178, 0)
  end
  self.self_break_timer_switch = 0
  self.self_break_timer_switch_red = 0
end

function M:counter_out_check()
  if check_magic(self.npc, 1999125) or check_magic(self.npc, 1999127) or check_magic(self.npc, 1999194) and 1 == self.do_counter_in then
    return true
  end
end

function M:cast_skill()
  if self:cast_counter() or self:cast_skill2() or self:cast_skill3() or self:cast_atk() or M.ultimate_skill(self) then
    return
  end
end

function M:cast_magic_to_team(magic_id)
  local teammate1 = get_scene_hero_by_poskey(21)
  local teammate2 = get_scene_hero_by_poskey(22)
  if teammate1 then
    cast_magic(self.npc, teammate1, magic_id, 0)
  end
  if teammate2 then
    cast_magic(self.npc, teammate2, magic_id, 0)
  end
  cast_magic(self.npc, self.npc, magic_id, 0)
end

function M:born_animation(skill_id)
  set_ult_skill_enabled(self.npc, false)
  if get_come_on_hero() ~= self.npc then
    return
  end
  if 1 == self.charge_type then
    set_ui_object_visible("fight", "SpecialBar", true)
    init_special_fight_ui(self.charge_type)
  elseif 2 == self.charge_type then
    set_ui_object_visible("fight", "SpecialBar", true)
    init_special_fight_ui(self.charge_type, self.charge_numb, self.fight_ui_staty)
  else
    set_ui_object_visible("fight", "SpecialBar", false)
  end
  if cancel_born_skill() then
    self.born_tag = true
    return
  end
  if not self.born_tag and is_hero_in_ground(self.npc) then
    if not is_hero_in_ground(self.npc) then
      set_can_searched(self.npc, false)
    end
    local x, z = get_scene_map_pos_postion("center")
    if x and z then
      lookat_position(self.npc, x, z, false)
      cast_skill(self.npc, nil, skill_id, x, z)
    else
      cast_skill(self.npc, nil, skill_id, nil, nil)
    end
    self.npc:set_guid_arrow_visible(false)
    hero_born_finish(skill_id)
    self.born_tag = true
  end
end

function M:gray_set(skill_type, switch, mask_type)
  local function mask_fuc(a)
    if 1 == mask_type then
      local value = get_common_value("BackGroundEnergyRecoveredPerSecond")
      
      if is_hero_in_ground(self.npc) then
        value = get_common_value("GroundEnergyRecoveredPerSecond")
      end
      set_btn_charging_type(a, 1, true, get_npc_attr(self.npc, 2), get_skill_cfg(a).BattleResCost, value, 2)
    elseif 2 == mask_type then
      set_btn_charging_type(a, 2, true, 1.5)
    end
  end
  
  if true == switch then
    for k, v in ipairs(self.button_gray_skill_list[skill_type]) do
      play_ui_fight_button_effect({
        "gray",
        nil,
        v,
        0
      })
      if 4 == skill_type then
        set_ult_skill_enabled(self.npc, true)
      end
    end
    self.button_gray_list[skill_type] = true
  else
    for k, v in ipairs(self.button_gray_skill_list[skill_type]) do
      play_ui_fight_button_effect({
        "gray",
        nil,
        v,
        1
      })
      if 4 == skill_type then
        set_ult_skill_enabled(self.npc, false)
      end
      mask_fuc(v)
    end
    self.button_gray_list[skill_type] = false
  end
end

function M.table_remove_manager(obj, list)
  local key
  for i, m in pairs(list) do
    if m == obj then
      key = i
      break
    end
  end
  if key then
    table.remove(list, key)
  end
end

function M.table_size(table)
  if type(table) ~= "table" then
    return 0
  end
  local i = 0
  for _ in pairs(table) do
    i = i + 1
  end
  return i
end

function M:do_after(func, time)
  self.do_after_list[func] = true
  self.do_after_timer[func] = get_time() + time
end

function M:clear_do_after(func)
  if self.do_after_list[func] then
    self.do_after_list[func] = nil
  end
  if self.do_after_timer[func] then
    self.do_after_timer[func] = nil
  end
end

function M:do_after_frame()
  UtilTable.clear_map(remove_key)
  local now_time = get_time()
  for task, _ in pairs(self.do_after_list) do
    if now_time > self.do_after_timer[task] then
      task()
      remove_key[task] = true
    end
  end
  for key, _ in pairs(remove_key) do
    self.do_after_list[key] = nil
  end
end

function M:do_while_magic_check(func, magic_id)
  self.do_while_magic_check_func[func] = true
  self.do_while_magic_check[func] = magic_id
end

function M:do_while_magic_check_frame()
  UtilTable.clear_map(remove_key)
  for task, _ in pairs(self.do_while_magic_check_func) do
    if self.do_while_magic_check[task] and check_magic(self.npc, self.do_while_magic_check[task]) then
      task()
      abort_magic_by_id(self.npc, self.do_while_magic_check[task])
      remove_key[task] = true
      self.counter_numb = true
    end
  end
  for key, _ in pairs(remove_key) do
    self.do_while_magic_check_func[key] = nil
    self.do_while_magic_check[key] = nil
  end
end

function M:counter_atk(input_id)
  if 15 ~= input_id then
    return
  end
  if 1 ~= self.counter_type then
    return
  end
  if check_magic(self.npc, 1999125) and check_magic(self.npc, 1999198) then
    self.counter_atk = true
  elseif check_magic(self.npc, 1999125) then
    M.do_counter_atk(self)
  end
end

function M:do_counter_atk()
  abort_magic_by_id(self.npc, 1999125)
  abort_magic_by_id(self.npc, 1999185)
  M.skill_setting(self)
  abort_skill(self.npc)
  cast_skill(self.npc, self.target, self.counter_atk_id[1], nil, nil)
  self.counter_atk = false
  self.skill_abort_level = 2
  M.clear_input(self, 15)
end

function M:Range_atk_show(is_open)
  if true == is_open then
    update_skill_indicator(15, self.area_arrow_atk_cfg, self.arrow_atk_cfg, 0.5)
    set_indicator_active(15, is_open, is_open)
    set_face_skill_indicator_pos(self.npc, true, 0, 0, 0)
    set_skill_end_to_idle(self.npc, false)
  end
  if false == is_open then
    set_indicator_active(15, false)
    set_face_skill_indicator_pos(self.npc, is_open, 0, 0, 3)
    set_skill_end_to_idle(self.npc, true)
  end
end

function M:Ranged_attack(ranged_atk_id, skill_abort_level)
  if not self.press_control then
    return
  end
  if not self.ranged_atk then
    return
  end
  local now_time = get_npc_time(self.npc)
  if get_npc_attr(self.npc, 2) < get_skill_cfg(ranged_atk_id[3]).BattleResCost then
    return
  end
  if check_npc_status(self.npc, 5) or check_npc_status(self.npc, 10) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 12) then
    return
  end
  if self.press_time_switch and now_time > self.press_time then
    self.is_range_atk = true
    self.press_time_switch = false
  end
  if self.is_range_atk and self.atk_pressing then
    if is_cast_skill_time(self.npc) and self.skill_abort_level >= 2 then
      return
    end
    if check_npc_status(self.npc, 2) then
      return
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.ranged_atk[1], nil, nil)
    M.Range_atk_show(self, true)
    self.is_range_atk = false
    self.skill_abort_level = 2
    self.is_range_atk_state = true
  end
end

function M:Range_atk_continued(skill_id)
  if not self.ranged_atk then
    return
  end
  if skill_id == self.ranged_atk[1] then
    if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 5) or check_npc_status(self.npc, 10) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 12) then
      M.Range_atk_show(self, false)
      M.magic_with_check(self, self.npc, self.npc, 19991999)
      clear_input()
      return
    end
    if self.atk_pressing then
      cast_skill(self.npc, self.target, self.ranged_atk[2], nil, nil)
    end
  end
  if skill_id == self.ranged_atk[2] then
    M.magic_with_check(self, self.npc, self.npc, 19991999)
    M.Range_atk_show(self, false)
    clear_input()
  end
end

function M:do_range_atk()
  if (is_cast_skill_time(self.npc, self.ranged_atk[1]) or is_cast_skill_time(self.npc, self.ranged_atk[2])) and not self.ranged_atk_cancle then
    abort_skill(self.npc, true)
    atk_x, atk_y = get_indicator_pos(15)
    lookat_position(self.npc, atk_x, atk_y, 1)
    cast_skill(self.npc, nil, self.ranged_atk[3], atk_x, atk_y)
    M.magic_with_check(self, self.npc, self.npc, 19991999)
    set_skill_end_to_idle(self.npc, true)
    self.skill_abort_level = 2
    self.is_range_atk_state = false
  end
end

function M:atk_pressing(input_id)
  if not self.press_control then
    return
  end
  if not self.ranged_atk then
    return
  end
  if check_magic(self.npc, 6070090) then
    return
  end
  local now_time = get_npc_time(self.npc)
  if 15 == input_id then
    self.atk_pressing = true
    self.ranged_atk_cancle = false
    self.press_time = now_time + 0.2
    self.press_time_switch = true
  end
  if 15 ~= input_id and (is_cast_skill_time(self.npc, self.ranged_atk[1]) or is_cast_skill_time(self.npc, self.ranged_atk[2])) then
    self.press_time_switch = false
    self.atk_pressing = false
    self.ranged_atk_cancle = true
    self.is_range_atk = false
    M.Range_atk_show(self, false)
  end
end

function M:atk_touch_up(input_id, iscancle)
  if not self.press_control then
    return
  end
  if 15 == input_id and false == iscancle then
    self.press_time_switch = false
    if self.atk_pressing then
      self.atk_pressing = false
      self.is_range_atk = false
      M.do_range_atk(self, false)
      M.Range_atk_show(self, false)
    end
  elseif 15 == input_id and true == iscancle then
    self.press_time_switch = false
    self.atk_pressing = false
    self.ranged_atk_cancle = true
    self.is_range_atk = false
    M.Range_atk_show(self, false)
    if is_cast_skill_time(self.npc, self.ranged_atk[1]) or is_cast_skill_time(self.npc, self.ranged_atk[2]) then
      abort_skill(self.npc, true)
    end
    set_skill_end_to_idle(self.npc, true)
  end
end

function M:battle_res_cost(battle_res_type, skill_id, consume_fixed, consume_ratio)
  consume_fixed = 89
  consume_ratio = 90
  battle_res_type = 2
  local cost = math.max((get_skill_cfg(skill_id).BattleResCost + get_npc_attr(self.npc, consume_fixed)) * (1 + get_npc_attr(self.npc, consume_ratio) / 10000), 0)
  return cost
end

function M.value_match_check(value, list)
  for k, i in pairs(list) do
    if i == value then
      return true
    end
  end
end

function M:battlesetting_camera_focus(skill_type)
  if not self.target then
    return
  end
  if 2 == get_camera_view_type() and (2 ~= skill_type or 8 ~= skill_type) then
    focus_npc(self.target)
  end
end

function M:battlesetting_camera_clearfocus(distance)
  if 2 == get_battle_setting_camera_type() then
    if self.target == nil then
      clear_focal()
    elseif not check_npc_distance(self.npc, self.target, distance or 15, 1) then
      clear_focal()
    end
  end
end

function M:input_time_update()
  for i, switch in pairs(self.input_time_last_switch) do
    if switch then
      self.input_time_last[i] = get_time() - self.input_time[i]
    end
  end
end

function M:role_common_on_frame(search_distance, focus_distance, sp_skill_logic)
  M.do_after_frame(self)
  M.do_while_magic_check_frame(self)
  M.on_dead_switch_timing(self)
  M.search_target(self, search_distance)
  M.dying_screen_effect(self)
  M.counter_in(self)
  if not sp_skill_logic then
    M.cast_skill(self)
  end
  M.battlesetting_camera_clearfocus(self, focus_distance)
  M.input_time_update(self)
end

function M:indicator_on_frame(indicator_param)
  for id, value in pairs(indicator_param[8]) do
    indicator_param[8][id] = indicator_param[8][id] + 1
    if indicator_param[8][id] > 4 then
      M.indicator_on_press(id, self, indicator_param)
      self.press_set = 1
      indicator_param[8][id] = nil
    end
  end
end

function M.indicator_on_press(input_id, self, indicator_param)
  local waycast_id = indicator_param[7]
  local dis_1 = indicator_param[1]
  local dis_2 = indicator_param[3]
  local dis_3 = indicator_param[5]
  if not waycast_id[input_id] then
    return
  end
  local now_npc_time = get_npc_time(self.npc)
  local now_cd_charge = get_npc_cd_charge(self.npc, waycast_id[input_id])
  if input_id ~= self.now_input_id then
    return
  end
  if indicator_param[1] and indicator_param[2] and 18 == input_id then
    if now_cd_charge < get_skill_cfg(waycast_id[input_id]).CdChargePerCost then
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, dis_1.sizex / 2, 0) then
      update_skill_indicator(input_id, indicator_param[1], indicator_param[2], 0.5)
      set_indicator_active(input_id, true, true)
    else
      update_skill_indicator(input_id, indicator_param[1], indicator_param[2], 0.5)
      set_indicator_active(input_id, true, false)
    end
  end
  if indicator_param[3] and indicator_param[4] and 19 == input_id then
    if now_cd_charge < get_skill_cfg(waycast_id[input_id]).CdChargePerCost then
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, dis_2.sizex / 2, 0) then
      update_skill_indicator(input_id, indicator_param[3], indicator_param[4], 0.5)
      set_indicator_active(input_id, true, true)
    else
      update_skill_indicator(input_id, indicator_param[3], indicator_param[4], 0.5)
      set_indicator_active(input_id, true, false)
    end
  end
  if indicator_param[5] and indicator_param[6] and 20 == input_id then
    if now_cd_charge < get_skill_cfg(waycast_id[input_id]).CdChargePerCost then
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, dis_3.sizex / 2, 0) then
      update_skill_indicator(input_id, indicator_param[5], indicator_param[6], 0.5)
      set_indicator_active(input_id, true, true)
    else
      update_skill_indicator(input_id, indicator_param[5], indicator_param[6], 0.5)
      set_indicator_active(input_id, true, false)
    end
  end
end

function M:role_common_on_npc_removed(npc)
  if self.target == npc then
    self.target = nil
    set_npc_target(self.npc, nil)
  end
end

function M:ultimate_skill()
  if not M.get_input(self, 62) then
    return
  end
  local joystick_target = search_joystick_npc(self.npc, 4, 5, 90)
  joystick_target = joystick_target and get_npc_pos(joystick_target)
  local curr_energy = get_npc_attr(self.npc, 108)
  local max_energy = get_npc_attr(self.npc, 109)
  if M.role_status_check(self) then
    return
  end
  if nil == curr_energy or nil == max_energy then
    M.magic_with_check(self, self.npc, self.npc, 100185)
    return
  end
  if curr_energy >= max_energy then
    cast_magic(self.npc, self.npc, 1999095, 0)
    if self.target then
      lookat_npc(self.npc, self.target, true)
    end
    abort_skill(self.npc)
    if joystick_target and self.target then
      lookat_position(self.npc, joystick_target.x, joystick_target.z, true)
      cast_skill_to_position(self.npc, self.qte_skill, joystick_target.x, joystick_target.z)
      cast_magic(self.npc, self.npc, 1009914, 0)
      self.skill_abort_level = 9
    elseif not joystick_target and self.target then
      cast_skill(self.npc, self.target, self.qte_skill, nil, nil)
      cast_magic(self.npc, self.npc, 1009914, 0)
      self.skill_abort_level = 9
    elseif not joystick_target and not self.target then
      local pos = get_npc_pos(self.npc)
      cast_skill(self.npc, nil, self.qte_skill, nil, nil)
      cast_magic(self.npc, self.npc, 1009914, 0)
      self.skill_abort_level = 9
    end
  else
    M.magic_with_check(self, self.npc, self.npc, 100185)
    play_ui_fight_button_effect({
      "gray",
      nil,
      self.qte_skill,
      1
    })
    return
  end
  M.clear_input(self, 62)
end

function M:role_common_on_input(input_id, indicator_time)
  indicator_time = indicator_time or 0.15
  self.input_cache[input_id] = get_npc_time(self.npc) + (cache_time[input_id] or 0)
  self.input_time[input_id] = get_time()
  self.input_time_last_switch[input_id] = true
  self.indicator_switch[input_id] = true
  self.indicator_timer[input_id] = get_time() + indicator_time
  self.input_state_list[input_id] = true
end

function M:role_common_on_output(input_id, iscancle)
  if not iscancle then
    self.output_cache[input_id] = get_npc_time(self.npc) + (cache_time[input_id] or 0)
    self.output_time[input_id] = get_time()
    self.input_time_last_switch[input_id] = false
    if 18 == input_id or 19 == input_id or 20 == input_id then
      set_indicator_active(input_id, false)
      M.indicator_slowdown_off(self)
      self.indicator_switch[input_id] = false
      self.skill_loc[input_id].x, self.skill_loc[input_id].z = get_indicator_pos(input_id)
    end
  else
    M.indicator_active(self, input_id, false)
  end
  self.input_state_list[input_id] = false
end

return M
