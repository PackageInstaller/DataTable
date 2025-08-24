local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local VoiceItem = require("uimodule.archives.archive_char_voice_item")
local VoiceItemKey = "CHAR_MAP_ARCHIVE_VOICE_ITEM_KEY"
local _tinsert = table.insert

function ui:ui_finish_load()
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.VoiceContent, VoiceItem, VoiceItemKey)
  self.v_content_canvas_grp = self:get_canvas_group(nil, self.v_uiobjects.VoiceTextObj)
end

function ui:ui_on_show(buddy_id)
  self.v_buddy_id = buddy_id
  self:refresh_voice_list()
  self:refresh_cv()
  Global.sound_mgr:voice_stop()
  self.v_uiobjects.VoiceTextObj:SetActive(false)
  self.v_uicompents.VoiceContent_rect:SetAnchoredPositionA(0, 0)
end

function ui:refresh_voice_list()
  local voice_list = ShareRes.create("buddy.buddy_voice_client", self.v_buddy_id)
  if 0 == UtilTable.hash_lenth(voice_list) then
    self.v_uiobjects.VoiceContent:SetActive(false)
  else
    self.v_uiobjects.VoiceContent:SetActive(true)
    local static_sv_data = {}
    for _, voice_data in pairs(voice_list) do
      _tinsert(static_sv_data, {v_archive_voice_ui = self, cfg = voice_data})
    end
    self.v_static_sv:update_list(static_sv_data)
  end
end

function ui:refresh_cv()
  local cv_name = CharacterMgr:get_cv_name(self.v_buddy_id)
  if nil == cv_name or "" == cv_name then
    self.v_uiobjects.Title:SetActive(false)
  else
    self.v_uicompents.cv_txt.text = cv_name
    self.v_uiobjects.Title:SetActive(true)
  end
end

function ui:on_play_voice_item(item, voice_length)
  self.v_uiobjects.VoiceTextObj:SetActive(true)
  local buddy_cv_cfg = item:get_buddy_cv_cfg()
  local buddy_cfg = item:get_buddy_cfg()
  self:show_voice_content_anim(1)
  self.v_uicompents.VoiceText_txt.text = Util.check_replace_player_name(buddy_cv_cfg.ChineseSoundTxt)
end

function ui:on_play_voice_finish()
  self:show_voice_content_anim(0)
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

function ui:ui_on_hide()
  self:clear_voice_content_anim()
  Global.sound_mgr:voice_stop()
  self.v_uiobjects.VoiceTextObj:SetActive(false)
end

return ui
