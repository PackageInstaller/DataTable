local Base = require("ui.uibase")
local GuideHelper = require("uimodule.guide.guide_helper")
local CSTweening = CS.DG.Tweening
local ui = Util.create_child_mt(Base)
local ICON_PREFIX = "%s"
local sformat = string.format
local BIND_TYPE = Config.BIND_TYPE
local EFFECT_TIME = 3
local CAN_NOT_CLICK = 2
local Vec2 = require("base.vec2")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local MODEL = {
  v_left_tips = {
    "TextTipsLeft",
    BIND_TYPE.OBJECT
  },
  v_right_tips = {
    "TextTipsRight",
    BIND_TYPE.OBJECT
  },
  v_combine_mask = {
    "CombineMask",
    BIND_TYPE.OBJECT
  },
  v_normal_mask = {
    "Mask",
    BIND_TYPE.BUTTON
  },
  v_tras_mask = {
    "TransparentMask",
    BIND_TYPE.BUTTON
  },
  v_com_btn = {
    "CombineBtn",
    BIND_TYPE.BUTTON
  },
  v_jump_btn = {
    "BtnSkip",
    BIND_TYPE.BUTTON
  },
  v_txt_icon = {
    "GuideType2",
    BIND_TYPE.OBJECT
  },
  v_txt_spine = {
    "GuideType3",
    BIND_TYPE.OBJECT
  }
}
local GUIDE_TYPE = {SYS = 1, LEVEL = 2}
local GUIDE_TXT_TYPE = {
  DEFAULT = 1,
  TXT_AND_ICON = 2,
  SPINE = 3
}
local CSScreen = UnityEngine.Screen
local ZERO = Vec2.zero
local DEFAULT_WORLD_WIDTH = 400
local FUNC_TYPE = {
  NORMAL = 1,
  LONG_CLICK = 2,
  NOTIFY = 3,
  STORY = 4
}
local GUIDE_VIEW = {
  [FUNC_TYPE.NORMAL] = "normal_guide",
  [FUNC_TYPE.LONG_CLICK] = "long_guide",
  [FUNC_TYPE.NOTIFY] = "notify_guide",
  [FUNC_TYPE.STORY] = "story_guide"
}
local GUIDE_AVOID_UI = {ui_capsule_toy_popup = true, award_show_panel = true}
local CLICK_AREA = {TARGET = 1, WHOLE = 2}
local MASK_TYPE = {
  NONE = 1,
  TRANSPARENT = 2,
  NORMAL = 3,
  COMBINE = 4
}

function ui:ui_finish_load(...)
  self:init_model(MODEL)
  self.v_tips = {}
  self.v_pos_to_txt_icon = {}
  
  local function findObj(obj)
    local tb = {}
    tb.rect = self:get_rect_transform(nil, obj)
    tb.short = self:get_child_gameobj("Short", obj)
    tb.short_rect = self:get_rect_transform(nil, tb.short)
    tb.long = self:get_child_gameobj("Long", obj)
    return tb
  end
  
  for i = 1, 4 do
    self.v_tips[i] = (1 == i or 4 == i) and findObj(self.v_right_tips) or findObj(self.v_left_tips)
  end
  for i = 1, 4 do
    local tb = {}
    tb.guide = self:get_child_gameobj("Guide" .. i, self.v_txt_icon)
    tb.profile = self:get_image("Profile", tb.guide)
    tb.profileBg = self:get_child_gameobj("ProfileBg", tb.guide)
    tb.txt = self:get_text("GuideTextBg/GuideText", tb.guide)
    self.v_pos_to_txt_icon[i] = tb
  end
  self.v_mask_list = {}
  for i = 1, 4 do
    self.v_mask_list[i] = self:get_rect_transform(nil, self.v_uiobjects["Mask" .. tostring(i)])
  end
  self.v_guide_view = {}
  for k, v in ipairs(GUIDE_VIEW) do
    self.v_guide_view[k] = self.v_panels[v]
  end
  self.v_ui_rect = self:get_rect_transform(nil, self.v_object)
  self.v_update_cnt = 0
  self:set_button_listener(self.v_com_btn, function()
    self:_onclick_combtn()
  end)
  self:set_button_listener(self.v_jump_btn, function()
    self:_onclick_jump()
  end)
  self.v_click_count = 0
  self.v_cur_time = 0
  self.v_group_alpha = Util.get_component(nil, self.v_object.gameObject, typeof(UnityEngine.CanvasGroup))
  self.v_anim_eff = self.v_uiobjects.GuideTipsIn2
  self.v_anim_eff_cd = 0
  self.v_anim_eff:SetActive(false)
  self:reset_ui_cmp()
