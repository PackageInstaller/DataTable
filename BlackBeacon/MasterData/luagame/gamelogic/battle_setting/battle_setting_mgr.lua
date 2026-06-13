local Base = require("gamelogic.base_system")
local Seri = require("seri")
local M = Util.create_child_mt(Base)
local _tinsert = table.insert
local LocalStorage = require("utils.localstorage")
local Fight_Layout_Cfg = require("uimodule.fight.custom_button.fight_layout_cfg")
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")
local Voice_Type = Setting_Cfg.VoiceType
local Voice_Type_Contain_List = Setting_Cfg.VoiceTypeContainList
local UI_CFG = Setting_Cfg.UI_CFG
local page_tag = Setting_Cfg.PageTag
local Quality_Cfg = require("manager.render.quality_cfg")
local Quality_Detail_Cfg = Quality_Cfg.CFG
local SETTING = Config.SETTING
local TouchManager = CS.TouchManager
local KEYCODE = UnityEngine.KeyCode
local Toggle_State = {CLOSE = 0, OPEN = 1}
local SOURCE_TYPE = Config.SOURCE_TYPE
local is_login_saved = false
local setting_info = {
  search_target_type = 2,
  lock_enemy_btn_visible = 0,
  joy_move_type = 0,
  skill_cancel_type = 0,
  skill_sensitivity = 10,
  camera_sensitivity = 10,
  camera_view_type = 1,
  depression_mode_rotate = 0,
  indicator_attach_target_enable = 1,
  auto_trigger_qte_on_role_out = 1,
  camera_pinch_type = 1,
  damage_font_size = 1,
  auto_lock_type = 1,
  login_camera_movement_setting = 2,
  start_drag_ratio = 1
}
local local_setting_info = {
  voice_main = 1,
  voice_bg = 1,
  voice_se = 1,
  voice_cv = 1,
  resolution = Global.quality_cfg.resolution,
  render_frame = Global.quality_cfg.render_frame,
  effect_quality = Global.quality_cfg.effect_quality,
  shadow = Global.quality_cfg.shadow,
  anti_aliasing = Global.quality_cfg.anti_aliasing and 1 or 0,
  HDR = Global.quality_cfg.HDR and 1 or 0,
  safe_area = 1,
  [Setting_Cfg.NOTIFICATION_TYPE.ALL] = 1,
  [Setting_Cfg.NOTIFICATION_TYPE.GAME] = 1,
  [Setting_Cfg.NOTIFICATION_TYPE.NOTICE] = 1,
  [Setting_Cfg.NOTIFICATION_TYPE.NIGHT] = 1,
  gpg_button_show = 1,
  button_forward = 119,
  button_left = 97,
  button_backward = 115,
  button_right = 100,
  button_dodge = 304,
  button_interact = 102,
  button_combo_burst = 116,
  button_basic_attack = 32,
  button_skill1 = 113,
  button_skill2 = 101,
  button_ult_skill = 114,
  button_stage_skill = 118,
  button_switch_char1 = 49,
  button_switch_char2 = 50,
  button_switch_c1_ult = 96,
  button_switch_c2_ult = 51,
  button_map = 109
}
local DEFAULT_SETTING_INFO = {
  search_target_type = 2,
  lock_enemy_btn_visible = 0,
  joy_move_type = 0,
  skill_cancel_type = 0,
  camera_pinch_type = 1,
  camera_view_type = 1,
  depression_mode_rotate = 0,
  indicator_attach_target_enable = 1,
  skill_sensitivity = 10,
  camera_sensitivity = 10,
  start_drag_ratio = 1,
  damage_font_size = 1,
  auto_lock_type = 1,
  login_camera_movement_setting = 2,
  auto_trigger_qte_on_role_out = 1
}
local DEFAULT_LOCAL_SETTING_INFO = {
  voice_main = 1,
  voice_bg = 1,
  voice_se = 1,
  voice_cv = 1,
  resolution = Quality_Cfg.MIDDLE,
  render_frame = 2,
  effect_quality = 2,
  shadow = 1,
  anti_aliasing = 1,
  HDR = 1,
  safe_area = 1,
  gpg_button_show = 1,
  button_forward = 119,
  button_left = 97,
  button_backward = 115,
  button_right = 100,
  button_dodge = 304,
  button_interact = 102,
  button_combo_burst = 116,
  button_basic_attack = 32,
  button_skill1 = 113,
  button_skill2 = 101,
  button_ult_skill = 114,
  button_stage_skill = 118,
  button_switch_char1 = 49,
  button_switch_char2 = 50,
  button_switch_c1_ult = 96,
  button_switch_c2_ult = 51,
  button_map = 109
}

