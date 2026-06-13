local M = Util.create_class()
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local CommonRole = import("common.role")
local skill_area = {
  type = 1,
  res = "FX_text_kong",
  sizex = 14
}
local skill_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 2,
  sizey = 6
}
local skill1_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 7.5
}
local skill1_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 0,
  sizey = 6
}

function M:_init(npc)
  stop_ui_fight_button_effect({
    "Strengthen_skill_",
    8
  })
  set_ui_object_visible("fight", "Btn_skillTower", false)
  self.level_skill_1fast = 300106301
  self.level_skill_2 = 300106302
  self.level_skill_3 = 300106303
  self.level_skill_1normal = 300106304
  self.now_level_skill = 300106301
  self.now_skill_press = 0
  self.missile_1 = 30010630101
  self.isInBattle = false
  self.isInBattleRecord = false
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.missile_1, self.on_skill_1_release_npc, self)
end

function M:indicator_input()
  if self.indicator_timer and get_npc_time(self.npc) > self.indicator_timer then
    self.indicator_timer = nil
    self.indicator_active = true
    if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      return
    end
    if self.now_level_skill == self.level_skill_1fast then
      if self.isInBattle then
        if get_npc_cd_charge(self.npc, self.level_skill_1normal) < get_skill_cfg(self.now_level_skill).CdChargePerCost then
          cast_magic(self.npc, self.npc, 100181, 0)
          return
        end
      elseif get_npc_cd_charge(self.npc, self.now_level_skill) < get_skill_cfg(self.now_level_skill).CdChargePerCost then
        cast_magic(self.npc, self.npc, 100181, 0)
        return
      end
      update_skill_indicator(60, skill1_area, skill1_indi_cfg, 0)
      set_indicator_active(60, true, false)
      CommonRole.indicator_slowdown_on(self)
      self.press_set = true
    elseif self.now_level_skill == self.level_skill_2 then
      if get_npc_cd_charge(self.npc, self.now_level_skill) < get_skill_cfg(self.now_level_skill).CdChargePerCost then
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
end

function M:on_input(input_id)
  if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
    return
  end
  if self.now_level_skill == self.level_skill_1fast then
    if self.isInBattle then
      if get_npc_cd_charge(self.npc, self.level_skill_1normal) >= get_skill_cfg(self.now_level_skill).CdChargePerCost then
        if 60 == input_id then
          self.now_skill_press = self.now_level_skill
          set_npc_target(self.npc, self.npc)
          self.indicator_timer = get_npc_time(self.npc) + 0.25
          return
        end
      else
        cast_magic(self.npc, self.npc, 100181, 0)
      end
    elseif get_npc_cd_charge(self.npc, self.now_level_skill) >= get_skill_cfg(self.now_level_skill).CdChargePerCost then
      if 60 == input_id then
        self.now_skill_press = self.now_level_skill
        set_npc_target(self.npc, self.npc)
        self.indicator_timer = get_npc_time(self.npc) + 0.1
        return
      end
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
    return
  end
  if get_npc_cd_charge(self.npc, self.now_level_skill) >= get_skill_cfg(self.now_level_skill).CdChargePerCost then
    if 60 == input_id then
      self.now_skill_press = self.now_level_skill
      if self.now_level_skill == self.level_skill_2 then
        self.target = search_npc(self.npc, 4, 15, Const.LOCK_ON_TAG, 1)
        set_npc_target(self.npc, self.target)
        self.indicator_timer = get_npc_time(self.npc) + 0.25
        return
      end
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.now_level_skill)
    end
  else
    cast_magic(self.npc, self.npc, 100181, 0)
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel then
    if self.now_level_skill == self.level_skill_3 then
      if self.isInBattle then
        replace_tower_skill(4)
      else
        replace_tower_skill(1)
      end
      stop_ui_fight_button_effect({
        "Strengthen_skill_",
        8
      })
      self.now_level_skill = self.level_skill_1fast
      return
    end
    if self.now_level_skill == self.level_skill_1fast then
      if self.indicator_active then
        if self.isInBattle then
          if get_npc_cd_charge(self.npc, self.level_skill_1normal) >= get_skill_cfg(self.now_level_skill).CdChargePerCost then
            abort_skill(self.npc)
            cast_skill(self.npc, nil, self.level_skill_1normal)
            cast_skill(self.npc, nil, self.level_skill_1fast)
          end
        else
          abort_skill(self.npc)
          cast_skill(self.npc, nil, self.level_skill_1fast)
        end
      elseif self.isInBattle then
        if get_npc_cd_charge(self.npc, self.level_skill_1normal) >= get_skill_cfg(self.now_level_skill).CdChargePerCost then
          abort_skill(self.npc)
          cast_skill(self.npc, nil, self.level_skill_1normal)
          cast_skill(self.npc, nil, self.level_skill_1fast)
        end
      else
        abort_skill(self.npc)
        cast_skill(self.npc, nil, self.level_skill_1fast)
      end
      self.indicator_timer = nil
      self.indicator_active = nil
      set_indicator_active(60, false)
      CommonRole.indicator_slowdown_off(self)
      return
    end
    if self.now_level_skill ~= self.level_skill_2 or self.now_level_skill ~= self.now_skill_press then
      return
    end
    local x, y = get_indicator_pos(60)
    if self.indicator_active and x and y then
      abort_skill(self.npc)
      cast_skill(self.npc, nil, self.now_level_skill, x, y)
    else
      abort_skill(self.npc)
      cast_skill(self.npc, self.target, self.now_level_skill)
    end
    self.indicator_timer = nil
    self.indicator_active = nil
    set_indicator_active(60, false)
    CommonRole.indicator_slowdown_off(self)
  end
