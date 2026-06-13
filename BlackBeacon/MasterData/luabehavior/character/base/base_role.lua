local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local CommonMonster = import("common.monster")
local CommonRole = import("common.role")
local tool = import("common.role_tool")
M.indiMgr = import("character.base.base_role_indicatorManager")

function M.debugOutput(role, ...)
  Util.debug_output(role.id, role.npc.uuid, ...)
end

function M:_init(npc)
  self.id = npc.id
  self.npc = npc
  tool:addRole(self)
  self.jixianshanbi_switch = 1
  self.ex_missile_owner = nil
  self.self_timer = 0
  self.self_timer_switch = 0
  self.self_break_timer = 0
  self.self_break_timer_switch = 0
  self.self_break_timer_red = 0
  self.self_break_timer_switch_red = 0
  self.counter_npc = nil
  self.Timescale_Collection_timer = 0
  self.god_npc = nil
  self.is_skill = false
  self.is_dead_switch = false
  self.qte_type = 1
  self.indicator_timer = {}
  self.indicator_switch = {}
  self.indicator_active = {}
  self.counter_numb = true
  self.counter_atk = false
  self.ultimate_icon_effect = false
  self.element_type = nil
  CommonRole.set_value("大招按钮特效", 1, false)
end

function M:on_remove()
  tool:removeRole(self)
end

function M:ultra_element()
end

function M:on_start()
  self.team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  cast_magic(self.npc, self.npc, Const.XRAY.ROLE, 1)
  self.god_npc = get_god_npc()
  if self.god_npc then
  end
  set_ui_object_visible("fight", "Btn_skill8", false)
  set_ui_object_visible("fight", "Btn_skill2", false)
  if is_hero_in_ground(self.npc) then
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc then
    if false == is_showup then
      tool:initUltToTeam()
      self.indiMgr:hide()
      self.indiMgr.indi = nil
      CommonRole.Range_atk_show(self, false)
      if 0 == get_npc_attr(self.npc, 1) then
        CommonRole.set_value("死亡换人", 1, true)
      else
        CommonRole.set_value("死亡换人", 1, false)
      end
      set_can_searched(self.npc, false)
      CommonRole.set_value("共用目标", 20220125, self.target)
      CommonRole.magic_with_check(self, self.npc, self.npc, 1999090)
      abort_magic_by_id(self.npc, 1999125)
      abort_magic_by_id(self.npc, 1999126)
      abort_magic_by_id(self.npc, 1999127)
      abort_magic_by_id(self.npc, 1999128)
      abort_magic_by_id(self.npc, 1999203)
      abort_magic_by_id(self.npc, 1999202)
      if self.target then
        abort_magic_by_id(self.target, Const.LOCK_ON_TAG)
      end
      self.target = nil
      self.target_pos = nil
      set_npc_targew_switch = true
      clear_skill_btn_charging(15)
    else
      tool:updateCurRole()
      if 1 == self.charge_type then
        set_ui_object_visible("fight", "SpecialBar", true)
        init_special_fight_ui(self.charge_type)
      elseif 2 == self.charge_type then
        set_ui_object_visible("fight", "SpecialBar", true)
        init_special_fight_ui(self.charge_type, self.charge_numb, self.fight_ui_staty)
      else
        set_ui_object_visible("fight", "SpecialBar", false)
      end
      local curr = get_npc_attr(self.npc, 108)
      local max = get_npc_attr(self.npc, 109)
      if nil == curr or nil == max then
        return
      end
      local curCd = get_npc_cd_charge(self.npc, self.qte_skill)
      local maxCd = self.qte_skill_maxCd
      if curr < max or curCd < maxCd then
        play_ui_fight_button_effect({
          "gray",
          nil,
          self.qte_skill,
          1
        })
        set_ult_skill_enabled(self.npc, false)
        self.button_gray_list[4] = false
      else
        play_ui_fight_button_effect({
          "gray",
          nil,
          self.qte_skill,
          0
        })
        set_ult_skill_enabled(self.npc, true)
        self.button_gray_list[4] = true
      end
      set_can_searched(self.npc, true)
      create_scene_effect("Fx_Switch_Hero", npc:get_pos_vec3(), 10)
      CommonRole.search_target(self)
      local joystick_target = search_joystick_npc(self.npc, 4, 5, 90)
      joystick_target = joystick_target and get_npc_pos(joystick_target)
      if not CommonRole.get_value("死亡换人", 1) then
        if by_ult_change then
          if self.target then
            lookat_npc(self.npc, self.target, true)
          end
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
        end
        if not by_ult_change and self.target and check_npc_distance(self.npc, self.target, 5, true) then
          cast_magic(self.npc, self.npc, 1999096, 0)
          if self.target then
            lookat_npc(self.npc, self.target, true)
          end
          if joystick_target then
            lookat_position(self.npc, joystick_target.x, joystick_target.z, true)
            cast_skill_to_position(self.npc, self.showup_skill, joystick_target.x, joystick_target.z)
            self.skill_abort_level = 1
          else
            cast_skill(self.npc, nil, self.showup_skill, nil, nil)
            self.skill_abort_level = 1
          end
        end
      end
      CommonRole.set_value("QTE开关", 1, 1)
    end
  end
