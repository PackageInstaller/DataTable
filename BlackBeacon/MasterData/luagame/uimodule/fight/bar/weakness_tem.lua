local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local LINE_WIDTH = 47
local HIDE_LINE_PERCEN = 0.045
local BOTTOM_Y = -26.5
local Y_INTERVAL = 53
local PAI = 3.14
local MAX_FILL_AMOUNT = 1
local MIN_FILL_AMOUNT = 0
local UIContainer = CS.UIContainer
local FightConfig = require("uimodule.fight.fight_config")
local FX_WEAKNESS_IMMUNEADD = FightConfig.FIGHT_UI_EFFECT.Fx_Weakness_ImmuneAdd
local CHANGE_STATE_FUN = {
  [Config.FightDefine.ABNORMAL_STATUS.IMMUNITY] = function(self)
    if 0 == self.v_weakness_alpha then
      self.v_uiobjects.Mask:SetActive(true)
      return
    end
    if self.v_last_state ~= Config.FightDefine.ABNORMAL_STATUS.IMMUNITY then
      self.v_uiobjects.Mask:SetActive(true)
      self:play_mask_effect(true)
      self:clear_timer()
    end
  end,
  [Config.FightDefine.ABNORMAL_STATUS.OPEN] = function(self)
    if 0 == self.v_weakness_alpha then
      self.v_uiobjects.Mask:SetActive(false)
      return
    end
    if self.v_last_state == Config.FightDefine.ABNORMAL_STATUS.IMMUNITY then
      self:play_mask_effect(false)
      self:clear_timer()
      self:close_mask_effect()
      self.v_uiobjects.Mask:SetActive(false)
    end
  end
}
local NEED_LOAD_COMP = {
  BgFill_img = true,
  Effect = true,
  FlagCount = true,
  FrameLine_rect = true,
  FrameLine = true,
  FrameLine_img = true,
  Frame_img = true,
  HitShake_pd = true,
  IconFill1_img = true,
  IconFill2_img = true,
  Mask = true,
  OnImmunityAdd_pd = true,
  OnImmunityRemove_pd = true
}
local temp_list_name, temp_list_count, temp_list_comp_name, temp_list_comp_count

function ui:init_ui_objlist()
  local ui_container = self:get_component(nil, nil, UIContainer)
  self.v_uiobjects = {}
  self.v_uicompents = {}
  if ui_container then
    local has_cache_info = true
    if nil == temp_list_name then
      has_cache_info = false
      temp_list_name = {}
      temp_list_comp_name = {}
    end
    local list_name = has_cache_info and temp_list_name or ui_container.ListName
    local list_count = has_cache_info and temp_list_count or list_name.Count
    temp_list_count = list_count
    local list_objects = ui_container.ListObj
    local list_comp_name = has_cache_info and temp_list_comp_name or ui_container.ListCompName
    local list_comp_count = has_cache_info and temp_list_comp_count or list_comp_name.Count
    temp_list_comp_count = list_comp_count
    local list_comp_objects = ui_container.ListComponent
    for i = 0, list_count - 1 do
      local name = list_name[i]
      if NEED_LOAD_COMP[name] then
        local object = list_objects[i]
        self.v_uiobjects[name] = object
        if not has_cache_info then
          temp_list_name[i] = name
        end
      end
    end
    for i = 0, list_comp_count - 1 do
      local name = list_comp_name[i]
      if NEED_LOAD_COMP[name] then
        local component = list_comp_objects[i]
        self.v_uicompents[name] = component
        if not has_cache_info then
          temp_list_comp_name[i] = name
        end
      end
    end
  end
end

local HIT_EFFECT_DURATION = {}
local ACTIVE_EFFECT_DURATION = {}

