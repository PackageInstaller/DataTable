local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local CommonMonster = import("common.monster")
local M = Util.create_child_mt(Base)
local skill2_counting
local npc_time = 0
local counter_skill_count = 3
local shield_level = 0
local skill2_hit_count = 0
local skill2_magic_count = 0
local fragile_trigger_layer = 3
local fragile_count = 0
local CD_magic_id = 1007060
local sheild_magic_id = 1007057
local E1_sheild_magic_id = 1007111
local charge_effect_id = 1007103
local god_magic_id = 1007117
local atk_id = {
  [1] = 100100701,
  [2] = 100100702,
  [3] = 100100703
}
local atk_time = {
  [100100701] = get_skill_cfg(100100701).CastTime + get_skill_cfg(100100701).BeforeTime,
  [100100702] = get_skill_cfg(100100702).CastTime + get_skill_cfg(100100702).BeforeTime,
  [100100703] = get_skill_cfg(100100703).CastTime + get_skill_cfg(100100703).BeforeTime
}
local counter_skill_id = {
  [1] = 100100715,
  [2] = 100100712,
  [3] = 100100713,
  [4] = 100100714
}
local skill2_id = {
  [1] = 100100721
}
local skill2_time = {
  [100100721] = get_skill_cfg(100100721).CastTime + get_skill_cfg(100100721).BeforeTime
}
local skill3_id = {
  [1] = 100100731
}
local exskill_id = {
  [1] = 100100451,
  [2] = 100100452,
  [3] = 100100453
}
local fragile_magic_id = 1007005
local slow_magic_id = 1007056
local charge_magic_id = 1007033
local now_skill = 0
local exskill_energy_cost = {100}
local born_skill = 100100793
local skill_abort_level = 0
local mark_mgic = {
  10021,
  12165,
  1324,
  4156
}

function M:_init(npc)
  Base._init(self, npc)
  CommonRole.role_common_init(self)
  self.death_set = 0
  self.current_hp = get_npc_attr(npc, 1)
  self.charge_count = 1
  self.counter_atk_id = 100100751
  self.shield_lv_max = 0
  self.shield_lv = 0
  self.atk_counting = nil
  self.atk_base_counting = 1
  self.qte_skill = 100100792
  self.shield_falloff_switch = false
  self.shield_falloff_timer = 0
  self.counter_skill_counting = 1
  self.now_atk_time = 0
  self.loop = true
  self.battle_res_type = 1
  if check_magic(npc, 1007009) then
    fragile_trigger_layer = 2
  end
  mark_limited_missile(10010074113, 3)
  mark_limited_missile(10010074114, 3)
  mark_limited_missile(10010074111, 1)
end

