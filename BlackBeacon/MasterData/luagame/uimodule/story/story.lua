local SOUND_STATUS = Config.SOUND_STATUS
local SOURCE_TYPE = Config.SOURCE_TYPE
local Behavior = require("manager.fight.behavior")
local UnityTime = UnityEngine.Time
local EffectStatus = TypeEffectStatus
local TypeSimpleNodeRef = typeof(CS.Game.SimpleNodeRef)
local CriManaMovieControllerForUI = typeof(CS.CriWare.CriManaMovieControllerForUI)
local STORY_CONFIG = require("uimodule.story.story_config")
local STEP_TYPE = STORY_CONFIG.STEP_TYPE
local STEP_LUA_PATH = STORY_CONFIG.STEP_LUA_PATH
local CommonDefine = require("cs_share.common_define")
local SHOW_FIGHT_UI = STORY_CONFIG.SHOW_FIGHT_UI
local NO_SPEED_CHANGE = STORY_CONFIG.NO_SPEED_CHANGE
local STEP_PLAY_TYPE = STORY_CONFIG.STEP_PLAY_TYPE
local BRANCH_NUM = STORY_CONFIG.BRANCH_NUM
local SPECIAL_STRING_FUN = STORY_CONFIG.SPECIAL_STRING_FUN
local UnityRawImage = UnityEngine.UI.RawImage
local Ease = CS.DG.Tweening.Ease
local INPUT_CODE = Config.INPUT_CODE
local CSUnityColor = UnityEngine.Color
local STORY_BG_TALK_KEY = "STORY_BG_TALK_KEY"
local CUR_STEP_ID = 1
local BRANCH_STEP_ID, CUR_USE_BG_LAYER
local BIND_TYPE = Config.BIND_TYPE
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local Vec3 = require("base.vec3")
local CSKeyCode = UnityEngine.KeyCode
local Math = require("base.mathx")
local _clamp = Math.Clamp
local _insert = table.insert
local _sort = table.sort
local _tremove = table.remove
local _find = string.find
local _gsub = string.gsub
local UP_SPEED = STORY_CONFIG.UP_SPEED
local SPEED_DEFAULT = STORY_CONFIG.SPEED_DEFAULT
local _tinsert = table.insert
local DESIGN_RATIO = 1.7777777777777777
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local is_video_skip_show = false
local STORY_SPEED = {
  [1] = 1,
  [2] = 1.5,
  [3] = 2
}
local GEN_CRI_SOURCE_TYPE = {COMMON_AUDIO = 1, TIMELINE_AUDIO = 2}
local SHAKE_STYLE = {
  DEFAULT = 0,
  LOW_SHAKE = 1,
  MID_SHAKE = 2,
  HIGH_SHAKE = 3
}
local SOURCE_TYPE = Config.SOURCE_TYPE

function ui:ui_finish_load()
  self:init_event()
  self:register_exist_auto_template(STORY_BG_TALK_KEY, self.v_uiobjects.TalkTem, self.v_uiobjects.TalkList)
  self.v_cur_story_speed_idx = StoryMgr.story_speed_idx
  self.v_story_speed = STORY_SPEED[self.v_cur_story_speed_idx]
  self.v_cache_is_auto = false
  self.v_shake_low_eff = self.v_uicompents.Ani_St_Shake_L_pd
  self.v_shake_mid_eff = self.v_uicompents.Ani_St_Shake_M_pd
  self.v_shake_high_eff = self.v_uicompents.Ani_St_Shake_H_pd
  self.v_shake_end_eff_L = self.v_uicompents.Ani_St_Shake_End_L_pd
  self.v_shake_end_eff_M = self.v_uicompents.Ani_St_Shake_End_M_pd
  self.v_shake_end_eff_H = self.v_uicompents.Ani_St_Shake_End_H_pd
  self.v_shake_low_eff.enabled = false
  self.v_shake_mid_eff.enabled = false
  self.v_shake_high_eff.enabled = false
  self.v_shake_end_eff_L.enabled = false
  self.v_shake_end_eff_M.enabled = false
  self.v_shake_end_eff_H.enabled = false
  self.v_shake_low_eff.gameObject:SetActive(true)
  self.v_shake_mid_eff.gameObject:SetActive(true)
  self.v_shake_high_eff.gameObject:SetActive(true)
  self.v_shake_end_eff_L.gameObject:SetActive(true)
  self.v_shake_end_eff_M.gameObject:SetActive(true)
  self.v_shake_end_eff_H.gameObject:SetActive(true)
end

function ui:init_event()
  for index = 1, BRANCH_NUM do
    self:set_button("BranchBtn" .. index, function()
      self:click_branch(index)
    end)
  end
  self:set_button("Hide", function()
    self:click_hide_btn()
  end)
  self:set_button("Auto", function()
    self:click_auto_btn()
  end)
  
  local function on_button_down()
    self:click_btn(true)
  end
  
  local function on_button_up()
    self:click_btn(false)
  end
  
  local btn = self:get_uiobject("BgBtn", BIND_TYPE.BUTTON_EX)
  self:set_button_ex_listener(btn, on_button_down, on_button_up, nil, nil)
  self:set_button("Skip", function()
    self:click_skip_btn()
  end)
  self:set_button("SkipConfirm", function()
    self:click_skip_confirm_btn()
  end)
  self:set_button("SkipCancel", function()
    self:click_skip_cancel_btn()
  end)
  self:set_button("ReviewBtn", function()
    self:click_review_btn()
  end)
  self:set_button("KeyWord", function()
    self:open_world_dic_ui()
  end)
  self:set_button("AutoSpeed", function()
    self.v_cur_story_speed_idx = self.v_cur_story_speed_idx + 1
    if self.v_cur_story_speed_idx > #STORY_SPEED then
      self.v_cur_story_speed_idx = 1
    end
    StoryMgr.story_speed_idx = self.v_cur_story_speed_idx
    local cur_speed = STORY_SPEED[self.v_cur_story_speed_idx]
    self:set_story_speed(cur_speed)
    self:set_story_speed_view(cur_speed, self.v_cur_story_speed_idx)
  end)
end

function ui:stop_auto_play(is_click_skip)
  if self.v_is_auto then
    self:click_auto_btn(is_click_skip)
  end
  self:clear_timer()
end

function ui:set_story_speed_view(cur_speed)
  if not self:visible() then
    return
  end
  self.v_uicompents.AutoSpeed_txt.text = "X" .. cur_speed
  local cur_speed_idx = self.v_cur_story_speed_idx
  for idx, _ in pairs(STORY_SPEED) do
    self.v_uiobjects["Speed" .. idx]:SetActive(idx == cur_speed_idx)
  end
end

function ui:reset_story_speed()
  self.v_cur_story_speed_idx = 1
  self.v_story_speed = 1
  self:set_story_speed_view(1)
  if Global.sound_mgr then
    Global.sound_mgr:change_story_sound_speed(self.v_story_speed, SOURCE_TYPE.VOICE)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_STORY_SPEED)
  msg.mm_obj = 1
end

function ui:set_story_speed(cur_speed)
  for type, data in pairs(self.v_step_map) do
    if not data.is_complete and not NO_SPEED_CHANGE[type] then
      data.lua_obj:set_speed(cur_speed)
    end
  end
  self.v_story_speed = cur_speed
  self:change_sequence_speed(cur_speed)
  if Global.sound_mgr then
    Global.sound_mgr:change_story_sound_speed(self.v_story_speed, SOURCE_TYPE.VOICE)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_STORY_SPEED)
  msg.mm_obj = cur_speed
end

function ui:refresh_story_speed_view(curr_speed)
  for index, speed in ipairs(STORY_SPEED) do
    if curr_speed == speed then
      self.v_cur_story_speed_idx = index
      break
    end
  end
  self:set_story_speed_view(curr_speed)
end

function ui:click_hide_btn()
  if not self:check_click_effect() then
    return
  end
  self.v_uiobjects.Up:SetActive(false)
  self.v_uiobjects.Talk:GetComponent("CanvasGroup").alpha = 0
  self.v_uiobjects.FightTalk:GetComponent("CanvasGroup").alpha = 0
  self.v_is_hide_up = true
  self:stop_auto_play()
end

function ui:click_branch(index)
  local branch_data = self.v_step_map[STEP_TYPE.BRANCH] or self.v_step_map[STEP_TYPE.FIGHT_BRANCH] or self.v_step_map[STEP_TYPE.NO_BRANCH]
  Util.assert(branch_data, "branch_lua is nil", self.v_step_map)
  local branch_lua = branch_data.lua_obj
  branch_lua:click_branch(index)
end

function ui:click_review_btn()
  if not self:check_click_effect() then
    return
  end
  self:stop_auto_play()
  local review_pnl = self:get_panel("story_review")
  
  local function cb()
    self.v_uiobjects.Up:SetActive(true)
  end
  
  review_pnl:set_enable(true, cb)
  self.v_uiobjects.Up:SetActive(false)
end

function ui:click_skip_btn()
  if self:check_story_write_name() then
    self.v_uicompents.Skip_btn.enabled = false
    return
  end
  if 0 ~= self:check_must_select_step() then
    return
  end
  self:stop_auto_play(true)
  self.v_uiobjects.Tips_skip:SetActive(true)
  self.v_showing_skip = true
  StoryMgr:update_curr_step_is_showing_skip(true)
