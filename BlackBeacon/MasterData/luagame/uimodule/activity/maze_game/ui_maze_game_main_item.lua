local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_btn()
  if self.v_unlock_str then
    Util.show_message_tip(self.v_uicompents.Time_txt.text .. "后解锁")
    return
  end
  self:close_red()
  self.v_parent_ui:on_click_item(self.v_point_id)
end

function ui:ui_finish_load()
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
end

function ui:ui_on_show()
end

function ui:set_data(activity_id, point_id)
  self:clear_timer()
  self.v_activity_id = activity_id
  self.v_point_id = point_id
  self:refresh_data()
end

function ui:refresh_data()
  local remain_lock_time
  local point_cfg = ShareRes.get_ponder_maze_point_cfg(self.v_point_id)
  if point_cfg then
    local unlock_time = point_cfg.UnlockTime and Date.get_time_stamp_by_scheme_id(point_cfg.UnlockTime)
    local server_time = Date.server_time()
    local in_lock_time = unlock_time and unlock_time > server_time or false
    local is_lock = in_lock_time or Util.is_more_than_zero(point_cfg.PrePoint) and not NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, point_cfg.PrePoint)
    self.v_uiobjects.BgLock:SetActive(is_lock)
    self.v_uiobjects.Bg:SetActive(not is_lock)
    self.v_uiobjects.TimeTag:SetActive(is_lock)
    self.v_uicompents.Name_txt.text = point_cfg.Name
    remain_lock_time = unlock_time and unlock_time - server_time
    self.v_unlock_str = nil
    if in_lock_time then
      self.v_unlock_str = Date.get_time_format_7(remain_lock_time)
      self:add_timer(remain_lock_time)
    elseif is_lock then
      local pre_point_cfg = ShareRes.get_ponder_maze_point_cfg(point_cfg.PrePoint)
      self.v_unlock_str = "通关" .. pre_point_cfg.Name
    end
    self.v_uicompents.Time_txt.text = self.v_unlock_str
    local content_root = point_cfg.UsePosUp and self.v_uicompents.PosUp_rect or self.v_uicompents.PosDown_rect
    self.v_uicompents.Content_rect:SetParent(content_root)
    self.v_is_red = not is_lock and NoviceMgr:is_ponder_maze_point_red(self.v_activity_id, self.v_point_id)
    self.v_uiobjects.RedPoint:SetActive(self.v_is_red)
    self.v_uiobjects.CompleteTag:SetActive(NoviceMgr:get_ponder_maze_point_is_comp(self.v_activity_id, self.v_point_id))
  end
  return remain_lock_time
end

function ui:close_red()
  if self.v_is_red then
    self.v_is_red = false
    NoviceMgr:request_activity_ponder_click_red(self.v_activity_id, self.v_point_id)
    self.v_uiobjects.RedPoint:SetActive(self.v_is_red)
  end
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:add_timer(remain_lock_time)
  self.v_timer = Global.ct_timer:add_timer("ui_maze_game_main_item_timer_" .. self.v_point_id, remain_lock_time, function(result_time)
    self.v_uicompents.Time_txt.text = Date.get_time_format_7(result_time)
    if result_time <= 0 then
      self:clear_timer()
      self.v_parent_ui:refresh_view()
    end
  end)
end

function ui:clear_timer()
  if not self.v_timer then
    return
  end
  Global.ct_timer:remove_timer(self.v_timer)
  self.v_timer = nil
end

function ui:ui_on_destroy()
end

return ui
