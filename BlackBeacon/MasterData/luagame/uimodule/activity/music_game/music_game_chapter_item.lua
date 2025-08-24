local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_MUSIC_GAME_DATA_UPDATE, self.refresh_red, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(cfg, idx)
  self.v_chapter_id = cfg.Id
  self.v_cfg = cfg
  local y_offset = 0 == idx % 2 and 0 or -36
  self.v_uicompents.TransRoot_rect:SetLocalPositionA(0, y_offset, 0)
  self.v_uicompents.ChapName_txt.text = cfg.Name
  ResMgr:load_set_icon(self.v_uicompents.NodeIcon_img, cfg.Icon)
  ResMgr:load_set_icon(self.v_uicompents.BgIcon_img, cfg.BgIcon)
  self:set_button_listener(self.v_uicompents.Button_btn, function()
    if self.v_is_unlock then
      self:on_click()
    else
      Util.show_message_tip("该难度未解锁")
    end
  end)
  self:refresh_view()
end

function ui:on_click()
  self.v_parent_ui:show_stage(self.v_chapter_id)
end

function ui:refresh_view()
  local data = MusicGameMgr:get_chapter_data(self.v_chapter_id)
  local now_time = Date.server_time()
  local start_time = self.v_cfg.StartTime and Date.get_time_stamp_by_scheme_id(self.v_cfg.StartTime) or 0
  local time_open = now_time >= start_time
  local condition_open = nil ~= data
  local is_unlock = time_open and condition_open
  self.v_is_unlock = is_unlock
  self.v_is_time_open = time_open
  Util.apply_grey_ex(self.v_uiobjects.Content, not is_unlock)
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  if not time_open then
    local remain_time = start_time - now_time
    if remain_time > 86400 then
      self.v_uicompents.LockDesc_txt.text = string.format("%s天后解锁", math.ceil(remain_time / 86400))
    else
      self.v_uicompents.LockDesc_txt.text = string.format("%s小时后解锁", math.ceil(remain_time / 3600))
    end
  elseif not condition_open then
    self.v_uicompents.LockDesc_txt.text = ShareRes.get_condition_desc(self.v_cfg.Condition)
  end
  self.v_cache_time = 0
  self:refresh_red()
end

function ui:refresh_red()
  local red = MusicGameMgr:get_new_stage_red(self.v_chapter_id)
  self.v_uiobjects.Redpoint:SetActive(red)
end

function ui:ui_on_update()
  if self.v_is_time_open then
    return
  end
  if not self.v_cache_time then
    self.v_cache_time = 0
    return
  end
  self.v_cache_time = self.v_cache_time + 1
  if self.v_cache_time > 1000 then
    self.v_cache_time = 0
    self:refresh_view()
  end
end

return ui