end

function ui:reset_skip_btn()
  self.v_uicompents.Skip_btn.enabled = true
end

function ui:check_story_write_name()
  local write_name_id = self.v_story_cfg.WriteNameStepId
  if not write_name_id or 0 == write_name_id then
    return false
  end
  if write_name_id <= CUR_STEP_ID then
    return false
  end
  self:end_step(write_name_id)
  return true
end

function ui:check_must_select_step()
  local must_select_step = self.v_story_cfg.MustSelectStep
  if not must_select_step or 0 == must_select_step then
    return 0
  end
  if must_select_step <= CUR_STEP_ID then
    return 0
  end
  local tips = "当前对话存在交互选项，是否跳转到相应步骤？"
  
  local function confirm_cb()
    self:end_step(must_select_step)
    return 1
  end
  
  local function cancel_cb()
    return 2
  end
  
  Util.show_notify_popup_message(confirm_cb, tips, nil, nil, nil, cancel_cb, false)
end

function ui:refresh_role_event_type()
  if not self.role_event_type then
    local role_event_step = self.v_story_cfg.RoleEventStep
    if role_event_step and role_event_step > 0 and role_event_step == CUR_STEP_ID then
      local must_select_step_cfg = self.v_story_step_cfg[role_event_step]
      self.role_event_type = must_select_step_cfg.SpecialEventType
    end
  end
end

function ui:get_curr_step_is_can_skip()
  self:refresh_role_event_type()
  local must_select_step = self.v_story_cfg.MustSelectStep
  if not must_select_step or 0 == must_select_step then
    return true
  end
  return CUR_STEP_ID ~= must_select_step
end

function ui:refresh_skip_btn_visible()
  self.v_uiobjects.Skip.gameObject:SetActive(self:get_curr_step_is_can_skip())
end

function ui:click_skip_confirm_btn()
  self.v_uiobjects.Tips_skip:SetActive(false)
  self:play_story_end_anim(nil, true)
  self:stop_all_sound()
  StoryMgr:update_curr_step_is_showing_skip(false)
end

function ui:click_auto_btn(is_click_skip)
  if not self:check_click_effect() then
    return
  end
  self.v_cache_is_auto = is_click_skip and self.v_is_auto or false
  self.v_is_auto = not self.v_is_auto
  StoryMgr.story_is_auto = is_click_skip and StoryMgr.story_is_auto or self.v_is_auto
  self.v_uiobjects.Auto_off:SetActive(self.v_is_auto)
  self.v_uiobjects.Auto_on:SetActive(not self.v_is_auto)
  if self.v_is_auto then
    self:set_story_speed_view(1)
  end
  for _, data in pairs(self.v_step_map) do
    if not data.is_complete then
      data.lua_obj:click_auto_btn()
    end
  end
  if self.v_is_auto and not self:check_is_playing_voice() then
    self:check_step_all_complete()
  end
end

function ui:check_auto()
  return self.v_is_auto
end

function ui:check_is_playing_voice()
  local is_playing = Global.sound_mgr:check_source_play_status(SOUND_STATUS.PLAYING, SOURCE_TYPE.VOICE, nil)
  return is_playing
end

function ui:before_play_story()
  self.v_is_delay_destroy = nil
  self.v_is_settle_story = nil
  self.v_is_play_next_story = nil
  self.role_event_type = nil
  self.v_uiobjects.DestroyBg:SetActiveEx(false)
  self.v_uiobjects.ExtraBgObj:SetActive(false)
  self.v_uiobjects.ExtraBgMask:SetActive(false)
end

function ui:ui_before_show(story_id, GM_Story_cfg, GM_step_id, GM_story_id, close_up_column, no_skip_story, finish_cb)
  if not GM_Story_cfg then
    StoryMgr:on_story_ui_before_show(story_id)
  end
end

function ui:ui_on_show(story_id, GM_Story_cfg, GM_step_id, GM_story_id, close_up_column, no_skip_story, finish_cb)
  self.finish_cb = finish_cb
  self:before_play_story()
  UIMgr:try_hide_ui("ui_click_effect")
  if SceneMgr:check_main_scene() and not UIMgr:try_get_visible_ui("ui_guide") and not JourneyEventMgr:get_is_need_run_force_journey_event() then
    Global.sound_mgr:clear_bgm_on_story_play()
    Global.sound_mgr:set_stop_switch_ui_sound(true)
    Global.sound_mgr:bgm_stop()
    Global.sound_mgr:bgm2_stop()
  end
  self.v_uiobjects.ExtraBgObj:SetActive(false)
  self.v_uiobjects.ExtraBgMask:SetActive(false)
  self:init_story_cfg(story_id, GM_Story_cfg, GM_step_id, GM_story_id)
  no_skip_story = no_skip_story or self.v_story_cfg.CannotSkip
  self.v_uiobjects.SkipUp:SetActive(not no_skip_story)
  self.v_uiobjects.UpCollect:SetActive(not close_up_column)
  Util.assert(self.v_story_cfg, "story_cfg is nil", story_id)
  if StoryMgr then
    StoryMgr:set_cur_story_id(story_id or GM_story_id)
  end
  self:init_data()
  if self.v_story_cfg.HideMainUI then
    local uimain = UIMgr:try_get_ui("uimain")
    if uimain then
      uimain:ui_fade_out_anim()
    end
  end
  if GM_step_id and GM_step_id > 0 then
    CUR_STEP_ID = GM_step_id or 1
  end
  self:init_ui()
  self:go_step()
  if Global.is_skip_story then
    self:click_skip_confirm_btn()
  end
  if self:is_captions_talk_data() then
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE")
  else
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE", 0)
  end
  if Global.scene_mgr:get_scene_name() == "Main" then
    UIMgr:set_default_camera_obj_visible(true)
  end
  if not self:is_captions_talk_data() and not self.v_story_cfg.HoldOnSceneAudio then
    Global.sound_mgr:set_audio_active(false, true)
  end
  self:set_story_speed(self.v_story_speed)
  self:set_story_speed_view(self.v_story_speed, self.v_cur_story_speed_idx)
  if StoryMgr.story_is_auto then
    self:click_auto_btn()
  end
  self:register_event()
  self.v_uicompents.Subtitles_txt.text = ""
  local is_show_key = UNITY_EDITOR or SDKManager:is_google_play_games() or UNITY_STANDALONE_WIN
  local local_setting_info = BattleSettingMgr:get_local_setting_info()
  local setting_value = 1 == local_setting_info.gpg_button_show
  self.v_uiobjects.PCTouch1:SetActive(is_show_key and setting_value)
  self.v_uiobjects.PCTouchC:SetActive(is_show_key and setting_value)
  self.v_uiobjects.PCCancel:SetActive(is_show_key and setting_value)
  self.v_uiobjects.PCSkipC:SetActive(is_show_key and setting_value)
  if is_show_key then
    self:bind_auto_mq(Const.MSG_KEY_DOWN, self._response_key_down, self)
    self:bind_auto_mq(Const.MSG_KEY_UP, self._response_key_up, self)
  end
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CRI_VIDEO_SUBTITLE_UPDATE, self.on_subtitle_refresh, self)
end

function ui:on_subtitle_refresh(msg)
  self.v_uicompents.Subtitles_txt.text = msg.mm_x
end

function ui:init_story_cfg(story_id, GM_Story_cfg, GM_step_id, GM_story_id)
  self.v_story_id = story_id
  self.v_is_gm_play = nil
  if story_id then
    local path = "story." .. story_id
    local story_cfg = ShareRes.create(path)
    self.v_story_cfg = story_cfg
    self.v_story_step_cfg = story_cfg.Steps
  elseif GM_Story_cfg then
    self.v_story_cfg = GM_Story_cfg
    self.v_story_step_cfg = GM_Story_cfg.Steps
    self.v_GM_story_id = GM_story_id
    self.v_is_gm_play = true
  end
  self.v_jump_to_step_map = self:collect_story_jump_step()
  LuaCfgFieldMgr:configure_defaults(self.v_story_cfg, nil, {select_story_cfg = true})
  self:preload_story_res(self.v_story_cfg)
  if self.v_story_cfg.PauseSceneAudio then
    Global.sound_mgr:pause_gen_source(true, GEN_CRI_SOURCE_TYPE.COMMON_AUDIO, nil, true)
  end
  if self.v_story_cfg.PauseTimeLineAudio then
    Global.sound_mgr:pause_gen_source(true, GEN_CRI_SOURCE_TYPE.TIMELINE_AUDIO, nil, true)
  end
end

function ui:preload_story_res(story_cfg)
  if not story_cfg then
    return
  end
  if not story_cfg.Steps then
    return
  end
  local story_steps = story_cfg.Steps
  local temp_img = self.v_uicompents.BlackBg_img
  local preload_record = {}
  for _, step_cfg_temp in pairs(story_steps) do
    if step_cfg_temp.Background and step_cfg_temp.Background.Image and not step_cfg_temp.Background.IsUseSpine and not preload_record[step_cfg_temp.Background.Image] then
      preload_record[step_cfg_temp.Background.Image] = true
      ResMgr:load_set_icon(temp_img, step_cfg_temp.Background.Image, function(temp_img_param)
        temp_img_param.overrideSprite = nil
      end, true, self)
    end
  end
