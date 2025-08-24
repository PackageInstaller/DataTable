local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local UI_WEAPON_ACTIVITY_ITEM = require("uimodule.activity.ui_weapon_activity_item")

function ui:change_next_weapon(is_left, need_reset)
  if self.v_move_tween or self.v_close_roll or self.v_is_draging then
    return
  end
  if need_reset then
    self.v_uicompents.BannerContent_rect:SetAnchoredPositionA(0, self.v_init_content_pos_y)
  end
  self.v_banner_scroll_view_ex.enabled = false
  local target_x = is_left and -self.v_banner_width or self.v_banner_width
  local duration = self.v_uicompents.Ani_UIActWeapon_Change_pd.duration
  self.v_move_tween = self.v_uicompents.BannerContent_rect:DOAnchorPosX(target_x, duration)
  self.v_uicompents.Ani_UIActWeapon_Change_pd:ResetPD()
  self.v_uicompents.Ani_UIActWeapon_Change_pd:Play()
  if self.v_change_next_weapon_timer then
    Timer:remove_timer(self.v_change_next_weapon_timer)
    self.v_change_next_weapon_timer = nil
  end
  self.v_change_next_weapon_timer = Timer:add_timer("change_next_weapon", duration / 2, function()
    self:change_center_info(is_left)
  end)
  self.v_move_tween:OnComplete(function()
    self.v_banner_scroll_view_ex.enabled = true
    self:rolling_operation(is_left)
    if self.v_move_tween then
      self.v_move_tween:Kill(false)
      self.v_move_tween = nil
    end
  end)
end

function ui:on_click_BtnWeaponDetail()
  if not self.v_rolling_index or not self.v_show_weapon_list[self.v_rolling_index] then
    return
  end
  local last_index = self.v_rolling_index
  local weapon_id = self.v_show_weapon_list[self.v_rolling_index].EquipId
  if weapon_id then
    UIMgr:get_ui("char_weapon", true):ui_show(nil, nil, nil, weapon_id)
  end
  self.v_rolling_index = last_index
end

function ui:on_click_BtnLast()
  self:change_next_weapon(false, true)
end

function ui:on_click_BtnNext()
  self:change_next_weapon(true, true)
end

function ui:on_click_BtnTask()
  if not self.v_activity_id or not self.v_activity_cfg then
    return
  end
  UIMgr:try_show_ui("ui_weapon_activity_task", nil, self.v_activity_cfg.TaskGroupId, self.v_activity_id)
end

function ui:on_click_BtnChooseWeapon()
  if not self.v_activity_id or not self.v_activity_cfg then
    return
  end
  UIMgr:try_show_ui("ui_weapon_activity_select", nil, self.v_activity_id)
end

function ui:ui_finish_load()
  self:set_button("BtnLast", function()
    self:on_click_BtnLast()
  end)
  self:set_button("BtnNext", function()
    self:on_click_BtnNext()
  end)
  self:set_button("BtnTask", function()
    self:on_click_BtnTask()
  end)
  self:set_button("BtnChooseWeapon", function()
    self:on_click_BtnChooseWeapon()
  end)
  self:set_button("BtnWeaponDetail", function()
    self:on_click_BtnWeaponDetail()
  end)
  self.v_init_content_pos_x, self.v_init_content_pos_y = self.v_uicompents.BannerContent_rect:GetAnchoredPositionA()
  self.v_banner_width = self.v_uicompents.BannerC_rect.rect.width
  self:init_rolling_part()
end

function ui:ui_on_show()
  self.v_left_weapon_item = UI_WEAPON_ACTIVITY_ITEM:ui_wrap_ex(self, self.v_uiobjects.BannerL, true)
  self.v_center_weapon_item = UI_WEAPON_ACTIVITY_ITEM:ui_wrap_ex(self, self.v_uiobjects.BannerC, true)
  self.v_right_weapon_item = UI_WEAPON_ACTIVITY_ITEM:ui_wrap_ex(self, self.v_uiobjects.BannerR, true)
  self.v_rolling_duration = 0
  self.v_activity_id = NoviceMgr:get_cur_open_weapon_activity_id()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedPoint, RedEnum.WAEPON_ACTIVITY)
  self.v_uicompents.BannerContent_rect:SetAnchoredPositionA(self.v_init_content_pos_x, self.v_init_content_pos_y)
  self.v_rolling_index = self.v_rolling_index or 1
  self:refresh_view()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

