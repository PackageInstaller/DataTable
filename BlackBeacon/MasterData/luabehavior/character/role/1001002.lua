local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local CommonMonster = import("common.monster")
local M = Util.create_child_mt(Base)
local atk_counting = 1
local skill3_counting = 1
local counter_skill_counting = 1
local x, y
local indicator_set = 0
local press_set = false
local test_area_cfg = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 10
}
local arrow_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 2,
  sizey = 5
}
local waycast_id = {
  [18] = 10100206,
  [20] = 10100216
}
local atk_id = {
  [1] = 10100202,
  [2] = 10100203,
  [3] = 10100204
}
local atk_time = {
  [10100201] = get_skill_cfg(10100201).CastTime,
  [10100202] = get_skill_cfg(10100202).CastTime,
  [10100203] = get_skill_cfg(10100203).CastTime,
  [10100204] = get_skill_cfg(10100204).CastTime
}
local is_enhance_atk = 0
local enhance_atk_id = 10100219
local enhance_atk_id2 = 10100234
local nomal_enhance_atk_id = 10100217
local enhance_atk_continued_id = 10100231
local enhance_atk_continued_id2 = 10100233
local enhance_energy = 0
local pre_enhance_skill = {
  10100206,
  10100211,
  10100213,
  10100216,
  10100214,
  10100227
}
local skill_time = {
  [10100206] = get_skill_cfg(10100206).CastTime,
  [10100211] = get_skill_cfg(10100211).CastTime,
  [10100213] = get_skill_cfg(10100213).CastTime,
  [10100216] = 0.4,
  [10100218] = get_skill_cfg(10100218).CastTime,
  [10100214] = 0.1,
  [10100227] = 0.4,
  [10100228] = get_skill_cfg(10100227).CastTime,
  [10100229] = get_skill_cfg(10100227).CastTime,
  [10100230] = get_skill_cfg(10100227).CastTime,
  [10100235] = get_skill_cfg(10100227).CastTime,
  [10100237] = get_skill_cfg(10100227).CastTime,
  [10100238] = get_skill_cfg(10100227).CastTime,
  [10100239] = get_skill_cfg(10100227).CastTime
}
local counter_skill_id = {
  [1] = 10100206,
  [2] = 10100206
}
local skill2_start = 10100208
local skill2_loop = 10100214
local skill2_end = 10100213
local skill2_end_success = 10100211
local skill2_status = 0
local skill3_id = {
  [1] = 10100227,
  [2] = 10100216
}
local skill3_reset_time = 0
local counter_skill_reset_time = 0
local exskill_id = 10100220
local now_skill = 0
local exskill_energy_cost = {100}
local born_skill = 10100222
local skill_abort_level = 5
local TEMP_POS = {}

function M:_init(npc)
  Base._init(self, npc)
  CommonRole.role_common_init(self)
  CommonRole.lock_setting = 0
  cast_magic(npc, npc, 1002045, 0)
  self.indicator_input_timer = self.indicator_input_timer or {}
  self.counter_atk_id = 10100235
  self.qte_skill = 10100292
  self.death_set = 0
  self.current_hp = get_npc_attr(npc, 1)
  self.hurt_hp = 0
  self.a3_switch = 1
  self.f1_switch = 1
  self.c1_switch = 1
  self.c2_switch = 1
  self.c3_switch = 1
  self.b1_switch = 1
  self.b2_switch = 1
  self.b3_switch = 1
  self.E_timer = 0
  self.E_timer_switch = 0
  self.now_skill_time = 0
  self.now_atk_time = 0
  self.battle_res_type = 3
  self.enhance_atk_reset_time = 0
  self.exhance_atk_timer = 0
  self.exhance_atk_set = 0
  self.exhance_damage_set = 0
  self.exhance_damage_limit = false
  self.split_hit = false
  self.split_used_enhance = 0
  self.skill2_success = 0
  self.skill2_nomal = 0
  self.atk_pro = 0
  self.counter = 0
  self.skill3 = 0
end

