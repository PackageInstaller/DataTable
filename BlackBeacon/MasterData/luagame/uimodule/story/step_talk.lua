local sound_mgr = Global.sound_mgr
local UnityTime = UnityEngine.Time
local ease_linear = CS.DG.Tweening.Ease.Linear
local ScrambleMode = CS.DG.Tweening.ScrambleMode
local UnityRawImage = UnityEngine.UI.RawImage
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local CSResLoader = CS.ResLoader
local FadeText = typeof(CS.Game.FadeText)
local _tinsert = table.insert
local _tremove = table.remove
local Vec2 = require("base.vec2")
local Math = require("base.mathx")
local _clamp = Math.Clamp
local _floor = math.floor
local _ceil = math.ceil
local LOGIC_FRAME = Config.LOGIC_FRAME
local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local SINGLE_TEXT_WIDTH = 36
local SINGLE_TEXT_HIGHT = 50
local BASE_OFFSETX = -20
local BASE_OFFSETY = 3
local FIRST_LINE = 0
local SECEND_LINE = 50
local SHOW_EFFECT_TYPE = {DEFAULT = 0, GRADIENT = 1}
local DESC_EFFECT_TYPE = {DEFAULT = 0, GARBLED = 1}
local SEQUENCE_TIME = 0.6
local TIME_DEFAULT_LEN = 5
local TIME_DEFAULT_LEN2 = 20
local TIME_GARBLED_LEN = 10
local STORY_CONFIG = require("uimodule.story.story_config")
local MIN_SPEED = STORY_CONFIG.FADE_TXT_DEFAULT_SPEED
local SPEED_UP = 35
local CLICK_SPEED = 100
local MAX_CHAR_NUM = STORY_CONFIG.MAX_CHAR_NUM
local GARBLED_SPEED = STORY_CONFIG.GARBLED_DEFAULT_SPEED
local HEAD_PATH = "Hero/Profile/"
local BACKGROUND_BLUR_TYPE = STORY_CONFIG.BACKGROUND_BLUR_TYPE
local TextMeshProType = typeof(CS.TMPro.TextMeshProUGUI)
local IS_TRACK_FINISH = false

function M:_init(...)
  Base._init(self, ...)
  self.v_time = UnityTime.realtimeSinceStartup
  self.v_delay_cb_list = {}
  self.v_complete_data = {
    is_text_finish = false,
    is_sound_finish = true,
    is_blur = false
  }
end

function M:on_destroy()
  Base.on_destroy(self)
  if self.v_desc_effect then
    ResMgr:destroy_gameobj(self.v_desc_effect)
  end
  self.v_desc_effect = nil
end

function M:update()
  Base.update(self)
  local now_time = UnityTime.realtimeSinceStartup
  if self.v_dalay_time and now_time - self.v_time >= self.v_dalay_time then
    if self.v_delay_cb then
      self.v_delay_cb()
      self.v_delay_cb = nil
    end
    self.v_dalay_time = nil
  end
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    if now_time - self.v_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _tremove(self.v_delay_cb_list, index)
    end
  end
  self:update_scene_blur_effect()
end

function M:init_ui()
  self.v_talk_content = self.v_uiobjects.Talk_content:GetComponent(TextMeshProType)
  self.v_talk_content.text = ""
  self.v_talk_name = self.v_uiobjects.Talk_name:GetComponent(TextMeshProType)
  self.v_talk_name.text = ""
end

function M:speed_up()
  Base.speed_up(self)
end

function M:speed_none()
  Base.speed_none(self, GARBLED_SPEED)
end

function M:down_btn()
  Base.down_btn(self)
  self:all_finished()
end

function M:all_finished()
  for key, _ in pairs(self.v_complete_data) do
    self.v_complete_data[key] = true
  end
  self:check_complete()
end

function M:up_btn()
  Base.up_btn(self)
end

function M:start()
  self:init_ui()
  local step_cfg = self.v_step_cfg
  local layer = step_cfg.Level
  self.v_lua_obj:insert_ui_obj_layer_data(self.v_uiobjects.Talk, layer)
  self.v_uiobjects.CharHeadBg:SetActive(false)
  self:update_talk_view()
  self:init_blur(step_cfg)