function ui:ui_on_update(delta_time)
  self:update_rolling_image(delta_time)
  self:refresh_time_remaining()
end

function ui:ui_on_hide()
  if self.v_move_tween then
    self.v_move_tween:Kill(false)
    self.v_move_tween = nil
  end
  self.v_left_weapon_item:ui_hide()
  self.v_left_weapon_item:ui_destroy()
  self.v_left_weapon_item = nil
  self.v_center_weapon_item:ui_hide()
  self.v_center_weapon_item:ui_destroy()
  self.v_center_weapon_item = nil
  self.v_right_weapon_item:ui_hide()
  self.v_right_weapon_item:ui_destroy()
  self.v_right_weapon_item = nil
  if self.v_change_next_weapon_timer then
    Timer:remove_timer(self.v_change_next_weapon_timer)
    self.v_change_next_weapon_timer = nil
  end
  self.v_rolling_index = 1
end

function ui:ui_on_destroy()
end

function ui:begin_drag()
  self.v_is_draging = true
end

function ui:on_drag()
  local drag_delta = self.v_banner_width / 4
  local dif = math.abs(self.v_uicompents.BannerContent_rect.anchoredPosition.x) - drag_delta
  if dif < 0 then
    return
  end
  local is_left = drag_delta > self.v_uicompents.BannerContent_rect.anchoredPosition.x
  self:change_center_info(is_left)
end

function ui:end_drag()
  self.v_is_draging = false
  local drag_delta = self.v_banner_width / 4
  local dif = math.abs(self.v_uicompents.BannerContent_rect.anchoredPosition.x) - drag_delta
  if dif < 0 then
    self.v_banner_scroll_view_ex.enabled = false
    local time = (1 - math.abs(dif) / drag_delta) * 0.2
    self.v_move_tween = self.v_uicompents.BannerContent_rect:DOAnchorPosX(0, time)
    self.v_move_tween:OnComplete(function()
      self.v_banner_scroll_view_ex.enabled = true
      if self.v_move_tween then
        self.v_move_tween:Kill(false)
        self.v_move_tween = nil
      end
    end)
    return
  end
  local is_left = drag_delta > self.v_uicompents.BannerContent_rect.anchoredPosition.x
  self:change_next_weapon(is_left)
end

function ui:init_rolling_part()
  self.v_banner_scroll_view_ex = Util.get_scrollrect_ex(nil, self.v_uiobjects.Banner)
  self:set_scrollrect_ex_listener(self.v_banner_scroll_view_ex, function()
    self:begin_drag()
  end, nil, function()
    self:end_drag()
  end, nil)
  self.v_banner_width = self.v_uicompents.BannerC_rect.sizeDelta.x
  self.v_rolling_interval = 5
end

function ui:init_weapon_data()
  local temp_list = {}
  for _, weapon_group_id in pairs(self.v_activity_cfg.EquipGroupId) do
    local temp = ShareRes.get_gold_equip_group_cfg(weapon_group_id)
    if not temp then
      Log.Error("获取武器组配置失败, 武器组ID", weapon_group_id, debug.traceback())
      return
    end
    for id, cfg in pairs(temp) do
      if cfg.Special then
        temp_list[id] = cfg
      end
    end
  end
  self.v_show_weapon_list = UtilTable.map2list(temp_list, function(a, b)
    if a.Priority ~= b.Priority then
      return a.Priority < b.Priority
    end
    return false
  end)
  if #self.v_show_weapon_list < 2 then
    self.v_close_roll = true
    self.v_banner_scroll_view_ex.enabled = false
    self:refresh_center_info(self.v_rolling_index)
    local centre_cfg = self.v_show_weapon_list[self.v_rolling_index]
    self.v_center_weapon_item:set_data(centre_cfg.Id, centre_cfg.EquipId)
    return
  end
  self.v_banner_scroll_view_ex.enabled = true
  local rolling_left_index = #self.v_show_weapon_list
  local rolling_right_index
  local next_index = self.v_rolling_index + 1
  if rolling_left_index < next_index then
    rolling_right_index = 1
  else
    rolling_right_index = next_index
  end
  self:refresh_center_info(self.v_rolling_index)
  self:set_rolling_data(self.v_show_weapon_list[rolling_left_index], self.v_show_weapon_list[self.v_rolling_index], self.v_show_weapon_list[rolling_right_index])