end

function ui:collect_story_jump_step()
  if not self.v_story_step_cfg or not next(self.v_story_step_cfg) then
    return {}
  end
  local jump_to_step_map = {}
  for index, step_cfg in ipairs(self.v_story_step_cfg) do
    if step_cfg.JumpId then
      if jump_to_step_map[step_cfg.JumpId] then
        Log.Error("剧情步骤的跳转id发生重复，剧情id:%s,步骤:%s和%s", self.v_story_id, jump_to_step_map[step_cfg.JumpId], index)
      else
        jump_to_step_map[step_cfg.JumpId] = index
      end
    end
  end
  return jump_to_step_map
end

function ui:get_jump_step_idx(jump_id)
  return self.v_jump_to_step_map[jump_id] or jump_id
end

function ui:stop_story()
  self:clear()
  self.v_wait_play_id_list = {}
  self:play_story_end_anim()
end

local function _play_next_story(self, story_id)
  local pre_story_id = self.v_story_id
  local cur_story_cfg = self.v_story_step_cfg
  self:init_story_cfg(story_id)
  Util.assert(self.v_story_cfg, "story_cfg is nil", story_id)
  self:clear(pre_story_id == story_id, cur_story_cfg)
  self.v_is_play_next_story = story_id
  if StoryMgr then
    StoryMgr:set_cur_story_id(story_id)
  end
  self:init_data()
  self:init_ui()
  self:go_step()
end

function ui:play_next(story_id, next_no_anim, no_skip_story)
  self:before_play_story()
  if self:can_be_break() then
    self.v_wait_play_id_list = {}
    if next_no_anim then
      _play_next_story(self, story_id)
    else
      _tinsert(self.v_wait_play_id_list, story_id)
      self:play_story_end_anim(function()
        _play_next_story(self, story_id)
      end)
    end
  else
    _tinsert(self.v_wait_play_id_list, story_id)
  end
  if self.v_story_cfg and not no_skip_story then
    no_skip_story = self.v_story_cfg.CannotSkip
  end
  self.v_uiobjects.SkipUp:SetActive(not no_skip_story)
end

function ui:insert_wait_play_story(story_id)
  _tinsert(self.v_wait_play_id_list, story_id)
end

function ui:remove_wait_id_list(story_id)
  for index = #self.v_wait_play_id_list, 1, -1 do
    if self.v_wait_play_id_list[index] == story_id then
      _tremove(self.v_wait_play_id_list, index)
      break
    end
  end
end

function ui:can_be_break()
  Util.assert(self.v_story_cfg, "缺少剧情配置，剧情id = " .. self.v_story_id)
  return not self.v_story_cfg.IsWaitForEnd
end

function ui:init_ui()
  local story_id = self.v_story_id or self.v_GM_story_id
  if story_id then
    local story_info_cfg = ShareRes.create("story.story_info", story_id)
    if story_info_cfg then
      self.v_uicompents.TipsChapter_txt.text = story_info_cfg.StageName
      self.v_uicompents.TipsStage_txt.text = story_info_cfg.ChapterName
      self.v_uicompents.TipsStory_txt.text = story_info_cfg.StoryContent
      self.v_uicompents.TipsPart_txt.text = story_info_cfg.PartName
    end
  end
  self.v_uiobjects.CharList:SetActive(false)
  self.v_uiobjects.BlackBg:SetActive(false)
  self.v_uiobjects.Tips_skip:SetActive(false)
  self.v_uiobjects.Talk:SetActive(false)
  self.v_uiobjects.Talk_bg:SetActive(false)
  self.v_uiobjects.FightTalk:SetActive(false)
  self.v_uiobjects.CaptionsTalk:SetActive(false)
  self.v_uiobjects.InsertImg:SetActive(false)
  self.v_uiobjects.Auto_off:SetActive(false)
  self.v_uiobjects.Auto_on:SetActive(true)
  self.v_uiobjects.AutoSpeed:SetActive(true)
  self.v_uiobjects.Speed1:SetActive(true)
  self.v_uiobjects.CharHeadBg:SetActive(false)
  self.v_uiobjects.Story_End_Bg:SetActive(false)
  local canvas = self.v_uiobjects.Story_End_Bg:GetComponent("CanvasGroup")
  canvas.alpha = 0
  self.v_uiobjects.Branch_List:SetActive(false)
  self.v_uiobjects.Location:SetActive(false)
  self.v_uiobjects.BgBtn:SetActive(true)
  self.v_Bgbtn_visible = true
  self.v_uiobjects.BgAnim:SetActive(false)
  self.v_uiobjects.ChapterContent:SetActive(false)
  local canvas = self.v_object:GetComponent("CanvasGroup")
  canvas.alpha = 1
  self.v_uiobjects.Video:SetActive(false)
end

function ui:is_video_playing()
  return self.v_uiobjects.Video.activeSelf
end

function ui:init_data()
  self.v_speed_up_time = nil
  self.v_is_speed_up = false
  self.v_cur_step = nil
  self.v_execute_story_end_event = nil
  self.v_has_set_curtain = nil
  self.v_step_map = {}
  self.v_effec_obj_list = {}
  self.v_is_auto = false
  self.v_spine_rt_list = {}
  self.v_layer_data = {}
  self.v_insert_step_map = {}
  self.v_insert_step_list = {}
  self.v_cache_branch_data = {}
  self.v_cache_talk_data = {}
  self.v_bg_spine_rt = {}
  self.v_play_step_type = STEP_PLAY_TYPE.DEFAULT
  CUR_STEP_ID = 1
  BRANCH_STEP_ID = nil
  CUR_USE_BG_LAYER = nil
  self.v_seqence_list = {}
  self.v_wait_play_id_list = {}
  self.v_story_start_time = Global.real_time
  self.v_enable_trace_data = true
  StoryMgr:after_uistory_init_data()
  self.v_story_unlock_dic = {}
  local res_name = self.v_story_cfg.TimelineRes
  if res_name then
    local room = not TowerMgr or TowerMgr:get_cur_room() or TowerMgr:get_story_room()
    if nil ~= room then
      local obj = ResPoolMgr:get_timeline(res_name)
      if nil == obj or obj:IsNull() then
        Log.Error("load timeline failed! ", res_name)
        return
      end
      obj.transform:SetPositionA(0, 0, 0)
      self.v_story_timeline_obj = obj
      self.v_story_timeline_node_ref_com = obj:GetComponent(TypeSimpleNodeRef)
      self.v_story_timeline_step_obj = nil
      TimeLineSeqPlayer.close_camera_transparent = true
    end
  end
end

function ui:get_timeline_node_ref_com()
  return self.v_story_timeline_node_ref_com
end

function ui:next_timeline_step(new_step_obj)
  if self.v_story_timeline_step_obj then
    self.v_story_timeline_step_obj:SetActive(false)
  end
  self.v_story_timeline_step_obj = new_step_obj
  self.v_story_timeline_step_obj:SetActive(true)
end

function ui:get_new_sequence(sequence_key)
  if not sequence_key then
    return
  end
  self:sequence_kill_by_key(sequence_key)
  local sequence = Util.create_sequence()
  self.v_seqence_list[sequence_key] = sequence
  return sequence
end

function ui:sequence_kill_by_key(key)
  if not self.v_seqence_list[key] then
    return
  end
  self.v_seqence_list[key]:Kill(false)
  self.v_seqence_list[key] = nil
end

function ui:init_drag_event()
  Util.set_start_drag(self:get_object(), self, function(x, y)
    self:drag_start()
  end)
  Util.set_end_drag(self:get_object(), self, function(x, y)
    self:drag_end()
  end)
end

function ui:drag_start()
  self.v_speed_up_time = UnityTime.realtimeSinceStartup
end

function ui:drag_end()
  self.v_is_speed_up = false
  self.v_speed_up_time = nil
  self:speed_none()
end

function ui:ui_update()
  self:update_speed()
  for _, data in pairs(self.v_step_map) do
    data.lua_obj:update()
  end
  for _, data in pairs(self.v_insert_step_map) do
    data.lua_obj:update()
  end
end

function ui:update_speed()
  if self.v_speed_up_time then
    local cur_time = UnityTime.realtimeSinceStartup
    local offset = cur_time - self.v_speed_up_time
    if offset >= 0.3 and offset <= 1 then
      self.v_uiobjects.Speed:SetActive(true)
      self.v_uicompents.SpAmount_img.fillAmount = offset
    elseif offset > 1 then
      self:speed_up()
      if not self.v_is_speed_up then
        self:check_step_all_complete()
      end
      self.v_is_speed_up = true
    end
  end
end

function ui:speed_up()
  for type, data in pairs(self.v_step_map) do
    if not data.is_complete and not NO_SPEED_CHANGE[type] then
      data.lua_obj:speed_up()
    end
  end
  self:change_sequence_speed(UP_SPEED)
end

function ui:speed_none()
  self.v_uiobjects.Speed:SetActive(false)
  self.v_uicompents.SpAmount_img.fillAmount = 0
  for key, data in pairs(self.v_step_map) do
    if not data.is_complete then
      data.lua_obj:speed_none()
    end
  end
  self:change_sequence_speed(SPEED_DEFAULT)
