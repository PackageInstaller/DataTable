local Base = require("ui.uiobject")
local FightDefine = require("cs_share.fight_define")
local FightCfg = require("uimodule.fight.fight_config")
local FORMAT_STR = "%.2f"
local ui = Util.create_child_mt(Base)
local SKL_BTN_7_ELEMENT_EFFECT = FightCfg.SKL_BTN_7_ELEMENT_EFFECT
local SKL_BTN_7_ELEMENT_EFFECT2 = FightCfg.SKL_BTN_7_ELEMENT_EFFECT2
local ULT_EFFECT_STATE = {READY = 1, ACTIVE = 2}
local INPUT_CODE = Config.INPUT_CODE
local POS2KEYCODE = {
  [1] = INPUT_CODE.QTE1,
  [2] = INPUT_CODE.QTE2,
  [3] = INPUT_CODE.OPERATE_CHAR1
}
local ATTR_TYPE = FightDefine.ATTR_TYPE
local HERO_HEAD_PREFIX = "Icon/Profile/%s"

local function _get_number_in_str(str)
  local num
  string.gsub(str, "([%d.]+)", function(a)
    num = tonumber(a)
  end)
  return num
end

function ui:ui_finish_load()
  function self.v_effect_cb()
    self:reset_heal_effect()
  end
  
  local idx = _get_number_in_str(self.v_object.name)
  if not idx then
    Log.Error("获取头像index失败！！！！")
    return
  end
  self.v_energy_point_list = {}
  self.keycode = POS2KEYCODE[idx]
  self.v_max_energy = ShareRes.get_comm_value("SwithHeroCD")
  self.v_cur_energy = self.v_max_energy
  self:init_ult_skill_enabled(false)
  self.v_qte_active_color_index = nil
  local head_btn = self:get_button(nil, self.v_object)
  self:set_button_listener(head_btn, function()
    self.v_parent_ui:do_switch_hero(self.keycode)
  end)
  self:set_button("UltSkill", function()
    self.v_hero:set_by_ult_change(true)
    self.v_parent_ui:do_switch_hero(self.keycode, true)
  end)
  self.v_fx_combo_cdot = self:get_custom_dotween(nil, self.v_uiobjects.Fx_Combo)
  self.v_fx_combo_cdot:SetCompleteCallBack(0, function()
    self:release_qte_effect()
  end)
  self.hero_uuid = 0
  self.v_in_switch_cd = false
  self.v_in_qet_cd = false
end

function ui:ui_on_show(hero, ...)
  if not hero then
    return
  end
  self.v_update_by_switch_cd = true
  self:set_hero_head(hero)
  self:set_color(hero:get_res_type())
  self:reset_heal_effect()
  self:_regist_client_event()
end

function ui:ui_on_destroy()
  self.v_energy_point_list = nil
  self:clear_ult_icon_sequence()
end

function ui:ui_on_low_update(delta_time)
  if not self.v_hero or self.v_hero:is_die() then
    return
  end
  if self.v_update_by_switch_cd then
    self:_update_switch_cd(delta_time)
  end
  self:update_effects(delta_time)
end

function ui:ui_on_hide()
  self:reset_heal_effect()
  self:hide_all_energy_tem(true)
end

function ui:on_pre_tp_room()
  self.v_uiobjects.EXSkillEffect:SetActive(false)
  self.v_uiobjects.ForbidSwitchHero:SetActive(false)
end

function ui:on_tp_toom_finish()
  self.v_uiobjects.EXSkillEffect:SetActive(true)
  self.v_uiobjects.ForbidSwitchHero:SetActive(not SceneMgr:check_switch_hero())
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_HERO_REBORN_END, self._response_hero_reborn, self)
  self:bind_auto_mq(Const.MSG_ON_ALL_HERO_REBORN_END, self._response_all_reborn, self)
  self:bind_auto_mq(Const.MSG_ON_ALL_HERO_ARCHIEVE_REBORN_END, self._response_all_reborn, self)
  self:bind_auto_mq(Const.MSG_ROLE_DEAD, self._response_hero_die, self)
  self:bind_auto_mq(Const.MSG_ON_ROLE_HEAL, self._on_hero_heal, self)
  self:bind_auto_mq(Const.MSG_PRE_TP_ROOM, self.on_pre_tp_room, self)
  self:bind_auto_mq(Const.MSG_TP_ROOM_FINISH, self.on_tp_toom_finish, self)
end

