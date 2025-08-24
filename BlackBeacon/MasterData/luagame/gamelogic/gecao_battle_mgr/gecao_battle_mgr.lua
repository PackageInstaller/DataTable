local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
M.is_need_reset_total_wave = false
M.is_need_reset_curr_wave = false
M.is_need_reset_right_wave = false
M.total_wave = 0
M.curr_wave = 0
M.curr_right_wave = 0
M.is_need_show_wave = false
M.is_need_show_right_wave = false
M.show_right_wave_type = nil
M.statistics_type = 0
M.finish_not_add = false
M.change_room_reset = false
M.kill_monster_reach_event_name = nil

function M:get_is_need_show_ware()
  return self.is_need_show_wave
end

function M:get_is_need_show_right_ware()
  return self.is_need_show_right_wave
end

function M:set_is_need_show_ware(is_show)
  self.is_need_show_wave = is_show
end

function M:set_is_need_show_right_wave(is_show)
  self.is_need_show_right_wave = is_show
end

function M:count_down_start(end_time)
  self:set_is_need_show_ware(false)
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if not ui then
    UIMgr:get_ui("gecao_battle"):ui_show(end_time)
  else
    ui:on_start_count_down_timer(end_time)
  end
end

function M:start_timer(use_time, force)
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if FightDataMgr:is_use_default_start_timer() and not FightDataMgr:is_fight_timer_ui_enable() and not force and not ui then
    return
  end
  if not ui then
    self:open_ui(use_time)
  else
    ui:on_start_fight_timer(use_time)
  end
end

function M:open_ui(use_time)
  UIMgr:get_ui("gecao_battle"):ui_show(nil, use_time, nil, function()
    local ui = UIMgr:try_get_visible_ui("gecao_battle")
    if self.is_need_reset_total_wave == true then
      ui:on_get_monster_total_wave(self.total_wave)
      self.is_need_reset_total_wave = false
      self.total_wave = 0
    end
    if true == self.is_need_reset_curr_wave then
      ui:on_get_cur_monster_wave(self.curr_wave)
      self.is_need_reset_curr_wave = false
      self.curr_wave = 0
    end
    if true == self.is_need_reset_right_wave then
      ui:refresh_right_wave_type(self.show_right_wave_type)
      ui:refresh_right_wave(self.curr_right_wave)
      self.is_need_reset_right_wave = false
      self.curr_right_wave = 0
    end
  end)
end

function M:stop_timer(force)
  if FightDataMgr:is_use_default_end_timer() and FightDataMgr:is_fight_timer_ui_enable() and not force then
    return
  end
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if ui then
    if force then
      ui:ui_hide()
    else
      ui:stop_fight_timer()
    end
  end
end

function M:refresh_total_wave(num)
  self:set_is_need_show_ware(true)
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if ui then
    ui:on_get_monster_total_wave(num)
  else
    self.is_need_reset_total_wave = true
    self.total_wave = num
  end
end

function M:refresh_current_wave(num)
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if ui then
    ui:on_get_cur_monster_wave(num)
  else
    self.is_need_reset_curr_wave = true
    self.curr_wave = num
  end
end

function M:refresh_right_wave(num, show_type)
  self:set_is_need_show_right_wave(true)
  local ui = UIMgr:try_get_visible_ui("gecao_battle")
  if ui then
    ui:refresh_right_wave(num)
    if show_type then
      ui:refresh_right_wave_type(show_type)
    end
  else
    self.is_need_reset_right_wave = true
    self.curr_right_wave = num
    if show_type then
      self.show_right_wave_type = show_type
    end
    ui = UIMgr:try_get_ui("gecao_battle")
    if not ui then
      self:open_ui(nil)
    end
  end
end

function M:refresh_statistics_monster_info(statistics_type, finish_not_add, change_room_reset, kill_monster_reach_event_name)
  self.statistics_type = statistics_type or 0
  self.finish_not_add = finish_not_add
  self.change_room_reset = change_room_reset
  self.kill_monster_reach_event_name = kill_monster_reach_event_name
end

function M:get_statistics_type()
  return self.statistics_type
end

function M:get_curr_kill_count()
  if not ChallengeRingPlusMgr then
    return 0
  end
  return ChallengeRingPlusMgr:get_curr_kill_count(self.statistics_type)
end

function M:reset_kill_monster_reach_event()
  self.kill_monster_reach_event_name = nil
end

function M:reset_kill_monster()
  self.kill_monster_reach_event_name = nil
  local ge_cao_ui = UIMgr:try_get_ui("gecao_battle")
  if ge_cao_ui then
    ge_cao_ui:reset_right_wave()
  end
  if ChallengeRingPlusMgr then
    ChallengeRingPlusMgr:reset_kill_enemy_list()
  end
end

function M:get_finish_not_add()
  return self.finish_not_add
end

function M:get_change_room_reset()
  return self.change_room_reset
end

function M:get_kill_monster_reach_event_name()
  return self.kill_monster_reach_event_name
end

function M:reset_show_status()
  self:set_is_need_show_ware(false)
  self:set_is_need_show_right_wave(false)
  self.show_right_wave_type = nil
end

return M
