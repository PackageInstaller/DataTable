local M = Util.create_class()
local CommonRole = import("common.role")
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 10
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 2
}

function M:_init()
  stop_ui_fight_button_effect({
    "Strengthen_skill_",
    8
  })
  set_ui_object_visible("fight", "Btn_skillTower", true)
  self.feicu = 319000101
  self.yanbu = 319000102
  self.yanbumissile = 31900010201
  self.Cancelcollision = 3190001021
  self.camerapush = 3190001012
  self.camerapull = 3190001013
  self.hero = get_come_on_hero()
  self.hero_one = get_scene_hero_by_poskey(21)
  self.hero_two = get_scene_hero_by_poskey(22)
  if get_cur_room_id() == 3190102 then
    replace_tower_skill(1)
    set_skill_btn_charging(60, 1, get_skill_cfg(self.feicu))
    play_ui_fight_button_effect({
      "Strengthen_skill_",
      8
    })
  elseif get_cur_room_id() == 3190201 then
    replace_tower_skill(2)
    set_skill_btn_charging(60, 1, get_skill_cfg(self.yanbu))
  end
end

function M:on_enter_room(room_id, is_first_enter)
  if get_cur_room_id() == 3190102 then
    replace_tower_skill(1)
    set_skill_btn_charging(60, 1, get_skill_cfg(self.feicu))
    play_ui_fight_button_effect({
      "Strengthen_skill_",
      8
    })
  elseif get_cur_room_id() == 3190201 then
    replace_tower_skill(2)
    set_skill_btn_charging(60, 1, get_skill_cfg(self.yanbu))
  end
end

function M:indicator_input()
  if self.indicator_timer and get_npc_time(self.npc) > self.indicator_timer then
    self.indicator_timer = nil
    self.indicator_active = true
    if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      return
    end
    if self.betargetd and get_npc_cd_charge(self.npc, self.yanbu) < get_skill_cfg(self.yanbu).CdChargePerCost then
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
  if get_cur_room_id() == 3190102 then
    if check_npc_status(self.npc, 12) or check_npc_status(self.npc, 11) or check_npc_status(self.npc, 10) then
      return
    end
    if get_npc_cd_charge(self.npc, self.feicu) >= get_skill_cfg(self.feicu).CdChargePerCost then
      if 60 == input_id then
        abort_skill(self.npc)
        cast_skill(self.npc, nil, self.feicu)
        cast_magic(self.npc, self.hero, self.camerapush, 1)
      end
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
  elseif get_cur_room_id() == 3190201 then
    if get_npc_cd_charge(self.npc, self.yanbu) >= get_skill_cfg(self.yanbu).CdChargePerCost then
      if 60 == input_id then
        self.target = search_npc(self.npc, 4, 15, Const.LOCK_ON_TAG, 1)
        set_npc_target(self.npc, self.target)
        self.indicator_timer = get_npc_time(self.npc) + 0.25
      end
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
  end
end

function M:on_touch_up(output_id, iscancel)
  if get_cur_room_id() == 3190201 and 60 == output_id and not iscancel then
    if get_npc_cd_charge(self.npc, self.yanbu) >= get_skill_cfg(self.yanbu).CdChargePerCost then
      local x, z = get_indicator_pos(60)
      if self.indicator_active and x and z then
        abort_skill(self.npc)
        cast_skill(self.npc, nil, self.yanbu, x, z)
        cast_missile(self.npc, self.npc, x, z, self.yanbumissile, 1)
        cast_magic(self.npc, get_come_on_hero(), self.Cancelcollision, 0)
        flash_to_pos(get_come_on_hero(), x, z)
      else
        local pos = get_npc_offset_position(self.npc, nil, 0, 5)
        abort_skill(self.npc)
        cast_skill(self.npc, nil, self.yanbu, pos.x, pos.z)
        cast_missile(self.npc, self.npc, pos.x, pos.z, self.yanbumissile, 1)
        cast_magic(self.npc, get_come_on_hero(), self.Cancelcollision, 0)
        flash_to_pos(get_come_on_hero(), pos.x, pos.z)
      end
      self.indicator_timer = nil
      self.indicator_active = nil
      set_indicator_active(60, false)
      CommonRole.indicator_slowdown_off(self)
    else
      cast_magic(self.npc, self.npc, 100181, 0)
    end
  end
end

function M:on_story_finish(story_id)
  if 2219106 == story_id then
    play_ui_fight_button_effect({
      "Strengthen_skill_",
      8
    })
  end
end

function M:on_frame()
  if get_cur_room_id() == 3190201 then
    self:indicator_input()
  end
end

return M