function M:born_behavior()
  if 1 == self.a3_switch and check_magic(self.npc, 1002205) then
    self.a3_switch = 0
    skill3_id = {
      [1] = 10100230,
      [2] = 10100228
    }
  end
  if 1 == self.f1_switch and check_magic(self.npc, 1002217) then
    self.f1_switch = 0
    enhance_atk_id = 10100236
  end
  if 1 == self.c1_switch and check_magic(self.npc, 1002209) then
    self.c1_switch = 0
    counter_skill_id[1] = 10100237
  end
  if 1 == self.b2_switch and check_magic(self.npc, 1002207) then
    self.b2_switch = 0
    cast_magic(self.npc, self.npc, 1002151, 0)
  end
  if check_magic(self.npc, 1002401) then
    cast_magic(self.npc, self.npc, 1002501, 0)
  end
  if check_magic(self.npc, 1002402) then
    cast_magic(self.npc, self.npc, 1002502, 0)
  end
  if check_magic(self.npc, 1002403) then
    cast_magic(self.npc, self.npc, 1002503, 0)
  end
  if check_magic(self.npc, 1002404) then
    cast_magic(self.npc, self.npc, 1002504, 0)
  end
  if check_magic(self.npc, 1002405) then
    cast_magic(self.npc, self.npc, 1002505, 0)
  end
  if check_magic(self.npc, 1002406) then
    cast_magic(self.npc, self.npc, 1002506, 0)
  end
end