end

function ui:change_sequence_speed(speed)
  for _, sequence in pairs(self.v_seqence_list) do
    sequence.timeScale = speed
  end
end

function ui:click_btn(is_down)
  local video_visible = false
  if self.v_uiobjects.Video then
    video_visible = self.v_uiobjects.Video.activeSelf
  end
  if video_visible and is_down then
    is_video_skip_show = not is_video_skip_show
    if TowerMgr and TowerMgr:get_tower_type() and TowerMgr:get_tower_type() == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
      is_video_skip_show = true
    end
    self.v_uiobjects.Skip.gameObject:SetActive(is_video_skip_show)
  end
  if self.v_end_sequence then
    return
  end
  if self.v_is_hide_up then
    self.v_uiobjects.Up:SetActive(true)
    self.v_uiobjects.Talk:GetComponent("CanvasGroup").alpha = 1
    self.v_uiobjects.FightTalk:GetComponent("CanvasGroup").alpha = 1
    self.v_is_hide_up = false
    return
  end
  if not self:check_default_mod() then
    return
  end
  if self:check_cur_step_must_play() then
    if self.v_is_need_must_play_timing == nil then
      if self:check_play_step_end() then
        self:check_step_all_complete(true)
      end
      return
    elseif self.v_is_need_must_play_timing == true then
      return
    end
  end
  local is_next = true
  for type, data in pairs(self.v_step_map) do
    if not data.is_complete and not NO_SPEED_CHANGE[type] then
      if is_down then
        is_next = false
        data.lua_obj:down_btn()
      else
        data.lua_obj:up_btn()
      end
    end
  end
  if is_down and is_next then
    self:check_step_all_complete()
  end
end

function ui:clear(is_same_story, cur_story_cfg)
  self:clear_lua_obj()
  self:release_effect_obj()
  self:release_blur_texture()
  if self.v_is_gm_play then
    ResPoolMgr:clear_specific_pool(ResPoolMgr.POOL_TYPE.ui_effect)
  end
  Global.sound_mgr:story_end(StoryMgr:is_settle_story(self.v_story_id), self.v_story_cfg.NotResetBgm)
  if self.v_end_sequence then
    self.v_end_sequence:Kill(false)
    self.v_end_sequence = nil
  end
  for _, data in pairs(self.v_spine_rt_list) do
    data.rt_view:on_destroy()
  end
  self.v_spine_rt_list = {}
  for _, spine in pairs(self.v_bg_spine_rt) do
    spine:on_destroy()
  end
  self.v_bg_spine_rt = {}
  for _, sequence in pairs(self.v_seqence_list) do
    sequence:Kill(false)
  end
  self.v_seqence_list = {}
  self:clear_timer()
  if self.v_insert_tick then
    Timer:remove_timer(self.v_insert_tick)
    self.v_insert_tick = nil
  end
  self.v_is_blur_state = false
  CSHelper.SetSceneGaussianBlur(-1, 0, 0)
  local use_story_cfg = cur_story_cfg or self.v_story_step_cfg
  local step_data = use_story_cfg[CUR_STEP_ID]
  local next_step_data = use_story_cfg[CUR_STEP_ID + 1]
  local is_skip = true
  if not step_data then
    is_skip = false
  end
  if not next_step_data then
    is_skip = false
  end
  if self.v_enable_trace_data and not is_same_story then
    self.v_enable_trace_data = nil
    StoryMgr:trace_story(self.v_story_start_time, is_skip)
  end
  self:reset_story_speed()
  if self.v_story_timeline_obj then
    local blend_out = self.v_story_cfg.TimelineFadeOut and 2 or 0
    blend_out = self.v_is_skip and 0 or blend_out
    Cinemachine:update_timelinestep_blending_duration(blend_out)
    ResPoolMgr:release(self.v_story_timeline_obj)
    self.v_story_timeline_obj = nil
    self.v_story_timeline_node_ref = nil
    self.v_story_timeline_step_obj = nil
    if Global.camera and Global.camera:get_view_type() == Config.CAMERA_VIEW_TYPE.SHOULDER then
      Global.camera:set_camera_to_default_pos_in_shouldermode()
    end
    TimeLineSeqPlayer.close_camera_transparent = false
    if TimeLineMgr then
      TimeLineMgr:on_timeline_skip()
    end
  end
  self.v_is_play_next_story = nil
end

function ui:ui_on_hide()
  self:clear()
  if SceneMgr:check_main_scene() then
    UIMgr:get_ui("ui_click_effect"):ui_show()
  end
  Global.sound_mgr:voice_stop()
  Global.sound_mgr:set_stop_switch_ui_sound()
  Global.sound_mgr:clear_step_lipsyc_sound()
  if not UIMgr:try_get_visible_ui("ui_chapter_detail") then
    Global.sound_mgr:set_sound_source_volume(SOURCE_TYPE.VOICE2, "VOICE")
    Global.sound_mgr:pause_gen_source(false, GEN_CRI_SOURCE_TYPE.TIMELINE_AUDIO, nil, true)
    Global.sound_mgr:set_audio_active(true, true, 0.5, true)
  end
  self:close_world_dic_ui()
  MsgGame:mq_publish2(Const.MSG_UI_ON_HIDE_OF_STORY)
  if self.v_has_set_effect_root and Global.camera then
    Global.camera:set_camera_effect_root_active(true)
  end
  self.v_has_set_effect_root = nil
end

function ui:ui_on_destroy()
  self.v_is_check_newbie = nil
  if self.v_story_cfg.HideMainUI then
    local uimain = UIMgr:try_get_ui("uimain")
    if uimain then
      uimain:ui_fade_in_anim()
    end
  end
  StoryMgr:on_story_ui_destroy(self.v_story_id)
  if not self.v_execute_story_end_event then
    BehaviorMgr:call_scene_logic_event_fun("on_story_end", self.v_story_id)
  end
  if self.v_has_set_curtain then
    SceneMgr:set_curtain_show(true)
  end
end

function ui:play_story_end_anim(cb, is_skip)
  if self.v_story_cfg.AlphaEffectEnd then
    local canvas = self.v_object:GetComponent("CanvasGroup")
    self.v_end_sequence = Util.create_sequence()
    self.v_end_sequence:Append(canvas:DOFade(0, 0.5))
    self.v_end_sequence:AppendCallback(function()
      self:story_end_fun(is_skip)
      if cb then
        cb()
      end
    end)
  else
    self:story_end_fun(is_skip)
    if cb then
      cb()
    end
  end
end

function ui:set_finish_cb(finish_cb)
  ui.finish_cb = finish_cb
end

function ui:story_end_fun(is_skip)
  UIMgr:check_enable_camera()
  self.v_is_skip = is_skip
  local not_reset_bgm = self.v_story_cfg.NotResetBgm
  
  local function cb()
    self.v_is_play_next_story = nil
    if self.finish_cb then
      self.finish_cb(self.role_event_type)
      self.finish_cb = nil
      self.role_event_type = nil
    end
    local wait_count = self:get_wait_play_story_count()
    if Global.camera then
      Global.camera:set_active(true)
    end
    local destory = 0 == wait_count
    for _, data in pairs(self.v_step_map) do
      if not data.is_complete then
        data.lua_obj:on_comfirm_skip()
      end
    end
    local next_play_story_id
    if wait_count > 0 then
      next_play_story_id = self.v_wait_play_id_list[1]
      self:remove_wait_id_list(next_play_story_id)
    end
    if next_play_story_id then
      if is_skip then
        self:clear()
        StoryMgr:on_end()
        StoryMgr:set_playing_story(true)
        StoryMgr:on_start(next_play_story_id, true)
      else
        _play_next_story(self, next_play_story_id)
      end
      return
    end
    if nil == self.v_is_settle_story then
      self.v_is_settle_story = StoryMgr:check_story_is_settle_story(self.v_story_id)
    end
    if nil == self.v_is_delay_destroy then
      self.v_is_delay_destroy = StoryMgr:is_delay_destroy(self.v_story_id)
    end
    if StoryMgr then
      if self.v_is_gm_play then
        Behavior.set_ui_object_visible("fight", "Main", true)
        UIMgr:try_destory_ui("uistory")
        UIMgr:try_destory_ui("ui_blackfade")
      end
      StoryMgr:on_end(not_reset_bgm)
    end
    if not self:is_destroy() and destory and not self.v_is_play_next_story then
      if NewbieTowerMgr and not NewbieTowerMgr:is_pass_tower() and NewbieTowerMgr:check_enter_newbie_tower() then
        return
      end
      if (self.v_is_delay_destroy or self.v_is_settle_story) and not Util.is_gm_fight() and TowerMgr and not TowerMgr:is_on_enter_room() then
        self.v_execute_story_end_event = true
        self.v_uiobjects.DestroyBg:SetActiveEx(true)
        BehaviorMgr:call_scene_logic_event_fun("on_story_end", self.v_story_id)
        return
      end
      self:ui_destroy()
    end
  end
  
  local stop_arg_params
  if SceneMgr:check_main_scene() then
    if not self.v_story_cfg.AlphaEffectEnd then
      stop_arg_params = StoryMgr:get_main_scene_story_param()
    end
  else
    stop_arg_params = StoryMgr:get_story_stop_arg_params()
  end
  if nil == stop_arg_params then
    cb()
  else
    local fade_in = stop_arg_params.stop_fade_in_time
    local stay = stop_arg_params.stop_stay_time
    if StoryMgr:is_delay_destroy(self.v_story_id) then
      stay = -1
    end
    local fade_out = stop_arg_params.stop_fade_out_time
    if fade_in > 0 or stay > 0 or fade_out > 0 then
      UIMgr:get_ui("ui_blackfade"):ui_show(fade_in, stay, fade_out, function()
        cb()
        StoryMgr:reset_story_stop_arg_params()
      end, true)
    else
      cb()
    end
  end
