local M = Util.create_class()
local CommonRole = import("common.role")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local open = 1
local close = 2
local h1 = get_come_on_hero()
local h2 = get_scene_hero_by_poskey(21)
local h3 = get_scene_hero_by_poskey(22)
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 14
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 6
}
local CDmonster

function M:_init(npc)
  if get_cur_room_id() == 20151 then
    self.guozai_id = 10003
  elseif get_cur_room_id() == 20152 then
    self.guozai_id = 10005
    self.dancishiting_id = 10006
    self.challeng_num = 3
  elseif get_cur_room_id() == 20153 then
    self.guozai_id = 10008
    self.dancishiting_id = 10009
    self.challeng_num = 5
  elseif get_cur_room_id() == 20251 then
    self.jixianshanbi_id = 10012
  elseif get_cur_room_id() == 20252 then
    self.tanfan_id = 10015
  elseif get_cur_room_id() == 20253 then
    self.tanfan_id = 10018
    self.noattack_id = 10017
  elseif get_cur_room_id() == 20351 then
    self.quanjushiting_id = 10021
  elseif get_cur_room_id() == 20352 then
    self.quanjushiting_id = 10024
  elseif get_cur_room_id() == 20353 then
    self.dancishiting_id = 10027
    self.challeng_num = 5
  end
  self.all_explode_num = 0
  self.count = -1
  self.base_skill_id = 300103901
  self.max_time = 3
  self.skill_hit_count = 0
  self.skill_hit_trigger = 5
  self.explode = 0
  self.skill_missile = nil
  self.skill_missile_id = 30010390101
  self.now_skill_id = 300103901
  self.SearchMonster = 0
  self.skill_hit_list = {}
  self.skill_charge_cfg = {
    param_type = 1,
    param1 = 74,
    param2 = 75
  }
  listen_missile_begin_pos(npc, self.skill_missile_id, self.on_missile_begin, self)
  listen_missile_begin_pos(npc, 30010390401, self.on_missile_begin, self)
  listen_missile_begin_pos(npc, 30010390501, self.on_missile_begin, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.skill_missile_id, self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.skill_missile_id, self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 30010390501, self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010390501, self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 30010390401, self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010390401, self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, npc, self.skill_missile_id, self.on_timestop_catch_missile, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, npc, self.skill_missile_id, self.on_timestop_release_missile, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, npc, 30010390501, self.on_timestop_catch_missile, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, npc, 30010390501, self.on_timestop_release_missile, self)
  listen_missile_end_pos(npc, 30010390102, self.on_missile_end, self)
  listen_missile_end_pos(npc, 30010390501, self.on_missile_end, self)
  listen_missile_end_pos(npc, self.skill_missile_id, self.on_missile_end, self)
  mark_limited_missile(30010390101, 1)
  mark_limited_missile(30010390501, 1)
  cast_magic(npc, npc, 3001039010, 0)
  cast_magic(npc, npc, 3001039011, 0)
  set_can_searched(npc, false)
  set_skill_btn_charging(60, 2, self.skill_charge_cfg)
end

function M:on_remove()
  unlisten_missile_begin_pos(self.npc, self.skill_missile_id, self)
  unlisten_missile_begin_pos(self.npc, 30010390401, self)
  unlisten_missile_begin_pos(self.npc, 30010390501, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 30010390501, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 30010390501, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, 30010390401, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, 30010390401, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, self.npc, self.skill_missile_id, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_MISSILE, self.npc, 30010390501, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_MISSILE, self.npc, 30010390501, self)
  unlisten_missile_end_pos(self.npc, 30010390102, self)
  unlisten_missile_end_pos(self.npc, 30010390501, self)
  unlisten_missile_end_pos(self.npc, self.skill_missile_id, self)
end

function M:on_born_behavior()
end

function M:on_role_level_change(level)
  if 8 == level then
    self.add74_timer = 0
  end
end