function M:init_sys()
  Base.init_sys(self)
  self.v_net_disk_data = {}
  self.v_all_local_btn_layout_info = {}
  self.v_all_local_setting_info = {}
  self.v_setting_info = {}
  self.v_pre_setting_info = {}
  self.v_local_setting_info = {}
  self.v_pre_local_setting_info = {}
  self.v_keycode_inputcode_map = {}
  self.v_btn_layout_list = {}
  self:load_init_layout()
  self.setting_tips = ShareRes.create("setting.setting_tips")
  if Util.is_client_only() then
    self.v_local_setting_info = local_setting_info
    self:init_keyboard_setting()
  end
end

function M:check_old_setting()
  for param_name, _ in pairs(self.v_local_setting_info) do
    local cfg = Setting_Cfg.UI_CFG[param_name]
    if not cfg and "local_graphic_quality" ~= param_name then
      Log.Error("旧的设置信息：", param_name, "不存在")
      self.v_local_setting_info = local_setting_info
      self:save_local_setting_info()
      break
    end
  end
  for param_name, _ in pairs(local_setting_info) do
    if not self.v_local_setting_info[param_name] then
      Log.Error("旧的设置信息：", param_name, "不存在")
      self.v_local_setting_info = local_setting_info
      self:save_local_setting_info()
      break
    end
  end
end

function M:get_cfg_by_id(id)
  local cfg = self.setting_tips[id]
  if nil ~= cfg then
    return cfg
  end
end

function M:load_init_layout()
  self.v_btn_layout_list = {}
  local defalu_layout_idxs = {}
  local fight_layout_cfg = ShareRes.get_fight_layout_config()
  for _, data in pairs(fight_layout_cfg) do
    local file_name = data.file_name
    local layout_tb = ShareRes.create(file_name)
    if not file_name then
      Log.Error("自定义布局配置：", file_name, "不存在")
    end
    defalu_layout_idxs[layout_tb.idx] = layout_tb
  end
  local custom_map = self:load_local_btn_layout_data()
  local use_index
  for _, layout_info in pairs(custom_map) do
    self.v_btn_layout_list[layout_info.idx] = layout_info
    if defalu_layout_idxs[layout_info.idx] then
      defalu_layout_idxs[layout_info.idx] = nil
    end
    if layout_info.is_use == Fight_Layout_Cfg.layout_is_use.using then
      use_index = layout_info.idx
    end
  end
  local need_save = false
  local copy_list
  for idx, layout_tb in pairs(defalu_layout_idxs) do
    copy_list = UtilTable.copy_table(layout_tb)
    copy_list.ui_list = self:copy_ui_layout_list(layout_tb.ui_list)
    local layout_cfg = ShareRes.get_fight_layout_config(idx)
    if layout_cfg then
      for key, value in pairs(layout_cfg) do
        copy_list[key] = value
      end
    end
    self.v_btn_layout_list[idx] = copy_list
    need_save = true
  end
  if need_save then
    self:save_select_layout_index(use_index)
  end
end

function M:update_btn_layout_list(update_tb)
  self.v_btn_layout_list = update_tb
end

function M:save_select_layout_index(use_idx)
  local custom_tb_list = {}
  local use_default = nil == use_idx
  for idx, layout_info in pairs(self.v_btn_layout_list) do
    if use_default and Util.is_more_than_zero(layout_info.default_use) then
      layout_info.is_use = Fight_Layout_Cfg.layout_is_use.using
    elseif idx == use_idx then
      layout_info.is_use = Fight_Layout_Cfg.layout_is_use.using
    else
      layout_info.is_use = Fight_Layout_Cfg.layout_is_use.not_using
    end
    _tinsert(custom_tb_list, layout_info)
  end
  local length = #custom_tb_list
  if length > 0 then
    self:save_local_btn_layout_data(custom_tb_list)
  end
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:load_setting_layout()
  end
end

function M:load_local_btn_layout_data()
  self.v_all_local_btn_layout_info = LocalStorage:load_table(Config.SETTING_BTN_LAYOUT_KEY) or {}
  return self.v_all_local_btn_layout_info[Global.player_uuid] or {}
end

function M:save_local_btn_layout_data(data)
  self.v_all_local_btn_layout_info[Global.player_uuid] = data
  LocalStorage:save_table(Config.SETTING_BTN_LAYOUT_KEY, self.v_all_local_btn_layout_info)
end

function M:load_treasure_chest_guide_state()
  local state = LocalStorage:load_int(Config.TREASURE_CHEST_GUIDE_STATE, 1)
  return state == Config.OPEN_OR_CLOSE_STATE.OPEN
end

function M:save_treasure_chest_guide_state(bool_state)
  local num_state = bool_state and Config.OPEN_OR_CLOSE_STATE.OPEN or Config.OPEN_OR_CLOSE_STATE.CLOSE
  LocalStorage:save_int(Config.TREASURE_CHEST_GUIDE_STATE, num_state)
end

