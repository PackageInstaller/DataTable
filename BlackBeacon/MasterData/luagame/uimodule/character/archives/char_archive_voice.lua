local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_cv_name = {
    "CVName",
    BIND_TYPE.TEXT
  },
  v_cv_text = {
    "CVText",
    BIND_TYPE.TEXT
  },
  v_char_name = {
    "CharName",
    BIND_TYPE.TEXT
  },
  v_char_profile = {
    "CharProfile",
    BIND_TYPE.IMAGE
  },
  v_none_voice = {
    "NoneVoice",
    BIND_TYPE.TEXT
  },
  v_voice_anim = {
    "VoiceAnim",
    BIND_TYPE.PLAYABLEDIRECTOR
  },
  v_voice_content = {
    "VoiceContent",
    BIND_TYPE.OBJECT
  },
  v_voice_sv = {
    "VoiceSV",
    BIND_TYPE.SCROLL
  },
  v_voice_tem = {
    "VoiceTem",
    BIND_TYPE.OBJECT
  },
  v_voice_text_obj = {
    "VoiceTextObj",
    BIND_TYPE.IMAGE
  },
  v_voice_text = {
    "VoiceText",
    BIND_TYPE.TEXT
  }
}
local HIDE_LANGUAGE_TYPE = {
  [1] = "CN",
  [2] = "EN",
  [3] = "JP",
  [4] = "KR"
}
local Camera_Move_Time = 0.5
local Canvas_Fade_Time = 0.2
local SaticSv = require("ui.widget.static_scroll_view")
local VoiceItem = require("uimodule.character.archives.char_voice_item")
local VoiceItemKey = "CHAR_ARCHIVE_VOICE_ITEM_KEY"
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TypeCSPlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local char_archive_voice_language_key = "CHAR_ARCHIVE_VOICE_LANGUAGE_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_toggle("PageTog1", function(is_on)
    if is_on then
      self.v_uicompents.PageTog2_tog.isOn = false
      self:refresh_voice_list(1)
    end
    self.v_uicompents.PageTog1_tog.interactable = not is_on
    self:stop_playing_voice()
  end)
  self:set_toggle("PageTog2", function(is_on)
    if is_on then
      self.v_uicompents.PageTog1_tog.isOn = false
      self:refresh_voice_list(2)
    end
    self.v_uicompents.PageTog2_tog.interactable = not is_on
    self:stop_playing_voice()
  end)
  self:set_button("BtnChangeLanguage", function()
    self:on_btn_change_language_click()
  end)
  self.v_static_sv = SaticSv:new(self, self.v_voice_content, VoiceItem, VoiceItemKey)
  self:register_exist_auto_template(char_archive_voice_language_key, self.v_uiobjects.CVLanguageItem, self.v_uiobjects.LanguageContent)
end

function ui:show_pnl(buddy_id)
  self:init_container()
  buddy_id = buddy_id or PlayerMgr:get_signboard_girl_id()
  self.v_buddy_id = buddy_id
  self.v_object:SetActive(true)
  self.v_voice_text_obj:SetActive(false)
  self.v_uiobjects.CVName:SetActive(false)
  self.v_canvas_grp = self:get_canvas_group(nil, self.v_object)
  self.v_canvas_grp.alpha = 0
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_canvas_grp:DOFade(1, Canvas_Fade_Time))
  self.v_sequence:OnComplete(function()
    self.v_voice_anim:Play()
    self:refresh_cv()
  end)
  self:refresh_icon_and_name()
  local show_obj = self.v_voice_text_obj
  self.v_content_canvas_grp = show_obj:GetComponent("CanvasGroup")
  self.v_content_canvas_grp.alpha = 0
  Global.sound_mgr:voice_stop()
  self.v_uicompents.PageTog1_tog.isOn = false
  self.v_uicompents.PageTog1_tog.isOn = true
  self:refresh_curr_buddy_cv_language()
end

function ui:refresh_curr_buddy_cv_language()
  local language = CharacterMgr:get_buddy_cv_language(self.v_buddy_id)
  self.v_uicompents.LanguageName_txt.text = LanguageMgr:get_code_text(Config.CommonDefine.LANGUAGE_CV_ID[language])
end