function ui:get_element_effect(effect_name, effect_key, fight)
  if not Util.is_empty(effect_name) and not fight:check_ui_effect_is_load(effect_key) then
    local ui_effect, ui_effect_go
    ui_effect = fight:get_ui_effect(effect_name, effect_key)
    ui_effect_go = ui_effect.gameObject
    ui_effect_go.transform:SetParent(self.v_uicompents.EXSkillEffect_rect)
    ui_effect_go:ResetAttr()
    return ui_effect_go
  end
end

function ui:set_element_effect_attr(fight, effect_key, effect_name, active)
  if fight:check_ui_effect_is_load(effect_key) then
    local ui_effect = fight:get_ui_effect(effect_name, effect_key)
    if ui_effect then
      ui_effect.gameObject:SetActiveEx(active)
      local ui_effect_go = ui_effect.gameObject
      ui_effect_go.transform:SetParent(self.v_uicompents.EXSkillEffect_rect)
    end
  end
end

function ui:update_element_effect()
  local buddy_id = self.v_hero:get_buddy_id()
  local element_id = ShareRes.get_char_element_id(buddy_id)
  self:set_qte_fill_color(element_id)
end

function ui:set_qte_fill_color(element_id)
  local color_tb1 = FightCfg.ELEMENT_COLOR_LIGHT1[element_id]
  if color_tb1 then
    self.v_uicompents.UltLight1_img:SetGraphicColor(color_tb1.r, color_tb1.g, color_tb1.b, color_tb1.a)
  end
  local color_tb2 = FightCfg.ELEMENT_COLOR_LIGHT2[element_id]
  if color_tb2 then
    self.v_uicompents.UltLight2_img:SetGraphicColor(color_tb2.r, color_tb2.g, color_tb2.b, color_tb2.a)
  end
  local color_tb3 = FightCfg.ELEMENT_COLOR_LIGHT3[element_id]
  if color_tb3 then
    self.v_uicompents.UltLight3_img:SetGraphicColor(color_tb3.r, color_tb3.g, color_tb3.b, color_tb3.a)
  end
end

function ui:set_hero_head(old_hero, reset_hero)
  local old_element_id
  if self.v_hero then
    local buddy_id = self.v_hero:get_buddy_id()
    old_element_id = ShareRes.get_char_element_id(buddy_id)
  end
  local need_change = self.hero_uuid ~= old_hero.uuid
  self.hero_uuid = old_hero.uuid
  self.v_hero = old_hero
  local new_buddy_id = old_hero:get_buddy_id()
  self.v_element_id = ShareRes.get_char_element_id(new_buddy_id)
  self:update_ui_visible(self.v_uiobjects.UltSkill, false)
  if need_change or reset_hero then
    if reset_hero then
      self:recover_max_energy()
    end
    self.v_ult_effect_state = ULT_EFFECT_STATE.READY
    local _, qteid_list = BattleSkillBookMgr:get_hero_btn_skill_map()
    local qte_skill_id = qteid_list[self.hero_uuid]
    if qte_skill_id then
      local skill_cfg = ShareRes.create("skill.skill", qte_skill_id)
      ResMgr:load_set_icon(self.v_uicompents.UltIcon_img, "skill/" .. skill_cfg.Icon)
      self:update_element_effect(old_element_id)
    end
    self:init_hero_energy()
    local fashion_id = old_hero:get_fashion_id()
    local icon_path = UtilUI.get_hero_images(new_buddy_id, 1, fashion_id)
    ResMgr:load_set_icon(self.v_uicompents.HeroIcon_img, icon_path)
    self:update_hero_hp()
    self:_update_hero_energy()
    self:update_qte_sp_fill_img()
  end
  self:set_ult_skill_enabled()
  if self.v_hero:is_die() then
    self:_set_hero_die()
  else
    self:update_ui_visible(self.v_uicompents.ChangMask_img, false)
  end
end

function ui:get_hero()
  return self.v_hero
end

function ui:set_color(res_type)
end

function ui:update_qte_sp_fill_img()
end

function ui:update_hero_hp()
  if SceneMgr:global_hero_is_destroyed() then
    return
  end
  local attr_mgr = self.v_hero.attr_mgr
  local hp = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
  local hp_max = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  self.v_uicompents.HeroHP_sld.value = hp / hp_max
end

function ui:in_switch_cd(in_cd)
  if nil ~= in_cd and not self.v_hero:is_die() then
    self.v_in_switch_cd = in_cd
    if in_cd then
      self.v_cur_energy = 0
    end
  else
    return self.v_in_switch_cd
  end
end