end

function M:init_blur(step_cfg)
  local blur_fade_time = step_cfg.FadeTime or 0
  self.v_blur_fade_time = blur_fade_time
  self.v_last_blur_time = 0
  local background_type = step_cfg.BackgroundBlurType
  if background_type == BACKGROUND_BLUR_TYPE.SHOW then
    self:show_background_blur()
  elseif background_type == BACKGROUND_BLUR_TYPE.HIDE then
    self:hide_background_blur()
  else
    self.v_complete_data.is_blur = true
  end
end

function M:blur_complete()
  self.v_blur_show = false
  self.v_blur_hide = false
  self.v_radius = nil
  self.v_val = nil
  self.v_complete_data.is_blur = true
  self:check_complete()
end

function M:show_background_blur()
  local last_blur_state = self.v_lua_obj:get_blur_state()
  local init_val = last_blur_state and 1 or 0
  local fade_time = self.v_blur_fade_time
  if fade_time > 0 then
    local num = fade_time * 20
    self.v_val = 1 / num
    self.v_blur_show = true
    self.v_radius = init_val
  else
    self.v_radius = nil
    CSHelper.SetSceneGaussianBlur(1, 2, 1)
    self:blur_complete()
  end
  self.v_lua_obj:set_blur_state(true)
end

function M:update_scene_blur_effect()
  if not self.v_radius or not self.v_val then
    return
  end
  if self.v_blur_show then
    self.v_radius = self.v_radius + self.v_val
  elseif self.v_blur_hide then
    self.v_radius = self.v_radius - self.v_val
  end
  self.v_radius = _clamp(self.v_radius, -1, 1)
  CSHelper.SetSceneGaussianBlur(self.v_radius, 2, 1)
  self.v_last_blur_time = self.v_last_blur_time + LOGIC_FRAME
  if self.v_last_blur_time >= self.v_blur_fade_time then
    self:blur_complete()
  end
end

function M:hide_background_blur()
  local fade_time = self.v_blur_fade_time
  if fade_time > 0 then
    local num = fade_time * 20
    self.v_val = 1 / num
    self.v_radius = 1
    self.v_blur_hide = true
  else
    self.v_radius = nil
    CSHelper.SetSceneGaussianBlur(-1, 0, 0)
    self:blur_complete()
  end
  self.v_lua_obj:set_blur_state(false)
end

function M:update_head_info()
  local step_cfg = self.v_step_cfg
  local head_info = step_cfg.HeadInfo
  local res_name = head_info.HeadRes
  local show_effect = head_info.ShowEffect
  local hide_effect = head_info.HideEffect
  local head_icon = self.v_uicompents.CharHeadIcon_img
  if res_name and "" ~= res_name then
    local res_path = HEAD_PATH .. res_name
    ResMgr:load_set_icon(head_icon, res_path)
  end
  local delay_time, cb
  local is_insert = false
  if show_effect and show_effect.Enable then
    function cb()
      self.v_uiobjects.CharHeadBg:SetActive(true)
    end
    
    delay_time = show_effect.Delay
    if delay_time and 0 ~= delay_time then
      is_insert = true
    else
      cb()
    end
  elseif hide_effect and hide_effect.Enable then
    function cb()
      self.v_uiobjects.CharHeadBg:SetActive(false)
    end
    
    delay_time = hide_effect.Delay
    if delay_time and 0 ~= delay_time then
      is_insert = true
    else
      cb()
    end
  end
  if is_insert then
    local cb_data = {delay_time = delay_time, cb = cb}
    _tinsert(self.v_delay_cb_list, cb_data)
  end
end

