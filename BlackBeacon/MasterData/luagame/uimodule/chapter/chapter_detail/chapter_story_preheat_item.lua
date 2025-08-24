local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_button()
  if not ChapterMgr:get_preheat_is_unlock(self.v_preheat_id) then
    return
  end
  local count_down_time = ChapterMgr:get_story_preheat_count_down_time(self.v_preheat_id)
  if count_down_time > 0 then
    Util.show_message_tip(2322, Date.get_time_desc2(count_down_time))
    return
  end
  if ChapterMgr:get_preheat_is_red(self.v_preheat_id) then
    ChapterMgr:request_click_preheat(self.v_preheat_id)
    self.v_uiobjects.RedPoint:SetActive(false)
  end
  self.v_parent_ui:on_select_preheat(self.v_preheat_id, self.v_index)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  if self.v_unlock_pd_cb then
    self.v_uicompents.Ani_UIPreviewStory_Unlock_pd:stopped("-", self.v_unlock_pd_cb)
    self.v_unlock_pd_cb = nil
  end
end

function ui:ui_on_destroy()
end

function ui:set_data(preheat_id, index)
  function self.v_unlock_pd_cb()
    self:set_lock_state(true)
  end
  
  self.v_uicompents.Ani_UIPreviewStory_Unlock_pd:stopped("+", self.v_unlock_pd_cb)
  self.v_index = index
  self.v_preheat_id = preheat_id
  local cfg = ShareRes.get_story_preheat_cfg(preheat_id)
  self.v_uicompents.StageNum_txt.text = cfg.Num
  local count_down_time = ChapterMgr:get_story_preheat_count_down_time(preheat_id)
  local is_unlock = count_down_time <= 0 and ChapterMgr:get_preheat_is_unlock(preheat_id)
  self:set_lock_state(is_unlock, true)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.Bg:SetActive(is_unlock)
  self.v_uiobjects.UnlockPD:SetActive(false)
  self:set_button_listener(self:get_button(), function()
    self:on_click_button()
  end)
end

function ui:set_lock_state(is_unlock, is_first)
  local cfg = ShareRes.get_story_preheat_cfg(self.v_preheat_id)
  local str, alpha
  local count_down_time = ChapterMgr:get_story_preheat_count_down_time(self.v_preheat_id)
  self.v_uiobjects.RedPoint:SetActive(is_unlock and ChapterMgr:get_preheat_is_red(self.v_preheat_id))
  if is_unlock then
    str = cfg.Name
    alpha = 1
    if not is_first then
      self:on_click_button()
    end
  elseif count_down_time > 0 then
    self:set_select(nil)
    str = Date.get_time_desc2(count_down_time) .. "后解锁"
    alpha = 0.25
  else
    self:set_select(nil)
    str = "未解锁"
    alpha = 0.25
  end
  self.v_uicompents.StageName_txt.text = str
  Util.change_component_alpha2(self.v_uicompents.StageName_txt, alpha)
end

function ui:set_select(cur_select_id)
  self.v_uiobjects.Select:SetActive(cur_select_id == self.v_preheat_id)
end

function ui:play_unlock_pd()
  self.v_uiobjects.UnlockPD:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.chapter_story_preheat_unlock_UI_SOUND)
end

return ui