function M:check_btn_layout_list(layout_tb)
  local ui_list = layout_tb.ui_list
  local origin_ui_list = self:get_standard_layout_ui_list()
  for ui_name, data in pairs(ui_list) do
    local origin_ui = origin_ui_list[ui_name]
    if not origin_ui then
      ui_list[ui_name] = nil
    end
  end
  for ui_name, data in pairs(origin_ui_list) do
    local now_ui = ui_list[ui_name]
    if not now_ui then
      ui_list[ui_name] = {}
      self:set_ui_data_by_origin(data, ui_list[ui_name])
    end
  end
end

function M:set_ui_data_by_origin(origin_ui, now_ui)
  for k, _ in pairs(origin_ui) do
    now_ui[k] = origin_ui[k]
  end
end

function M:use_player_setting_info(init_keyboard_setting)
  self:load_player_setting_info()
  self:check_old_setting()
  if init_keyboard_setting and SDKManager:is_support_key_mouse() then
    self:init_keyboard_setting()
  end
end

function M:load_player_setting_info()
  self.v_all_local_setting_info = LocalStorage:load_table(Config.SETTING_INFO_KEY) or {}
  if not self.v_all_local_setting_info[Global.player_uuid] then
    self.v_all_local_setting_info[Global.player_uuid] = local_setting_info
  end
  self.v_local_setting_info = self.v_all_local_setting_info[Global.player_uuid]
  if 0 == Global.player_uuid then
    local last_login_data = LocalStorage:load_table(Config.LAST_LOGIN_UUID_KEY) or {}
    local uuid = last_login_data.player_uuid
    if uuid and uuid > 0 and self.v_all_local_setting_info[uuid] then
      self.v_local_setting_info = self.v_all_local_setting_info[uuid]
    end
  end
  self:init_game_setting()
  self:reset_pre_local_setting_info()
end

function M:init_game_setting()
  local data
  for key, value in pairs(self.v_local_setting_info) do
    data = UI_CFG[key]
    if data then
      if data.type == "slider_toggle" then
        self[data.fun](self, value, data.voice_type)
      elseif data.type == "single_toggle" then
        self[data.fun](self, value == Toggle_State.OPEN)
      elseif data.type == "multi_toggle" then
        self[data.fun](self, value)
      elseif data.type == "slider" then
        self[data.fun](self, value)
      end
    end
  end
end

function M:reset_pre_local_setting_info()
  self.v_pre_local_setting_info = {}
  for key, value in pairs(self.v_local_setting_info) do
    self.v_pre_local_setting_info[key] = value
  end
end

function M:reset_local_setting_info()
  self.v_local_setting_info = {}
  for key, value in pairs(self.v_pre_local_setting_info) do
    self.v_local_setting_info[key] = value
  end
end

function M:reset_local_setting_info_to_default(init_toggle, cur_page)
  if cur_page == page_tag.Voice then
    local reset_voice_target = {
      voice_main = true,
      voice_bg = true,
      voice_se = true,
      voice_cv = true
    }
    for key, value in pairs(reset_voice_target) do
      self.v_local_setting_info[key] = DEFAULT_LOCAL_SETTING_INFO[key]
    end
  elseif cur_page == page_tag.Quality then
    local reset_quality_target = {
      resolution = true,
      render_frame = true,
      effect_quality = true,
      shadow = true,
      anti_aliasing = true,
      HDR = true
    }
    for key, value in pairs(reset_quality_target) do
      self.v_local_setting_info[key] = DEFAULT_LOCAL_SETTING_INFO[key]
    end
    self.v_local_setting_info.unity_quality = nil
    self.v_local_setting_info.local_graphic_quality = nil
  elseif cur_page == page_tag.Other then
    self.v_local_setting_info.safe_area = DEFAULT_LOCAL_SETTING_INFO.safe_area
  elseif cur_page == page_tag.PCTouch then
    local reset_gpg_button = {
      "gpg_button_show",
      "button_forward",
      "button_left",
      "button_backward",
      "button_right",
      "button_dodge",
      "button_interact",
      "button_combo_burst",
      "button_basic_attack",
      "button_skill1",
      "button_skill2",
      "button_ult_skill",
      "button_stage_skill",
      "button_switch_char1",
      "button_switch_char2",
      "button_switch_c1_ult",
      "button_switch_c2_ult",
      "button_map"
    }
    for _, key in pairs(reset_gpg_button) do
      self.v_local_setting_info[key] = DEFAULT_LOCAL_SETTING_INFO[key]
    end
  end
end

function M:get_btn_layout_list()
  return self.v_btn_layout_list
end

function M:get_btn_layout_info_by_index(idx)
  return self.v_btn_layout_list[idx]
end

function M:get_standard_layout_ui_list(idx)
  idx = idx or 1
  local fight_layout_cfg = ShareRes.get_fight_layout_config(idx)
  local file_name = fight_layout_cfg.file_name
  if not file_name then
    Log.Error("自定义布局配置：", file_name, "不存在")
  end
  local layout_tb = ShareRes.create(file_name)
  return layout_tb.ui_list, layout_tb.is_flip