end

function ui:check_newbie_tower()
  local newbie_story_id = ShareRes.get_comm_value("CreateAccountStory")
  local is_newbie_story = self.v_story_id == newbie_story_id
  if is_newbie_story and not self.v_is_check_newbie then
    if self.v_uiobjects then
      self.v_uiobjects.Story_End_Bg:SetActive(true)
    end
    UIMgr:get_ui("ui_blackfade"):ui_show(0, -1, 0.5, nil, true)
    if StoryMgr then
      StoryMgr:on_end()
    end
    NewbieTowerMgr:on_enter_newbie_tower()
    self.v_is_check_newbie = true
  end
  return is_newbie_story
end

function ui:clear_lua_obj()
  for _, data in pairs(self.v_step_map) do
    data.lua_obj:on_destroy()
  end
  self.v_step_map = {}
  for _, data in pairs(self.v_insert_step_map) do
    data.lua_obj:on_destroy()
  end
  self.v_play_step_type = STEP_PLAY_TYPE.DEFAULT
  self.v_insert_step_map = {}
end

function ui:get_wait_play_story_count()
  local wait_count = #self.v_wait_play_id_list
  return wait_count
end

function ui:init_next_step_ui()
  self.v_uiobjects.UpContent:SetActive(true)
  self.v_uiobjects.BgAnim:SetActive(false)
end

function ui:go_step()
  if not self.v_story_step_cfg then
    return
  end
  self.v_cur_step = self.v_story_step_cfg[CUR_STEP_ID]
  if not self.v_cur_step then
    self:play_story_end_anim()
    return
  end
  self:refresh_skip_btn_visible()
  self:init_next_step_ui()
  if StoryMgr then
    StoryMgr:set_story_cur_step_id(CUR_STEP_ID, BRANCH_STEP_ID)
  end
  BRANCH_STEP_ID = nil
  self:stop_all_sound()
  self:init_default_step_lua_obj()
  self:check_show_world_dic()
end

function ui:open_world_dic_ui(title_id, dic_id)
  local world_dic_ui = "world_dic_for_story"
  if SysOpenMgr:get_is_ui_open("world_dic", true) then
    self:stop_auto_play()
    UIMgr:get_ui(world_dic_ui):ui_show(true, title_id, dic_id, self.v_story_unlock_dic, true)
  end
end

function ui:close_world_dic_ui()
  local world_dic_ui = "world_dic_for_story"
  UIMgr:try_hide_ui(world_dic_ui)
end

function ui:check_show_world_dic()
  local world_dic_id
  if self.v_cur_step then
    world_dic_id = self.v_cur_step.WorldDicId
  end
  if not world_dic_id or -1 == world_dic_id then
    return
  else
    self.v_uiobjects.KeywordTips:SetActive(true)
    local cfg = ShareRes.get_world_dic_cfg(world_dic_id)
    local DISAPPEAR_POS = -650
    if cfg then
      self.v_story_unlock_dic[cfg.TitleID] = self.v_story_unlock_dic[cfg.TitleID] or {}
      _tinsert(self.v_story_unlock_dic[cfg.TitleID], cfg.Id)
      ArchiveMgr:unlock_world_dic_list(cfg.Id)
      local dic_hold_time = ShareRes.get_comm_value("WorldDicHoldTime")
      if self.v_world_disc_sequence and self.v_world_disc_sequence then
        self.v_world_disc_sequence:Kill(false)
        self.v_world_disc_sequence = nil
      end
      self.v_world_disc_sequence = Util.create_sequence()
      local keyword_tips = self.v_uicompents.KeywordTips_rect
      if self.v_worlddic_is_playing then
        self.v_world_disc_sequence:Append(keyword_tips:DOAnchorPosX(DISAPPEAR_POS, 0.5))
      else
        self.v_uicompents.KeywordTips_rect:SetAnchoredPositionA(DISAPPEAR_POS, 0, 0)
        self.v_worlddic_is_playing = true
      end
      self.v_world_disc_sequence:AppendInterval(self.v_cur_step.WorldDicDelay)
      self.v_world_disc_sequence:AppendCallback(function()
        self.v_uicompents.KeywordName_txt.text = cfg.Name
        self:set_button_listener(self.v_uicompents.KeywordTips_btn, function()
          self:open_world_dic_ui(cfg.TitleID, cfg.Id)
        end)
      end)
      self.v_world_disc_sequence:Append(keyword_tips:DOAnchorPosX(0, 1))
      self.v_world_disc_sequence:AppendInterval(dic_hold_time)
      self.v_world_disc_sequence:Append(keyword_tips:DOAnchorPosX(DISAPPEAR_POS, 0.5))
      self.v_world_disc_sequence:AppendCallback(function()
        self.v_worlddic_is_playing = nil
      end)
    else
      return
    end
  end
end

function ui:stop_all_sound()
  Global.sound_mgr:voice_stop()
end

function ui:check_cur_step_use_spine_res()
  return self.v_cur_step.UseSpineRes
end

function ui:check_cur_step_must_play()
  if not self.v_cur_step then
    return
  end
  return self.v_cur_step.MustPlay
end

function ui:check_click_effect()
  if self:check_cur_step_must_play() then
    return
  end
  if self.v_end_sequence then
    return
  end
  return true
end

function ui:update_must_play_ui()
  local must_play
  if self.v_cur_step then
    must_play = self.v_cur_step.MustPlay
  end
  self.v_uiobjects.UpContent:SetActiveEx(not must_play)
end

function ui:init_default_step_lua_obj()
  if not self.v_cur_step then
    return
  end
  self.v_is_step_init = false
  self:init_step_lua(self.v_cur_step)
  self:init_fight_ui_visiability()
  self.v_is_step_init = true
  self:story_step_start()
  self:check_play_change_anim(true)
  self:set_ui_obj_layer()
  self:update_must_play_ui()
end

function ui:init_fight_ui_visiability()
  local visiable = false
  for type, _ in pairs(self.v_step_map) do
    if SHOW_FIGHT_UI[type] then
      visiable = true
      break
    end
  end
  Behavior.set_ui_object_visible("fight", "Main", visiable)
  self.v_Bgbtn_visible = not visiable
  self.v_uiobjects.BgBtn:SetActive(not visiable)
  self.v_uiobjects.FullScreenBackground:SetActive(not visiable)
  self.v_uiobjects.Up:SetActive(not visiable)
  if StoryMgr then
    StoryMgr:set_playing_full_screen_story(not visiable)
  end
  if not visiable then
    Joystick.on_joystick("end")
    if Global.camera then
      self.v_has_set_effect_root = true
      Global.camera:set_camera_effect_root_active(false)
    end
  end
end

local function set_cur_use_bg_layer(step_data)
  if not CUR_USE_BG_LAYER then
    CUR_USE_BG_LAYER = 1
    return CUR_USE_BG_LAYER
  end
  if step_data.IsNoSwitchBgIdx then
    return
  end
  CUR_USE_BG_LAYER = 1 == CUR_USE_BG_LAYER and 2 or 1
end

function ui:init_step_lua(step_list)
  local step_num = 0
  for step_key, step_data in pairs(step_list) do
    local lua_path = STEP_LUA_PATH[step_key]
    if not lua_path or (step_key == STEP_TYPE.WRITE_NAME or step_key == STEP_TYPE.PLAYER_SETTING) and not step_data then
    else
      local step_type = step_key
      if step_type == STEP_TYPE.CHAPTER_BG_ANIM then
        if not SceneMgr:check_main_scene() and step_data.OnlyOutBattle or SceneMgr:check_main_scene() and string.lower(step_data.Image) == "uistory_trans" and step_data.NotFullImage then
        else
          set_cur_use_bg_layer(step_data)
          local new_path, new_type = self:check_step_path(step_type, step_data)
          lua_path = new_path or lua_path
          step_type = new_type or step_type
          local lua_step = require(lua_path):new(self, step_data, step_type, self.v_play_step_type, self.v_story_id, self.v_story_speed, step_list)
          local lua_data = {is_complete = false, lua_obj = lua_step}
          if not self.v_play_step_type or self.v_play_step_type == STEP_PLAY_TYPE.DEFAULT then
            self.v_step_map[step_type] = lua_data
          elseif self.v_play_step_type == STEP_PLAY_TYPE.INSERT_PLAY then
            self.v_insert_step_map[step_type] = lua_data
          end
          step_num = step_num + 1
        end
      end
    end
  end
  if step_num <= 1 then
    self:check_play_change_anim()
  end
end

function ui:is_captions_talk_data()
  local data = self.v_step_map[STEP_TYPE.CAPTIONS_TALK]
  if data then
    return true
  end
  data = self.v_insert_step_map[STEP_TYPE.CAPTIONS_TALK]
  if data then
    return true
  end
  return false
