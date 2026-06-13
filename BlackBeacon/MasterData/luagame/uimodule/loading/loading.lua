local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _ceil = math.ceil
local LIFE_TIME = ShareRes.get_comm_value("LoadingTime") or 0.5
local MODEL = {}
local bird_obj_list = {}
local loading_list_cfg = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_load_scene_mod = Global.gamemode:get_load_scene_mode()
  bird_obj_list = {}
  self.timeline_in = self.v_uiobjects.UILoading1_IN
  self.timeline_loop = self.v_uiobjects.UILoading1_Loop
  self.timeline_out = self.v_uiobjects.UILoading1_Out
  self.black = self.v_uiobjects.Black
  local data_table = ShareRes.get_comm_string_value("LoadingAnimation")
  self.total_weight = 0
  if data_table then
    for i, v in ipairs(data_table) do
      local obj_name = Util.get_child_gameobj("Loading/Bird/" .. v[1], self.v_object)
      local obj_weight = tonumber(v[2])
      local data = {}
      data.obj_name = obj_name
      data.obj_weight = obj_weight
      self.total_weight = self.total_weight + obj_weight
      bird_obj_list[#bird_obj_list + 1] = data
    end
  end
  self.v_cg = self:get_canvas_group()
end

function ui:set_timeline_visible(value)
  self.timeline_in:SetActive(value)
  self.timeline_loop:SetActive(value)
end

function ui:cache_hide_ui()
  return false
end

local last_tips_type

function ui:ui_on_show()
  self.v_cg.alpha = 1
  self.black:SetActive(false)
  self:set_timeline_visible(true)
  local index = self:get_random_index()
  for i, v in pairs(bird_obj_list) do
    v.obj_name:SetActive(index == i)
  end
  if Global.sound_mgr then
    local SOURCE_TYPE = Config.SOURCE_TYPE
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE", 0)
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.BGM2, "BGM", 0)
    Global.sound_mgr:bgm_stop()
    Global.sound_mgr:bgm2_stop()
  end
  local show_tips
  local fight_type = TowerMgr and TowerMgr:get_fight_type()
  fight_type = self.v_ignore_fight_type_trigger and 0 or fight_type
  self.v_ignore_fight_type_trigger = nil
  local tips_type
  if not fight_type or 0 == fight_type then
    tips_type = last_tips_type and last_tips_type or 0
    last_tips_type = nil
  else
    tips_type = fight_type
    last_tips_type = fight_type
  end
  local temp_loading_list_cfg = ShareRes.get_loading_tips_cfg(tips_type)
  temp_loading_list_cfg = temp_loading_list_cfg or ShareRes.get_loading_tips_cfg(0)
  UtilTable.clear_list(loading_list_cfg)
  if not Util.is_client_only() then
    for _, cfg in ipairs(temp_loading_list_cfg) do
      local is_achieve = Condition:check_condition(cfg.Condition, false)
      if is_achieve then
        table.insert(loading_list_cfg, cfg)
      end
    end
  end
  UtilTable.random_sort_list(loading_list_cfg)
  local tips_group_cfg = ShareRes.get_loading_tips_group_cfg(tips_type)
  local pick_count = tips_group_cfg and tips_group_cfg.PickCount or 0
  if pick_count > 0 then
    local default_tips = ShareRes.get_loading_tips_cfg(0)
    local copy_table = UtilTable.copy_table(default_tips)
    UtilTable.random_sort_list(copy_table)
    local insert_count = 0
    for i = 1, #copy_table do
      if pick_count <= insert_count then
        break
      end
      local cfg = copy_table[i]
      local is_achieve = Condition:check_condition(cfg.Condition, false)
      if is_achieve then
        table.insert(loading_list_cfg, cfg)
        insert_count = insert_count + 1
      end
    end
  end
  if #loading_list_cfg > 0 then
    self.v_loading_tips_index = 1
    self:remove_button_listener(self.v_uicompents.Mask_btn)
    self:set_button_listener(self.v_uicompents.Mask_btn, function()
      self:on_click_panel()
    end)
    self:show_tips()
    show_tips = true
  end
  self.v_uiobjects.Title:SetActive(show_tips)
  self.v_uiobjects.Desc:SetActive(show_tips)
end

function ui:get_random_index()
  local random = math.random(1, self.total_weight)
  local weight_sum = 0
  for k, v in pairs(bird_obj_list) do
    weight_sum = weight_sum + v.obj_weight
    if random <= weight_sum then
      return k
    end
  end
  return 1
end

function ui:ui_on_destroy()
  bird_obj_list = nil
  if self.v_end_cb_timer then
    Timer:remove_timer(self.v_end_cb_timer)
    self.v_end_cb_timer = nil
  end
end