end

function ui:reset_ui_cmp()
  local text_tips_right = Util.get_component(nil, self.v_object.TextTipsRight, typeof(UnityEngine.CanvasGroup))
  if text_tips_right then
    text_tips_right.alpha = 1
  end
end

function ui:ui_on_show(guide, func_type, param, ...)
  self.v_anim_eff:SetActive(false)
  self.v_guider = guide
  self.v_ui_size = self.v_ui_rect.sizeDelta
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self.v_txt_rect = nil
  if not self.v_guider then
    self:ui_hide()
    return
  end
  if not param then
    self:ui_hide()
    return
  end
  self.v_param = param
  self.v_alpha_delay_flag = param.delay_show or -1
  self.v_group_alpha_inter = true
  self.v_set_pause = true
  self.v_func_type = func_type
  self.v_cur_view = self.v_guide_view[func_type]
  if not self.v_cur_view then
    Log.Error("get guide type failure! param=", param)
    self:ui_hide()
    return
  end
  self.v_cur_view:set_enable(true, self.v_guider, param)
  self:_show_mask(param.need_mask, param.finish_type)
  self.v_txt_side = param.txt_side
  self.v_txt_pos = param.txt_pos
  self:_show_guide_txt(param.guide_txt, param.txt_pos, param.txt_type, param.txt_icon_pos, param.txt_icon, param.spine_id, param.spine_pos)
  if not self.v_cur_view then
    Log.Error("引导目标 不存在 强制结束当前引导")
    GuideMgr:force_finish_cur_guide()
    return
  end
  if self.v_mask_type ~= MASK_TYPE.NORMAL and self.v_cur_view.set_canvas_group_alpha then
    self.v_cur_view:set_canvas_group_alpha(0)
  end
  self.v_jump_btn:SetActive(false)
  self.v_cur_time = 0
  self.v_jump_count_down = 0
  self.v_jump_count_down_EF = true
  self.v_target_ui = nil
  self.v_target_ui_canvasGroup = nil
  local target_ui = UIMgr:try_get_visible_ui(param.ui_name)
  if target_ui then
    self.v_target_ui = target_ui:get_object()
  end
  if self.v_target_ui then
    local suc_get = false
    suc_get, self.v_target_ui_canvasGroup = self.v_target_ui:TryGetComponent(typeof(UnityEngine.CanvasGroup))
    if not suc_get then
      local safe_area = Util.get_child_gameobj("SafeArea_", self.v_target_ui) or Util.get_child_gameobj("SafeArea", self.v_target_ui)
      if safe_area then
        suc_get, self.v_target_ui_canvasGroup = safe_area:TryGetComponent(typeof(UnityEngine.CanvasGroup))
      end
      if not suc_get then
        self.v_target_ui_canvasGroup = nil
      end
    end
  end
  self:_show_drag_anim(target_ui, param.control_path, param.drag_target_path)
  local suc_get_temp
  suc_get_temp, self.v_object_cvs = self.v_object:TryGetComponent(typeof(UnityEngine.CanvasGroup))
end

function ui:get_safearea_width_height()
  local safe_area = self:get_rect_transform("SafeArea")
  if safe_area then
    return safe_area.rect.width, safe_area.rect.height
  else
    return CSScreen.x, CSScreen.y
  end
end

function ui:get_long_guide()
  if self.v_func_type ~= FUNC_TYPE.LONG_CLICK then
    return
  end
  return self.v_cur_view
end

function ui:ui_on_hide()
  self:resume_game()
  for _, v in pairs(self.v_guide_view) do
    v:set_enable(false)
  end
  self.v_cur_view = nil
  self.v_click_count = 0
  self.v_last_input_time = nil
  self.v_is_complete = nil
  self.v_mask_type = nil
  self.v_info_rect = nil
  self.v_pivot_rect = nil
  self:clear_spine_rt()
  self:clear_drag_sequence()