function ui:in_qet_cd(in_cd)
  if nil ~= in_cd and not self.v_hero:is_die() then
    self.v_in_qet_cd = in_cd
    if in_cd then
      self:_set_effect(self.v_ef_ready, false)
    end
  else
    return self.v_in_qet_cd
  end
end

function ui:update_normal_atk_energy(delta_time)
  self:_update_hero_energy(delta_time)
end

function ui:reset_head_cd()
  self.v_in_qet_cd = false
  self:recover_max_energy()
end

function ui:_update_switch_cd(delta_time)
  if not self.v_in_switch_cd then
    return
  end
  if self.v_cur_energy < self.v_max_energy then
    self.v_cur_energy = self.v_cur_energy + delta_time * 100
  end
  local percent = self.v_cur_energy / self.v_max_energy
  if percent < 1 then
    local left_part = 1 - percent
    self:update_ui_visible(self.v_uicompents.ChangMask_img, true)
    self.v_uicompents.ChangMask_img.fillAmount = left_part
    self.v_uicompents.ChangCd_txt.text = string.format(FORMAT_STR, left_part * self.v_max_energy * 0.01)
  else
    self:update_ui_visible(self.v_uicompents.ChangMask_img, false)
    self.v_in_switch_cd = false
  end
end

function ui:_update_qet_skill_cd(delta_time)
  if not self.v_in_qet_cd then
    return
  end
  local hero = self.v_hero
  if not hero or hero:is_die() then
    return
  end
  local cur_energy, max_energy = self:_get_qet_skill_energy()
  if (cur_energy == max_energy or 0 == max_energy) and self.v_in_qet_cd then
    self:_play_qet_charge_effect(true)
    self.v_in_qet_cd = false
    return
  end
  local percent = cur_energy / max_energy
  if 1 - percent > 0.01 then
    local left_part = 1 - percent
    self:_play_qet_charge_effect(false)
    self.v_uicompents.ChangMask_img.fillAmount = left_part
    self.v_uicompents.ChangCd_txt.text = string.format(FORMAT_STR, left_part * max_energy * 0.01)
  else
    self.v_in_qet_cd = false
    self:_play_qet_charge_effect(true)
  end
  if (cur_energy == max_energy or 0 == max_energy) and self.v_in_qet_cd then
    self.v_in_qet_cd = false
    self:_play_qet_charge_effect(true)
  end
end

function ui:_play_qet_charge_effect(is_full)
  self:update_ui_visible(self.v_uicompents.ChangMask_img, not is_full)
end

function ui:_play_qet_skill_ready_effect()
  if not self.v_hero or self.v_hero:is_die() or self.v_hero:is_destroy() then
    self:_set_effect(self.v_ef_ready, false)
    return
  end
  local cur = self.v_hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY) or 0
  local max = self.v_hero.attr_mgr:get_attr(ATTR_TYPE.TEAM_SKILL_ENERGY_MAX) or 0
  if 0 == max then
    self:_set_effect(self.v_ef_ready, false)
    return
  end
  local qte_percent = cur / max
  if qte_percent < 1 then
    self:_set_effect(self.v_ef_ready, false)
    return
  else
    self:_set_effect(self.v_ef_ready, true)
  end
  if SceneMgr and not SceneMgr:check_switch_hero() then
    self:_set_effect(self.v_ef_ready, false)
    return
  end
end

function ui:_get_hero_target()
  if Global.hero then
    return Global.hero:get_target()
  end
end

function ui:_set_hero_die()
  self:update_ui_visible(self.v_uicompents.ChangMask_img, true)
  self.v_uicompents.ChangMask_img.fillAmount = 1
  self.v_uicompents.ChangCd_txt.text = ""
  self:_set_effect(self.v_ef_ready, false)
  self:_set_effect(self.v_ef_charge_point, false)
  self:_set_effect(self.v_ef_charge, false)
  self.v_in_switch_cd = false
  self.v_in_qet_cd = false
  self.v_parent_ui:clear_qte_effect(self.hero_uuid)
  self:release_qte_effect()
end

function ui:_set_effect(ef_name, play)
end

function ui:_get_qet_skill_energy()
  return self.v_parent_ui:get_qet_skill_energy()
end

function ui:_response_hero_reborn(msg)
  if msg.mm_x ~= self.hero_uuid then
    return
  end
  self:update_ui_visible(self.v_uicompents.ChangMask_img, false)
end

function ui:_response_all_reborn()
  self:update_ui_visible(self.v_uicompents.ChangMask_img, false)
end