end

function ui:story_step_start()
  local lua_list = {}
  if not self.v_play_step_type or self.v_play_step_type == STEP_PLAY_TYPE.DEFAULT then
    lua_list = self.v_step_map
  elseif self.v_play_step_type == STEP_PLAY_TYPE.INSERT_PLAY then
    lua_list = self.v_insert_step_map
  end
  for role_pos = 1, 7 do
    local char_img_obj = self.v_uiobjects["CharRt" .. role_pos]
    local img = Util.get_component(nil, char_img_obj, UnityRawImage)
    self:image_grey_spine(img, 100)
  end
  self:reset_skip_btn()
  for _, data in pairs(lua_list) do
    if not data.is_complete then
      data.lua_obj:start()
    end
  end
end

function ui:check_step_path(step_key, step_data)
  if step_key == STEP_TYPE.ROLE_TALK then
    local type = step_data.Type
    if type == STORY_CONFIG.TALK_TYPE.BG_TALK then
      return STEP_LUA_PATH[STEP_TYPE.BG_TALK], STEP_TYPE.BG_TALK
    elseif type == STORY_CONFIG.TALK_TYPE.FIGHT_TALK then
      return STEP_LUA_PATH[STEP_TYPE.FIGHT_TALK], STEP_TYPE.FIGHT_TALK
    elseif type == STORY_CONFIG.TALK_TYPE.CAPTIONS_TALK then
      return STEP_LUA_PATH[STEP_TYPE.CAPTIONS_TALK], STEP_TYPE.CAPTIONS_TALK
    end
  elseif step_key == STEP_TYPE.BRANCH then
    if step_data.Branch then
      return STEP_LUA_PATH[STEP_TYPE.BRANCH], STEP_TYPE.BRANCH
    elseif step_data.FightBranch then
      return STEP_LUA_PATH[STEP_TYPE.BRANCH], STEP_TYPE.FIGHT_BRANCH
    elseif step_data.NoBranch then
      return STEP_LUA_PATH[STEP_TYPE.BRANCH], STEP_TYPE.NO_BRANCH
    end
  end
end

function ui:check_play_change_anim(is_open, is_check)
  local step_data = self.v_step_map[STEP_TYPE.CHANGE_ANIM]
  if not step_data then
    return
  end
  local lua_obj = step_data.lua_obj
  if not lua_obj then
    return
  end
  if step_data.is_complete then
    return
  end
  if is_check then
    return true
  end
  if is_open then
    lua_obj:open_anim()
  else
    lua_obj:close_anim()
  end
end

function ui:step_complete(step_type)
  if not self.v_step_map[step_type] then
    return
  end
  if self.v_step_map[step_type].is_complete then
    return
  end
  self.v_step_map[step_type].is_complete = true
  local next_step = self.v_story_step_cfg[CUR_STEP_ID + 1]
  local auto_play
  if next_step then
    auto_play = next_step.AutoPlay
  end
  if self.v_is_speed_up or self.v_is_auto or auto_play then
    self:check_step_all_complete(auto_play)
  end
  local cur_step_cfg = self.v_story_step_cfg[CUR_STEP_ID]
  if cur_step_cfg and cur_step_cfg.AutoEndPlay then
    self:check_step_all_complete(auto_play)
  end
end

function ui:check_play_step_end()
  for type, data in pairs(self.v_step_map) do
    local lua_obj = data.lua_obj
    if not data.is_complete and type ~= STEP_TYPE.CHANGE_ANIM then
      return false
    end
  end
  return true
end

function ui:check_step_all_complete(step_auto)
  if not self.v_is_step_init then
    return
  end
  if not self.v_step_map then
    return
  end
  local no_complete_list = {}
  for type, data in pairs(self.v_step_map) do
    local lua_obj = data.lua_obj
    if not data.is_complete then
      no_complete_list[type] = true
    end
  end
  
  local function cb()
    self:check_play_change_anim()
  end
  
  local len = UtilTable.hash_lenth(no_complete_list)
  if 0 ~= len then
    if len <= 1 then
      if self.v_is_auto then
        local is_play_end_anim = self:check_play_change_anim(false, true)
        if is_play_end_anim then
          self.v_is_play_end_anim = is_play_end_anim
          self:start_pause_time(cb)
        end
      else
        cb()
      end
    end
    return
  end
  if not self.v_is_play_end_anim and (self.v_is_auto or step_auto) then
    self:start_pause_time(function()
      if self.v_step_map[STEP_TYPE.ROLE_TALK] and self.v_cur_step.MustPlay then
        local step_talk = self.v_step_map[STEP_TYPE.ROLE_TALK].lua_obj
        step_talk:enable_talk_next(true)
      end
      self:end_step()
    end)
  else
    self:end_step()
  end
end

function ui:start_pause_time(cb)
  if self.v_auto_timer then
    return
  end
  if not self.v_cur_step then
    return
  end
  local cur_cd = self.v_cur_step.StepCD or 1
  if cur_cd > 0 then
    cur_cd = cur_cd / self.v_story_speed
  end
  self.v_auto_timer = Timer:add_timer("check_step_all_complete", cur_cd, cb)
end

function ui:start_timing_with_must_play(cb)
  if self.v_cur_step.MustPlay then
    self.v_is_need_must_play_timing = true
    local cur_cd = self.v_cur_step.StepCD or 1
    if cur_cd > 0 then
      cur_cd = cur_cd / self.v_story_speed
    end
    self.v_must_play_timing_timer = Timer:add_timer("start_timing_with_must_play", cur_cd, function()
      self.v_is_need_must_play_timing = false
      if cb then
        cb()
      end
    end)
  end
end

function ui:clear_timer()
  self.v_is_need_must_play_timing = nil
  if self.v_auto_timer then
    Timer:remove_timer(self.v_auto_timer)
    self.v_auto_timer = nil
  end
  if self.v_must_play_timing_timer then
    Timer:remove_timer(self.v_must_play_timing_timer)
    self.v_must_play_timing_timer = nil
  end
end

function ui:end_step(fixed_step)
  self:clear_timer()
  self.v_is_play_end_anim = false
  local cur_step_cfg = self.v_story_step_cfg[CUR_STEP_ID]
  if cur_step_cfg and cur_step_cfg.AutoEndPlay then
    CUR_STEP_ID = #self.v_story_step_cfg + 1
  elseif BRANCH_STEP_ID then
    CUR_STEP_ID = BRANCH_STEP_ID
  elseif fixed_step and 0 ~= fixed_step then
    CUR_STEP_ID = fixed_step
  else
    CUR_STEP_ID = CUR_STEP_ID + 1
  end
  self:clear_lua_obj()
  self:go_step()
end

function ui:get_cur_step_id()
  return CUR_STEP_ID
end

function ui:set_branch_step_id(step_id)
  BRANCH_STEP_ID = step_id
end

local FLIP_TYPE_X_MASK = 10
local FLIP_TYPE_Y_MASK = 12

function ui:add_effect_obj(res_name, obj, layer, parent, flip_type)
  local effect_data = self.v_effec_obj_list[res_name]
  if effect_data then
    ResPoolMgr:release(effect_data.obj)
    ResMgr:destroy_gameobj(effect_data.parent)
  end
  local gameobj = ResMgr:create_empty_role_obj(res_name .. "_Parent")
  gameobj.transform:SetParent(parent.transform)
  gameobj:ResetAttr()
  gameobj.transform:SetSiblingIndex(layer)
  local scale = self:get_canvas_scale()
  local bit = 1 << flip_type
  local scale_x = scale * (bit & FLIP_TYPE_X_MASK == bit and -1 or 1)
  local scale_y = scale * (bit & FLIP_TYPE_Y_MASK == bit and -1 or 1)
  gameobj.transform:SetLocalScaleA(scale_x, scale_y, 1)
  obj.transform:SetParent(gameobj.transform)
  local effect_state = obj:GetComponent(EffectStatus)
  if effect_state and not effect_state:IsNull() then
    local cur_use_bg_layer = self:get_cur_bg_layer()
    local bg_obj = self.v_uiobjects["StoryBg" .. cur_use_bg_layer]
    effect_state:SetupOwner(bg_obj)
    effect_state:SetActive(true)
  end
  self.v_effec_obj_list[res_name] = {parent = gameobj, obj = obj}
end

function ui:add_effect_obj_for_title_effect(res_name, obj, parent)
  local effect_data = self.v_effec_obj_list[res_name]
  if effect_data then
    ResPoolMgr:release(effect_data.obj)
    ResMgr:destroy_gameobj(effect_data.parent)
  end
  obj.transform:SetParent(parent.transform)
  obj.transform:SetAsLastSibling()
  local rect_obj = Util.get_rect_transform(nil, obj)
  rect_obj:SetOffsetMinMax(0, 0, 0, 0)
  self.v_effec_obj_list[res_name] = {parent = obj, obj = obj}
end

function ui:get_effect_obj(res_name)
  local eff_data = self.v_effec_obj_list[res_name]
  if eff_data then
    return eff_data.obj
  end
end