function ui:ui_finish_load()
  self.v_flag_count_tmp = self:get_component(nil, self.v_uiobjects.FlagCount, typeof(CS.TMPro.TextMeshProUGUI))
  self.v_hit_effect_list = {}
  self.v_active_effect_list = {}
  self.v_effect_obj_list = {}
  self.v_last_in_timer = false
  self.v_weakness_cg = self:get_canvas_group()
  self.v_weakness_lg = self:get_layout_element()
  self.v_weakness_alpha = self.v_weakness_cg.alpha
end

function ui:ui_on_show()
end

function ui:set_ui_hp(ui_hp)
  self.v_ui_hp = ui_hp
end

function ui:set_icon(element_id)
  if Util.is_nil(self.v_object) then
    return
  end
  local cfg = ShareRes.get_element_cfg(element_id)
  if not cfg then
    Log.Error("元素id", element_id, "获取不到配置")
    return
  end
  local element_icon_path = cfg.ElementWeakIconPath
  Util.set_color(self.v_uicompents.BgFill_img, FightConfig.WEAK_ELEMENT_COLOR[element_id], 0.5)
  Util.set_color(self.v_uicompents.Frame_img, FightConfig.WEAK_FRAME_ELEMENT_COLOR[element_id], 1)
  Util.set_color(self.v_uicompents.FrameLine_img, FightConfig.WEAK_ELEMENT_COLOR[element_id], 0.45)
  ResMgr:load_set_icon(self.v_uicompents.IconFill1_img, element_icon_path[1][1])
  ResMgr:load_set_icon(self.v_uicompents.IconFill2_img, element_icon_path[2][1])
end

function ui:init_element_effect()
  if Util.is_nil(self.v_object) then
    return
  end
  local active_effect = self.v_active_effect_list[self.v_element_id]
  if not active_effect or active_effect:IsNull() then
    local root = self.v_uiobjects.Effect.transform
    local parent_ui = self.v_parent_ui or self.v_ui_hp
    
    local function cb(go)
      if Util.is_nil(go) then
        return
      end
      go.transform:SetParent(root)
      go.transform:ResetAttr()
      local hit_praticle = self:get_effect_status("Hit", go)
      hit_praticle.gameObject:SetActive(false)
      local active_praticle = self:get_effect_status("Active", go)
      active_praticle.gameObject:SetActive(false)
      if not HIT_EFFECT_DURATION[self.v_element_id] then
        HIT_EFFECT_DURATION[self.v_element_id] = hit_praticle.LifeTime
      end
      if not ACTIVE_EFFECT_DURATION[self.v_element_id] then
        ACTIVE_EFFECT_DURATION[self.v_element_id] = active_praticle.LifeTime
      end
      self.v_active_effect_list[self.v_element_id] = active_praticle
      self.v_hit_effect_list[self.v_element_id] = hit_praticle
      self.v_effect_obj_list[go] = true
    end
    
    parent_ui:get_element_effect(self.v_element_id, cb)
  end
end

function ui:set_id_info(attr_id, target_uuid)
  self.v_target_uuid = target_uuid
  self.v_attr_id = attr_id
end

function ui:set_element_info(element_id)
  self.v_element_id = element_id
  self:init_element_effect()
  self.v_last_value = nil
  self:set_icon(element_id)
end

function ui:play_reverse_dot(duration)
  if Util.is_nil(self.v_object) then
    return
  end
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  local coms = self.v_uicompents
  coms.FrameLine_rect.gameObject:SetActive(false)
  local Ease = CS.DG.Tweening.Ease
  coms.BgFill_img.fillAmount = MAX_FILL_AMOUNT
  local tween = coms.BgFill_img:DOFillAmount(MIN_FILL_AMOUNT, duration)
  tween:SetEase(Ease.Linear)
  self.v_sequence:Join(tween)
  coms.IconFill2_img.fillAmount = MAX_FILL_AMOUNT
  coms.Frame_img.fillAmount = MAX_FILL_AMOUNT
  tween = coms.Frame_img:DOFillAmount(MIN_FILL_AMOUNT, duration)
  tween:SetEase(Ease.Linear)
  self.v_sequence:Join(tween)
  coms.IconFill1_img.fillAmount = MIN_FILL_AMOUNT
  tween = coms.IconFill1_img:DOFillAmount(MAX_FILL_AMOUNT, duration)
  tween:SetEase(Ease.Linear)
  self.v_sequence:Join(tween)
  self.v_sequence:OnComplete(function()
    self:clear_sequence()
    self:set_data()
  end)
