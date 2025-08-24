local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local CT_Timer = Global.ct_timer
local CT_Use_Time_Limit = 86400

function M:ui_finish_load()
  self.v_init_pos = self.v_uicompents.Layout_rect.anchoredPosition
end

function M:ui_on_show(end_time, use_time, is_continue, on_show_callback)
  self.v_is_continue = is_continue
  self.v_use_time = FightDataMgr:get_use_time()
  self.v_is_count_down = false
  self.v_millisecond_counter = 0
  local uobj = self.v_uiobjects
  uobj.CTTime:SetActive(false)
  uobj.Time:SetActive(false)
  uobj.Wave:SetActive(false)
  uobj.RightWave:SetActive(false)
  self:register_event()
  if end_time then
    self:on_start_count_down_timer(end_time)
  else
    self:on_start_fight_timer()
  end
  self.v_uiobjects.Root:SetActive(true)
  if on_show_callback then
    on_show_callback()
  end
  self:refresh_layout_pos()
  self:refresh_icon(true)
end

function M:ui_on_hide()
  self:unbind_all_auto_mq()
  self:clear_timer()
  self:clear_pause_timer()
end

function M:on_start_count_down_timer(end_time)
  if self:start_count_down_timer(end_time) then
    self.v_is_count_down = true
    local uobj = self.v_uiobjects
    uobj.UpRight:SetActive(true)
    uobj.CTTime:SetActive(true)
    uobj.Time:SetActive(false)
    uobj.Wave:SetActive(false)
  end
end

function M:start_count_down_timer(end_time)
  self.v_count_down_end_time = end_time
  local sever_time = Date.server_time()
  local count_down_time = end_time - sever_time or 0
  if count_down_time > 0 and not self.v_ct_timer then
    self:refresh_count_down_time(end_time)
    self:create_countdown_timer("cut_grass_count_down", count_down_time, function()
      self:refresh_count_down_time(end_time)
    end)
    return true
  end
  return false
end

function M:create_countdown_timer(timer_name, limit_time, cb)
  self:clear_timer()
  CT_Timer:add_timer(timer_name, limit_time, function()
    if cb then
      cb()
    end
  end)
end

function M:refresh_count_down_time(end_time)
  local count_down_text = self.v_uicompents.StartAhead_txt
  local sever_time = Date.server_time()
  local count_down_time = end_time - sever_time
  if count_down_time < 0 then
    self:clear_timer()
    self.v_uiobjects.CTTime:SetActive(false)
    self.v_uiobjects.UpRight:SetActive(false)
  end
  local remain_hour = math.floor(count_down_time / 3600)
  local rest_time = count_down_time % 3600
  local remain_min = math.floor(rest_time / 60)
  local remain_sec = rest_time % 60
  count_down_text.text = string.format("%02d:%02d", remain_min, remain_sec)
end

function M:ui_on_update(dt)
  if Global.is_open_timer and JournalMgr:get_oepn_record_jiournal_info() and self.v_ct_timer then
    self.v_millisecond_counter = self.v_millisecond_counter + dt
    JournalMgr:record_cur_time(self.v_use_time + self.v_millisecond_counter)
  end
end

function M:refresh_use_time()
  local count_down_text = self.v_uicompents.TimeNum_txt
  self.v_use_time = FightDataMgr:get_use_time()
  local remain_hour = math.floor(self.v_use_time / 3600)
  local rest_time = self.v_use_time % 3600
  local remain_min = math.floor(rest_time / 60)
  local remain_sec = rest_time % 60
  if remain_hour > 0 then
    count_down_text.text = string.format("%02d:%02d:%02d", remain_hour, remain_min, remain_sec)
  else
    count_down_text.text = string.format("%02d:%02d", remain_min, remain_sec)
  end
  TowerMgr:check_tower_task_update(Config.CommonDefine.TOWER_TASK_TYPE.FIGHT_TIME, false, self.v_use_time)
  if Global.is_open_timer and JournalMgr:get_oepn_record_jiournal_info() then
    self.v_millisecond_counter = 0
  end
end