function ui:on_btn_change_language_click()
  if self.v_uiobjects.LanguageContent.activeSelf then
    self.v_uiobjects.LanguageContent:SetActive(false)
    return
  end
  self.v_uiobjects.LanguageContent:SetActive(true)
  self:give_back_auto_cache(char_archive_voice_language_key)
  local language = CharacterMgr:get_buddy_cv_language(self.v_buddy_id)
  local select_index = Config.CommonDefine.LANGUAGE_INDEX[language]
  self.v_cv_language_index_list = BattleSettingMgr:get_show_language_list(Config.CommonDefine.LANGUAGE_TYPE.Voice)
  self.v_cv_language_list = {}
  local buddy_cfg = ShareRes.get_buddy_cfg(self.v_buddy_id)
  for i, language_index in pairs(self.v_cv_language_index_list) do
    local item_obj = self:get_auto_cache(char_archive_voice_language_key)
    local select = self:get_child_gameobj("LanguageName/Check", item_obj)
    select:SetActive(select_index == language_index)
    local language_name = self:get_text("LanguageName", item_obj)
    local language_id = Config.CommonDefine.LANGUAGE_CV_ID[Config.CommonDefine.INDEX_LANGUAGE[language_index]]
    language_name.text = LanguageMgr:get_code_text(language_id)
    local cv_name = self:get_text("CVName", item_obj)
    local language_str = Config.CommonDefine.INDEX_LANGUAGE[language_index]
    local hide_text = "暂未实装"
    if language_str == Config.CommonDefine.LANGUAGE.CN then
      cv_name.text = HIDE_LANGUAGE_TYPE[buddy_cfg.HideType] == language_str and hide_text or buddy_cfg.CV
    else
      cv_name.text = HIDE_LANGUAGE_TYPE[buddy_cfg.HideType] == language_str and hide_text or buddy_cfg["CV_" .. language_str]
    end
    local btn = self:get_button(nil, item_obj)
    if language_str ~= HIDE_LANGUAGE_TYPE[buddy_cfg.HideType] then
      self:set_button_listener(btn, function()
        if language_index == select_index then
          self.v_uiobjects.LanguageContent:SetActive(false)
          return
        end
        self:change_cv_language(language_str)
      end)
    else
      self:set_button_listener(btn, function()
        if language_index == select_index then
          self.v_uiobjects.LanguageContent:SetActive(false)
          return
        end
        Util.show_message_tip("暂未实装")
      end)
    end
  end
end

function ui:change_cv_language(language_str)
  local function cb()
    CharacterMgr:refresh_buddy_cv_language(self.v_buddy_id, language_str)
    
    self:refresh_curr_buddy_cv_language()
    Global.sound_mgr:remove_cache_voice_sound()
    self.v_uiobjects.LanguageContent:SetActive(false)
    self:refresh_cv()
    self:stop_playing_voice()
    Util.show_message_tip("切换成功")
  end
  
  if Game_AssetBundle then
    local format_size = CS.VoiceCheckManager.Instance:GetNeedDownloadSoundSize(language_str)
    if "" == format_size then
      cb()
    else
      Util.show_conform_tip(Util.format_str("切换该语音需要下载{1}对应音频文件,是否退出到登录界面？", format_size), "取消", "确认", function()
        self.v_uiobjects.LanguageContent:SetActive(false)
      end, function()
        CharacterMgr:refresh_buddy_cv_language(self.v_buddy_id, language_str)
        Global.sound_mgr:remove_cache_voice_sound()
        Util.change_to_other_language(Global.curr_language, Config.CommonDefine.LANGUAGE_TYPE.Voice)
      end)
    end
  else
    cb()
  end
end

function ui:stop_playing_voice()
  if self.v_content_canvas_grp and self.v_content_canvas_grp.alpha > 0 and self.v_play_voice_item then
    self.v_play_voice_item:on_click_stop()
  end
end

function ui:refresh_cv()
  local cv_name = CharacterMgr:get_cv_name(self.v_buddy_id)
  if nil == cv_name or "" == cv_name then
    self.v_uiobjects.CVName:SetActive(false)
    self.v_uiobjects.CVText:SetActive(false)
  else
    self.v_cv_name.text = cv_name
    self.v_uiobjects.CVName:SetActive(true)
    self.v_uiobjects.CVText:SetActive(true)
  end
end

function ui:refresh_icon_and_name()
  local buddy_id = self.v_buddy_id
  local icon = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.SHOW_IMG)
  ResMgr:load_set_icon(self.v_char_profile, icon)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  self.v_char_name.text = buddy_cfg.Name