function M:cast_counter()
  if 1 == self.counter_skill_counting then
    if not CommonRole.get_input(self, 18) then
      return
    end
  elseif not CommonRole.get_input(self, 15) then
    return
  end
  if get_npc_cd_charge(self.npc, counter_skill_id[self.counter_skill_counting]) < get_skill_cfg(counter_skill_id[self.counter_skill_counting]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  self.loop = nil
  abort_skill(self.npc)
  local self_pos = get_npc_pos(self.npc)
  local joystick_target = get_joystick_target_pos(self.npc)
  CommonRole.joystick_search_target(self)
  if self.charge_count >= 2 then
    counter_skill_id[3] = 100100716
  end
  cast_skill(self.npc, nil, counter_skill_id[self.counter_skill_counting], nil, nil)
  self.loop = true
  counter_skill_id[3] = 100100713
  if 1 == self.counter_skill_counting then
    self.counter_skill_counting = 3
  elseif 3 == self.counter_skill_counting then
    self.counter_skill_counting = 1
  end
  if 3 == self.counter_skill_counting then
    skill_abort_level = 4
  end
  self.atk_counting = 1
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
    if self.ex_missile_owner then
      lookat_npc(self.npc, self.ex_missile_owner, true)
      cast_skill(self.npc, self.ex_missile_owner, self.counter_atk_id, nil, nil)
    else
      lookat_npc(self.npc, self.target, true)
      cast_skill(self.npc, self.target, self.counter_atk_id, nil, nil)
    end
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
    return
  end
  if not atk_id[self.atk_counting] or nowtime > self.now_atk_time + 0.3 then
    self.atk_counting = 1
    if is_cast_skill_time(self.npc) then
      return
    end
    CommonRole.skill_setting(self)
    self:do_cast_atk()
  elseif nowtime > self.now_atk_time then
    abort_skill(self.npc)
    CommonRole.skill_setting(self)
    self:do_cast_atk()
  end
end

function M:do_cast_atk()
  local pos = get_npc_offset_position(self.npc, nil, 0, 2)
  local pos2 = get_npc_offset_position(self.npc, nil, 0, 100)
  if self.target then
    cast_skill(self.npc, self.target, atk_id[self.atk_counting], nil, nil)
  elseif atk_id[self.atk_counting] == atk_id[3] then
    cast_skill(self.npc, nil, atk_id[self.atk_counting], pos2.x, pos2.z)
  else
    cast_skill(self.npc, nil, atk_id[self.atk_counting], pos.x, pos.z)
  end
  self.now_atk_time = get_npc_time(self.npc) + atk_time[atk_id[self.atk_counting]]
  self.atk_counting = self.atk_counting + 1
  skill_abort_level = 1
  CommonRole.clear_input(self, 15)
end

function M:cast_skill2()
  if not CommonRole.get_input(self, 19) then
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if get_npc_cd_charge(self.npc, skill2_id[1]) < get_skill_cfg(skill2_id[1]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1003024)
    return
  end
  if get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc) < CommonRole.battle_res_cost(self, self.battle_res_type, skill2_id[1]) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1003024)
    return false
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
    return
  end
  CommonRole.role_counter_reset(self)
  abort_skill(self.npc)
  CommonRole.skill_setting(self)
  cast_skill(self.npc, self.target, skill2_id[1], nil, nil)
  skill_abort_level = 2
  self.atk_counting = 1
  self.skill2_state = 0
  set_skill_end_to_idle(self.npc, true)
  CommonRole.clear_input(self, 19)
end

function M:cast_skill3()
  if not CommonRole.get_input(self, 20) then
    return
  end
  if CommonRole.role_status_check(self) then
    return
  end
  if get_npc_cd_charge(self.npc, skill3_id[1]) < get_skill_cfg(skill3_id[1]).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1003025)
    return
  end
  if get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc) < CommonRole.battle_res_cost(self, self.battle_res_type, skill3_id[1]) then
    CommonRole.magic_with_check(self, self.npc, self.npc, 1003025)
    return false
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 1 then
    return
  end
  CommonRole.role_counter_reset(self)
  abort_skill(self.npc)
  CommonRole.skill_setting(self)
  cast_skill(self.npc, self.target, skill3_id[1], nil, nil)
  CommonRole.abort_magic_with_check(self, self.npc, 1004006)
  skill_abort_level = 6
  self.atk_counting = 1
  self.skill2_state = 0
  set_skill_end_to_idle(self.npc, true)
  CommonRole.clear_input(self, 20)
end

function M:on_npc_removed(npc)
  CommonRole.role_common_on_npc_removed(self, npc)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target and check_magic(npc, fragile_magic_id) and check_magic(self.npc, 1007013) then
    cast_magic(npc, npc, 1007030, 0)
  end
  if npc == self.npc and 1007039 == magic_id and check_magic(self.npc, 1007019) then
    cast_magic(npc, npc, 1007042 + skill2_hit_count, 0)
    skill2_hit_count = skill2_hit_count + 1
    if 1007042 + skill2_hit_count == 1007054 then
      skill2_hit_count = 66
    end
  end
  if check_magic(target, 1007117) or check_magic(target, 1007117) then
    cast_magic(npc, npc, 1007119, 0)
  end
end

local teammate0 = get_come_on_hero()
local teammate1 = get_scene_hero_by_poskey(21)
local teammate2 = get_scene_hero_by_poskey(22)