function M:on_get_battle_skill(npc, magic_id)
  if npc ~= self.npc then
    return
  end
  if check_magic(self.npc, 1002401) then
    cast_magic(self.npc, self.npc, 1002501, 0)
  end
  if check_magic(self.npc, 1002402) then
    cast_magic(self.npc, self.npc, 1002502, 0)
  end
  if check_magic(self.npc, 1002403) then
    cast_magic(self.npc, self.npc, 1002503, 0)
  end
  if check_magic(self.npc, 1002404) then
    cast_magic(self.npc, self.npc, 1002504, 0)
  end
  if check_magic(self.npc, 1002405) then
    cast_magic(self.npc, self.npc, 1002505, 0)
  end
  if check_magic(self.npc, 1002406) then
    cast_magic(self.npc, self.npc, 1002506, 0)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  Base.on_missile_collide(self, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function M:cast_counter()
  if not CommonRole.get_input(self, 18) then
    return
  end
  if get_npc_cd_charge(self.npc, counter_skill_id[counter_skill_counting]) < get_skill_cfg(counter_skill_id[counter_skill_counting]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return
  end
  CommonRole.role_counter_reset(self)
  self.counter = 1
  abort_skill(self.npc)
  local self_pos = get_npc_pos(self.npc)
  local joystick_target = get_joystick_target_pos(self.npc)
  local counter_pos = self_pos + self_pos - joystick_target
  if 0 == joystick_target.x and 0 == joystick_target.z then
    cast_skill(self.npc, nil, counter_skill_id[1], nil, nil)
  elseif 1 == counter_skill_counting then
    lookat_position(self.npc, counter_pos.x, counter_pos.z, 1)
    cast_skill_to_position(self.npc, counter_skill_id[1], counter_pos.x, counter_pos.z)
  else
    cast_skill(self.npc, nil, counter_skill_id[1], nil, nil)
  end
  skill_abort_level = 4
  atk_counting = 1
  CommonRole.clear_input(self, 18)
end

function M:cast_atk()
  local nowtime = get_npc_time(self.npc)
  if not CommonRole.get_input(self, 15) then
    return
  end
  if CommonRole.counter_out_check(self) then
    CommonRole.counter_out(self)
    abort_skill(self.npc)
    local target = self.ex_missile_owner
    if not self.ex_missile_owner then
      target = self.target
    end
    if target then
      lookat_npc(self.npc, target, true)
    end
    cast_skill(self.npc, target, self.counter_atk_id, nil, nil)
    self.ex_missile_owner = nil
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  local nowtime = get_npc_time(self.npc)
  if self:is_pre_enhance_skill(now_skill) and nowtime > self.now_skill_time then
    self.atk_pro = 1
    is_enhance_atk = 1
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    self:do_cast_atk()
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  local joystick_target = get_joystick_target_pos(self.npc)
  CommonRole.role_counter_reset(self)
  if not atk_id[atk_counting] or nowtime > self.now_atk_time + 0.3 then
    atk_counting = 1
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    self:do_cast_atk()
  elseif nowtime > self.now_atk_time then
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    self:do_cast_atk()
  end
end

function M:do_cast_atk()
  if 1 == is_enhance_atk then
    enhance_energy = get_npc_attr(self.npc, 74)
    local joystick_target = get_joystick_target_pos(self.npc)
    if 0 == enhance_energy then
      CommonRole.skill_setting(self)
      cast_skill(self.npc, self.target, nomal_enhance_atk_id, nil, nil)
      is_enhance_atk = 0
    else
      CommonRole.skill_setting(self)
      cast_skill(self.npc, self.target, enhance_atk_id, nil, nil)
      is_enhance_atk = 0
    end
    if check_magic(self.npc, 1002098) then
      cast_missile(self.npc, self.target, nil, nil, 1010022401, 0)
    elseif check_magic(self.npc, 1002099) then
      cast_missile(self.npc, self.target, nil, nil, 1010022401, 0)
      cast_missile(self.npc, self.target, nil, nil, 1010022402, 0)
      cast_missile(self.npc, self.target, nil, nil, 1010022403, 0)
      cast_missile(self.npc, self.target, nil, nil, 1010022404, 0)
      cast_missile(self.npc, self.target, nil, nil, 1010022405, 0)
    end
    skill_abort_level = 2
    skill2_status = 0
  else
    cast_skill(self.npc, self.target, atk_id[atk_counting], nil, nil)
    self.now_atk_time = get_npc_time(self.npc) + atk_time[atk_id[atk_counting]]
    atk_counting = atk_counting + 1
    skill_abort_level = 1
  end
  CommonRole.role_counter_reset(self)
  CommonRole.clear_input(self, 15)
end

function M:enhance_atk_reset()
  if 0 == is_enhance_atk then
    return
  end
  local nowtime = get_time()
  if nowtime > self.enhance_atk_reset_time then
    is_enhance_atk = 0
  end
end

function M:is_pre_enhance_skill(skill_id)
  for _, v in pairs(pre_enhance_skill) do
    if v == skill_id then
      return true
    end
  end
  return false
end

function M:cast_skill2()
  if not CommonRole.get_input(self, 19) then
    return
  end
  if 0 == skill2_status and get_npc_cd_charge(self.npc, skill2_start) < get_skill_cfg(skill2_start).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1002060)
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 2 then
    return
  end
  local nowtime = get_npc_time(self.npc)
  CommonRole.joystick_search_target(self)
  CommonRole.role_counter_reset(self)
  if 0 == skill2_status then
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    cast_skill(self.npc, self.target, skill2_start, nil, nil)
    replace_hero_skill(4, 10100211)
    skill2_status = 1
    skill_abort_level = 1
    CommonRole.clear_input(self, 19)
    return
  end
  if 1 == skill2_status and nowtime > self.now_skill_time then
    self.skill2_success = 1
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    cast_skill(self.npc, self.target, 10100211, nil, nil)
    replace_hero_skill(4, skill2_start)
    cast_magic(self.npc, self.npc, 1002078, 0)
    skill2_status = 0
    skill_abort_level = 3
    CommonRole.clear_input(self, 19)
    return
  end
  if 1 == skill2_status and nowtime < self.now_skill_time then
    self.skill2_nomal = 1
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    cast_skill(self.npc, self.target, skill2_end, nil, nil)
    replace_hero_skill(4, skill2_start)
    cast_magic(self.npc, self.npc, 1002078, 0)
    skill2_status = 0
    skill_abort_level = 3
    CommonRole.clear_input(self, 19)
    return
  end
end

function M:cast_skill3()
  if not CommonRole.get_input(self, 20) then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 2 then
    return
  end
  if check_magic(self.npc, 1002301) then
  elseif get_npc_cd_charge(self.npc, skill3_id[skill3_counting]) < get_skill_cfg(skill3_id[skill3_counting]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1002061)
    return
  end
  self.skill3 = 1
  abort_skill(self.npc)
  CommonRole.role_counter_reset(self)
  CommonRole.skill_setting(self)
  if check_magic(self.npc, 1002301) then
    cast_skill(self.npc, self.target, skill3_id[2], nil, nil)
    abort_magic_by_id(self.npc, 1002301, 1)
  else
    cast_skill(self.npc, self.target, skill3_id[1], nil, nil)
  end
  skill_abort_level = 3
end

function M:icon()
  if check_magic(self.npc, 1002301) then
    replace_hero_skill(5, 10100216)
  else
    replace_hero_skill(5, 10100227)
  end
  if 1 == is_enhance_atk and get_npc_attr(self.npc, 74) > 0 then
    replace_hero_skill(1, 10100219)
    cast_magic(self.npc, self.npc, 100169, 1)
  elseif 1 == is_enhance_atk and 0 == get_npc_attr(self.npc, 74) then
    replace_hero_skill(1, 10100219)
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
  else
    replace_hero_skill(1, 10100202)
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
  end
end

function M:counter_skill_reset()
  if 1 == counter_skill_counting then
    return
  end
  local nowtime = get_time()
  if nowtime > counter_skill_reset_time then
    counter_skill_counting = 1
    replace_hero_skill(3, counter_skill_id[1])
  end
end

function M:cast_ex_skill()
  if not CommonRole.get_input(self, 17) then
    return
  end
  if check_npc_status(self.npc, 2) or check_npc_status(self.npc, 12) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return
  end
  if get_npc_cd_charge(self.npc, exskill_id) < get_skill_cfg(exskill_id).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1002062)
    return
  end
  if get_npc_attr(self.npc, 3) < exskill_energy_cost[1] then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1002062)
    return
  end
  CommonRole.role_counter_reset(self)
  abort_skill(self.npc)
  stop_move(self.npc)
  CommonRole.skill_setting(self)
  cast_skill(self.npc, self.target, exskill_id, nil, nil)
  skill_abort_level = 5
  atk_counting = 1
  CommonRole.clear_input(self, 17)