end

function ui:set_data(force_refresh, target)
  target = target or SceneMgr:pick_by_uuid(self.v_target_uuid)
  if Util.is_destroy(target) or Util.is_nil(self.v_object) then
    return
  end
  if self.v_sequence then
    self:refrsh_flag_count(target)
    return
  end
  local cur_value = target.element_abnormal_mgr:get_display_abnormal_value(self.v_element_id)
  local active = self:refresh_obj_active(target)
  if not active then
    self.v_last_value = cur_value
    return
  end
  local max_value = target.element_abnormal_mgr:get_abnormal_max_value(self.v_element_id)
  if cur_value ~= self.v_last_value or force_refresh then
    self:refresh_weak(cur_value, max_value)
  end
  self.v_last_value = cur_value
end

function ui:refresh_weak(cur_value, max_value)
  local coms = self.v_uicompents
  if cur_value ~= max_value and self.v_last_value and self.v_hit_effect_list[self.v_element_id] then
    self:set_value_change_active(true)
  end
  local percent2 = cur_value / max_value
  local percent1 = 1 - percent2
  coms.BgFill_img.fillAmount = percent1
  coms.IconFill2_img.fillAmount = percent1
  coms.Frame_img.fillAmount = percent1
  coms.IconFill1_img.fillAmount = percent2
  if percent1 <= HIDE_LINE_PERCEN or percent1 >= 1 - HIDE_LINE_PERCEN then
    if self.v_uiobjects.FrameLine.activeSelf then
      self.v_uiobjects.FrameLine:SetActive(false)
    end
  else
    if not self.v_uiobjects.FrameLine.activeSelf then
      self.v_uiobjects.FrameLine:SetActive(true)
    end
    local width = LINE_WIDTH * math.sin(percent1 * PAI)
    coms.FrameLine_rect:SetSizeDeltaWidthA(width)
    coms.FrameLine_rect:SetAnchoredPositionY(BOTTOM_Y + Y_INTERVAL * percent1)
  end
  Util.change_component_alpha2(coms.Frame_img, 1)
  self.v_ready_play_active = true
  self:remove_warning_timer()
  self:clear_sequence()
end

function ui:set_state(state)
  self.v_state = state
  if self.v_last_state and self.v_last_state ~= state then
    CHANGE_STATE_FUN[self.v_state](self)
  end
  self.v_last_state = self.v_state
end

function ui:show_effect(target)
  target = target or SceneMgr:pick_by_uuid(self.v_target_uuid)
  if Util.is_destroy(target) or Util.is_nil(self.v_object) then
    return
  end
  if self.v_active_effect_list[self.v_element_id] then
    self:set_value_change_active(false)
  end
end

function ui:ui_on_hide()
  self:remove_warning_timer()
  self:clear_timer()
  self:set_value_change_unactive(true)
  self:set_value_change_unactive(false)
  if self.v_uiobjects and self.v_uiobjects.Mask and not self.v_uiobjects.Mask:IsNull() then
    self.v_uiobjects.Mask:SetActive(false)
  end
end

function ui:ui_on_destroy()
  self:give_back_all_effect()
  self.v_ui_hp = nil
  self:clear_sequence()
  self.v_del_effect_key = nil
end

function ui:play_mask_effect(is_add)
  self:play_effect_by_mgr(FX_WEAKNESS_IMMUNEADD, self.v_uiobjects.Mask.transform)
  if not is_add then
    self:play_effect_end_status_by_mgr(FX_WEAKNESS_IMMUNEADD)
  end
end