function M:on_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  cast_magic(self.npc, target_npc, 4032110, 0)
  cast_magic(self.npc, target_npc, 3001039001, 0)
  if get_god_skill_level() >= 7 and (missile_cfg.Id == self.skill_missile_id or missile_cfg.Id == 30010390501) and 5 ~= get_role_kind(target_npc) then
    cast_magic(self.npc, self.npc, 3001039009, 0)
    if get_npc_attr(self.npc, 74) >= 100 then
      replace_tower_skill(4)
      self.now_skill_id = 300103904
    end
  end
  if missile_cfg.Id ~= 30010390101 or 3 == get_role_kind(target_npc) and not self.kind3 and not check_magic(target_npc, 40321110) then
  elseif 4 == get_role_kind(target_npc) and not self.kind4 and not check_magic(target_npc, 40321110) then
    self.missile_timer = self.missile_timer - 2.5
    self.kind4 = true
  end
  if missile_cfg.Id ~= 30010390501 or 3 == get_role_kind(target_npc) and not self.kind33 and not check_magic(target_npc, 40321110) then
  elseif 4 == get_role_kind(target_npc) and not self.kind44 and not check_magic(target_npc, 40321110) then
    self.missile_timer2 = self.missile_timer2 - 2.5
    self.kind44 = true
  end
end

function M:on_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  self:stop_missile_effect(owner, target_npc, missile_cfg)
end

function M:on_timestop_catch_missile(owner, target_missile_cfg, target_missile, missile_cfg, missile, target_missile_owner)
  if (missile_cfg.Id == self.skill_missile_id or missile_cfg.Id == 30010390501) and 2 == target_missile_cfg.MissileTypeTag then
    if get_god_skill_level() >= 5 then
      create_scene_effect("FX_T3001039_tanfan", get_missile_pos(target_missile), 10)
      rebound_missile(target_missile, get_come_on_hero(), target_missile_owner, nil, nil, 10, false, true, true)
      if self.tanfan_id then
        add_task_progress(self.tanfan_id, 1)
      end
      if get_god_skill_level() >= 6 then
        cast_magic(self.npc, self.npc, 3001039036, 0)
        cast_magic(self.npc, self.npc, 3001039022, 0)
      end
    elseif get_god_skill_level() < 5 then
      set_missile_dt(target_missile, 0)
    end
  end
  if missile_cfg.Id == 30010390401 then
    set_missile_dt(target_missile, 0)
  end
end

function M:on_timestop_release_missile(owner, target_missile, missile_cfg, missile)
  if get_god_skill_level() < 6 then
    set_missile_dt(target_missile, 1)
  end
end

function M:indicator_input()
  if self.indicator_timer and get_npc_time(self.npc) > self.indicator_timer then
    self.indicator_timer = nil
    self.indicator_active = true
    if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      return
    end
    if self.betargetd then
      if get_npc_cd_charge(self.npc, 300103903) < get_skill_cfg(300103903).CdChargePerCost then
        cast_magic(self.npc, self.npc, 100181, 0)
        return
      end
    elseif get_npc_cd_charge(self.npc, 300103901) < get_skill_cfg(300103901).CdChargePerCost then
      cast_magic(self.npc, self.npc, 100181, 0)
      return
    end
    if self.target and check_npc_distance(self.npc, self.target, 7, 0) then
      update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
      set_indicator_active(60, true, true)
      CommonRole.indicator_slowdown_on(self)
      self.press_set = true
    else
      update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
      set_indicator_active(60, true, false)
      CommonRole.indicator_slowdown_on(self)
      self.press_set = true
    end
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    if get_sync_var("H1001001_103307") then
      return
    end
    self.target = search_npc(self.npc, 4, 15, Const.LOCK_ON_TAG, 1)
    set_npc_target(self.npc, self.target)
    if get_npc_cd_charge(self.npc, self.now_skill_id) < get_skill_cfg(self.now_skill_id).CdChargePerCost then
      return
    end
    self.indicator_timer = get_npc_time(self.npc) + 0.25
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel then
    if get_sync_var("H1001001_103307") then
      return
    end
    if get_npc_cd_charge(self.npc, self.now_skill_id) >= get_skill_cfg(self.now_skill_id).CdChargePerCost then
      if get_god_skill_level() >= 7 and get_npc_attr(self.npc, 74) >= get_skill_cfg(300103904).BattleResCost then
        if not self.indicator_active then
          abort_skill(self.npc)
          if self.skill_missile then
            stop_missile(self.skill_missile)
          end
          if self.skill_missile2 then
            stop_missile(self.skill_missile2)
          end
          cast_skill(self.npc, self.npc, 300103904)
          cast_magic(self.npc, self.npc, 3001039010, 0)
          if self.quanjushiting_id then
            add_task_progress(self.quanjushiting_id, 1)
          end
        elseif self.betargetd then
          if get_npc_cd_charge(self.npc, 300103903) >= get_skill_cfg(300103903).CdChargePerCost then
            local x, y = get_indicator_pos(60)
            abort_skill(self.npc)
            cast_skill(self.npc, nil, self.base_skill_id, x, y)
            cast_skill(self.npc, nil, 300103903, x, y)
          end
        elseif get_npc_cd_charge(self.npc, 300103901) >= get_skill_cfg(300103901).CdChargePerCost then
          local x, y = get_indicator_pos(60)
          abort_skill(self.npc)
          cast_skill(self.npc, nil, self.base_skill_id, x, y)
        end
      else
        local x, y = get_indicator_pos(60)
        if self.indicator_active and x and y then
          abort_skill(self.npc)
          cast_skill(self.npc, nil, self.base_skill_id, x, y)
          if self.betargetd then
            cast_skill(self.npc, nil, 300103903, x, y)
          end
        else
          abort_skill(self.npc)
          cast_skill(self.npc, self.target, self.base_skill_id)
          if self.betargetd then
            cast_skill(self.npc, nil, 300103903, x, y)
          end
        end
      end
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
    self.indicator_timer = nil
    self.indicator_active = nil
    set_indicator_active(60, false)
    CommonRole.indicator_slowdown_off(self)
  end