end

function ui:ui_on_update(delta_time)
  if self.v_update_obj then
    self.v_update_obj:SetActive(false)
    self.v_update_obj:SetActive(true)
    self.v_update_cnt = self.v_update_cnt + 1
    if 2 == self.v_update_cnt then
      self.v_update_cnt = 0
      self.v_update_obj = nil
    end
  end
  self.v_group_alpha.interactable = true
  self.v_check_alpha = true
  if self.v_cur_time and self.v_cur_time < EFFECT_TIME then
    if self.v_set_pause then
      self:_set_pause(self.v_param.guide_id, self.v_param.need_pause)
      self.v_set_pause = false
    end
    self:update_guide_location()
    self:update_guide_alpha()
    self.v_check_alpha = false
  end
  if self.v_param.auto_jump_delay and self.v_jump_count_down > self.v_param.auto_jump_delay then
    if self.v_guider:is_jump_auto_click_guide() and nil ~= self.v_cur_view then
      local click_cb = self.v_cur_view:get_click_event()
      if click_cb then
        click_cb(true)
      end
    end
    GuideMgr:jump_guide(self.v_guider.guide_id, true)
  end
  self.v_cur_time = self.v_cur_time + delta_time
  self.v_jump_count_down = self.v_jump_count_down_EF and self.v_jump_count_down + delta_time or self.v_jump_count_down
  if self.v_cur_time and self.v_cur_time < CAN_NOT_CLICK then
    local cannt_obj = Util.get_child_gameobj("CantClick", self.v_left_tips.transform.parent.gameObject)
    if cannt_obj then
      cannt_obj:SetActive(false)
    end
  end
  self:check_play_spine()
  self:check_avoid_ui(delta_time)
end

function ui:check_avoid_ui(delta_time)
  if not self.v_object_cvs then
    return
  end
  local check_ui_temp = false
  for avoid_ui, _ in pairs(GUIDE_AVOID_UI) do
    if UIMgr:try_get_visible_ui(avoid_ui) ~= nil and self.v_param.ui_name ~= avoid_ui then
      check_ui_temp = true
    end
  end
  if check_ui_temp then
    self.v_object_cvs.alpha = 0
    self.v_object_cvs.blocksRaycasts = false
  else
    self.v_object_cvs.blocksRaycasts = true
    if self.v_check_alpha then
      self.v_object_cvs.alpha = 1
    end
    if self.v_alpha_delay_flag > 0 then
      self.v_object_cvs.alpha = 0
      self.v_object_cvs.interactable = false
      self.v_alpha_delay_flag = self.v_alpha_delay_flag - delta_time
    elseif self.v_group_alpha_inter then
      self.v_object_cvs.interactable = true
    end
  end
end

function ui:update_guide_location()
  if self.v_mask_type == MASK_TYPE.COMBINE then
    local frame_rect = self.v_cur_view:get_frame_rect()
    for i = 1, 4 do
      local mask = self.v_mask_list[i]
      local width, height = GuideHelper.get_mask_size(i, frame_rect, self.v_ui_size)
      mask:SetSizeDeltaA(width, height)
    end
  end
  if self.v_param.follow_ui then
    if self.v_info_rect then
      local pos = self.v_pivot_rect.position
      self.v_info_rect:SetPositionA(pos.x, pos.y, pos.z)
    end
    if self.v_cur_view then
      self.v_cur_view:update_cope_obj_location()
    end
  end
  if self.v_txt_rect ~= nil and self.v_info_rect ~= nil and self.v_pivot_rect ~= nil then
    local offset_y = self.v_txt_rect.rect.height - self.v_pivot_rect.anchoredPosition.y + 50
    if offset_y < 0 then
      offset_y = 0
    end
    local offset_x = 0
    local offset_y_2 = 0
    if nil ~= self.v_txt_side then
      if 3 == self.v_txt_pos then
        offset_x = -1 * self.v_txt_rect.rect.width
        offset_y_2 = -1 * self.v_txt_rect.rect.height
      elseif 4 == self.v_txt_pos then
        offset_x = self.v_txt_rect.rect.width
        offset_y_2 = -1 * self.v_txt_rect.rect.height
      end
    end
    self.v_info_rect:SetAnchoredPositionA(self.v_cur_info_pos.x + offset_x, self.v_cur_info_pos.y + offset_y + offset_y_2, self.v_cur_info_pos.z)
  end