end

function M:on_timeline_begin(timeline_name)
  if self.now_level_skill ~= self.level_skill_2 or self.now_level_skill ~= self.now_skill_press then
    return
  end
  local x, y = get_indicator_pos(60)
  if self.indicator_active and x and y then
    abort_skill(self.npc)
    cast_skill(self.npc, nil, self.now_level_skill, x, y)
  else
    abort_skill(self.npc)
    cast_skill(self.npc, self.target, self.now_level_skill)
  end
  self.indicator_timer = nil
  self.indicator_active = nil
  set_indicator_active(60, false)
  CommonRole.indicator_slowdown_off(self)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010630901 then
    cast_magic(get_come_on_hero(), hit_target, 30010630901, 1)
  elseif missile_cfg.Id == 30010630201 then
    cast_magic(get_come_on_hero(), hit_target, 30010630201, 1)
  elseif missile_cfg.Id == 30010630301 then
    cast_magic(get_come_on_hero(), hit_target, 30010630301, 1)
  end
  if skill_id == self.level_skill_2 and missile_cfg.Id == 30010630201 and get_role_kind(hit_target) < 4 and get_role_kind(hit_target) >= 2 and not check_magic(hit_target, 3001063021) then
    abort_magic_by_id(hit_target, 3001064011)
    abort_magic_by_id(hit_target, 3001064012)
    abort_magic_by_id(hit_target, 3001064013)
    abort_magic_by_id(hit_target, 3001064014)
    cast_magic(npc, hit_target, 3001063021)
    cast_magic(npc, hit_target, 3001063022)
    cast_magic(npc, hit_target, 3001070004)
  end
  if skill_id ~= self.level_skill_1fast then
    return
  end
  if missile_cfg.Id ~= self.missile_1 then
    return
  end
  local hit_target_role = get_role_kind(hit_target)
  if 2 ~= hit_target_role and 3 ~= hit_target_role and get_npc_id(hit_target) ~= 3001074 then
    cast_magic(hit_target, hit_target, 3001064001, 0)
  end
  if get_npc_id(hit_target) ~= 3001064 and get_npc_id(hit_target) ~= 3001069 and get_npc_id(hit_target) ~= 3001075 then
    return
  end
  if 1 == hit_target.state then
    return
  end
  if not hit_target.D_hitted and missile_cfg.Id == 30010630101 then
    hit_target.D_hitted = true
    local smoke = hit_target:get_behavior()
    local smokeOnAbsorb = smoke and smoke.on_be_absorb
    if smokeOnAbsorb then
      smokeOnAbsorb(smoke)
    end
    abort_skill(self.npc)
    self.hit_count = 0
    if get_npc_id(hit_target) == 3001064 then
      self.now_level_skill = self.level_skill_2
      replace_tower_skill(2)
    end
    if get_npc_id(hit_target) == 3001069 or get_npc_id(hit_target) == 3001075 then
      self.now_level_skill = self.level_skill_3
      replace_tower_skill(3)
    end
    cast_magic(self.npc, get_come_on_hero(), 3001063002)
    play_ui_fight_button_effect({
      "Strengthen_skill_",
      8
    })
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.level_skill_2 then
    if self.isInBattle then
      replace_tower_skill(4)
    else
      replace_tower_skill(1)
    end
    stop_ui_fight_button_effect({
      "Strengthen_skill_",
      8
    })
    self.now_level_skill = self.level_skill_1fast
  end
end

function M:fightCheck()
  local player = get_come_on_hero()
  local role = player:get_behavior()
  if not role then
    return
  end
  self.isInBattle = role:isInBattle()
  if self.now_level_skill == self.level_skill_1fast then
    if self.isInBattle then
      replace_tower_skill(4)
    else
      replace_tower_skill(1)
    end
  end
  self.isInBattleRecord = self.isInBattle
end

function M:on_frame()
  self:indicator_input()
  self:fightCheck()
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_cfg.Id ~= self.missile_1 then
    return
  end
  local snake_fogA = {201049010404}
  local snake_fogB = {202049010402}
  for k, v in pairs(snake_fogA) do
    if m2_cfg.Id == v then
      remove_missile(m2)
      self.now_level_skill = self.level_skill_2
      abort_skill(self.npc)
      replace_tower_skill(2)
      cast_magic(self.npc, get_come_on_hero(), 3001063002)
      play_ui_fight_button_effect({
        "Strengthen_skill_",
        8
      })
    end
  end
  for k, v in pairs(snake_fogB) do
    if m2_cfg.Id == v then
      remove_missile_by_id(m2_cfg.Id)
      remove_missile_by_id(m2_cfg.Id + 4)
      self.now_level_skill = self.level_skill_2
      abort_skill(self.npc)
      replace_tower_skill(2)
      cast_magic(self.npc, get_come_on_hero(), 3001063002)
      play_ui_fight_button_effect({
        "Strengthen_skill_",
        8
      })
    end
  end
end

function M:on_npc_dead(npc)
  if npc == get_come_on_hero() then
    abort_skill(self.npc)
  end
end

function M:on_skill_1_release_npc(owner, target_npc, missile_cfg, missile)
  if check_magic(target_npc, 3001063001) then
    abort_magic_by_id(target_npc, 3001063001)
  end
end

return M