function M:on_magic_begin(npc, target, magic_id)
  if target == self.npc and 1007009 == magic_id then
    fragile_trigger_layer = 2
  end
  if magic_id == fragile_magic_id and check_magic(self.npc, 1007026) then
    fragile_count = fragile_count + 1
    if 3 == fragile_count then
      fragile_count = 0
      if check_magic(self.npc, CD_magic_id) then
        return
      end
      cast_magic(self.npc, self.npc, CD_magic_id, 0)
      cast_missile(self.npc, target, nil, nil, 10010074113, 0)
      cast_missile(self.npc, target, nil, nil, 10010074114, 0)
    end
  end
  if target == self.npc and 1007010 == magic_id then
    fragile_magic_id = 1007028
    slow_magic_id = 1007113
  end
  if 1007004 == magic_id and get_magic_num(target, 1007004) == fragile_trigger_layer then
    abort_magic_by_id(target, 1007004, fragile_trigger_layer)
    cast_magic(self.npc, target, fragile_magic_id, 0)
    cast_magic(self.npc, target, slow_magic_id, 0)
    if not check_magic(self.npc, 1007012) and get_magic_num(target, fragile_magic_id) > 1 then
      abort_magic_by_id(target, fragile_magic_id, 1)
      abort_magic_by_id(target, slow_magic_id, 1)
    end
  end
  if target == self.npc and 1007015 == magic_id then
    charge_magic_id = 1007034
    charge_effect_id = 1007104
    E1_sheild_magic_id = 1007112
    sheild_magic_id = 1007102
    god_magic_id = 1007118
  end
  if target == self.npc and 1007016 == magic_id then
    E1_sheild_magic_id = 1007112
    sheild_magic_id = 1007102
  end
  if target == self.npc and 1007021 == magic_id then
    skill3_id[1] = 100100732
    replace_hero_skill(5, skill3_id[1])
  end
  if target == self.npc and 1007031 == magic_id then
    stop_skill_joystick_move(self.npc)
    if not is_cast_skill_time(self.npc, 100100792) then
      abort_magic_by_id(self.npc, sheild_magic_id, 1)
      abort_magic_by_id(self.npc, 1007094, 1)
      abort_magic_by_id(self.npc, 1007095, 1)
      abort_magic_by_id(self.npc, 1007096, 1)
    end
    abort_magic_by_id(self.npc, charge_effect_id, 2)
    if 1 == self.charge_count then
      cast_missile(self.npc, self.npc, nil, nil, 10010071902, 0)
      play_common_sound("H1001007_CounterAtk_1")
    elseif 2 == self.charge_count then
      cast_missile(self.npc, self.npc, nil, nil, 10010071903, 0)
      cast_magic(self.npc, self.npc, 1007088, 0)
      play_common_sound("H1001007_CounterAtk_2")
    elseif 3 == self.charge_count then
      cast_missile(self.npc, self.npc, nil, nil, 10010071904, 0)
      cast_magic(self.npc, self.npc, 1007088, 0)
      play_common_sound("H1001007_CounterAtk_3")
    elseif 9 == self.charge_count then
      play_common_sound("H1001007_CounterAtk_2")
      cast_missile(self.npc, self.npc, nil, nil, 10010071905, 0)
      cast_magic(self.npc, self.npc, 1007088, 0)
    end
    self.charge_count = 1
    self.shield_lv = get_npc_shield(self.npc)
  end
  if magic_id == sheild_magic_id then
    abort_magic_by_id(self.npc, E1_sheild_magic_id, 1)
    abort_magic_by_id(target, 1007105, 1)
    self.shield_falloff_switch = true
    cast_magic(self.npc, target, 1007094, 0)
    self.shield_lv_max = get_npc_shield(self.npc)
    self.shield_lv = get_npc_shield(self.npc)
  end
  if magic_id == E1_sheild_magic_id then
    cast_magic(self.npc, target, 1007094, 0)
    abort_magic_by_id(target, 1007105, 1)
    self.E1_shield_lv_max = get_npc_shield(self.npc)
    self.E1_shield_lv = get_npc_shield(self.npc)
  end
  if target == self.npc and 1007032 == magic_id then
    skill2_hit_count = 0
    local monster_list = search_npc(self.npc, 4, 50, nil, 0, true)
    local monster_num = #monster_list
    if self.target and get_target_angel(self.npc, self.target) > 90 and 1 == monster_num then
      local distance_min = check_npc_distance(self.npc, self.target, 4, true)
      local distance_max = check_npc_distance(self.npc, self.target, 8, true)
      if distance_max and not distance_min then
        cast_missile(self.npc, self.target, nil, nil, 10010072907, 0)
      elseif distance_min then
        cast_missile(self.npc, self.target, nil, nil, 10010072928, 0)
      elseif not distance_max then
        cast_missile(self.npc, self.target, nil, nil, 10010072929, 0)
      end
    elseif not self.target then
      local position = get_npc_offset_position(self.npc, nil, 0, 1000)
      cast_missile(self.npc, nil, position.x, position.z, 10010072905, 0)
    else
      cast_missile(self.npc, self.target, nil, nil, 10010072905, 0)
    end
  end
  if target == self.npc and 1007027 == magic_id then
    CD_magic_id = 1007061
  end
  if target == self.npc and magic_id == charge_magic_id then
    cast_magic(self.npc, target, charge_effect_id, 0)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if magic_id == fragile_magic_id and not check_magic(target, fragile_magic_id) and check_magic(self.npc, 1007014) and not check_npc_die(self.npc) and target then
    cast_magic(target, target, fragile_magic_id, 0)
  end
  if target == self.npc and magic_id == charge_magic_id and self.charge_count < 3 and (is_cast_skill_time(self.npc, counter_skill_id[1]) or is_cast_skill_time(self.npc, counter_skill_id[2])) then
    self.charge_count = self.charge_count + 1
    if self.charge_count < 3 then
      cast_magic(self.npc, target, charge_magic_id, 0)
    end
    if 2 == self.charge_count then
      play_common_sound("H1001007_Counter_2")
    elseif 3 == self.charge_count then
      play_common_sound("H1001007_Counter_3")
    end
  end
  if magic_id == sheild_magic_id then
    if is_cast_skill_time(target, counter_skill_id[1]) or is_cast_skill_time(target, counter_skill_id[2]) then
      return
    end
    CommonRole.magic_with_check(self, target, target, 1007097)
    abort_magic_by_id(target, 1007094, 1)
    abort_magic_by_id(target, 1007095, 1)
    abort_magic_by_id(target, 1007096, 1)
    if is_hero_in_ground(target) then
      CommonRole.magic_with_check(self, target, target, 1007105)
    end
  end
  if magic_id == E1_sheild_magic_id then
    if is_cast_skill_time(target, counter_skill_id[1]) or is_cast_skill_time(target, counter_skill_id[2]) then
      return
    end
    CommonRole.magic_with_check(self, target, target, 1007097)
    abort_magic_by_id(target, 1007094, 1)
    abort_magic_by_id(target, 1007095, 1)
    abort_magic_by_id(target, 1007096, 1)
    if is_hero_in_ground(target) then
      CommonRole.magic_with_check(self, target, target, 1007105)
    end
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if (1007039 == magic_id or 1007067 == magic_id) and get_npc_attr(target, 1) <= 0 and self.missile_1001007 then
    stop_missile(self.missile_1001007)
    self.missile_1001007 = nil
    rebound_count = 0
  end
  if npc == self.npc and 1007038 == magic_id and check_magic(self.npc, 1007017) then
    cast_magic(self.npc, target, 1007041, 0)
  end
  if check_magic(target, sheild_magic_id) or check_magic(target, E1_sheild_magic_id) then
    cast_missile(self.npc, nil, nil, nil, 10010074112, 0)
  end
  if target == self.npc and (is_cast_skill_time(self.npc, counter_skill_id[1]) or is_cast_skill_time(self.npc, counter_skill_id[2])) and get_npc_shield(self.npc) <= 0 then
    abort_skill(self.npc)
    lookat_npc(self.npc, npc, 1)
    cast_skill(self.npc, nil, counter_skill_id[4], nil, nil)
    cast_magic(self.npc, self.npc, 1007098, 0)
    cast_magic(self.npc, self.npc, 1007105, 0)
    abort_magic_by_id(target, 1007094, 1)
    abort_magic_by_id(self.npc, charge_effect_id, 2)
    self.counter_skill_counting = 1
    replace_hero_skill(3, counter_skill_id[1])
    stop_skill_joystick_move(self.npc)
  end
  if check_magic(target, sheild_magic_id) then
    local shield_lv = get_npc_shield(target)
    if shield_lv / self.shield_lv_max > 0 then
    elseif shield_lv <= 0 then
      cast_magic(target, target, 1007097, 0)
      cast_magic(target, target, 1007058, 0)
      if is_hero_in_ground(target) then
        CommonRole.magic_with_check(self, target, target, 1007105)
      end
    end
  end
  if check_magic(target, E1_sheild_magic_id) then
    local E1_shield_lv = get_npc_shield(target)
    if E1_shield_lv / self.E1_shield_lv_max > 0 then
      play_effect_anim(target, "Fx_H1001007_skill1_counter_1_1", "Fx_H1001007_skill1_counter_2_4")
    elseif E1_shield_lv <= 0 then
      cast_magic(target, target, 1007097, 0)
      cast_magic(target, target, 1007058, 0)
      if is_hero_in_ground(target) then
        CommonRole.magic_with_check(self, target, target, 1007105)
      end
    end
  end
  if target == self.npc then
    CommonRole.hit_screen_effect(self)
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_cfg.Id == 10010074111 and m1_owner == self.npc and 2 == m2_cfg.MissileTypeTag and m2_owner ~= self.teammate_now and check_magic(self.npc, 1007023) then
    rebound_missile(m2, self.teammate_now, m2_owner, nil, nil, 10)
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and check_magic(self.npc, 1007011) and (100100701 == skill_id or 100100702 == skill_id or 100100703 == skill_id) then
    cast_magic(self.npc, hit_target, 1007004, 0)
  end
  if (missile_cfg.Id == 10010073102 or missile_cfg.Id == 10010073202 or missile_cfg.Id == 10010074110) and check_magic(self.npc, 1007021) and hit_target ~= self.npc and not check_magic(hit_target, E1_sheild_magic_id) then
    CommonRole.magic_with_check(self, hit_target, hit_target, E1_sheild_magic_id)
  end
  if (missile_cfg.Id == 10010071902 or missile_cfg.Id == 10010071903 or missile_cfg.Id == 10010071904 or missile_cfg.Id == 10010071905) and check_magic(self.npc, 1007024) and (check_magic(hit_target, 1007005) or check_magic(hit_target, 1007028)) then
    cast_missile(self.npc, self.npc, nil, nil, 10010074111, 0)
  end
  if check_magic(self.npc, 1007027) and hit_target == self.npc and (missile_cfg.Id == 10010074116 or missile_cfg.Id == 10010074114 or missile_cfg.Id == 10010074110) then
    cast_magic(self.npc, self.npc, 1007062, 0)
  end
  if hit_target == self.npc and is_cast_skill_time(self.npc, counter_skill_id[1]) then
    CommonRole.common_counter(self, npc, hit_target, hit_type, missile_cfg, false)
  end
  local rebound_count = 0
  local max_rebound_count = 10
  if npc == self.npc and (missile_cfg.Id == 10010072905 or missile_cfg.Id == 10010072908) then
    local rebound_target = search_npc(hit_target, 2, 30, 0, 1)
    if rebound_target and rebound_count <= max_rebound_count then
      self.missile_1001007 = nil
      rebound_missile(missile, hit_target, rebound_target, nil, nil, 20, 1, true, true)
      rebound_count = rebound_count + 1
      if check_magic(npc, 1007018) and (check_magic(hit_target, 1007005) or check_magic(npc, 1007028)) then
        local mod = math.fmod(rebound_count, 2)
        local pos1 = get_npc_pos(rebound_target)
        local pos2 = get_npc_pos(hit_target)
        cast_missile(hit_target, rebound_target, pos2.x, pos2.z, 10010072931, pos1.x, pos1.z)
      end
    elseif not rebound_target then
      self.missile_1001007 = missile
      if missile_cfg.Id == 10010072908 then
        rebound_missile(missile, hit_target, hit_target, nil, nil, 5, 1, true, true)
      else
        rebound_missile(missile, hit_target, hit_target, nil, nil, 5, 1)
      end
      rebound_count = rebound_count + 1
      if check_magic(npc, 1007018) then
        local mod = math.fmod(rebound_count, 2)
        local pos = get_npc_pos(hit_target)
        if check_magic(hit_target, 1007005) or check_magic(npc, 1007028) then
          if 1 == mod then
            cast_missile(npc, hit_target, pos.x, pos.z, 10010072930, 0)
          else
            cast_missile(npc, hit_target, pos.x, pos.z, 10010072931, 0)
          end
        end
      end
    end
    if max_rebound_count < rebound_count then
      rebound_count = 0
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  Base.on_skill_begin(self, npc, skill_id, skill_type)
  if npc == self.npc then
    CommonRole.counter_timecount(self, skill_type, 2)
    if skill_id == skill3_id[1] then
      set_ui_object_visible("fight", "Main", false)
    end
    if skill_id == counter_skill_id[1] then
      cast_magic(self.npc, self.npc, sheild_magic_id, 0)
      cast_magic(self.npc, self.npc, charge_magic_id, 0)
    end
    if 100100716 == skill_id or 100100713 == skill_id then
      replace_hero_skill(3, counter_skill_id[1])
      skill_abort_level = 5
    end
    if 100100792 == skill_id then
      self.charge_count = 2
    end
    if 100100751 == skill_id then
      self.charge_count = 9
    end
    if 100100721 == skill_id then
      skill2_hit_count = 0
    end
    CommonRole.battlesetting_camera_focus(self, skill_type)
  end
  now_skill = skill_id
  if skill_id == born_skill then
    check_play_born_sound(self.npc)
  end
  if skill_id == born_skill or skill_id == exskill_id then
    set_ui_object_visible("fight", "Main", false)
  end
  if 100100715 == skill_id then
    set_skill_end_to_idle(self.npc, false)
  end
  if 100100716 == skill_id or 100100713 == skill_id then
    set_skill_end_to_idle(self.npc, true)
  end
  if skill_id == self.qte_skill then
    cast_magic(self.npc, self.npc, 1007120, 0)
  end