end

function M:element_trigger(skill_id, hit_target)
  local cam_id = {
    [2010230102] = true,
    [2010330101] = true
  }
  local act_type = get_skill_cfg(skill_id).ElementTriggerAct
  if not check_magic(self.npc, Const.MONSTER_BE_HIT.SLOMO_OTHERS) then
    if 0 == act_type and 5 ~= get_role_kind(hit_target) then
      cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.CAM_PULL, 0)
      cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.SLOMO_SELF, 0)
      cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.CAM_SHAKE, 0)
      if not cam_id[get_cur_camera_id()] and not get_sync_var("disable_battle_focus") then
        change_follow_target(1, hit_target, {
          8,
          4.5,
          {
            x = 0,
            y = -0.2,
            z = 2
          },
          1.3,
          0.55
        })
        change_focus_follow_speed(1.5)
        CommonRole.do_after(self, function()
          change_follow_target(0)
        end, 1)
      end
    elseif 1 == act_type then
      cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.SLOMO_SELF, 0)
      cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.CAM_SHAKE, 0)
    end
    cast_magic(self.npc, self.npc, Const.MONSTER_BE_HIT.SLOMO_OTHERS, 0)
  end
end

function M:Element_attack(npc, skill_id, hit_target, missile_cfg, missile)
  if missile_cfg.InteracteType == "Light" then
    cast_magic(self.npc, hit_target, 1998040, 1)
    cast_magic(self.npc, hit_target, 1998042, 1)
  end
  if get_magic_num(hit_target, 1998040) > 1 and missile_cfg.InteracteType == "Light" then
    cast_missile(self.npc, hit_target, nil, nil, 10019900501, 1)
    self:element_trigger(skill_id, hit_target)
  end
  if missile_cfg.InteracteType == "Electric" then
    cast_magic(self.npc, hit_target, 1998030, 1)
  end
  if get_magic_num(hit_target, 1998030) > 1 and missile_cfg.InteracteType == "Electric" then
    local list_monster = search_npc(self.npc, 4, 10, nil, false, true)
    local monster_num = 0
    for k, v in pairs(list_monster) do
      monster_num = monster_num + 1
    end
    if 1 == monster_num then
      cast_missile(self.npc, hit_target, nil, nil, 10019900401, 1)
    elseif monster_num > 1 then
      cast_missile(self.npc, hit_target, nil, nil, 10019900402, 1)
      self:element_trigger(skill_id, hit_target)
    end
  end
  if missile_cfg.InteracteType == "Fire" then
    cast_magic(self.npc, hit_target, 1998020, 1)
    self:element_trigger(skill_id, hit_target)
    cast_magic(self.npc, hit_target, 1999022, 0)
    cast_magic(self.npc, hit_target, 1998021, 1)
  end
  if missile_cfg.InteracteType == "Ice" and 0 == get_magic_num(hit_target, 1998010) then
    cast_magic(self.npc, hit_target, 1998010, 1)
  end
  if get_magic_num(hit_target, 1998010) > 1 and missile_cfg.InteracteType == "Ice" then
    cast_magic(self.npc, hit_target, 1998011, 1)
    cast_magic(self.npc, hit_target, 1998012, 1)
    self:element_trigger(skill_id, hit_target)
  end
  if missile_cfg.InteracteType == "Darkness" then
    local blood_list = {
      0.05,
      0.1,
      0.15,
      0.2,
      0.25
    }
    self:element_trigger(skill_id, hit_target)
    cast_magic(self.npc, hit_target, 1998050, 0)
    local tag_num = get_magic_num(hit_target, 1998050)
    if check_magic(hit_target, 1998050) then
      set_effect_bar_show(hit_target, true)
      set_effect_bar_length(hit_target, blood_list[tag_num])
    else
      set_effect_bar_show(hit_target, false)
    end
    if get_npc_attr(hit_target, 1) / get_npc_attr(hit_target, 4) <= blood_list[tag_num] then
      cast_magic(self.npc, hit_target, 1998051, 0)
      cast_magic(self.npc, hit_target, 1998057, 0)
      set_effect_bar_show(hit_target, false)
    end
    if check_npc_status(hit_target, 5) then
      set_effect_bar_show(hit_target, false)
    end
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  if 2 == skill_type then
    if check_magic(self.npc, 1999170) then
      cast_magic(self.npc, self.npc, 1999171, 0)
    else
      cast_magic(self.npc, self.npc, 1999170, 0)
    end
  end
  if 5 == skill_type or 20 == skill_type then
    self.is_elemental_attack = true
  end
  if 1 ~= skill_type and 2 ~= skill_type then
    self.is_skill = true
  else
    self.is_skill = false
  end
  if skill_id == self.qte_skill then
    if 3 ~= self.qte_type then
      local time = get_skill_cfg(self.qte_skill).BeforeTime + get_skill_cfg(self.qte_skill).CastTime
    end
    set_ui_object_visible("fight", "Main", false)
  end