end

function ui:update_guide_alpha()
  if self.v_target_ui_canvasGroup then
    self.v_group_alpha.alpha = self.v_target_ui_canvasGroup.alpha
    if self.v_target_ui_canvasGroup.alpha < 0.3 then
      self.v_group_alpha.interactable = false
      self.v_group_alpha_inter = false
    else
      self.v_group_alpha.interactable = true
      self.v_group_alpha_inter = true
    end
  end
end

function ui:get_size()
  return self.v_ui_size
end

function ui:_set_pause(guide_id, need_pause)
  self.v_need_pause = nil
  if not need_pause then
    return
  end
  if SceneMgr then
    SceneMgr:set_game_pause(true, true)
  end
  self.v_need_pause = true
end

function ui:_show_mask(need_mask, finish_type)
  if not self.v_cur_view then
    self:ui_hide()
    return
  end
  local mask_type = self:_get_mask_type(need_mask, finish_type)
  self.v_mask_type = mask_type
  self.v_combine_mask:SetActive(mask_type == MASK_TYPE.COMBINE)
  self.v_normal_mask:SetActive(mask_type == MASK_TYPE.NORMAL)
  self.v_tras_mask:SetActive(mask_type == MASK_TYPE.TRANSPARENT)
  if mask_type == MASK_TYPE.NONE then
    return
  end
  local copy_obj = self.v_cur_view:get_copy_obj()
  local ctl_type = self.v_cur_view:get_ctl_type()
  local need_btn = false
  if self.v_func_type == FUNC_TYPE.NOTIFY and CLICK_AREA.TARGET == finish_type then
  elseif copy_obj then
    need_btn = 0 == ctl_type % 2 and CLICK_AREA.TARGET == finish_type or copy_obj.activeSelf == false or CLICK_AREA.WHOLE == finish_type
  end
  self.v_com_btn:SetActive(need_btn)
  if mask_type == MASK_TYPE.COMBINE then
    self:_combine_mask(finish_type)
  elseif mask_type == MASK_TYPE.NORMAL then
    self:set_button_listener(self.v_normal_mask, function()
      self:_onclick_mask(finish_type)
    end)
  elseif mask_type == MASK_TYPE.TRANSPARENT then
    self:set_button_listener(self.v_tras_mask, function()
      self:_onclick_mask(finish_type)
    end)
  end
  ctl_type = ctl_type or 0
  if finish_type == CLICK_AREA.WHOLE and 0 == ctl_type % 2 then
    self:set_button_listener(self.v_uicompents.WholeClickMask_btn, function()
      self:_onclick_mask(finish_type)
    end)
    self.v_uiobjects.WholeClickMask:SetActive(true)
  else
    self.v_uiobjects.WholeClickMask:SetActive(false)
  end
end

function ui:_get_mask_type(need_mask, finish_type)
  if not self.v_cur_view then
    Log.Error("get guide type failure! guide_id=", self.v_guider.guide_id)
    self:ui_hide()
    return
  end
  local ctl_type = self.v_cur_view:get_ctl_type()
  if need_mask then
    return ctl_type <= 2 and MASK_TYPE.COMBINE or MASK_TYPE.NORMAL
  elseif finish_type == CLICK_AREA.WHOLE then
    return MASK_TYPE.TRANSPARENT
  elseif 0 == ctl_type % 2 then
    Log.Error("当前引导guide_id=", self.v_guider.guide_id, "没有任何响应点击事件的UI控件，step=", self.v_guider:get_cur_step())
  end
  return MASK_TYPE.NONE
end

function ui:_combine_mask(finish_type)
  local frame_rect = self.v_cur_view:get_frame_rect()
  for i = 1, 4 do
    local mask = self.v_mask_list[i]
    local width, height = GuideHelper.get_mask_size(i, frame_rect, self.v_ui_size)
    mask:SetSizeDeltaA(width, height)
    local btn = self:get_button(nil, mask)
    self:set_button_listener(btn, function()
      self:_onclick_mask(finish_type)
    end)
  end
end