end

function M:hurt()
  if self and check_npc_status(self.npc, 2) then
    set_skill_end_to_idle(self.npc, true)
  end
end

function M:on_skill_end(npc, skill_id)
  Base.on_skill_end(self, npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == skill3_id[1] then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == born_skill or skill_id == exskill_id then
    set_ui_object_visible("fight", "Main", true)
  end
  if skill_id == counter_skill_id[1] and self.loop then
    cast_skill(self.npc, nil, 100100712, nil, nil)
    CommonRole.abort_magic_with_check(self, self.npc, 1004006)
    skill_abort_level = 4
  end
  if skill_id == counter_skill_id[2] then
    if 1 == self.charge_count then
      CommonRole.skill_setting(self)
      cast_skill(self.npc, nil, counter_skill_id[3], nil, nil)
      self.counter_skill_counting = 1
      skill_abort_level = 5
    elseif self.charge_count >= 2 then
      CommonRole.skill_setting(self)
      counter_skill_id[3] = 100100716
      cast_skill(self.npc, nil, counter_skill_id[3], nil, nil)
      self.counter_skill_counting = 1
      counter_skill_id[3] = 100100713
      skill_abort_level = 5
    end
  end
  if 100100716 == skill_id or 100100713 == skill_id then
    set_skill_end_to_idle(self.npc, true)
    stop_skill_joystick_move(self.npc)
  end
  if skill_id == counter_skill_id[4] then
    set_skill_end_to_idle(self.npc, true)
    skill_abort_level = 1
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  set_skill_end_to_idle(self.npc, true)
  now_skill = 0
  if skill_id == born_skill or skill_id == skill3_id[1] then
    set_ui_object_visible("fight", "Main", true)
  end
end

function M:on_hero_showup_or_back(npc, is_showup)
  Base.on_hero_showup_or_back(self, npc, is_showup)
  if npc == self.npc then
    if true == is_showup then
      self.counter_skill_counting = 1
      self.charge_count = 1
      stop_skill_joystick_move(self.npc)
      abort_magic_by_id(self.npc, sheild_magic_id, 2)
      abort_magic_by_id(self.npc, 1007094, 1)
      abort_magic_by_id(self.npc, 1007095, 1)
      abort_magic_by_id(self.npc, 1007096, 1)
    end
    if false == is_showup then
      abort_skill(self.npc, 1)
      abort_magic_by_id(self.npc, sheild_magic_id, 1)
      abort_magic_by_id(self.npc, 1007094, 1)
      abort_magic_by_id(self.npc, 1007095, 1)
      abort_magic_by_id(self.npc, 1007096, 1)
      stop_skill_joystick_move(self.npc)
      set_skill_end_to_idle(self.npc, true)
      replace_hero_skill(3, counter_skill_id[1])
      self.counter_skill_counting = 1
      self.charge_count = 1
      shield_level = 0
      clear_input()
      CommonRole.role_counter_reset(self)
    end
  end
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
end

function M:on_touch_up(input_id, iscancle)
  CommonRole.role_common_on_output(self, input_id)
  if true == iscancle then
    press_set = 0
  end
end

function M:grey_mask()
  local now_energy = get_npc_attr(self.npc, 72) + get_npc_temp_blue(self.npc)
  if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, 100100721) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      100100721,
      1
    })
  elseif now_energy >= CommonRole.battle_res_cost(self, self.battle_res_type, 100100721) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      100100721,
      0
    })
  end
  if now_energy < CommonRole.battle_res_cost(self, self.battle_res_type, 100100731) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      100100731,
      1
    })
  elseif now_energy >= CommonRole.battle_res_cost(self, self.battle_res_type, 100100731) then
    play_ui_fight_button_effect({
      "gray",
      nil,
      100100731,
      0
    })
  end