function M:update_talk_view()
  local step_cfg = self.v_step_cfg
  local show_effect = step_cfg.ShowEffect
  local hide_effect = step_cfg.HideEffect
  local delay_time, cb
  local is_insert = false
  if show_effect and show_effect.Enable then
    delay_time = show_effect.Delay
    
    function cb()
      self:show_effect()
    end
    
    if delay_time and 0 ~= delay_time then
      is_insert = true
    else
      cb()
    end
  elseif hide_effect and hide_effect.Enable then
    delay_time = hide_effect.Delay
    
    function cb()
      self:hide_effect()
    end
    
    if delay_time and 0 ~= delay_time then
      is_insert = true
    else
      cb()
    end
  else
    self:show_effect()
  end
  if is_insert then
    local cb_data = {delay_time = delay_time, cb = cb}
    _tinsert(self.v_delay_cb_list, cb_data)
  end
end

function M:show_effect()
  local talk_obj = self.v_uiobjects.Talk
  local normal_talk_obj = self.v_uiobjects.NormalTalk
  local canvas = normal_talk_obj:GetComponent("CanvasGroup")
  local step_cfg = self.v_step_cfg
  local show_effect_data = step_cfg.ShowEffect
  local effect_type = show_effect_data.Effect
  
  local function callback()
    self:shake_anim()
    self:update_talk_desc()
  end
  
  normal_talk_obj:SetActive(true)
  talk_obj:SetActive(true)
  talk_obj:GetComponent("CanvasGroup").alpha = 1
  if effect_type == SHOW_EFFECT_TYPE.DEFAULT then
    canvas.alpha = 1
    callback()
  elseif effect_type == SHOW_EFFECT_TYPE.GRADIENT then
    canvas.alpha = 0
    local sequence = self:get_new_sequence("talk_show_effect")
    sequence:Append(canvas:DOFade(1, SEQUENCE_TIME))
    sequence:OnComplete(callback)
  end
  self:check_show_scroll_pass_bg()
end

function M:hide_effect()
  local talk_obj = self.v_uiobjects.Talk
  local normal_talk_obj = self.v_uiobjects.NormalTalk
  local canvas = normal_talk_obj:GetComponent("CanvasGroup")
  local step_cfg = self.v_step_cfg
  local hide_effect_data = step_cfg.HideEffect
  local effect_type = hide_effect_data.Effect
  
  local function callback()
    self:shake_anim()
    self:complete()
  end
  
  if effect_type == SHOW_EFFECT_TYPE.DEFAULT then
    normal_talk_obj:SetActive(false)
    canvas.alpha = 0
    callback()
  elseif effect_type == SHOW_EFFECT_TYPE.GRADIENT then
    local sequence = self:get_new_sequence("talk_hide_effect")
    sequence:Append(canvas:DOFade(0, SEQUENCE_TIME))
    sequence:OnComplete(function()
      normal_talk_obj:SetActive(false)
      talk_obj:SetActive(false)
      callback()
    end)
  end
  self:check_show_scroll_pass_bg()
end

function M:shake_anim()
  local step_cfg = self.v_step_cfg
  if not step_cfg.IsShake then
    return
  end
  local shake_data = step_cfg.ShakeData
  local time = shake_data[1]
  local force = shake_data[2]
  local shake_times = shake_data[3]
  local random = shake_data[4]
  local transform = self.v_uiobjects.ShakeTalkPart.transform
  local sequence = self:get_new_sequence("bg_shake_anim")
  sequence:AppendInterval(0.2)
  sequence:Append(transform:DOShakePosition(time, force, shake_times, random, true))
end

function M:update_char_state()
  local step_cfg = self.v_step_cfg
  if step_cfg.IsNoEffect then
    return
  end
  local show_char_list = {}
  for _, id in pairs(step_cfg.TalkPos) do
    show_char_list[id] = true
  end
  for index = 1, MAX_CHAR_NUM do
    local image, char_ui
    local grey_val = show_char_list[index] and 255 or 100
    if self.v_lua_obj:check_cur_step_use_spine_res() then
      char_ui = self.v_uiobjects["CharRt" .. index]
      if char_ui then
        image = Util.get_component(nil, char_ui, UnityRawImage)
      end
    else
      image = self.v_uicompents["CharImg" .. index .. "_img"]
    end
    if image then
      self:image_grey(image, grey_val)
    end
  end