end

function ui:refresh_view()
  if not self.v_activity_id then
    return
  end
  self.v_activity_cfg = ShareRes.get_gold_equip_cfg(self.v_activity_id)
  if not self.v_activity_cfg then
    return
  end
  self.v_activity = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  self:init_weapon_data()
  self:refresh_text()
end

function ui:refresh_text()
  self.v_uicompents.ChooseNum_txt.text = NoviceMgr:get_weapon_select_count(self.v_activity_id)
  self.v_uicompents.Tips1_txt.text = self.v_activity_cfg.Tips[1]
  self.v_uicompents.Tips2_txt.text = self.v_activity_cfg.Tips[2]
  local suc_count = TaskMgr:get_task_group_count(self.v_activity_cfg.TaskGroupId)
  local total_count = NoviceMgr:get_weapon_next_select_task_count(self.v_activity_id)
  self.v_uicompents.TaskNum_txt.text = string.format("(%d/%d)", suc_count, total_count)
end

function ui:update_rolling_image(delta_time)
  if self.v_move_tween or self.v_is_draging or self.v_close_roll then
    self.v_rolling_duration = 0
    return
  else
    self.v_rolling_duration = self.v_rolling_duration + delta_time
  end
  if self.v_rolling_duration > self.v_rolling_interval then
    self.v_rolling_duration = self.v_rolling_duration % self.v_rolling_interval
    self:change_next_weapon(true, true)
  end
end

function ui:get_center_index(is_left)
  local sign = is_left and 1 or -1
  local index = self.v_rolling_index
  local total_count = #self.v_show_weapon_list
  index = 1 == sign and index + 1 or index - 1
  if total_count < index then
    index = 1
  elseif index < 1 then
    index = total_count
  end
  return index
end

function ui:rolling_operation(is_left)
  local total_count = #self.v_show_weapon_list
  local index = self.v_rolling_index
  local rolling_left_index = 1 == index and total_count or index - 1
  local rolling_right_index = index == total_count and 1 or index + 1
  local origin_y = self.v_init_content_pos_y
  self.v_uicompents.BannerContent_rect:SetAnchoredPositionA(0, origin_y)
  self:set_rolling_data(self.v_show_weapon_list[rolling_left_index], self.v_show_weapon_list[index], self.v_show_weapon_list[rolling_right_index])
end

function ui:refresh_center_info(index)
  local cfg = self.v_show_weapon_list[index]
  local total_count = #self.v_show_weapon_list
  self.v_rolling_index = 0 == index and total_count or index
  local weapon_cfg = ShareRes.get_equip(cfg.EquipId)
  self.v_uicompents.WeaponName_txt.text = weapon_cfg.Name
  self.v_uiobjects.LimitTips:SetActive(cfg.Special)
  local time = Util.is_more_than_zero(cfg.BeginTime) and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
  local is_lock = time and time >= Date.server_time()
  self.v_uiobjects.BtnWeaponDetail:SetActive(not is_lock)
  self.v_uiobjects.Lock:SetActive(is_lock)
  if is_lock then
    self.v_uicompents.UnlockTime_txt.text = Date.standard_data2(time)
  end
end

function ui:change_center_info(is_left)
  local index = self:get_center_index(is_left)
  self:refresh_center_info(index)
end

function ui:set_rolling_data(left_cfg, centre_cfg, right_cfg)
  self.v_left_weapon_item:set_data(left_cfg.Id, left_cfg.EquipId)
  self.v_center_weapon_item:set_data(centre_cfg.Id, centre_cfg.EquipId, true)
  self.v_right_weapon_item:set_data(right_cfg.Id, right_cfg.EquipId)
end

function ui:refresh_time_remaining()
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = self.v_parent_panel:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_data.open_time, activity_cfg.SustainTime)
  self.v_uiobjects.Time:SetActive(nil ~= remain_time)
  if nil ~= remain_time then
    self.v_uicompents.TimeNum_txt.text = remain_time
  end
end

return ui