function M:on_start_fight_timer()
  self.v_is_count_down = false
  self.v_use_time = FightDataMgr:get_use_time()
  local uobj = self.v_uiobjects
  uobj.UpRight:SetActive(true)
  uobj.CTTime:SetActive(false)
  uobj.Time:SetActive(true)
  if self.v_is_continue then
    self.v_start_time = FightDataMgr:get_start_time()
    self:refresh_use_time(self.v_start_time)
    self.v_is_continue = nil
    return
  end
  if self.v_use_time and self.v_use_time > 0 then
    self:start_fight_timer()
  else
    self:start_fight_timer()
  end
end

function M:start_fight_timer(start_time)
  self.v_start_time = FightDataMgr:get_start_time()
  self:refresh_use_time(self.v_start_time)
  self.v_is_pause_timer = false
  self.v_ct_timer = FightDataMgr:listen_timer_refresh(function()
    if self:is_ready() then
      self:refresh_use_time(self.v_start_time)
    end
  end)
end

function M:set_root_obj_visiability(is_visible)
  local uobj = self.v_uiobjects
  uobj.UpRight:SetActive(is_visible)
  uobj.Wave:SetActive(is_visible and GeCaoBattleMgr:get_is_need_show_ware())
  uobj.RightWave:SetActive(is_visible and GeCaoBattleMgr:get_is_need_show_right_ware())
end

function M:stop_fight_timer()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  if tower:get_tower_pass() then
    self:ui_hide()
    return
  end
  self:pause_timer()
  self.v_uiobjects.Wave:SetActive(false)
  self:clear_pause_timer()
end

function M:fight_end()
  local cur_floor = TowerMgr:get_pass_floor()
  local tower = TowerMgr:get_tower()
  local max_floor = 0
  if tower then
    max_floor = tower:get_max_floor()
  end
  if cur_floor >= max_floor then
    self:ui_hide()
  end
end

function M:on_get_monster_total_wave(num)
  self.v_uicompents.Max_txt.text = num
  self.v_uiobjects.Wave:SetActive((GeCaoBattleMgr:get_is_need_show_ware()))
end

function M:on_get_cur_monster_wave(num)
  self.v_uicompents.Now_txt.text = num
end

function M:pause_timer(is_hide_ui)
  self.v_pause_start_time = Date.server_time()
  self.v_is_pause_timer = true
  self:clear_timer()
  if is_hide_ui then
    self:set_root_obj_visiability(false)
  end
end

function M:restart_timer()
  self.v_pause_end_time = Date.server_time()
  if self.v_pause_start_time == nil or not self.v_is_pause_timer then
    return
  end
  if self.v_is_count_down then
    local end_time = self.v_pause_end_time - self.v_pause_start_time + self.v_count_down_end_time
    self:start_count_down_timer(end_time)
  else
    local start_time = self.v_pause_end_time - self.v_pause_start_time + self.v_start_time
    self:start_fight_timer(start_time)
  end
  self.v_is_pause_timer = false
  self:set_root_obj_visiability(true)
end

function M:on_game_pause_state_changed(msg)
  if self:get_time_is_stop() then
    return
  end
  local is_pause = msg.mm_x
  if is_pause then
    self:pause_timer(true)
  else
    self:restart_timer()
  end
end

function M:on_pre_tp_room()
  self.v_uiobjects.UpRight:SetActive(false)
end

function M:on_tp_toom_finish()
  self.v_uiobjects.UpRight:SetActive(true)
end

function M:on_show_ui(msg)
  if msg.mm_obj == "fight" then
    self.v_uiobjects.Root:SetActive(true)
  end
end

function M:on_hide_ui(msg)
  if msg.mm_obj == "fight" then
    self.v_uiobjects.Root:SetActive(false)
  end
end