end

function M:check_play_sound()
  local sound_name = self.v_step_cfg.Sound
  if not sound_name or "" == sound_name then
    return
  end
  sound_mgr:set_is_story_sound(sound_name)
  if sound_mgr then
    self.v_complete_data.is_sound_finish = false
    if self.v_story_id == ShareRes.get_comm_value("CreateAccountStory") and not IS_TRACK_FINISH then
      IS_TRACK_FINISH = true
      SDKManager:track_adjust_event("09_prologue_dialogue1_cosmos")
    end
    self.v_sound_type = sound_mgr:play_sound_by_id(sound_name, nil, function(sound_length_msec)
      local sound_length_seconds = sound_length_msec / 1000
      local original_length_time = sound_length_msec / 1000
      sound_length_seconds = sound_length_seconds / self.v_story_speed
      local cb_data = {
        is_sound = true,
        original_time = original_length_time,
        delay_time = sound_length_seconds,
        cb = function()
          self:on_sound_play_finish()
        end
      }
      _tinsert(self.v_delay_cb_list, cb_data)
    end)
    sound_mgr:play_step_lipsyc_sound(sound_name)
  end
end

function M:set_speed(speed)
  Base.set_speed(self, speed)
  for _, data in pairs(self.v_delay_cb_list) do
    if data and data.is_sound then
      data.delay_time = data.original_time / self.v_story_speed
    end
  end
end

function M:on_sound_play_finish()
  self.v_complete_data.is_sound_finish = true
  self:check_complete()
end

function M:check_complete()
  if self.v_lua_obj:check_auto() then
    for _, complete in pairs(self.v_complete_data) do
      if not complete and not self.v_lua_obj:is_video_playing() then
        return
      end
    end
    self:complete()
    self.v_lua_obj:check_step_all_complete()
  end
  self:complete()
end

function M:update_talk_desc()
  local step_cfg = self.v_step_cfg
  local desc_effect = step_cfg.ContentShowType
  local show_name = LanguageMgr:get_story_text(step_cfg.CharName) or ""
  local show_char_icon = step_cfg.CharIcon or ""
  self.v_talk_name.text = show_name
  self:check_play_sound()
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.Talk_name)
  LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local obj = Util.get_child_gameobj("Image", self.v_uiobjects.Talk_name)
  obj:SetActive("" ~= show_name)
  self.v_lua_obj:cache_talk_data(step_cfg)
  if "" ~= show_char_icon then
    ResMgr:load_set_icon(self.v_uicompents.CharHeadIcon_img, show_char_icon)
    self.v_uicompents.Talk_name_rect:SetAnchoredPositionA(375, 245.5)
    self.v_uicompents.TalkContentRoot_rect.offsetMin = UnityVector2(350, self.v_uicompents.TalkContentRoot_rect.offsetMin.y)
  else
    self.v_uicompents.Talk_name_rect:SetAnchoredPositionA(342, 245.5)
    self.v_uicompents.TalkContentRoot_rect.offsetMin = UnityVector2(318, self.v_uicompents.TalkContentRoot_rect.offsetMin.y)
  end
  self.v_uiobjects.CharHeadBg:SetActive("" ~= show_char_icon)
  self.v_uiobjects.Note:SetActive(false)
  if not desc_effect or desc_effect == DESC_EFFECT_TYPE.DEFAULT then
    self:desc_effect_default2()
    self:check_create_desc_effect()
  elseif desc_effect == DESC_EFFECT_TYPE.GARBLED then
    self:desc_effect_garbled()
  end
end

function M:enable_talk_next(enable)
  self.v_uiobjects.Talk_next:SetActive(enable)
  self:check_show_scroll_pass_bg()
end

function M:check_show_scroll_pass_bg()
  local is_end = self.v_uiobjects.Talk_next.activeSelf
  local is_overflow = self.v_uicompents.TalkContentRoot_rect.rect.height < self.v_uicompents.Talk_content_rect.rect.height
  self.v_uiobjects.TalkContentScrollPass:SetActiveEx(is_end and is_overflow)
