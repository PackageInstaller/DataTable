local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ease_linear = CS.DG.Tweening.Ease.Linear

function ui:ui_finish_load()
  self.v_voice_item_list = {}
  for index = 1, 5 do
    table.insert(self.v_voice_item_list, self.v_uiobjects["VoiceTem" .. index])
  end
end

function ui:show_pnl(buddy_id)
  local voice_data = ShareRes.create("buddy.buddy_voice_client", buddy_id)
  self.v_uiobjects.NoneVoice:SetActive(not voice_data)
  if not voice_data then
    self:none_voice_cfg()
    return
  end
  self:deal_data(buddy_id, voice_data)
  self:set_cur_page(1)
  self.v_is_click = true
  self.v_buddy_id = buddy_id
end

function ui:none_voice_cfg()
  for _, item in ipairs(self.v_voice_item_list) do
    item:SetActive(false)
  end
  self.v_parent_ui.v_uiobjects.Lower:SetActive(false)
end

function ui:deal_data(buddy_id, voice_data)
  self.v_voice_list = {}
  for index, data in ipairs(voice_data) do
    local page = math.ceil(index / 5)
    if not self.v_voice_list[page] then
      self.v_voice_list[page] = {}
    end
    table.insert(self.v_voice_list[page], data)
  end
  self.v_parent_ui.v_now_page_num = 1
  self.v_parent_ui.v_max_page_num = #self.v_voice_list
  self.v_parent_ui:refresh_page_num()
end

function ui:set_cur_page(page)
  if not self.v_voice_list then
    return
  end
  self.v_cur_page = page
  self:show_voice_item_list(page)
end

function ui:show_voice_item_list(page)
  for _, item in ipairs(self.v_voice_item_list) do
    item:SetActive(false)
  end
  for index, item in ipairs(self.v_voice_list[page]) do
    self.v_voice_item_list[index]:SetActive(true)
    self:set_voice_data(index)
  end
end

function ui:set_voice_data(index)
  local info = self.v_voice_list[self.v_cur_page][index]
  local item = self.v_voice_item_list[index]
  local lock_obj = Util.get_child_gameobj("LockObj_", item)
  local unlock_con = Util.get_text("UnlockCon_", lock_obj)
  local unlock_obj = Util.get_child_gameobj("NotLockObj_", item)
  local btn_on = Util.get_button("BtnOn_", unlock_obj)
  local btn_off = Util.get_button("BtnOff_", unlock_obj)
  local name = Util.get_text("VoiceName_", unlock_obj)
  local pro = Util.get_image("VoiceBarFill_", Util.get_child_gameobj("VoiceBar", unlock_obj))
  local red_point = Util.get_child_gameobj("New", unlock_obj)
  local is_lock = CharacterMgr.v_voice_list[info.Id] == nil
  lock_obj:SetActive(is_lock)
  unlock_obj:SetActive(not is_lock)
  pro.fillAmount = 0
  pro.gameObject:SetActive(false)
  if self.v_cur_play_id and self.v_cur_play_id == info.Id then
    pro.gameObject:SetActive(true)
  end
  if is_lock then
    local condition_cfg = ShareRes.create("condition.condition", info.Condition)
    if condition_cfg then
      unlock_con.text = condition_cfg.Desc
    else
      Log.Error(" 没有此条件ID =", info.Condition)
    end
  else
    red_point:SetActive(not CharacterMgr.v_voice_list[info.Id].is_read)
    name.text = info.Title
    btn_off.gameObject:SetActive(false)
    btn_on.gameObject:SetActive(true)
    self:set_button_listener(btn_on, function()
      local buddy_cv_cfg = ShareRes.get_buddy_cv_config(tostring(info.Id))
      if buddy_cv_cfg then
        pro.gameObject:SetActive(true)
        self.v_cur_play_id = info.Id
        self:play_audio(buddy_cv_cfg.ChineseSound, pro, btn_off, btn_on)
        self.v_parent_ui:set_voice_content(buddy_cv_cfg.ChineseSoundTxt)
        if not CharacterMgr.v_voice_list[info.Id].is_read then
          CharacterMgr:req_read_buddy_voice(info.Id, self.v_buddy_id, function()
            red_point:SetActive(false)
          end)
        end
      else
        Log.Error("角色CV音效表 没有此ID =", info.Id)
      end
    end)
    self:set_button_listener(btn_off, function()
      self:stop_audio()
    end)
  end
end

function ui:play_audio(audio_id, pro, btn_off, btn_on)
  if self.v_sound_type then
    Global.sound_mgr:stop_sound_by_type(self.v_sound_type)
  end
  self.v_sound_type = Global.sound_mgr:play_sound_by_id(audio_id, nil, function(time)
    self.v_parent_ui:show_voice_content_anim(1)
    self.v_parent_ui:show_favors_anim(0)
    self.v_play_time = time / 1000
    self:play_audio_pro(self.v_play_time, pro, btn_off, btn_on)
  end)
end

function ui:stop_audio()
  if self.v_sound_type then
    Global.sound_mgr:stop_sound_by_type(self.v_sound_type)
  end
  if not self.v_cur_play_id then
    return
  end
  self.v_parent_ui:show_voice_content_anim(0)
  self.v_parent_ui:show_favors_anim(1)
  if self.v_pro then
    self.v_btn_off.gameObject:SetActive(false)
    self.v_btn_on.gameObject:SetActive(true)
    self.v_pro.fillAmount = 0
  end
  self:clear_play_audio_pro()
  self.v_cur_play_id = nil
end

function ui:play_audio_pro(time, pro, btn_off, btn_on)
  if not self.v_pro then
    self.v_pro = pro
    self.v_btn_off = btn_off
    self.v_btn_on = btn_on
  end
  self:clear_play_audio_pro()
  self.v_pro.fillAmount = 0
  self.v_btn_off.gameObject:SetActive(false)
  self.v_btn_on.gameObject:SetActive(true)
  self.v_pro = pro
  self.v_btn_off = btn_off
  self.v_btn_on = btn_on
  self.v_btn_off.gameObject:SetActive(true)
  self.v_btn_on.gameObject:SetActive(false)
  self.v_audio_pro_seq = Util.create_sequence()
  self.v_audio_pro_seq:Append(pro:DOFillAmount(1, time):SetEase(ease_linear))
  self.v_audio_pro_seq:AppendCallback(function()
    self.v_pro.fillAmount = 0
    self:stop_audio()
  end)
end

function ui:clear_play_audio_pro()
  if self.v_audio_pro_seq then
    self.v_audio_pro_seq:Kill()
    self.v_audio_pro_seq = nil
  end
end

function ui:req_read_cur_page_vocie()
  if not self.v_voice_list then
    return
  end
  for _, info in pairs(self.v_voice_list[self.v_cur_page]) do
    if CharacterMgr.v_voice_list[info.Id] and not CharacterMgr.v_voice_list[info.Id].is_read then
      CharacterMgr:req_read_buddy_voice(info.Id, self.v_buddy_id)
    end
  end
end

function ui:change_page()
  self:req_read_cur_page_vocie()
end

function ui:hide_pnl()
  self.v_parent_ui.v_uiobjects.Lower:SetActive(true)
  if not self.v_is_click then
    return
  end
  self:req_read_cur_page_vocie()
  self:stop_audio()
  self.v_is_click = false
  self.v_voice_list = nil
end

return ui