end

function ui:refresh_voice_list(page_idx)
  if self.v_is_playing then
    self:on_play_voice_finish()
  end
  local list = ShareRes.create("buddy.buddy_voice_client", self.v_buddy_id)
  local is_empty = true
  if list and #list > 0 then
    local data = {}
    for _, v in pairs(list) do
      if v.Page == page_idx and not CharacterMgr.HideCvMap[v.Id] then
        table.insert(data, {v_archive_voice_ui = self, cfg = v})
      end
    end
    self.v_static_sv:update_list(data)
    is_empty = 0 == #data
  end
  self.v_voice_sv:SetActive(not is_empty)
  self.v_none_voice:SetActive(is_empty)
end

function ui:hide_anim(cb)
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_canvas_grp:DOFade(0, Canvas_Fade_Time))
  self.v_sequence:OnComplete(function()
    if cb then
      cb()
    end
  end)
end

function ui:on_click_archive()
  self.v_parent_ui:on_click_archive_in_voice_pnl()
  self:hide_anim(function()
    self:hide_pnl()
  end)
end

function ui:hide_pnl(ignore_sound)
  self:clear_anim_loop()
  self.v_static_sv:clear()
  if not ignore_sound then
    Global.sound_mgr:voice_stop()
  end
  self:clear_sequence()
  self.v_object:SetActive(false)
  self.v_uiobjects.LanguageContent:SetActive(false)
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
end

function ui:set_voice_content(content)
  self.v_voice_text.text = Util.check_replace_player_name(content)
  self.v_voice_text_obj:SetActive(true)
end

function ui:clear_voice_content_anim()
  if self.v_voice_content_alpha_show_seq then
    self.v_voice_content_alpha_show_seq:Kill()
    self.v_voice_content_alpha_show_seq = nil
  end
end

function ui:show_voice_content_anim(alpha)
  self:clear_voice_content_anim()
  self.v_voice_content_alpha_show_seq = Util.create_sequence()
  self.v_voice_content_alpha_show_seq:Append(self.v_content_canvas_grp:DOFade(alpha, 0.5))
end

function ui:anim_loop()
  if not self.v_is_playing then
    return
  end
  if self.v_loop_timer then
    Timer:remove_timer(self.v_loop_timer)
  end
  self.v_loop_timer = Timer:add_timer("cd_anim_loop", 5, function()
    self.v_CD_handle.time = 1
    self.v_CD_handle:Play()
    self:anim_loop()
  end)
end

function ui:clear_anim_loop()
  self.v_is_playing = false
  if self.v_loop_timer then
    Timer:remove_timer(self.v_loop_timer)
    self.v_loop_timer = nil
  end
  if self.v_CD_handle then
    self.v_CD_handle:Stop()
    self.v_CD_handle:Evaluate()
  end
  if self.v_CD_disk then
    self.v_CD_disk:Stop()
  end
end

function ui:play_cd_ani(is_play)
  if is_play then
    if not self.v_is_playing then
      self.v_is_playing = true
      self.v_CD_handle.time = 0
      self.v_CD_handle:Play()
      self.v_CD_disk.time = -1
      self.v_CD_disk:Play()
      self:anim_loop()
    end
  else
    self:clear_anim_loop()
    self.v_CD_handle.time = 6
    self.v_CD_handle:Play()
    self.v_CD_disk:Stop()
  end
end

function ui:on_play_voice_item(item, voice_length)
  local buddy_cv_cfg = item:get_buddy_cv_cfg()
  local buddy_cfg = item:get_buddy_cfg()
  self:show_voice_content_anim(1)
  self:set_voice_content(buddy_cv_cfg.ChineseSoundTxt)
  self.v_play_voice_item = item
end

function ui:on_play_voice_finish()
  self:show_voice_content_anim(0)
  self:play_cd_ani(false)
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill()
    self.v_sequence = nil
  end
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  Util.assert(root_gameobj)
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  Util.assert(self.v_container)
  self.v_CD_handle = self.v_container:Get("CD_handle"):GetComponent(TypeCSPlayableDirector)
  self.v_CD_disk = self.v_container:Get("CD_disk"):GetComponent(TypeCSPlayableDirector)
  self.v_CD_handle:Evaluate()
end

return ui