function ui:ui_on_hide()
  if Global.sound_mgr then
    local SOURCE_TYPE = Config.SOURCE_TYPE
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE")
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.BGM2, "BGM")
  end
  self.v_fade_out_duration = nil
  self.v_fade_out_time = nil
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if self.v_sequence_left then
    self.v_sequence_left:Kill(false)
    self.v_sequence_left = nil
  end
  if self.v_sequence_right then
    self.v_sequence_right:Kill(false)
    self.v_sequence_right = nil
  end
  if self.v_time_index then
    Timer:remove_timer(self.v_time_index)
    self.v_time_index = nil
  end
  if self.v_effect_timer then
    Timer:remove_timer(self.v_effect_timer)
    self.v_effect_timer = nil
  end
  self.v_end = nil
  MsgGame:mq_publish2(Const.MSG_LOADING_HIDE)
  if not UNITY_EDITOR and Config.Watermark then
    UIMgr:get_ui("fly_mark_main"):ui_show()
  end
  if UIMgr then
    UIMgr:open_default_ui(false)
  end
  self:set_timeline_visible(true)
  if not self.v_show_time then
    local tower = TowerMgr and TowerMgr:get_tower()
    local story_id = StoryMgr:get_cur_play_story_id()
    if tower and not StoryMgr:check_story_has_tiem_line(story_id) then
      SceneMgr:set_curtain_show(true)
    end
  end
  self.v_show_time = nil
end

function ui:set_bg_active(param)
end

function ui:show_progress()
  self.v_uiobjects.Progress:SetActive(true)
  self.v_uiobjects.LoadingSliderL:SetActive(true)
  self.v_uiobjects.LoadingSliderR:SetActive(true)
end

function ui:on_click_panel()
  self.v_loading_tips_index = self.v_loading_tips_index + 1
  self.v_loading_tips_index = self.v_loading_tips_index > #loading_list_cfg and 1 or self.v_loading_tips_index
  self:show_tips()
end

function ui:show_tips()
  self.v_uicompents.Title_txt.text = loading_list_cfg[self.v_loading_tips_index].Title
  self.v_uicompents.Desc_txt.text = loading_list_cfg[self.v_loading_tips_index].Content
end

function ui:ui_update(delta_time)
  self:update_progress(delta_time)
end

function ui:update_progress(delta_time)
  if delta_time and self:update_show_time(delta_time) then
    return
  end
  local tower = TowerMgr and TowerMgr:get_tower()
  local is_loading_finish = self.v_load_scene_mod:get_is_loading_finish()
  local is_in_preload = tower and tower:is_in_room_preload()
  if not (not is_loading_finish or is_in_preload) or self.v_show_time then
    if not self.v_end then
      self:load_end_effct()
    end
  elseif self.v_end then
    self.v_end = false
    if self.v_effect_timer then
      Timer:remove_timer(self.v_effect_timer)
      self.v_effect_timer = nil
    end
  end
end

function ui:update_show_time(delta_time)
  if self.v_show_time and self.v_fade_out_duration and self.v_fade_out_time then
    self.v_show_time = self.v_show_time - delta_time
    if self.v_fade_out_duration >= self.v_show_time then
      self.v_fade_out_time = math.max(self.v_fade_out_time - delta_time, 0)
      local percent = self.v_fade_out_time / self.v_fade_out_duration
      self.v_cg.alpha = percent
    end
    if self.v_show_time > 0 then
      return true
    end
  end
  return false
end

function ui:load_end(end_back)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if self.v_sequence_left then
    self.v_sequence_left:Kill(false)
    self.v_sequence_left = nil
  end
  if self.v_sequence_right then
    self.v_sequence_right:Kill(false)
    self.v_sequence_right = nil
  end
  if self.v_time_index then
    Timer:remove_timer(self.v_time_index)
    self.v_time_index = nil
  end
  self.v_end_cb = end_back
  self.v_end_cb_timer = Timer:add_timer("v_end_cb", 0.3, function()
    if self.v_end_cb then
      self.v_end_cb()
      self.v_end_cb = nil
    end
  end)
end

function ui:load_end_effct()
  self.v_end = true
  self.black:SetActive(true)
  self.timeline_out:SetActive(true)
  Global.ui_mgr:try_hide_ui("loading")
end

function ui:open_testing_time()
  if self.v_time_index then
    Timer:remove_timer(self.v_time_index)
    self.v_time_index = nil
  end
  self.v_time_index = Timer:add_timer("loading.open_testing_time", 20, function()
    Log.Error("进度加载异常")
  end)
end

function ui:update_text(str)
end

function ui:set_loading_show_time(show_time, fade_out_time)
  self.v_show_time = show_time
  self.v_fade_out_duration = fade_out_time
  self.v_fade_out_time = fade_out_time
end

function ui:ignore_fight_type_trigger()
  self.v_ignore_fight_type_trigger = true
end

return ui