end

function M:desc_effect_default2()
  local step_cfg = self.v_step_cfg
  local desc = LanguageMgr:get_story_text(step_cfg.Content)
  self:enable_talk_next(false)
  desc = self:replace_talk_content(desc)
  
  local function cb()
    if not self.v_step_all_cfg.MustPlay then
      self:enable_talk_next(true)
    else
      self.v_lua_obj:start_timing_with_must_play(function()
        self:enable_talk_next(true)
      end)
    end
    self.v_complete_data.is_text_finish = true
    self:check_complete()
  end
  
  self.v_talk_content.text = ""
  local string_len = Util.get_string_len(desc)
  if step_cfg.hasStyledText then
    string_len = step_cfg.ContentLength
  end
  local sequence = self:get_new_sequence("desc_talkeffect_default")
  local time = string_len / TIME_DEFAULT_LEN2
  sequence:Append(CSHelper.WrapTextTweenTo(self.v_talk_content.gameObject, desc, time))
  local sound_name = self.v_step_cfg.Sound
  if not sound_name or "" == sound_name then
    sequence:AppendCallback(function()
      if not self.v_step_all_cfg.MustPlay then
        self:enable_talk_next(true)
      end
    end)
    sequence:AppendInterval(1)
  end
  local line_space = ShareRes.get_comm_value("PlotLineSpaceDefault")
  if step_cfg.UseNoteText then
    local txt_rect = Util.get_rect_transform(nil, self.v_talk_content.gameObject)
    local note_rect = Util.get_rect_transform(nil, self.v_uiobjects.Note)
    local note_obj = self.v_uicompents.Note_txt
    local width = txt_rect.rect.size.x
    local set_num = step_cfg.NoteTextPos
    local txt_num = _floor(width / SINGLE_TEXT_WIDTH)
    local txt_row = _floor(set_num / txt_num)
    if txt_row > 0 then
      line_space = ShareRes.get_comm_value("PlotLineSpaceNote")
    end
    note_rect.anchoredPosition = Vec2.New(SINGLE_TEXT_WIDTH * (set_num - txt_row * txt_num) + BASE_OFFSETX, -txt_row * SINGLE_TEXT_HIGHT * line_space + BASE_OFFSETY)
    self.v_uiobjects.Note:SetActive(true)
    note_obj.text = ""
    local note_desc = LanguageMgr:get_story_text(step_cfg.NoteText)
    local insert_note_time = set_num / TIME_DEFAULT_LEN2
    local show_note_time = Util.get_string_len(note_desc) / 2 / TIME_DEFAULT_LEN2 / 3
    sequence:Insert(insert_note_time, note_obj:DOText(note_desc, show_note_time, true):SetEase(ease_linear))
  end
  self.v_talk_content.lineSpacing = line_space
  sequence:OnComplete(cb)
end

function M:desc_effect_garbled()
  local step_cfg = self.v_step_cfg
  local desc = LanguageMgr:get_story_text(step_cfg.Content)
  desc = self:replace_talk_content(desc)
  
  local function cb()
    self:complete()
  end
  
  self.v_talk_content.text = ""
  local string_len = Util.get_string_len(desc)
  local sequence = self:get_new_sequence("desc_talkeffect_garbled")
  local time = string_len / TIME_GARBLED_LEN
  sequence.timeScale = GARBLED_SPEED
  sequence:Append(CSHelper.WrapTextTweenTo(self.v_talk_content.gameObject, desc, time))
  sequence:OnComplete(cb)
end

function M:check_create_desc_effect()
  local effect_name = self.v_step_cfg.ContentShowEffect
  if Util.is_empty(effect_name) then
    return
  end
  local full_res_path = CSResLoader.GetFullPath(effect_name)
  
  local function callback(_, obj)
    self.v_desc_effect = obj
    obj.transform:SetParent(self.v_uicompents.TalkContentRoot_rect)
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(0.3)
  end
  
  ResMgr:load_gameobj_async(full_res_path, nil, nil, callback)
end

return M