function ui:get_canvas_scale()
  local root_rect = self:get_rect_transform()
  local size_delta = root_rect.sizeDelta
  local width = size_delta.x
  local height = size_delta.y
  local canvas_radtio = width / height
  local screen_radtio = 1.7777777777777777
  local scale
  if canvas_radtio > screen_radtio then
    scale = canvas_radtio / screen_radtio
  else
    scale = screen_radtio / canvas_radtio
  end
  return scale
end

function ui:release_effect_obj(res_name)
  if res_name then
    local effect_data = self.v_effec_obj_list[res_name]
    if effect_data then
      ResPoolMgr:release(effect_data.obj)
      ResMgr:destroy_gameobj(effect_data.parent)
    end
    self.v_effec_obj_list[res_name] = nil
    return
  end
  for _, data in pairs(self.v_effec_obj_list) do
    ResPoolMgr:release(data.obj)
    ResMgr:destroy_gameobj(data.parent)
  end
  self.v_effec_obj_list = {}
end

function ui:get_cur_bg_layer()
  return CUR_USE_BG_LAYER or 1
end

function ui:get_spine_rt_view(role_pos)
  local spine_rt = self.v_spine_rt_list[role_pos]
  if not spine_rt then
    return
  end
  return spine_rt.rt_view
end

function ui:load_spine_res(role_res, role_pos, load_cb)
  local char_img_obj = self.v_uiobjects["CharRt" .. role_pos]
  local spine_data = self.v_spine_rt_list[role_pos]
  if not spine_data then
    local new_rt = SPINE_RT_VIEW:new(self, char_img_obj, role_pos)
    local new_data = {rt_view = new_rt, role_res = role_res}
    self.v_spine_rt_list[role_pos] = new_data
  end
  local rt_view = self.v_spine_rt_list[role_pos].rt_view
  rt_view:load_spine_res(role_res, load_cb)
end

function ui:load_bg_spine_res(img_obj, res_name, cb)
  if not self.v_bg_spine_rt[img_obj] then
    self.v_bg_spine_rt[img_obj] = SPINE_RT_VIEW:new(self, img_obj)
  end
  self.v_bg_spine_rt[img_obj]:load_spine_res(res_name, cb)
end

function ui:get_bg_spine(img_obj)
  return self.v_bg_spine_rt[img_obj]
end

function ui:insert_ui_obj_layer_data(obj, layer)
  local is_new = true
  for key, data in pairs(self.v_layer_data) do
    if data.obj == obj then
      data.layer = layer
      is_new = false
      break
    end
  end
  if is_new then
    _insert(self.v_layer_data, {obj = obj, layer = layer})
  end
end

function ui:set_ui_obj_layer()
  _sort(self.v_layer_data, function(a, b)
    return a.layer < b.layer
  end)
  for _, data in ipairs(self.v_layer_data) do
    data.obj.transform:SetSiblingIndex(data.layer)
  end
end

function ui:step_camera_special_effect(step_data)
  local key = "camera_move_sequence"
  if self.v_seqence_list[key] then
    self.v_seqence_list[key]:Kill(false)
    self.v_seqence_list[key] = nil
  end
  local use_bg_layer = CUR_USE_BG_LAYER or 1
  local start_data = step_data.Start
  local start_posx = start_data[1]
  local start_posy = start_data[2]
  local start_scale = start_data[3]
  local end_data = step_data.End
  local end_scale = end_data[3]
  local time = end_data[4]
  local ease_type = step_data.EaseType or 1
  local sequence = self:get_new_sequence(key)
  local end_pos = Vec3.New(end_data[1], end_data[2], 1)
  local new_scale = Vec3.New(end_scale, end_scale, 1)
  local start_scale_seq = Vec3.New(start_scale, start_scale, 1)
  local is_spine_bg = step_data.IsSpineBg
  local select_bg_obj_rect
  if is_spine_bg then
    select_bg_obj_rect = self.v_uicompents["StorySpineBg" .. use_bg_layer .. "_rect"]
  else
    select_bg_obj_rect = self.v_uicompents["StoryBg" .. use_bg_layer .. "_rect"]
  end
  if not select_bg_obj_rect then
    return
  end
  select_bg_obj_rect.transform:SetLocalScaleA(start_scale, start_scale, 1)
  start_posx, start_posy = self:clamp_move_pos(start_posx, start_posy, start_scale)
  end_pos.x, end_pos.y = self:clamp_move_pos(end_pos.x, end_pos.y, end_scale)
  select_bg_obj_rect:SetAnchoredPositionA(start_posx, start_posy)
  local start_pos_seq = Vec3.New(start_posx, start_posy, 1)
  sequence:Append(select_bg_obj_rect.transform:DOScale(start_scale_seq, 0.01):SetEase(Ease[1]))
  sequence:Append(select_bg_obj_rect:DOLocalMove(start_pos_seq, 0.01):SetEase(Ease[1]))
  sequence:Append(select_bg_obj_rect.transform:DOScale(new_scale, time):SetEase(Ease[ease_type]))
  sequence:Join(select_bg_obj_rect:DOLocalMove(end_pos, time):SetEase(Ease[ease_type]))
end

function ui:clamp_move_pos(posx, posy, scale)
  local stroy_rect = Util.get_rect_transform(nil, self.v_object.gameObject)
  local stroy_width = stroy_rect.rect.width or 0
  local stroy_hight = stroy_rect.rect.height or 0
  local move_width = stroy_width * scale / 2 - stroy_width / 2
  local move_height = stroy_hight * scale / 2 - stroy_hight / 2
  local new_posx = _clamp(posx, -move_width, move_width)
  local new_posy = _clamp(posy, -move_height, move_height)
  return new_posx, new_posy
end

function ui:set_blur_state(is_state)
  self.v_is_blur_state = is_state
end

function ui:get_blur_state()
  return self.v_is_blur_state
end

function ui:check_default_mod()
  return not self.v_play_step_type or self.v_play_step_type == STEP_PLAY_TYPE.DEFAULT
end

function ui:play_insert_step_mod(step_list, cb)
  if self.v_play_step_type == STEP_PLAY_TYPE.INSERT_PLAY then
    Log.Error("ui:play_insert_step_mod: 当前正在播放插入步骤模式，不能重复播放")
    return
  end
  self.v_play_step_type = STEP_PLAY_TYPE.INSERT_PLAY
  self.v_insert_step_list = step_list
  self.v_insert_step_id = 1
  self.v_insert_step_cb = cb
  self:init_insert_step_lua_obj()
end

function ui:init_insert_step_lua_obj()
  local step_id = self.v_insert_step_list[self.v_insert_step_id]
  if not step_id then
    self.v_play_step_type = STEP_PLAY_TYPE.DEFAULT
    if self.v_insert_step_cb then
      self.v_insert_step_cb()
    end
    self.v_insert_step_cb = nil
    for _, data in pairs(self.v_insert_step_map) do
      data.lua_obj:on_destroy()
    end
    self.v_insert_step_map = {}
    local last_step_id = self.v_insert_step_list[self.v_insert_step_id - 1]
    local next_step_data = self.v_story_step_cfg[last_step_id + 1] or {}
    local auto_play = next_step_data.AutoPlay
    if auto_play then
      self:check_step_all_complete(auto_play)
    end
    return
  end
  local step_data = self.v_story_step_cfg[step_id]
  self.v_insert_step_data = step_data
  self:init_step_lua(step_data)
  self:story_step_start()
  self.v_uiobjects.UpContent:SetActive(false)
end

function ui:insert_step_complete(step_type)
  if not self.v_insert_step_map[step_type] then
    return
  end
  if self.v_insert_step_map[step_type].is_complete then
    return
  end
  self.v_insert_step_map[step_type].is_complete = true
  for _, lua_obj in pairs(self.v_insert_step_map) do
    if not lua_obj.is_complete then
      return
    end
  end
  if self.v_insert_tick then
    Timer:remove_timer(self.v_insert_tick)
    self.v_insert_tick = nil
  end
  
  local function cb()
    self.v_insert_step_id = self.v_insert_step_id + 1
    self:init_insert_step_lua_obj()
  end
  
  local cd = self.v_insert_step_data.StepCD or 1
  if cd > 0 then
    cd = cd / self.v_story_speed
  end
  self.v_insert_tick = Timer:add_timer("insert_step_complete", cd, cb)
end

function ui:cache_branch_select_data(branch_id, story_id)
  if self.v_story_id ~= story_id then
    return
  end
  self.v_cache_branch_data[branch_id] = true
end

function ui:check_branch_has_chose(branch_id)
  return self.v_cache_branch_data[branch_id]
end

function ui:cache_talk_data(talk_data, branch_data, story_id)
  local insert_data
  if talk_data then
    insert_data = {
      desc = self:replace_talk_content(LanguageMgr:get_story_text(talk_data.Content)) or "",
      name = LanguageMgr:get_story_text(talk_data.CharName) or "",
      sound = talk_data.Sound or ""
    }
    if talk_data.UseNoteText then
      insert_data.UseNoteText = true
      insert_data.NoteText = talk_data.NoteText
      insert_data.NoteTextPos = talk_data.NoteTextPos
    end
    insert_data.txt_alignment = talk_data.TextAnchor
  elseif branch_data then
    if self.v_story_id ~= story_id then
      return
    end
    insert_data = {
      is_branch = true,
      desc = self:replace_talk_content(LanguageMgr:get_story_text(branch_data.Content)) or ""
    }
  end
  _tinsert(self.v_cache_talk_data, insert_data)