function ui:_response_hero_die(msg)
  if msg.mm_obj.uuid ~= self.hero_uuid then
    return
  end
  self:_set_hero_die()
end

function ui:on_charge_start()
  self.v_update_by_switch_cd = false
  self:update_ui_visible(self.v_uicompents.ChangMask_img, true)
end

function ui:set_charge_info(cd_param)
  local time = cd_param.need_charge_time - cd_param.total_charge_time
  local left_part = 1 - cd_param.cur_value
  self.v_uicompents.ChangMask_img.fillAmount = left_part
  self.v_uicompents.ChangCd_txt.text = string.format(FORMAT_STR, time)
end

function ui:on_charge_done()
  self:update_ui_visible(self.v_uicompents.ChangMask_img, false)
  self.v_update_by_switch_cd = true
  if self.v_in_switch_cd then
    self:reset_head_cd()
  end
end

function ui:is_on_charge()
  return not self.v_update_by_switch_cd
end

function ui:_update_hero_energy(delta_time)
  if not self.v_hero or self.v_hero:is_destroy() then
    return
  end
  local show_point_count = self.v_hero:get_show_point_count()
  if not show_point_count or 0 == show_point_count then
    return
  end
  local current_count
  if not delta_time then
    self:clear_ui_visible_record()
    current_count = self.v_hero:get_charged_point_count()
  end
  for index = 1, show_point_count do
    local point = self:get_energy_point(index)
    if not delta_time then
      point.is_comp = index <= current_count
    end
  end
  self:update_energy_point_progress()
end

function ui:init_hero_energy()
  self:hide_all_energy_tem()
end

function ui:update_energy_point_progress()
  local data = self.v_hero:get_fake_sp_data()
  Util.update_energy_point_progress(self, self.v_energy_point_list, data.count, self.v_hero:get_show_point_count(), data.differen)
end

function ui:get_energy_point(index)
  local point_info = self.v_energy_point_list[index]
  if not point_info then
    local obj = self.v_parent_ui:get_energy_obj()
    obj.transform:SetParent(self.v_uiobjects.EnergyList.transform)
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(0.65)
    self.v_energy_point_list[index] = {root = obj}
    point_info = self.v_energy_point_list[index]
    local ui_container = obj:GetComponent(typeof(CS.UIContainer))
    local com_name_list = ui_container.ListCompName
    local com_obj_list = ui_container.ListComponent
    for i = 0, com_name_list.Count - 1 do
      if point_info.fill_img and point_info.max_img then
        break
      end
      if "Fill_img" == com_name_list[i] then
        point_info.fill_img = com_obj_list[i]
      end
      if "Max_img" == com_name_list[i] then
        point_info.max_img = com_obj_list[i]
      end
    end
  end
  return self.v_energy_point_list[index]
end

function ui:get_energy_effect(effect_name, parent)
  local effect_obj = ResPoolMgr:get_ui_effect(effect_name)
  effect_obj.transform:SetParent(parent.transform)
  effect_obj:ResetAttr()
  local ui_particle = self:get_particle(nil, effect_obj)
  local effect_status = self:get_effect_status(nil, effect_obj.gameObject)
  local effect_length = effect_status and effect_status.LifeTime or 0
  return effect_obj, ui_particle, effect_length
end

function ui:hide_all_energy_tem(is_hide)
  for key, point in pairs(self.v_energy_point_list) do
    if is_hide then
      self.v_parent_ui:give_back_energy_obj(point.root)
      self.v_energy_point_list[key] = nil
    end
  end
end

function ui:reset_heal_effect()
  if self:is_destroy() then
    return
  end
end

function ui:_on_hero_heal(msg)
  if self.v_hero and msg and msg.mm_x == self.v_hero.uuid then
    local effect_name = FightCfg.FIGHT_UI_EFFECT.Fx_UI_Hp_back
    local effect_key = effect_name .. self.v_name
    Util.play_auto_release_fight_ui_effect(effect_name, effect_key, self:get_object_transform())
  end
end

function ui:set_ult_skill_enabled(enabled)
  if nil == enabled then
    enabled = self.v_parent_ui:get_ult_skill_enabled(self.v_hero.uuid)
  end
  self:update_ui_visible(self.v_uiobjects.UltSkill, enabled)
  self:on_change_ult_state()
end