end

function M:on_frame()
  Base.on_frame(self)
  local now_time = get_npc_time(self.npc)
  TEMP_POS = get_npc_pos(self.npc)
  CommonRole.role_common_on_frame(self)
  self:icon()
  self:enhance_atk_reset()
  self:born_behavior(self)
end

function M:on_frame_background()
  Base.on_frame_background(self)
end

function M:on_born_behavior()
  CommonRole.born_animation(self, born_skill)
end

function M:on_npc_removed(npc)
  CommonRole.role_common_on_npc_removed(self, npc)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc == self.npc then
    if (1002144 == magic_id or 1002166 == magic_id) and check_magic(self.npc, 1002218) then
      cast_magic(self.npc, self.npc, 1002145, 0)
    end
    if 1002091 == magic_id and check_magic(self.npc, 1002215) and self.exhance_damage_limit == true and self.exhance_damage_set >= 1 then
      cast_magic(self.npc, target, 1002182, self.exhance_damage_set)
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc then
    CommonRole.hit_screen_effect(self)
  end
  if npc == self.npc then
    if 1002091 ~= magic_id and 1002144 ~= magic_id and 1002089 ~= magic_id and 1002161 ~= magic_id and 1002163 ~= magic_id and 1002166 ~= magic_id or 0 == get_npc_attr(target, 1) then
    end
    if (1002135 == magic_id or 1002088 == magic_id) and check_magic(self.npc, 1002201) then
      cast_magic(self.npc, self.npc, 1002137, 0)
    end
    if is_crit and check_magic(self.npc, 1002201) then
      cast_magic(self.npc, self.npc, 1002138, 0)
    end
    if (1002141 == magic_id or 1002091 == magic_id) and check_magic(self.npc, 1002140) then
      abort_magic_by_id(self.npc, 1002140)
    end
    if 1002091 == magic_id then
      CommonRole.abort_magic_with_check(self, self.npc, 1002182)
    end
    if 1002091 == magic_id then
      CommonRole.abort_magic_with_check(self, self.npc, 1002183)
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  Base.on_skill_begin(self, npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  CommonRole.battlesetting_camera_focus(self, skill_type)
  if 10100219 == skill_id or 10100233 == skill_id or 10100236 == skill_id then
    abort_magic_by_id(self.npc, 100169, 1)
    if check_magic(self.npc, 1002200) then
      cast_magic(self.npc, self.npc, 1002077, 0)
    end
  end
  if 10100219 == skill_id or 10100231 == skill_id or 10100233 == skill_id or 10100234 == skill_id or 10100236 == skill_id or 10100292 == skill_id then
    local now_time = get_npc_time(self.npc)
    if check_magic(self.npc, 1002212) and now_time > self.exhance_atk_timer then
      self.exhance_atk_timer = now_time + 2
      self.exhance_atk_set = 1
      cast_magic(self.npc, self.npc, 1002042, 1)
      if 10100236 == skill_id and check_magic(self.npc, 1002217) then
        self.split_used_enhance = 99
      end
    elseif check_magic(self.npc, 1002212) and now_time <= self.exhance_atk_timer then
      if self.exhance_atk_set > 4 then
        self.exhance_atk_set = 4
      end
      cast_magic(self.npc, self.npc, 1002188, self.exhance_atk_set)
      if 10100236 == skill_id and check_magic(self.npc, 1002217) then
        self.split_used_enhance = self.exhance_atk_set
      end
      self.exhance_atk_timer = now_time + 2
      self.exhance_atk_set = self.exhance_atk_set + 1
    else
      if 10100236 == skill_id and check_magic(self.npc, 1002217) then
        self.split_used_enhance = 99
      end
      cast_magic(self.npc, self.npc, 1002042, 1)
    end
  end
  if (10100211 == skill_id or 10100219 == skill_id) and check_magic(self.npc, 1002139) and check_magic(self.npc, 1002202) then
    cast_magic(self.npc, self.npc, 1002140, 0)
    cast_magic(self.npc, self.npc, 1002142, 0)
    cast_magic(self.npc, self.npc, 1002143, 0)
  end
  if skill_id == skill3_id[1] or skill_id == skill3_id[2] or skill_id == skill3_id[3] or skill_id == counter_skill_id[1] or skill_id == counter_skill_id[2] then
    is_enhance_atk = 1
    self.enhance_atk_reset_time = get_time() + 1
  end
  now_skill = skill_id
  if self:is_pre_enhance_skill(skill_id) then
    self.now_skill_time = get_npc_time(self.npc) + skill_time[skill_id]
  end
  if skill_id == skill2_start then
    self.now_skill_time = get_npc_time(self.npc) + 0.8
  end
  if skill_id == born_skill or skill_id == exskill_id then
    set_ui_object_visible("fight", "Main", false)
  end
  if skill_id ~= skill2_start and skill_id ~= skill2_loop then
    abort_magic_by_id(self.npc, 1002303, 1)
    skill2_status = 0
    replace_hero_skill(4, skill2_start)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  for _, v in pairs(skill3_id) do
    if skill_id == v and check_magic(self.npc, 1002205) then
      cast_magic(self.npc, self.npc, 1002044, 1)
    end
  end
  if check_magic(self.npc, 1002215) and not check_magic(self.npc, 1002217) and (10100219 == skill_id or 10100231 == skill_id) and self.exhance_damage_limit == false then
    self.exhance_damage_set = self.exhance_damage_set + 1
    self.exhance_damage_limit = true
  end
  if check_magic(self.npc, 1002217) and false == self.split_hit then
    self.split_hit = true
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if npc ~= self.npc then
    return
  end
  now_skill = 0
  if 10100217 == skill_id or 10100219 == skill_id then
    self.atk_pro = 0
  end
  if skill_id == skill2_start then
    if 0 ~= self.skill2_nomal then
      return
    end
    if 0 ~= self.counter then
      return
    end
    if 0 ~= self.atk_pro then
      return
    end
    if 1 == self.skill2_success then
      return
    end
    if 0 ~= self.skill3 then
      return
    end
    cast_skill(self.npc, self.target, skill2_loop, nil, nil)
    skill2_status = 1
    skill_abort_level = 2
    is_enhance_atk = 1
    self.enhance_atk_reset_time = get_time() + 1
    return
  end
  if self.exhance_damage_limit == true then
    self.exhance_damage_limit = false
    self.exhance_damage_set = 0
  end
  if true == self.split_hit then
    self.split_hit = false
    self.split_used_enhance = 0
  end
  if skill_id == skill2_loop then
    if 0 ~= self.skill2_success then
      return
    end
    if 0 ~= self.atk_pro then
      return
    end
    if 0 ~= self.counter then
      return
    end
    if 0 ~= self.skill3 then
      return
    end
    cast_skill(self.npc, self.target, skill2_end, nil, nil)
    replace_hero_skill(4, skill2_start)
    cast_magic(self.npc, self.npc, 1002078, 0)
  end
  if skill_id == skill2_end then
    is_enhance_atk = 1
    skill_abort_level = 3
    self.skill2_nomal = 0
  end
  if skill_id == skill2_end_success then
    self.skill2_success = 0
  end
  if 10100206 == skill_id then
    self.counter = 0
  end
  skill2_status = 0
  replace_hero_skill(4, skill2_start)
  if skill_id == born_skill or skill_id == exskill_id then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == skill3_id[1] or skill_id == skill3_id[2] then
    self.skill3 = 0
  end
end

function M:on_magic_end(npc, target, magic_id)
end

function M:on_hero_showup_or_back(npc, is_showup)
  Base.on_hero_showup_or_back(self, npc, is_showup)
  stop_ui_fight_button_effect({
    "Strengthen_skill_1",
    1
  })
  if true == is_showup then
    if 1 == skill2_status then
      replace_hero_skill(4, skill2_start)
      skill2_status = 0
    end
    self.skill2_success = 0
  else
    self.skill2_success = 1
    CommonRole.role_counter_reset(self)
    abort_skill(self.npc)
  end
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
  self.indicator_input_timer[input_id] = get_npc_time(self.npc) + 0.15
  self.now_input_id = input_id
  if self.press_set == true and input_id ~= self.now_input_id then
    return
  end
  if 15 == input_id then
    self.E_timer = get_npc_time(self.npc) + 0.1
    self.E_timer_switch = 1
  end
end

function M:on_click()
end

function M:on_press(input_id)
end

function M:on_touch_up(input_id, iscancle)
  self.indicator_input_timer[input_id] = nil
  if true == iscancle then
    press_set = false
  end
  if true == self.press_set and input_id ~= self.now_input_id then
    self.press_set = false
    self.now_input_id = nil
    clear_input()
    return
  end
  if 20 == input_id and false == iscancle then
    indicator_set = 2
    CommonRole.skill_setting(self)
    self:cast_skill3()
  end
  if 15 == input_id and false == iscancle then
    abort_magic_by_id(self.npc, 1002121)
    self.E_timer_switch = 0
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    clear_input()
    self.E_timer_switch = 0
    abort_magic_by_id(self.npc, 1002121)
  end
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc and self.split_hit == true then
    if 99 == self.split_used_enhance then
      cast_magic(self.npc, self.npc, 1002044, 1)
      self.split_used_enhance = 0
      self.split_hit = false
    else
      cast_magic(self.npc, self.npc, 1002189, self.split_used_enhance + 1)
      self.split_used_enhance = 0
      self.split_hit = false
    end
  end
  if npc ~= self.npc then
    return
  end
  if (check_magic(self.npc, 6020017) or check_magic(self.npc, 6020032) or check_magic(self.npc, 6030016)) and 0 == self.death_set then
    self.death_set = 1
    return
  end
  CommonRole.on_dead_hero_common(self)
  create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 10)
  set_npc_dead(self.npc, "die1", false)
end

function M:on_hero_reborn(reborned_hero)
  Base.on_hero_reborn(self, reborned_hero)
end

return M