end

function ui:get_cache_talk_data()
  return self.v_cache_talk_data
end

function ui:cache_hide_ui()
  return false
end

function ui:replace_talk_content(content)
  for string_key, fun_name in pairs(SPECIAL_STRING_FUN) do
    if _find(content, string_key) then
      local fun = self[fun_name]
      if fun then
        local replace_content = fun()
        content = _gsub(content, string_key, replace_content)
      end
    end
  end
  return content
end

function ui:_get_player_name()
  if not PlayerMgr then
    return ""
  end
  return PlayerMgr:get_player_name() or ""
end

function ui:on_node_story_play_done()
  if StoryMgr and StoryMgr.need_refresh_room_view then
    StoryMgr.need_refresh_room_view = false
  end
end

function ui:no_skip_story()
  self.v_uiobjects.SkipUp:SetActive(false)
end

function ui:play_storybg_shake(shake_type, is_end)
  self.v_is_shaking = true
  if is_end then
    if shake_type == SHAKE_STYLE.LOW_SHAKE then
      self.v_shake_end_eff_L.enabled = true
    elseif shake_type == SHAKE_STYLE.MID_SHAKE then
      self.v_shake_end_eff_M.enabled = true
    elseif shake_type == SHAKE_STYLE.HIGH_SHAKE then
      self.v_shake_end_eff_H.enabled = true
    end
    return
  end
  if shake_type == SHAKE_STYLE.LOW_SHAKE then
    self.v_shake_low_eff.enabled = true
  elseif shake_type == SHAKE_STYLE.MID_SHAKE then
    self.v_shake_mid_eff.enabled = true
  elseif shake_type == SHAKE_STYLE.HIGH_SHAKE then
    self.v_shake_high_eff.enabled = true
  end
end

function ui:get_storybg_shake_duration(shake_type, is_end)
  if is_end then
    if shake_type == SHAKE_STYLE.LOW_SHAKE then
      return self.v_shake_end_eff_L.duration
    elseif shake_type == SHAKE_STYLE.MID_SHAKE then
      return self.v_shake_end_eff_M.duration
    elseif shake_type == SHAKE_STYLE.HIGH_SHAKE then
      return self.v_shake_end_eff_H.duration
    end
  end
  if shake_type == SHAKE_STYLE.LOW_SHAKE then
    return self.v_shake_low_eff.duration
  elseif shake_type == SHAKE_STYLE.MID_SHAKE then
    return self.v_shake_mid_eff.duration
  elseif shake_type == SHAKE_STYLE.HIGH_SHAKE then
    return self.v_shake_high_eff.duration
  end
  return 0
end

function ui:stop_storybg_shake()
  if not self.v_is_shaking then
    return
  end
  self.v_shake_low_eff.enabled = false
  self.v_shake_mid_eff.enabled = false
  self.v_shake_high_eff.enabled = false
  self.v_shake_end_eff_L.enabled = false
  self.v_shake_end_eff_M.enabled = false
  self.v_shake_end_eff_H.enabled = false
  self.v_is_shaking = false
end

function ui:image_grey_spine(img_obj, grey_cfg_val)
  if not grey_cfg_val or grey_cfg_val <= 0 then
    return
  end
  local grey_val = grey_cfg_val / 255
  local color = CSUnityColor(grey_val, grey_val, grey_val, 1)
  img_obj.color = color
end

function ui:force_stop_captions_talk()
  if self:is_captions_talk_data() then
    self:click_skip_confirm_btn()
  end
end

function ui:on_story_bg_change(bg_res_name)
  if bg_res_name ~= self.v_last_bg_res_name then
    if TowerMgr and TowerMgr:is_on_enter_room() and not self.v_story_timeline_obj and "UIstory_trans" == bg_res_name then
      SceneMgr:set_curtain_show(false)
      self.v_has_set_curtain = true
    end
    self.v_last_bg_res_name = bg_res_name
  end
end

function ui:get_story_cfg()
  return self.v_story_cfg
end

function ui:response_click_escape()
  return UIMgr.RESPONCE_ESCAPE_TYPE.ESCAPE_CUSTOM
end

function ui:pause_captions_talk(pause)
  if not self.v_step_map then
    return
  end
  for step_type, data in pairs(self.v_step_map) do
    if step_type == STEP_TYPE.CAPTIONS_TALK then
      local lua_obj = data.lua_obj
      if lua_obj then
        lua_obj:pause_captions_talk(pause)
      end
    end
  end
end

function ui:set_canvas_group_alpha(obj, alpha_param)
  obj:GetComponent(TypeCanvasGroup).alpha = alpha_param
end

function ui:set_image_color(obj_img)
  obj_img.color = Util.ColorWhite
end

function ui:cache_ui_prefab_clear()
  self.v_uiobjects.Blur:SetActive(false)
  self.v_uiobjects.FullBg:SetActive(false)
  self.v_uiobjects.BlackBg:SetActive(true)
  self.v_uiobjects.StoryBg1:SetActive(true)
  self.v_uiobjects.StoryBg2:SetActive(true)
  self.v_uiobjects.StorySpineBg1:SetActive(false)
  self.v_uiobjects.StorySpineBg2:SetActive(false)
  self:set_canvas_group_alpha(self.v_uiobjects.StoryBg1, 0)
  self:set_canvas_group_alpha(self.v_uiobjects.StoryBg2, 0)
  self:set_canvas_group_alpha(self.v_uiobjects.StorySpineBg1, 0)
  self:set_canvas_group_alpha(self.v_uiobjects.StorySpineBg2, 0)
  self:set_image_color(self.v_uicompents.StoryBg1_img)
  self:set_image_color(self.v_uicompents.StoryBg2_img)
  local img1 = Util.get_component(nil, self.v_uiobjects.StorySpineBg1, UnityRawImage)
  local img2 = Util.get_component(nil, self.v_uiobjects.StorySpineBg2, UnityRawImage)
  self:set_image_color(img1)
  self:set_image_color(img2)
  self.v_shake_low_eff.enabled = false
  self.v_shake_mid_eff.enabled = false
  self.v_shake_high_eff.enabled = false
  self.v_shake_end_eff_L.enabled = false
  self.v_shake_end_eff_M.enabled = false
  self.v_shake_end_eff_H.enabled = false
  self.v_shake_low_eff.gameObject:SetActive(true)
  self.v_shake_mid_eff.gameObject:SetActive(true)
  self.v_shake_high_eff.gameObject:SetActive(true)
  self.v_shake_end_eff_L.gameObject:SetActive(true)
  self.v_shake_end_eff_M.gameObject:SetActive(true)
  self.v_shake_end_eff_H.gameObject:SetActive(true)
  self.v_uiobjects.Video:TryRemoveComponent(CriManaMovieControllerForUI)
  for i = 1, 7 do
    local char_obj = self.v_uiobjects["Char" .. i]
    local char_bg_obj = self.v_uiobjects["CharBg" .. i]
    local char_mask_obj = self.v_uiobjects["CharMask" .. i]
    local char_spinebg_obj = self.v_uiobjects["SpineBg" .. i]
    local char_charrt_obj = self.v_uiobjects["CharRt" .. i]
    local char_frame_obj = self.v_uiobjects["CharFrame" .. i]
    self:set_canvas_group_alpha(char_obj, 0)
    char_obj:SetActive(true)
    char_bg_obj:SetActive(false)
    char_mask_obj:SetActive(true)
    char_spinebg_obj:SetActive(false)
    char_charrt_obj:SetActive(true)
    char_frame_obj:SetActive(false)
  end
  self.v_uiobjects.StoryTitleCom:SetActive(false)
  self.v_uiobjects.StoryTitleObj:SetActive(false)
  self.v_uiobjects.StoryTitleObj1:SetActive(false)
  self.v_uiobjects.StoryTitleObj2:SetActive(false)
  self.v_uiobjects.StoryTitleObj3:SetActive(false)
  self.v_uiobjects.AniBookOneL:SetActive(false)
  self.v_uiobjects.AniBookOneR:SetActive(false)
  self.v_uiobjects.DestroyBg:SetActive(false)
end

function ui:_response_key_down(msg)
  local input_code = msg.mm_x
  if (input_code == CSKeyCode.Space or input_code == INPUT_CODE.INPUT_COMMON) and self.v_Bgbtn_visible then
    self:click_btn(true)
  end
end

function ui:_response_key_up(msg)
  local input_code = msg.mm_x
  if input_code == CSKeyCode.Space or input_code == INPUT_CODE.INPUT_COMMON then
    if self.v_Bgbtn_visible then
      self:click_btn(false)
    end
  elseif input_code == CSKeyCode.C and self:get_curr_step_is_can_skip() and self.v_uiobjects.Skip.activeInHierarchy then
    if not self.v_showing_skip then
      self:click_skip_btn()
    else
      self:click_skip_confirm_btn()
    end
  end
end

function ui:click_skip_cancel_btn()
  if self.v_cache_is_auto then
    self:click_auto_btn()
  end
  self.v_uiobjects.Tips_skip:SetActive(false)
  self.v_showing_skip = false
  StoryMgr:update_curr_step_is_showing_skip(false)
end

return ui