function M:register_event()
  self:bind_auto_mq(Const.MSG_ON_FIGHT_END, self.fight_end, self)
  self:bind_auto_mq(Const.MSG_ON_GAME_PAUSE, self.on_game_pause_state_changed, self)
  self:bind_auto_mq(Const.MSG_PRE_TP_ROOM, self.on_pre_tp_room, self)
  self:bind_auto_mq(Const.MSG_TP_ROOM_FINISH, self.on_tp_toom_finish, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.on_hide_ui, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.on_show_ui, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_START, self.on_hide_ui, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_END, self.on_show_ui, self)
  self:bind_auto_mq(Const.KILL_ENEMY_COUNT_REFRESH, self.on_kill_enemy_count_refresh, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DEFAULT_TIMER_PAUSE, self.on_fight_default_timer_pause, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_TIMER_PAUSE_NOTICE_HIDE, self.hide_notice_tips, self)
end

function M:refresh_wave_num(num)
  local ucom = self.v_uicompents
  ucom.Now_txt.text = num
end

function M:clear_timer()
  if self.v_ct_timer then
    FightDataMgr:remove_timer_refresh_listen(self.v_ct_timer)
    self.v_ct_timer = nil
  end
end

function M:get_time_is_stop()
  local tower = TowerMgr:get_tower()
  if tower then
    local room = tower:get_room()
    if room then
      return room:is_fight_end()
    else
      return false
    end
  else
    return false
  end
end

function M:clear_pause_timer()
  if self.v_pause_timer then
    Timer:remove_timer(self.v_pause_timer)
    self.v_pause_timer = nil
  end
end

function M:get_use_time()
  return self.v_use_time
end

function M:on_kill_enemy_count_refresh(msg)
  if not self.total_right_wave then
    return
  end
  local curr_right_wave = msg.mm_x
  local kill_type = msg.mm_y
  if kill_type ~= GeCaoBattleMgr:get_statistics_type() then
    return
  end
  if self.total_right_wave and curr_right_wave and curr_right_wave > self.total_right_wave and GeCaoBattleMgr:get_finish_not_add() then
    return
  end
  if curr_right_wave >= self.total_right_wave then
    local event_name = GeCaoBattleMgr:get_kill_monster_reach_event_name()
    if event_name then
      BehaviorMgr:call_scene_logic_event_fun("on_kill_monster_reach", event_name)
      GeCaoBattleMgr:reset_kill_monster_reach_event()
    end
  end
  self:refresh_right_wave(self.total_right_wave, curr_right_wave)
end

function M:refresh_right_wave(wave, curr)
  if wave then
    self.total_right_wave = wave
  end
  if 0 == self.show_type then
    self.v_uicompents.RightWareNow_txt.text = wave
  elseif 1 == self.show_type then
    curr = curr or GeCaoBattleMgr:get_curr_kill_count()
    self.v_uicompents.RightWareNow_txt.text = string.format("%s/%s", curr, wave)
  end
  self.v_uiobjects.RightWave:SetActive(GeCaoBattleMgr:get_is_need_show_right_ware())
end

function M:reset_right_wave()
  self:refresh_right_wave(self.total_right_wave, 0)
end

function M:refresh_right_wave_type(show_type)
  self.show_type = show_type
  self:refresh_text_with_show_type()
end

function M:refresh_text_with_show_type()
  if 0 == self.show_type then
    self.v_uicompents.RightWareDesc_txt.text = "轮次"
  elseif 1 == self.show_type then
    self.v_uicompents.RightWareDesc_txt.text = "击杀"
  end
end

function M:refresh_layout_pos()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == Config.CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    self.v_uicompents.Layout_rect:SetAnchoredPositionA(367, self.v_init_pos.y)
  else
    self.v_uicompents.Layout_rect.anchoredPosition = self.v_init_pos
  end
end

function M:on_fight_default_timer_pause(msg)
  if self.v_uiobjects.TimeNum.activeSelf then
    self:refresh_icon(msg.mm_x)
    if not msg.mm_y then
      self.v_uiobjects.TimeStopTips:SetActive(msg.mm_x == true)
    end
  end
end

function M:hide_notice_tips(msg)
  if self.v_uiobjects.TimeNum.activeSelf then
    self.v_uiobjects.TimeStopTips:SetActive(not msg.mm_x)
  end
end

function M:refresh_icon(is_pause)
  self.v_uiobjects.TimeRun:SetActive(not is_pause)
  self.v_uiobjects.TimePause:SetActive(is_pause)
end

return M
