local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local CT_Timer = Global.ct_timer
local CommonDefine = require("cs_share.common_define")
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local is_need_refresh_score = false
local fight_type
local base_score = 0
local seconds_score = 0
local fixed_seconds_score = 0
local live_score = 0
local number_to_int, scene_logic_timer_end_event_name

function M:ui_finish_load()
  self.v_init_pos_x = self.v_uicompents.CTTimeTips_rect:GetAnchoredPositionA()
end

function M:ui_on_show(seconds, text, event_name)
  scene_logic_timer_end_event_name = event_name
  self.v_ct_seconds = seconds
  self.v_millisecond_counter = 0
  self.v_uicompents.Text_txt.text = text
  self.v_start_time = Date.server_time()
  self.v_uiobjects.Root:SetActive(true)
  self:register_event()
  self:start_count_down_timer()
  is_need_refresh_score = false
  self.v_uiobjects.EndLessScoreTips:SetActive(false)
  self:refresh_cttimetips_pos()
end

function M:refresh_end_less_score_tips()
  self.v_uiobjects.EndLessScoreTips:SetActive(false)
  if not TowerMgr then
    return
  end
  fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI and fight_type ~= CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return
  end
  is_need_refresh_score = true
  self.v_uiobjects.EndLessScoreTips:SetActive(true)
  local point_id = TowerMgr:get_cur_point_id()
  if fight_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI then
    number_to_int = math.floor
    local all_config = ShareRes.get_weekly_prepare_war()
    for i, cfg in pairs(all_config) do
      if cfg.EpiID == point_id then
        base_score = cfg.BaseScore
        seconds_score = cfg.SecondScore
        fixed_seconds_score = cfg.FixedSecondScore
        live_score = cfg.LiveScore
        break
      end
    end
  else
    number_to_int = math.ceil
    local data = WeeklyMgr:get_player_pvp_data()
    local cur_segment = data.segment
    local segment_cfg = ShareRes.get_week_acty_segment_cfg(cur_segment)
    base_score = segment_cfg.LvBaseScore
    local all_config = ShareRes.create("activity.week_acty_episode")
    for i, epi_group_cfg in pairs(all_config) do
      local is_hava = false
      for i, epi_id in pairs(epi_group_cfg.EpisodeList) do
        if epi_id == point_id then
          is_hava = true
          seconds_score = epi_group_cfg.SecondScore
          fixed_seconds_score = epi_group_cfg.FixedSecondScore
          live_score = epi_group_cfg.LiveScore
          break
        end
      end
      if is_hava then
        break
      end
    end
  end
  self:refresh_live_score()
end

function M:refresh_live_score(msg)
  local is_hero = msg and msg.mm_x
  if false == is_hero then
    return
  end
  fight_type = TowerMgr:get_fight_type()
  if fight_type ~= CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI and fight_type ~= CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  local cur_hp = 0
  local max_hp = 0
  for i, hero in pairs(hero_list) do
    cur_hp = cur_hp + hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    max_hp = max_hp + hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_HP_MAX)
  end
  local score = number_to_int(base_score * live_score * (cur_hp / max_hp) * 100)
  self.v_uicompents.HpScoreNum_txt.text = tostring(score)
end

function M:refresh_time_score(seconds)
  if not is_need_refresh_score then
    return
  end
  self.v_uicompents.TimeScoreNum_txt.text = tostring(base_score * seconds * seconds_score + fixed_seconds_score)
end

function M:ui_on_hide()
  self:unbind_all_auto_mq()
  self:clear_timer()
  self:clear_pause_timer()
end

function M:ui_on_update(dt)
  if Global.is_open_timer and JournalMgr:get_oepn_record_jiournal_info() and self.v_ct_timer then
    self.v_millisecond_counter = self.v_millisecond_counter + dt
    JournalMgr:record_cur_time(self.v_ct_seconds + self.v_start_time - Date.server_time() + self.v_millisecond_counter)
  end
  if self.v_pause_start_time then
    return
  end
  self:refresh_count_down_time()
end

function M:start_count_down_timer(seconds)
  self.v_ct_seconds = seconds or self.v_ct_seconds
  if self.v_ct_seconds > 0 and Global.is_open_timer and JournalMgr:get_oepn_record_jiournal_info() then
    self.v_millisecond_counter = 0
  end
  return false
end

function M:create_countdown_timer(timer_name, limit_time, cb)
  self:clear_timer()
  self.v_ct_timer = CT_Timer:add_timer(timer_name, limit_time, function()
    if cb then
      cb()
    end
  end)
end

function M:refresh_count_down_time()
  local seconds = self.v_ct_seconds + self.v_start_time - Date.server_time()
  if self.v_curr_show_seconds and self.v_curr_show_seconds == seconds then
    return
  end
  self.v_curr_show_seconds = seconds
  TowerMgr:check_tower_task_update(Config.CommonDefine.TOWER_TASK_TYPE.FIGHT_TIME, false, math.max(0, Date.server_time() - self.v_start_time))
  if seconds <= 0 then
    self:clear_timer()
    self:ui_hide()
    if scene_logic_timer_end_event_name then
      BehaviorMgr:call_scene_logic_event_fun("on_ct_timer_end", scene_logic_timer_end_event_name)
      scene_logic_timer_end_event_name = nil
    end
    return
  end
  local count_down_text = self.v_uicompents.CTTime_txt
  local remain_min = math.floor(seconds / 60)
  local remain_sec = seconds % 60
  local temp_text = string.format("%02d:%02d", remain_min, remain_sec)
  count_down_text.text = temp_text
  self:refresh_time_score(seconds)
  self.v_record_time = temp_text
end

function M:get_record_time()
  return self.v_record_time or 0
end

function M:fight_end()
  self:ui_hide()
end

function M:pause_timer()
  if self.v_pause_start_time then
    return
  end
  self.v_pause_start_time = Date.server_time()
  self:clear_timer()
  return true
end

function M:restart_timer()
  if self.v_pause_start_time == nil then
    return
  end
  local pause_seconds = Date.server_time() - self.v_pause_start_time
  self.v_start_time = self.v_start_time + pause_seconds
  self:start_count_down_timer()
  self.v_pause_start_time = nil
  return true
end

function M:on_game_pause_state_changed(msg)
  local is_pause = msg.mm_x
  if is_pause then
    self:pause_timer()
    self.v_uiobjects.Root:SetActive(false)
  else
    self:restart_timer()
    self.v_uiobjects.Root:SetActive(true)
  end
end

function M:on_pre_tp_room()
  self.v_uiobjects.Root:SetActive(false)
end

function M:on_tp_toom_finish()
  self.v_uiobjects.Root:SetActive(true)
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
end

function M:clear_timer()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
end

function M:clear_pause_timer()
  if self.v_pause_timer then
    Timer:remove_timer(self.v_pause_timer)
    self.v_pause_timer = nil
  end
end

function M:refresh_cttimetips_pos()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == Config.CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    self.v_uicompents.CTTimeTips_rect:SetAnchoredPositionX(560)
  else
    self.v_uicompents.CTTimeTips_rect:SetAnchoredPositionX(self.v_init_pos_x)
  end
end

return M