function ui:_onclick_mask(finish_type)
  local click_cb = self.v_cur_view:get_click_event()
  if finish_type == CLICK_AREA.WHOLE then
    if click_cb then
      self:_complete_step()
    else
      self:_complete_step()
    end
  elseif finish_type ~= CLICK_AREA.TARGET or not click_cb then
  end
  self:_check_show_jump()
  if self.v_anim_eff ~= nil and Global.real_time - self.v_anim_eff_cd > 1 then
    self.v_anim_eff_cd = Global.real_time
    self.v_anim_eff:SetActive(false)
    self.v_anim_eff:SetActive(true)
  end
end

function ui:_onclick_combtn()
  local click_cb = self.v_cur_view:get_click_event()
  if click_cb then
    click_cb(true)
  else
    self:_complete_step()
  end
  self:_check_show_jump()
end

function ui:_show_guide_txt(guide_txt, txt_pos, txt_type, txt_icon_pos, txt_icon, spine_id, spine_pos)
  self.v_txt_rect = nil
  for _, v in pairs(self.v_tips) do
    v.rect:SetActive(false)
  end
  self.v_txt_icon:SetActive(false)
  self.v_txt_spine:SetActive(false)
  self.v_spine_id = nil
  if not guide_txt then
    return
  end
  if not txt_type or 1 == txt_type then
    txt_pos = txt_pos or 1
    local info = self.v_tips[txt_pos]
    if not info then
      return
    end
    info.rect:SetActive(true)
    info.long:SetActive(false)
    local txt = self:get_text("BG/Content", info.short)
    txt.text = guide_txt
    local len = self:calc_text_width(txt)
    info.short:SetActive(len <= DEFAULT_WORLD_WIDTH)
    info.long:SetActive(len > DEFAULT_WORLD_WIDTH)
    if len > DEFAULT_WORLD_WIDTH then
      txt = self:get_text("Content", info.long)
      txt.text = guide_txt
    end
    if self.v_cur_view then
      local pivot_rect = self.v_cur_view:get_pivot(txt_pos)
      local pos = pivot_rect.position
      if 3 == txt_pos or 4 == txt_pos then
        local txt_rect = Util.get_rect_transform(nil, txt.gameObject)
        if nil ~= txt_rect then
          self.v_txt_rect = txt_rect
        end
      else
      end
      info.rect:SetPositionA(pos.x, pos.y, pos.z)
      self.v_cur_info_pos = {
        x = info.rect.anchoredPosition.x,
        y = info.rect.anchoredPosition.y,
        z = info.rect.anchoredPosition.z
      }
      self.v_pivot_rect = pivot_rect
      self.v_info_rect = info.rect
      self.v_update_obj = info.rect.gameObject
    end
  elseif txt_type == GUIDE_TXT_TYPE.TXT_AND_ICON or txt_type == GUIDE_TXT_TYPE.SPINE then
    self.v_txt_icon:SetActive(true)
    for i = 1, 4 do
      self.v_pos_to_txt_icon[i].guide:SetActive(false)
    end
    self.v_pos_to_txt_icon[txt_icon_pos].guide:SetActive(true)
    local profile = self.v_pos_to_txt_icon[txt_icon_pos].profile
    local profileBg = self.v_pos_to_txt_icon[txt_icon_pos].profileBg
    local spine_flag = txt_type == GUIDE_TXT_TYPE.SPINE
    profile.gameObject:SetActive(not spine_flag)
    local txt = self.v_pos_to_txt_icon[txt_icon_pos].txt
    txt.text = guide_txt
    if spine_flag then
      self.v_spine_id = spine_id
      if self.v_spine_id then
        self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
        self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.GuideSpine)
        self.v_uiobjects.GuideSpine.transform:SetLocalPositionA(spine_pos[1], spine_pos[2], spine_pos[3])
        self.v_uiobjects.GuideSpine.transform:SetLocalScaleA(spine_pos[4], spine_pos[4], spine_pos[4])
        SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_txt_spine)
      end
    else
      ResMgr:load_set_icon(profile, sformat(ICON_PREFIX, txt_icon))
    end
  end
end

function ui:calc_text_width(text)
  if not text then
    return 0
  end
  local tg = text.cachedTextGeneratorForLayout
  local setting = text:GetGenerationSettings(ZERO)
  return tg:GetPreferredWidth(text.text, setting) / text.pixelsPerUnit