end

function M:get_default_layout()
  return self.v_btn_layout_list[1]
end

function M:get_setting_info()
  return self.v_setting_info
end

function M:get_local_setting_info()
  return self.v_local_setting_info
end

function M:get_indicator_skill_sensitivity()
  local ui_cfg = Setting_Cfg.UI_CFG
  local skill_sensitivity_cfg = ui_cfg.skill_sensitivity
  local sld_min_num = skill_sensitivity_cfg.min_num
  local sld_max_num = skill_sensitivity_cfg.max_num
  local part_num = sld_max_num - sld_min_num
  local joy_max_num = SETTING.SKILL_SENSITIVITY.MAX_NUM
  local joy_min_num = SETTING.SKILL_SENSITIVITY.MIN_NUM
  local joy_part_num = (joy_max_num - joy_min_num) / part_num
  local result_num = joy_min_num + self:get_skill_sensitivity() * joy_part_num
  return result_num
end

function M:get_swipe_camera_sensitivity()
  local ui_cfg = Setting_Cfg.UI_CFG
  local camara_sensitivity = ui_cfg.camera_sensitivity
  local sld_min_num = camara_sensitivity.min_num
  local sld_max_num = camara_sensitivity.max_num
  local part_num = sld_max_num - sld_min_num
  local camera_max_num = SETTING.CAMERA_SENSITIVITY.MAX_NUM
  local camera_min_num = SETTING.CAMERA_SENSITIVITY.MIN_NUM
  local camera_part_num = (camera_max_num - camera_min_num) / part_num
  local result_num = camera_min_num + self:get_camera_sensitity() * camera_part_num
  return result_num
end

function M:get_skill_sensitivity()
  return self.v_setting_info.skill_sensitivity or DEFAULT_SETTING_INFO.skill_sensitivity
end

function M:get_search_target_type()
  return self.v_setting_info.search_target_type or DEFAULT_SETTING_INFO.search_target_type
end

function M:get_lock_enemy_btn_visible()
  return self.v_setting_info.lock_enemy_btn_visible or DEFAULT_SETTING_INFO.lock_enemy_btn_visible
end

function M:get_skill_cancel_type()
  return self.v_setting_info.skill_cancel_type or DEFAULT_SETTING_INFO.skill_cancel_type
end

function M:get_skill_active_location()
  return SETTING.SKILL_ACTIVE_LOCATION.HANDLE
end

function M:get_joy_move_type()
  return self.v_setting_info.joy_move_type or DEFAULT_SETTING_INFO.joy_move_type
end

function M:get_custom_camera_view()
  return SETTING.CUSTOM_CAMERA_VIEW.AUTO_ANGLE
end

function M:get_camera_pinch_type()
  return self.v_setting_info.camera_pinch_type or DEFAULT_SETTING_INFO.camera_pinch_type
end

function M:get_camera_sensitity()
  return self.v_setting_info.camera_sensitivity or DEFAULT_SETTING_INFO.camera_sensitivity
end

function M:get_camera_view_type()
  return self.v_setting_info and self.v_setting_info.camera_view_type or DEFAULT_SETTING_INFO.camera_view_type
end

function M:get_depression_mode_rotate()
  return self.v_setting_info.depression_mode_rotate or DEFAULT_SETTING_INFO.depression_mode_rotate
end

function M:get_login_camera_movement_mode()
  return self.v_setting_info and self.v_setting_info.login_camera_movement_setting or DEFAULT_SETTING_INFO.login_camera_movement_setting
end

function M:get_damage_font_size()
  return self.v_setting_info.damage_font_size or DEFAULT_SETTING_INFO.damage_font_size
end

function M:get_auto_lock_type()
  return self.v_setting_info.auto_lock_type or DEFAULT_SETTING_INFO.auto_lock_type
end

function M:get_voice_main()
  return self.v_local_setting_info.voice_main or DEFAULT_LOCAL_SETTING_INFO.voice_main
end

function M:get_voice_bg()
  return self.v_local_setting_info.voice_bg or DEFAULT_LOCAL_SETTING_INFO.voice_bg
end

function M:get_voice_se()
  return self.v_local_setting_info.voice_se or DEFAULT_LOCAL_SETTING_INFO.voice_se
end

function M:get_voice_cv()
  return self.v_local_setting_info.voice_cv or DEFAULT_LOCAL_SETTING_INFO.voice_cv
end

function M:get_actual_voice_se()
  return self:get_voice_main() * self:get_voice_se()
end

function M:get_default_voice_main()
  return DEFAULT_LOCAL_SETTING_INFO.voice_main
end

function M:get_default_voice_bg()
  return DEFAULT_LOCAL_SETTING_INFO.voice_bg
end

function M:get_default_voice_se()
  return DEFAULT_LOCAL_SETTING_INFO.voice_se
end

function M:get_default_voice_cv()
  return DEFAULT_LOCAL_SETTING_INFO.voice_cv