end

function M:after_damage(npc, target, magic_id)
  if get_god_skill_level() >= 2 and (check_magic(target, 3001039001) or check_magic(self.npc, 3001039013)) and 1 ~= get_role_kind(target) then
    cast_magic(self.npc, target, 3001039005, 0)
    if get_magic_num(target, 3001039005) == self.skill_hit_trigger then
      abort_magic_by_id(target, 3001039005, self.skill_hit_trigger)
      cast_magic(self.npc, target, 3001039006, 0)
      self.skill_hit_count = 0
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if (missile_cfg.Id == 30010390103 or missile_cfg.Id == 30010390503) and get_god_skill_level() >= 3 then
    cast_magic(self.npc, hit_target, 3001039006, 0)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc and 300103904 == skill_id then
    if self.betargetd then
      self.now_skill_id = 300103903
      replace_tower_skill(3)
    else
      self.now_skill_id = 300103901
      replace_tower_skill(1)
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 300103905 == skill_id and self.jixianshanbi_id then
    add_task_progress(self.jixianshanbi_id, 1)
  end
  if (100100101 == skill_id or 100100102 == skill_id or 100100103 == skill_id or 100100104 == skill_id or 100100105 == skill_id or 100100106 == skill_id or 100100107 == skill_id or 100100108 == skill_id or 100100109 == skill_id or 100100121 == skill_id or 100100122 == skill_id or 100100131 == skill_id or 100100132 == skill_id or 100100192 == skill_id) and get_cur_room_id() == 20253 then
    add_task_progress(self.noattack_id, -1)
  end
end