end

function M:shield_falloff()
  local npc_time_now = get_npc_time(self.npc)
  if self.shield_falloff_switch == true and npc_time_now > self.shield_falloff_timer then
    if 1007057 == sheild_magic_id then
      local min_shield = get_npc_attr(self.npc, 4) * 0.06
      if min_shield <= get_npc_shield(self.npc) then
        self.shield_falloff_timer = npc_time_now + 0.1
        cast_magic(self.npc, self.npc, 1007109, 0)
      else
        self.shield_falloff_switch = false
      end
    elseif 1007102 == sheild_magic_id then
      local min_shield = get_npc_attr(self.npc, 4) * 0.09
      if min_shield <= get_npc_shield(self.npc) then
        self.shield_falloff_timer = npc_time_now + 0.1
        cast_magic(self.npc, self.npc, 1007110, 0)
      else
        self.shield_falloff_switch = false
      end
    end
  end
end

function M:on_frame()
  Base.on_frame(self)
  CommonRole.role_common_on_frame(self)
  self:grey_mask()
  self:shield_falloff()
  if self.target == nil then
  end
end

function M:on_frame_background()
  Base.on_frame(self)
end

function M:on_born_behavior()
  CommonRole.born_animation(self, born_skill)
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    abort_magic_by_id(self.npc, sheild_magic_id, 1)
    abort_magic_by_id(self.npc, 1007094, 1)
    abort_magic_by_id(self.npc, 1007095, 1)
    abort_magic_by_id(self.npc, 1007096, 1)
    stop_skill_joystick_move(self.npc)
    set_skill_end_to_idle(self.npc, true)
    replace_hero_skill(3, counter_skill_id[1])
    self.counter_skill_counting = 1
    self.charge_count = 1
    shield_level = 0
    clear_input()
  end
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
  abort_magic_by_id(self.npc, sheild_magic_id, 1)
  abort_magic_by_id(self.npc, 1007094, 1)
  abort_magic_by_id(self.npc, 1007095, 1)
  abort_magic_by_id(self.npc, 1007096, 1)
  if (check_magic(self.npc, 6020017) or check_magic(self.npc, 6020032)) and 0 == self.death_set then
    self.death_set = 1
    return
  end
  CommonRole.on_dead_hero_common(self)
  create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 10)
  set_npc_dead(self.npc, "die1", false)
end

function M:on_hero_reborn(reborned_hero)
  Base.on_hero_reborn(self, reborned_hero)
  if reborned_hero ~= self.npc then
    return
  end
  stop_skill_joystick_move(self.npc)
  set_skill_end_to_idle(self.npc, true)
  replace_hero_skill(3, counter_skill_id[1])
  self.counter_skill_counting = 1
  self.charge_count = 1
  shield_level = 0
end

return M