end

function M:get_local_graphic_quality()
  return self.v_local_setting_info.local_graphic_quality
end

function M:get_effect_quality()
  return self.v_local_setting_info.effect_quality or DEFAULT_LOCAL_SETTING_INFO.effect_quality
end

function M:get_safe_area()
  return self.v_local_setting_info.safe_area or DEFAULT_LOCAL_SETTING_INFO.safe_area
end

function M:setting_info_not_nil()
  return self.v_local_setting_info ~= nil
end

function M:set_search_target_type(data)
  self.v_setting_info.search_target_type = data
end

function M:set_lock_enemy_btn_visible(data)
  data = data and SETTING.LOCK_ENEMY_BTN_VISIBLE.OPEN or SETTING.LOCK_ENEMY_BTN_VISIBLE.CLOSE
  self.v_setting_info.lock_enemy_btn_visible = data
  MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHANGE)
end

function M:set_joy_move_type(data)
  self.v_setting_info.joy_move_type = data
  MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHANGE)
end

function M:set_skill_cancel_type(data)
  self.v_setting_info.skill_cancel_type = data
end

function M:set_skill_active_location(data)
  self.v_setting_info.skill_active_location = data
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_INDICATOR_CONFIG)
end

function M:set_skill_sensitivity(data)
  self.v_setting_info.skill_sensitivity = data
end

function M:set_camera_sensitivity(data)
  self.v_setting_info.camera_sensitivity = data
end

function M:set_custom_camera_view(data)
  if Global.camera then
    if data == SETTING.CUSTOM_CAMERA_VIEW.DEPRESSION_ANGLE then
      Global.camera:set_scene_camera(Config.CAMERA_VIEW_TYPE_ID.DEPRESSION_ANGLE, true)
    elseif data == SETTING.CUSTOM_CAMERA_VIEW.SHOULDER_ANGLE then
      Global.camera:set_scene_camera(Config.CAMERA_VIEW_TYPE_ID.SHOULDER_ANGLE, true)
    else
      Global.camera:set_scene_camera(Config.CAMERA_VIEW_TYPE_ID.SHOULDER_ANGLE, true)
    end
  end
end

function M:set_camera_pinch_type(data)
  self.v_setting_info.camera_pinch_type = data
end

function M:set_camera_view_type(data)
  self.v_setting_info.camera_view_type = data
  local param = {camera_type = data}
  SDKTrack:user_set(param)
end

function M:enable_depression_mode_rotate(data)
  self.v_setting_info.depression_mode_rotate = data
end

function M:set_login_camera_movement_setting(data)
  self.v_setting_info.login_camera_movement_setting = data
end

function M:set_damage_font_size(data)
  self.v_setting_info.damage_font_size = data
end

function M:set_auto_lock_type(data)
  data = data and SETTING.AUTO_LOCK_TYPE.OPEN or SETTING.AUTO_LOCK_TYPE.CLOSE
  self.v_setting_info.auto_lock_type = data
  BehaviorMgr:set_hero_behaviour_value(Config.HERO_BEHAVIOR_VALUE.LOCK_AND_TURN_SETTING, data)
end

function M:set_game_voice(data, voice_type)
  local voice_main_volumn = self:get_voice_main()
  local voice_bg_volumn = self:get_voice_bg()
  local voice_se_volumn = self:get_voice_se()
  local voice_cv_volumn = self:get_voice_cv()
  if voice_type == Voice_Type.Main then
    self.v_local_setting_info.voice_main = data
    local voice_volumn = 1
    for _, type in pairs(Voice_Type_Contain_List[voice_type]) do
      if type == SOURCE_TYPE.BGM then
        voice_volumn = voice_bg_volumn * data
      elseif type == SOURCE_TYPE.EFFECT then
        voice_volumn = voice_se_volumn * data
      elseif type == SOURCE_TYPE.SPECIAL then
        voice_volumn = voice_se_volumn * data
      elseif type == SOURCE_TYPE.VOICE then
        voice_volumn = voice_cv_volumn * data
      end
      Global.sound_mgr:set_source_volume_val(type, voice_volumn)
    end
  elseif voice_type == Voice_Type.BG then
    self.v_local_setting_info.voice_bg = data
    for _, type in pairs(Voice_Type_Contain_List[voice_type]) do
      Global.sound_mgr:set_source_volume_val(type, voice_main_volumn * data)
    end
  elseif voice_type == Voice_Type.SE then
    self.v_local_setting_info.voice_se = data
    local voice_volumn
    for _, type in pairs(Voice_Type_Contain_List[voice_type]) do
      voice_volumn = voice_main_volumn * data
      Global.sound_mgr:set_source_volume_val(type, voice_volumn)
    end
  elseif voice_type == Voice_Type.CV then
    self.v_local_setting_info.voice_cv = data
    for _, type in pairs(Voice_Type_Contain_List[voice_type]) do
      Global.sound_mgr:set_source_volume_val(type, voice_main_volumn * data)
    end
  end