end

function M:ultimate_icon_blink(self)
end

function M:on_frame()
  self:heavy()
end

function M:on_frame_background()
  local curr = get_npc_attr(self.npc, 108)
  local max = get_npc_attr(self.npc, 109)
  local curCd = get_npc_cd_charge(self.npc, self.qte_skill)
  local maxCd = self.qte_skill_maxCd
  local isUltEnable = self.button_gray_list[4]
  if isUltEnable then
    if curr < max or curCd < maxCd then
      set_ult_skill_enabled(self.npc, false)
      self.button_gray_list[4] = false
    end
  elseif curr >= max and curCd >= maxCd then
    set_ult_skill_enabled(self.npc, true)
    self.button_gray_list[4] = true
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  self:Element_attack(npc, skill_id, hit_target, missile_cfg, missile)
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  CommonRole.Range_atk_continued(self, skill_id)
  if npc == self.npc and skill_id == self.qte_skill and (1 == self.qte_type or 2 == self.qte_type) then
    abort_magic_by_id(self.npc, 1009911)
    set_ui_object_visible("fight", "Main", true)
    local hideList = get_ui_obj_list()
    for uiName, objList in pairs(hideList) do
      for _, objName in pairs(objList) do
        set_ui_object_visible(uiName, objName, false)
      end
    end
  end
  if skill_id == self.showup_skill then
    abort_magic_by_id(self.npc, 1999096)
  end
  if skill_id == self.heavy_atk then
    self.skill_abort_level = 1
  end
end