function ui:refresh_obj_active(target)
  target = target or SceneMgr:pick_by_uuid(self.v_target_uuid)
  local cur_value = target.element_abnormal_mgr:get_display_abnormal_value(self.v_element_id)
  local max_value = target.element_abnormal_mgr:get_abnormal_max_value(self.v_element_id)
  local attr_on_timer = target.element_abnormal_mgr:check_abnormal_on_timer(self.v_attr_id)
  local flag_count = target.element_abnormal_mgr:get_element_abnormal_flag_count(self.v_element_id)
  local active
  local parent_ui = self.v_parent_ui or self.v_ui_hp
  if cur_value == max_value and not attr_on_timer and flag_count <= 0 then
    if 0 ~= self.v_weakness_alpha then
      self.v_weakness_alpha = 0
      self.v_weakness_lg.ignoreLayout = true
      self.v_weakness_cg.alpha = self.v_weakness_alpha
    end
    active = false
  else
    self:refrsh_flag_count(target)
    if 1 ~= self.v_weakness_alpha then
      self.v_weakness_lg.ignoreLayout = false
      self.v_weakness_alpha = 1
      self.v_weakness_cg.alpha = self.v_weakness_alpha
    end
    active = true
  end
  return active
end

function ui:refrsh_flag_count(target)
  local flag_count = target.element_abnormal_mgr:get_element_abnormal_flag_count(self.v_element_id)
  if flag_count > 0 then
    self:update_ui_visible(self.v_uiobjects.FlagCount, true)
    local tmp_str = FightDataMgr:get_tmp_string(flag_count, 0)
    self.v_flag_count_tmp.component.text = tmp_str
  else
    self:update_ui_visible(self.v_uiobjects.FlagCount, false)
  end
end

function ui:give_back_all_effect()
  if Util.is_nil(self.v_object) then
    return
  end
  local parent_ui = self.v_parent_ui or self.v_ui_hp
  for effect_obj in pairs(self.v_effect_obj_list) do
    if not effect_obj:IsNull() then
      parent_ui:give_back_element_effect(self.v_element_id, effect_obj)
    end
    self.v_effect_obj_list[effect_obj] = nil
  end
  self.v_active_effect_list = {}
  self.v_hit_effect_list = {}
end

function ui:remove_warning_timer()
  if self.v_warning_timer then
    Timer:remove_timer(self.v_warning_timer)
    self.v_warning_timer = nil
  end
end

function ui:set_value_change_active(is_hit)
  local effect = is_hit and self.v_hit_effect_list[self.v_element_id] or self.v_active_effect_list[self.v_element_id]
  if not Util.is_nil(effect) then
    effect.gameObject:SetActive(true)
    effect.component:RestartParticle(true)
    self:progress_value_change_effect_timer(true, is_hit)
  end
end

function ui:set_value_change_unactive(is_hit)
  local effect = is_hit and self.v_hit_effect_list[self.v_element_id] or self.v_active_effect_list[self.v_element_id]
  if not Util.is_nil(effect) then
    effect.gameObject:SetActive(false)
  end
  self:progress_value_change_effect_timer(false, is_hit)
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:close_mask_effect()
  self:stop_effect_by_mgr(FX_WEAKNESS_IMMUNEADD, true)
end

function ui:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

local HIT_EFFECT_TIMER = "v_hit_effect_timer"
local ACTIVE_EFFECT_TIMER = "v_active_effect_timer"

function ui:progress_value_change_effect_timer(is_add, is_hit)
  local timer_key = is_hit and HIT_EFFECT_TIMER or ACTIVE_EFFECT_TIMER
  if self[timer_key] then
    Timer:remove_timer(self[timer_key])
  end
  if is_add then
    local duration = is_hit and HIT_EFFECT_DURATION[self.v_element_id] or ACTIVE_EFFECT_DURATION[self.v_element_id]
    self[timer_key] = Timer:add_timer(nil, duration, self.set_value_change_unactive, self, is_hit)
  end
end

return ui