end

function M:set_resolution(data)
  self.v_local_setting_info.resolution = data
  Global.quality_cfg.resolution = data
  Global.render_mgr:set_resolution(data)
end

function M:set_render_frame(data)
  self.v_local_setting_info.render_frame = data
  Global.quality_cfg.render_frame = data
  Global.render_mgr:set_render_frame(data)
end

function M:set_effect_quality(data)
  self.v_local_setting_info.effect_quality = data
  Global.quality_cfg.effect_quality = data
end

function M:set_shadow_quality(quality)
  self.v_local_setting_info.shadow = quality
  Global.quality_cfg.shadow = quality
  Global.render_mgr:set_shadow(quality)
end

function M:set_unity_quality_setting(quality)
  self.v_local_setting_info.unity_quality = quality
  Global.render_mgr:set_unity_quality_setting(quality)
end

function M:set_anti_aliasing(is_on)
  local anti_aliasing = is_on and SETTING.ANTI_ALIASING_TYPE.OPEN or SETTING.ANTI_ALIASING_TYPE.CLOSE
  self.v_local_setting_info.anti_aliasing = anti_aliasing
  Global.quality_cfg.anti_aliasing = anti_aliasing
  Global.render_mgr:set_anti_aliasing(is_on)
end

function M:get_anti_aliasing()
  return self.v_local_setting_info.anti_aliasing == SETTING.ANTI_ALIASING_TYPE.OPEN
end

function M:set_hdr(is_on)
  self.v_local_setting_info.HDR = is_on and SETTING.HDR_TYPE.OPEN or SETTING.HDR_TYPE.CLOSE
  Global.render_mgr:enable_hdr(is_on)
end

function M:get_hdr()
  return self.v_local_setting_info.HDR == SETTING.HDR_TYPE.OPEN
end

function M:set_safe_area(data)
  self.v_local_setting_info.safe_area = data
  UIMgr:set_all_safe_area_offset()
end

function M:set_local_graphic_quality(data)
  Global.render_mgr:set_quality_level(data)
end

function M:set_local_graphic_quality_level(data)
  self.v_local_setting_info.local_graphic_quality = data
end

function M:save_online_setting_info()
  self:reset_pre_setting_info()
  local pack_args = Seri.packstring(self.v_setting_info)
  local type_tmp = Config.SAVE_TYPE.BATTLE_SETTING
  Network:call("c2gs_netdisk_save_data", {type = type_tmp, pack_string = pack_args})
end

function M:load_online_setting_info()
  local setting_info_str
  for k, _ in pairs(self.v_net_disk_data) do
    if k.type == Config.SAVE_TYPE.BATTLE_SETTING then
      setting_info_str = k.pack_string
      break
    end
  end
  local player_setting_info = Seri.unpack(setting_info_str)
  return player_setting_info
end

function M:get_net_disk_data(type)
  if next(self.v_net_disk_data) ~= nil then
    local info_str
    for k, _ in pairs(self.v_net_disk_data) do
      if k.type == type then
        info_str = k.pack_string
        break
      end
    end
    local setting_info = Seri.unpack(info_str)
    return setting_info
  end
end

function M:reset_online_setting_info()
  return
end

function M:on_get_netdisk_data(data)
  if next(data.netdisk_data) ~= nil then
    for _, v in pairs(data.netdisk_data) do
      self.v_net_disk_data[v] = true
    end
    self.v_setting_info = self:load_online_setting_info() or setting_info
  else
    self.v_setting_info = setting_info
  end
  self:reset_pre_setting_info()
end

function M:reset_pre_setting_info()
  self.v_pre_setting_info = {}
  for key, value in pairs(self.v_setting_info) do
    self.v_pre_setting_info[key] = value
  end
end

function M:reset_setting_info()
  self.v_setting_info = {}
  for key, value in pairs(self.v_pre_setting_info) do
    self.v_setting_info[key] = value
  end
end

function M:reset_setting_info_to_default(cur_page)
  if cur_page == page_tag.Other then
    self.v_setting_info = {}
    for key, value in pairs(DEFAULT_SETTING_INFO) do
      self.v_setting_info[key] = value
    end
  end
end

function M:save_local_setting_info()
  self:reset_pre_local_setting_info()
  self.v_all_local_setting_info[Global.player_uuid] = self.v_local_setting_info
  LocalStorage:save_table(Config.SETTING_INFO_KEY, self.v_all_local_setting_info)
end

function M.load_local_setting_info()
  return LocalStorage:load_table(Config.SETTING_INFO_KEY)
end

function M:get_shadow_quality()
  return self.v_local_setting_info and self.v_local_setting_info.shadow or Quality_Cfg.SHADOW.MIDDLE
end

function M:is_enable_shadow_camera()
  local shadow_quality = self:get_shadow_quality()
  return shadow_quality > Quality_Cfg.SHADOW.LOW