function M:on_magic_begin(npc, target, magic_id)
  if 100182 == magic_id or 100183 == magic_id then
    set_ui_object_visible("fight", "Main", true)
    abort_magic_by_id(target, 100182)
    abort_magic_by_id(target, 1009911)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if 1998050 == magic_id then
    set_effect_bar_show(target, false)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg, skill_abort_level)
  if m1_owner == self.npc and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) and not check_magic(m1_owner, 1999126) and not check_npc_die(m1) and self.counter_numb then
    stop_missile(m1)
    self.counter_numb = false
    CommonRole.do_while_magic_check(self, function()
      if 7 ~= m2_cfg.MissileTypeTag and 6 ~= m2_cfg.MissileTypeTag then
        if (2 == self.counter_type or self.counter_block) and not check_magic(self.npc, 1999170) then
          if check_magic(self.npc, 1999187) then
            cast_magic(self.npc, self.npc, 1999190, 0)
            self.counter_state = 2
            if self.god_npc and get_config_id(self.god_npc) == 3001039 and get_god_skill_level() >= 4 and get_npc_cd_charge(self.god_npc, 300103905) >= get_skill_cfg(300103905).CdChargePerCost then
              cast_skill(self.god_npc, m2_owner, 300103905)
            end
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999127)
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999128)
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999189)
            CommonRole.magic_with_check(self, m1_owner, m2_owner, 1999102)
          elseif check_magic(self.npc, 1999188) then
            self.counter_state = 1
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999194)
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999195)
            CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999196)
            CommonRole.magic_with_check(self, m1_owner, m2_owner, 1999101)
          end
          abort_skill(self.npc)
          if m2_owner then
            lookat_npc(self.npc, m2_owner, 1)
          end
          cast_skill(self.npc, nil, self.counter_skill_id[2])
          self.ex_missile_owner = m2_owner
        elseif 3 ~= m2_cfg.MissileTypeTag then
          if self.god_npc and get_config_id(self.god_npc) == 3001039 and get_god_skill_level() >= 4 and get_npc_cd_charge(self.god_npc, 300103905) >= get_skill_cfg(300103905).CdChargePerCost then
            cast_skill(self.god_npc, m2_owner, 300103905)
          end
          CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999125)
          CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999126)
          CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999198)
          if self.counter_sound then
            cast_magic(self.npc, self.npc, self.counter_sound, 1)
          end
          self.counter_state = 1
          self.counter_atk = false
        end
        change_skill_cd(self.npc, 18, 1, 1999191)
      end
      if self.counter_shadow_magic then
        cast_magic(self.npc, self.npc, self.counter_shadow_magic, 0)
      end
      self.do_counter_in = 1
      CommonRole.magic_with_check(self, m1_owner, m1_owner, 1999095)
      self.self_timer = get_npc_time(self.npc) + 0.1
      self.self_break_timer = get_time() + 0.8
      self.self_break_timer_switch = 1
      self.self_break_timer_red = get_time() + 3
      self.self_break_timer_switch_red = 1
      self.self_timer_switch = 1
      self.counter_npc = m1_owner
    end, 1999185)
  end
end

function M:heavy()
  local nowtime = get_time()
  if not self.heavy_atk then
    return
  end
  if self.input_time_last_switch[15] and nowtime > self.input_time[15] + 0.15 and self.skill_abort_level < 2 then
    abort_skill(self.npc)
    if self.target then
      lookat_npc(self.npc, self.target, 1)
      cast_skill(self.npc, self.target, self.heavy_atk, nil, nil)
    else
      cast_skill(self.npc, nil, self.heavy_atk, nil, nil)
    end
    self.skill_abort_level = 2
    CommonRole.clear_input(self, 15)
    CommonRole.clear_output(self, 15)
    on_up_skill_btn(15, false)
    self.input_time_last_switch[15] = false
    set_skill_end_to_idle(self.npc, true)
    self.atk_counting = 1
    CommonRole.do_after(self, function()
      self.skill_abort_level = 1
    end, get_skill_cfg(self.heavy_atk).BeforeTime + get_skill_cfg(self.heavy_atk).CastTime)
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    CommonRole.Range_atk_show(self, false)
    clear_input()
  end
end

function M:on_hero_reborn(reborned_hero)
  if reborned_hero ~= self.npc then
    return
  end
  cast_magic(self.npc, self.npc, Const.REBORN_INVUL, 0)
end

function M:remove_curse(curse_id)
  if 1003 == curse_id then
    switch_ui_image("fight", "SpSldBg", "UIFight/new/Fight_energy_Fill5_")
    switch_ui_image("fight", "SpSldFill", "UIFight/new/Fight_energy_Fill5_")
    cast_magic(self.npc, self.npc, 6070082, 1)
    abort_magic_by_id(self.npc, 6070080)
  end
end

function M.missile_skill_action_info(role, missileId)
  return
end

function M.isInControl(role)
  return role.npc == get_come_on_hero()
end

return M