function ui:on_change_ult_state()
  local is_ready_state = self.v_ult_effect_state == ULT_EFFECT_STATE.READY
  self.v_uiobjects.UltLight1:SetActive(is_ready_state)
  self.v_uiobjects.UltLight2:SetActive(is_ready_state)
  self.v_uiobjects.Bg01:SetActive(is_ready_state)
  self.v_uiobjects.Frame:SetActive(is_ready_state)
  self.v_uicompents.UltIcon_rect:SetLocalScaleA(1)
  if not is_ready_state then
    if not self.v_ult_icon_sequence then
      self.v_ult_icon_sequence = Util.create_sequence()
      self.v_ult_icon_sequence:SetAutoKill(false)
      self.v_ult_icon_sequence:Append(self.v_uicompents.UltIcon_rect:DOScale(1.5, 0.05))
      self.v_ult_icon_sequence:Append(self.v_uicompents.UltIcon_rect:DOScale(1.2, 0.05))
    end
    self.v_ult_icon_sequence:Restart()
  end
  if self.v_uiobjects.UltSkill.activeSelf then
    local buddy_id = self.v_hero:get_buddy_id()
    local element_id = ShareRes.get_char_element_id(buddy_id)
    local effect_name = is_ready_state and SKL_BTN_7_ELEMENT_EFFECT[element_id] or SKL_BTN_7_ELEMENT_EFFECT2[element_id]
    if self.v_element_effec_name ~= effect_name then
      self:stop_effect_by_mgr(self.v_element_effec_name, true)
      self:play_effect_by_mgr(effect_name, self.v_uicompents.EXSkillEffect_rect)
      self.v_element_effec_name = effect_name
    end
  end
end

function ui:clear_ult_icon_sequence()
  if self.v_ult_icon_sequence then
    self.v_ult_icon_sequence:Kill(false)
    self.v_ult_icon_sequence = nil
  end
end

function ui:init_ult_skill_enabled(enabled)
  self.v_uiobjects.UltSkill:SetActive(enabled)
end

function ui:play_recover_particle(index)
  local point_info = self.v_energy_point_list[index]
  local effect_name = "Fx_common_energy_button_recoverFlash"
  local effect_key = effect_name .. self.v_name .. index
  Util.play_auto_release_fight_ui_effect(effect_name, effect_key, point_info.root.transform)
end

function ui:change_ult_effect(state)
  if self.v_ult_effect_state ~= state then
    self.v_ult_effect_state = state
    self:on_change_ult_state()
  end
end

function ui:get_target_hero_uuid()
  return self.hero_uuid
end

function ui:recover_max_energy()
  self.v_cur_energy = self.v_max_energy
  self.v_in_switch_cd = true
  if self.v_hero and self.v_hero:is_die() then
    self:_set_hero_die()
  else
    self:_update_switch_cd(0)
  end
end

function ui:set_active_qte_effect(effect_name)
  local effect_key = effect_name .. self.v_object.name
  if effect_key == self.v_qte_effect_key and not Util.is_nil(self.v_qte_effect) and not self.v_qte_effect_on_fade then
    return
  end
  self:release_qte_effect()
  self.v_qte_effect_key = effect_key
  self.v_qte_effect = Util.play_auto_release_fight_ui_effect(effect_name, self.v_qte_effect_key, self.v_uicompents.Fx_Combo_rect)
  self.v_fx_combo_cdot:Pause()
  self.v_uicompents.Fx_Combo_cg.alpha = 1
  self.v_qte_effect.transform:SetAsFirstSibling()
  self.v_qte_effect.transform:ResetAttr()
end

function ui:release_qte_effect_by_fade()
  self.v_uicompents.Fx_Combo_cg.alpha = 1
  self.v_fx_combo_cdot:Restart()
  self.v_qte_effect_on_fade = true
end

function ui:release_qte_effect()
  if self.v_qte_effect then
    Util.release_fight_ui_effect(self.v_qte_effect_key)
    self.v_qte_effect = nil
    self.v_qte_effect_key = nil
    self.v_qte_effect_on_fade = nil
  end
end

function ui:on_playing_effect_remove(effect_name)
  local hero_head_view = self.v_parent_ui
  local fight = hero_head_view.v_parent_ui
  fight:on_playing_effect_remove(effect_name)
end

function ui:set_forbid_switch_hero_effect_visible(visible)
  local effect_name = FightCfg.FIGHT_UI_EFFECT.Fx_Conmon_not_switch_hero
  self.v_uiobjects.ForbidSwitchHero:SetActive(visible)
  if visible then
    self:play_effect_by_mgr(effect_name, self.v_uicompents.ForbidSwitchHero_rect)
  else
    self:stop_effect_by_mgr(effect_name)
  end
end

return ui