end

function M:get_resolution()
  if Util.is_client_only() then
    return Quality_Cfg.RESOLUTION.VERY_HIGH
  end
  if self.v_local_setting_info and self.v_local_setting_info.resolution ~= nil then
    if self.v_local_setting_info.resolution == Quality_Cfg.QUALITY.LOW then
      return Quality_Cfg.RESOLUTION.LOW
    elseif self.v_local_setting_info.resolution == Quality_Cfg.QUALITY.MIDDLE then
      return Quality_Cfg.RESOLUTION.MIDDLE
    elseif self.v_local_setting_info.resolution == Quality_Cfg.QUALITY.HIGH then
      return Quality_Cfg.RESOLUTION.HIGH
    elseif self.v_local_setting_info.resolution == Quality_Cfg.QUALITY.VERY_HIGH then
      return Quality_Cfg.RESOLUTION.VERY_HIGH
    end
  end
  return Quality_Cfg.RESOLUTION.MIDDLE
end

function M:set_indicator_attach_target_enable(data)
  self.v_setting_info.indicator_attach_target_enable = data
end

function M:get_indicator_attach_target_enable()
  return self.v_setting_info and self.v_setting_info.indicator_attach_target_enable or SETTING.INDICATOR_ATTACH_TARGET.ON
end

function M:set_auto_trigger_qte_on_role_out(data)
  self.v_setting_info.auto_trigger_qte_on_role_out = data
end

function M:get_auto_trigger_qte_on_role_out()
  return self.v_setting_info and self.v_setting_info.auto_trigger_qte_on_role_out or SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.ONLY_LINK
end

function M:copy_ui_layout_list(ui_list)
  local copy_list = {}
  for ui_name, data in pairs(ui_list) do
    copy_list[ui_name] = copy_list[ui_name] or {}
    for data_key in pairs(Fight_Layout_Cfg.layout_data_key) do
      if data[data_key] then
        copy_list[ui_name][data_key] = data[data_key]
      end
    end
  end
  return copy_list
end

function M:set_is_login_saved(value)
  is_login_saved = value
end

function M:get_is_login_saved()
  return is_login_saved
end

function M:set_start_drag_ratio(data)
  self.v_setting_info.start_drag_ratio = data
  MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHANGE)
end

function M:get_start_drag_ratio()
  local start_drag_ratio = (self.v_setting_info and self.v_setting_info.start_drag_ratio or 0) / 10
  local min_num = ShareRes.get_comm_value("IndicatorStartMinRatio")
  local max_num = ShareRes.get_comm_value("IndicatorStartMaxRatio")
  local dif = max_num - min_num
  return min_num + start_drag_ratio * dif
end

do
  local function show_notification_change_msg(type, is_on)
    local is_on_str = is_on and "开启" or "关闭"
    
    local tip_content = string.format("%s%s: [Glohow] %s %s %s", is_on_str, Setting_Cfg.NOTIFICATION_TYPE_NAME[type], Date.get_time_year_month_day(Date.now()), is_on_str, Setting_Cfg.NOTIFICATION_TYPE_NAME[type])
    Util.show_banner_tip(tip_content)
  end
  
  function M:set_all_notification(is_on)
    local old_value = self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.ALL]
    local new_value = is_on and 1 or 0
    self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.ALL] = new_value
    if old_value ~= new_value then
      show_notification_change_msg(Setting_Cfg.NOTIFICATION_TYPE.ALL, is_on)
      self:set_night_notification(false, true)
    end
    if is_on then
      SDKManager:request_notification_permission()
    end
  end
  
  function M:get_all_notification_enabled()
    return self.v_local_setting_info and 1 == self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.ALL]
  end
  
  function M:set_game_notification(is_on, is_skip_tip)
    local old_value = self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.GAME]
    local new_value = is_on and 1 or 0
    self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.GAME] = new_value
    if old_value ~= new_value and not is_skip_tip then
      show_notification_change_msg(Setting_Cfg.NOTIFICATION_TYPE.GAME, is_on)
    end
  end
  
  function M:get_game_notification_enabled()
    return self.v_local_setting_info and 1 == self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.GAME]
  end
  
  function M:set_notice_notification(is_on, is_skip_tip)
    local old_value = self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NOTICE]
    local new_value = is_on and 1 or 0
    self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NOTICE] = new_value
    if old_value ~= new_value and not is_skip_tip then
      show_notification_change_msg(Setting_Cfg.NOTIFICATION_TYPE.NOTICE, is_on)
      self:set_night_notification(false, true)
    end
  end
  
  function M:get_notice_notification_enabled()
    return self.v_local_setting_info and 1 == self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NOTICE]
  end
  
  function M:set_night_notification(is_on, is_skip_tip)
    local old_value = self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NIGHT]
    local new_value = is_on and 1 or 0
    self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NIGHT] = new_value
    if old_value ~= new_value and not is_skip_tip then
      show_notification_change_msg(Setting_Cfg.NOTIFICATION_TYPE.NIGHT, is_on)
    end
    SDKManager:set_remote_push(self:get_notice_notification_enabled(), is_on)
    MsgGame:mq_publish2(Const.MSG_ON_NOTIFICATION_SETTING_CHANGE)
  end
  
  function M:get_night_notification_enabled()
    return self.v_local_setting_info and 1 == self.v_local_setting_info[Setting_Cfg.NOTIFICATION_TYPE.NIGHT]
  end