function M:on_missile_end(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 30010390102 then
    if self.count and self.count >= 1 then
      if h1 then
        cast_magic(self.npc, h1, 3001039008, 0)
        self.h1_buff_time = get_time() + self.count * 2
      end
      if h2 then
        cast_magic(self.npc, h2, 3001039008, 0)
        self.h2_buff_time = get_time() + self.count * 2
      end
      if h3 then
        cast_magic(self.npc, h3, 3001039008, 0)
        self.h3_buff_time = get_time() + self.count * 2
      end
    end
    self.count = -1
  end
  if missile_cfg.Id == 30010390101 then
    self.skill_missile = nil
  end
  if missile_cfg.Id == 30010390501 then
    self.skill_missile2 = nil
  end
end

function M:atk_buff_timer()
  if self.h1_buff_time and get_time() > self.h1_buff_time then
    abort_magic_by_id(h1, 3001039008, 1)
    self.h1_buff_time = nil
  end
  if self.h2_buff_time and get_time() > self.h2_buff_time then
    abort_magic_by_id(h2, 3001039008, 1)
    self.h2_buff_time = nil
  end
  if self.h3_buff_time and get_time() > self.h3_buff_time then
    abort_magic_by_id(h3, 3001039008, 1)
    self.h3_buff_time = nil
  end
end

function M:on_missile_begin(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.npc then
    if missile_cfg.Id == self.skill_missile_id then
      self.missile_timer = get_time() + self.max_time
      self.skill_missile = missile
    end
    if missile_cfg.Id == 30010390501 then
      self.missile_timer2 = get_time() + self.max_time
      self.skill_missile2 = missile
    end
  end
end

function M:stop_missile_effect(o, t, m)
  abort_magic_by_id(t, 4032110, 1)
  abort_magic_by_id(t, 3001039001)
  abort_magic_by_id(t, 3001039005)
  local explode_num = get_magic_num(t, 3001039006)
  local monster_pos = get_npc_pos(t)
  self.skill_hit_count = 0
  self.kind3 = nil
  self.kind4 = nil
  self.kind33 = nil
  self.kind44 = nil
  if 0 ~= explode_num then
    for i = 1, explode_num do
      cast_missile(get_come_on_hero(), t, monster_pos.x, monster_pos.z, 30010390201, 1, nil, nil, nil, monster_pos.y)
      play_common_sound("Sound_TimeSphere_overload")
      create_scene_effect("Fx_H1001004_skill1_counter_1_3_2", t:get_pos_vec3(), 0)
      if self.guozai_id then
        add_task_progress(self.guozai_id, 1)
      end
      self.all_explode_num = self.all_explode_num + 1
      if self.challeng_num and self.dancishiting_id and self.all_explode_num >= self.challeng_num then
        add_task_progress(self.dancishiting_id, 1)
      end
    end
  end
  abort_magic_by_id(t, 3001039006, 10)
end

function M:timeout_stop_missile()
  if self.all_explode_timer and get_time() >= self.all_explode_timer then
    self.all_explode_num = 0
    self.all_explode_timer = nil
  end
  if self.skill_missile and self.missile_timer and get_time() > self.missile_timer then
    stop_missile(self.skill_missile)
    for _, monster in ipairs(self.skill_hit_list) do
      self:stop_missile_effect(monster)
    end
    self.skill_missile = nil
    self.missile_timer = nil
  end
  if self.skill_missile2 and self.missile_timer2 and get_time() > self.missile_timer2 then
    stop_missile(self.skill_missile2)
    for _, monster in ipairs(self.skill_hit_list) do
      self:stop_missile_effect(monster)
    end
    self.skill_missile2 = nil
    self.missile_timer2 = nil
  end
end

function M:change_CD()
  if get_npc_time(self.npc) > self.SearchMonster then
    self.SearchMonster = get_npc_time(self.npc) + 1.5
    CDmonster = search_npc(self.npc, 4, 40, 0, 1)
  end
  if CDmonster and 5 ~= get_role_kind(CDmonster) then
    self.monster = CDmonster
    self.pass_timer = nil
  else
    self.monster = nil
  end
  if self.monster and not self.betargetd then
    CommonRole.set_value("betargetd", 1, true)
    self.pass_timer = nil
    self.betargetd = true
    self.now_skill_id = 300103903
    replace_tower_skill(3)
  elseif not self.monster and self.betargetd and not self.pass_timer then
    self.pass_timer = get_time() + 2
  end
  if self.pass_timer and get_time() > self.pass_timer then
    self.pass_timer = nil
    CommonRole.set_value("betargetd", 1, false)
    self.betargetd = nil
    self.now_skill_id = 300103901
    replace_tower_skill(1)
    if get_god_skill_level() >= 4 then
      cast_magic(self.npc, self.npc, 3001039017, 0)
    end
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 3001039015 == magic_id or 3001039016 == magic_id then
    cast_magic(self.npc, self.npc, 3001039017, 0)
  end
end

function M:on_enter_room(room_id, is_first_enter)
  if 1313 == room_id then
    offset_shadow_api(2, 2, 0)
  end
end

function M:lv8()
  if self.add74_timer and get_time() > self.add74_timer then
    if self.betargetd == true then
      self.add74_timer = get_time() + 0.4
      cast_magic(self.npc, self.npc, 3001039018, 0)
    else
      self.add74_timer = get_time() + 0.2
      cast_magic(self.npc, self.npc, 3001039018, 0)
    end
    if get_npc_attr(self.npc, 74) >= 100 then
      replace_tower_skill(4)
      self.now_skill_id = 300103904
    end
  end
end

function M:on_frame()
  self:lv8()
  self:change_CD()
  self:timeout_stop_missile()
  self:indicator_input()
  self:atk_buff_timer()
end

return M