end

function ui:_show_drag_anim(target_ui, drag_begin_path, drag_target_path)
  local do_show = target_ui and nil ~= drag_begin_path and nil ~= drag_target_path
  self.v_uiobjects.Drag:SetActiveEx(do_show)
  if not do_show then
    return
  end
  local begin_obj = GuideHelper.get_obj_by_path(self, drag_begin_path, target_ui)
  local target_obj = GuideHelper.get_obj_by_path(self, drag_target_path, target_ui)
  if not begin_obj or not target_obj then
    return
  end
  local drag_trans = self.v_uiobjects.Drag.transform
  local begin_trans = begin_obj.transform
  local begin_size = begin_trans.sizeDelta
  local begin_pivot = begin_trans.pivot
  drag_trans.pivot = begin_pivot
  drag_trans.sizeDelta = begin_trans.sizeDelta
  drag_trans.position = begin_trans.position
  local offset_x = (0.5 - begin_pivot.x) * begin_size.x
  local offset_y = (0.5 - begin_pivot.y) * begin_size.y
  drag_trans.pivot = Vec2.New(0.5, 0.5)
  drag_trans:SetAnchoredPositionA(drag_trans.anchoredPosition.x + offset_x, drag_trans.anchoredPosition.y + offset_y)
  local drag_canvas_group = self:get_canvas_group(nil, drag_trans)
  drag_canvas_group.alpha = 0
  self:clear_drag_sequence()
  self.v_drag_sequence = Util.create_sequence()
  self.v_drag_sequence:AppendInterval(0.3)
  self.v_drag_sequence:Append(drag_trans:DOMove(target_obj.transform.position, 1.2):SetEase(CSTweening.Ease.InOutQuad))
  self.v_drag_sequence:Join(drag_canvas_group:DOFade(1, 0.4))
  self.v_drag_sequence:Join(drag_canvas_group:DOFade(0, 0.2):SetDelay(1))
  self.v_drag_sequence:SetLoops(-1, CSTweening.LoopType.Restart)
end

function ui:clear_drag_sequence()
  if self.v_drag_sequence then
    self.v_drag_sequence:Kill(false)
    self.v_drag_sequence = nil
  end
end

function ui:_check_show_jump()
  if not self.v_last_input_time then
    self.v_last_input_time = Global.real_time
  end
  if Global.real_time - self.v_last_input_time > 0.1 then
    self.v_click_count = self.v_click_count + 1
    self.v_last_input_time = Global.real_time
  end
  if self.v_click_count > 10 then
    self.v_jump_btn:SetActive(true)
    self.v_last_input_time = nil
    self.v_click_count = 0
  end
end

function ui:_onclick_jump()
  self.v_jump_count_down_EF = false
  local tip = Util.format_str("是否确定跳过引导？")
  
  local function sure_callback()
    if self.v_guider:is_jump_auto_click_guide() and self.v_cur_view ~= nil then
      local click_cb = self.v_cur_view:get_click_event()
      if click_cb then
        click_cb(true)
      end
    end
    GuideMgr:jump_guide(self.v_guider.guide_id, true)
  end
  
  local function cancel_callback()
    self.v_jump_count_down_EF = true
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, cancel_callback, tip)
end

function ui:resume_game()
  if self.v_need_pause and SceneMgr then
    SceneMgr:set_game_pause(false)
  end
  self.v_need_pause = nil
end

function ui:hide_mask()
  self.v_combine_mask:SetActive(false)
  self.v_normal_mask:SetActive(false)
  self.v_tras_mask:SetActive(false)
  for _, v in pairs(self.v_tips) do
    v.rect:SetActive(false)
  end
end

function ui:_complete_step()
  if self.v_is_complete then
    return
  end
  if self.v_guider then
    self.v_is_complete = true
    for k, v in pairs(self.v_panels) do
      if v:visible() then
        v:set_complete()
      end
    end
    self.v_guider:complete_step()
  end
end

function ui:get_joystick_btn()
  return self.v_uiobjects.JoystickBtn
end

function ui:set_joystick_btn_pos(rect_posx, rect_posy)
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.JoystickBtn)
  rect:SetAnchoredPositionA(rect_posx, rect_posy)
end

function ui:check_play_spine()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