end

function M:get_show_language_list(language_type)
  if language_type == Config.CommonDefine.LANGUAGE_TYPE.Text then
    if not self.v_text_show_language_list then
      local list = CS.GameToLua.CheckUpdate.GetSDKShowLanguageList(language_type)
      self.v_text_show_language_list = {}
      for i = 0, list.Count - 1 do
        table.insert(self.v_text_show_language_list, list[i])
      end
    end
    return self.v_text_show_language_list
  elseif language_type == Config.CommonDefine.LANGUAGE_TYPE.Voice then
    if not self.v_voice_show_language_list then
      local list = CS.GameToLua.CheckUpdate.GetSDKShowLanguageList(language_type)
      self.v_voice_show_language_list = {}
      for i = 0, list.Count - 1 do
        table.insert(self.v_voice_show_language_list, list[i])
      end
    end
    return self.v_voice_show_language_list
  elseif language_type == Config.CommonDefine.LANGUAGE_TYPE.Story then
    if not self.v_story_voice_show_language_list then
      local list = CS.GameToLua.CheckUpdate.GetSDKShowLanguageList(language_type)
      self.v_story_voice_show_language_list = {}
      for i = 0, list.Count - 1 do
        table.insert(self.v_story_voice_show_language_list, list[i])
      end
    end
    return self.v_story_voice_show_language_list
  end
end

function M:set_gpg_button_show(is_on)
  local new_value = is_on and 1 or 0
  self.v_local_setting_info.gpg_button_show = new_value
end

function M:get_gpg_button_show()
  return self.v_local_setting_info and 1 == self.v_local_setting_info.gpg_button_show
end

function M:set_gpg_custom_button(btn_key, key_code)
  self.v_local_setting_info[btn_key] = key_code
end

function M:get_gpg_custom_button(btn_key)
  return self.v_local_setting_info and self.v_local_setting_info[btn_key]
end

function M:init_keyboard_setting()
  for _, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local btn_key = t.key
    if self.v_local_setting_info[btn_key] then
      TouchManager.Instance:AddKeyListener(self.v_local_setting_info[btn_key])
    end
  end
  self:_update_input_setting()
end

function M:save_keyboard_setting()
  local all_local_setting_info = BattleSettingMgr:load_local_setting_info()
  local previous_local_setting_info = (all_local_setting_info or E)[Global.player_uuid]
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  for _, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local key = t.key
    local old_keycode = previous_local_setting_info and previous_local_setting_info[key] or nil
    local new_keycode = local_setting_info[key]
    if old_keycode ~= new_keycode then
      TouchManager.Instance:AddKeyListener(new_keycode)
    end
  end
  self:_update_input_setting()
end

function M:_update_input_setting()
  self:_update_arrow_key()
  self:_update_input_map()
  MsgGame:mq_publish2(Const.MSG_UPDATE_INPUT_SETTING)
end

function M:_update_arrow_key()
  local w = self.v_local_setting_info[Setting_Cfg.BTNNAME_INFO.ButtonForward.key]
  local a = self.v_local_setting_info[Setting_Cfg.BTNNAME_INFO.ButtonLeft.key]
  local s = self.v_local_setting_info[Setting_Cfg.BTNNAME_INFO.ButtonBackward.key]
  local d = self.v_local_setting_info[Setting_Cfg.BTNNAME_INFO.ButtonRight.key]
  TouchManager.Instance:SetArrowKey(w, a, s, d)
end

function M:_update_input_map()
  UtilTable.clear_map(self.v_keycode_inputcode_map)
  for _, t in pairs(Setting_Cfg.BTNNAME_INFO) do
    local key_code_int = self.v_local_setting_info[t.key]
    if 0 ~= key_code_int then
      self.v_keycode_inputcode_map[UnityEngine.KeyCode.__CastFrom(key_code_int)] = t.input_code
    end
  end
end

function M:get_keycode_inputcode_map()
  return self.v_keycode_inputcode_map
end

function M:keycode_to_string(integer)
  if Setting_Cfg.KEYCODE_TO_STRING_MAP[integer] then
    return Setting_Cfg.KEYCODE_TO_STRING_MAP[integer]
  end
  local keycode = tostring(KEYCODE.__CastFrom(integer))
  local index = string.find(keycode, ":")
  return string.sub(keycode, 1, index - 1)
end

return M
