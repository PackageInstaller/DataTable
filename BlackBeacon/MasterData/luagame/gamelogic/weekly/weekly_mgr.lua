local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local TEAM_BUDDY_TYPE = CommonDefine.TEAM_BUDDY_TYPE
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local TASK_STATE = BATTLE_TASK_CFG.TASK_STATE
local TASK_CONFIG = require("gamelogic.task.task_config")
local NEW_TASK_STATE = TASK_CONFIG.TASK_STATE
local CommonDef = require("cs_share.common_define")
local ActivityCfg = require("gamelogic.activity.activity_config")
local LocalStorage = require("utils.localstorage")
local ACTY_TYPE = CommonDef.ACTY_TYPE
local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID
local ONE_DAY_SECS = 86400
M.battle_type = 1
M.is_open_rune = false
M.once_request_top_rank_count = 500
M.max_difficulty = 0

function M:init_sys()
  Base.init_sys(self)
  self:reset_data()
end

function M:on_reconnect()
  self:reset_data()
end

function M:reset_data()
  self.v_hurdle_list = {}
end

function M:init_hurdle_data(data)
  local all_hurdle_data = data.prepare_war_epi_list
  for _, info in pairs(all_hurdle_data) do
    local id = info.epi_id
    self.v_hurdle_list[id] = info
  end
end

function M:refresh_hurdle_data(data)
  local hurdle_data = data.prepare_war_epi_data
  local idx = hurdle_data.epi_id
  self.v_hurdle_list[idx] = hurdle_data
  local msg = MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_REFRESH_HURDLE_DATA)
  msg.mm_obj = idx
end

function M:update_weekly_team_data(hurdle_id, pos, buddy_id, is_pvp, is_temp)
  if not is_pvp then
    return
  end
  local team_data = self:get_pvp_hurdle_team_data(hurdle_id, is_temp)
  if not team_data then
    return
  end
  local is_new_buddy = true
  for _, data in pairs(team_data) do
    if data.buddy_pos == pos then
      data.buddy_id = buddy_id
      is_new_buddy = false
      data.rune_pos = {}
    elseif data.buddy_id == buddy_id and data.buddy_pos ~= pos then
      data.buddy_id = 0
    end
    if 0 == data.buddy_id then
      data.rune_pos = {}
    end
  end
  if is_new_buddy then
    local data = {
      buddy_pos = pos,
      buddy_id = buddy_id,
      rune_pos = {}
    }
    table.insert(team_data, data)
  end
end

function M:update_weekly_buddy_team_first_pos(pos_index, fight_type, epi_id, is_temp)
  local cur_team_data = self:get_hurdle_team_data(fight_type, epi_id, is_temp)
  if cur_team_data then
    for _, data in pairs(cur_team_data) do
      if data.buddy_pos == pos_index then
        data.is_first_pos = true
      else
        data.is_first_pos = false
      end
    end
  end
end

function M:get_hurdle_star_award(hurdle_id, star_num)
  local data = self.v_hurdle_list[hurdle_id]
  if not data then
    return
  end
  local index = data.index
  if not self:check_get_star_award(hurdle_id, star_num) then
    return
  end
  Network:call("c2gs_week_acty_prepare_epi_stat_reward", {prepare_epi_index = index, stat_num = star_num}, function(ok, resp)
    if ok then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_GET_STAR_REWARD_SUC)
      msg.mm_obj = hurdle_id
      msg.mm_x = star_num
    end
  end)
end

function M:request_weekly_prepare_score(callback)
  Network:call("c2gs_tower_settlement_before", {}, function(ok, resp)
    Log.Info("c2gs_tower_settlement_before callback = ", ok, resp)
    if ok then
      self.v_last_weekly_fraction_data = self.v_weekly_fraction_data
      self.v_weekly_fraction_data = resp.week_acty_fraction
      if callback then
        callback()
      end
    end
  end)
end

function M:set_weekly_score_info(data)
  self.v_weekly_fraction_data = data
end

function M:get_weekly_fraction_data()
  return self.v_weekly_fraction_data
end

function M:check_weekly_fight(change_type, is_pvp)
  if not is_pvp then
    if change_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or change_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
      return true
    end
  elseif change_type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function M:set_weekly_fight_wave_num(num)
  local fight_progress = TowerMgr:get_tower_progress()
  if not fight_progress then
    return
  end
  local change_type = fight_progress.challenge_type
  if not self:check_weekly_fight(change_type) then
    return
  end
  self.v_fight_wave_num = num
end

function M:get_weekly_fight_wave_num()
  return self.v_fight_wave_num or 0
end

function M:check_get_star_award(hurdle_id, star_num)
  local star_map = self:get_hurdle_star_map(hurdle_id)
  local star_get_map = self:get_hurdle_star_reward_map(hurdle_id)
  if not star_map[star_num] or star_get_map[star_num] then
    return false
  end
  return true
end

function M:get_weekly_hurdle_data(id, is_pvp)
  if not is_pvp then
    return self.v_hurdle_list[id]
  else
    return self.v_pvp_hurdle_data[id]
  end
end

function M:get_hurdle_data(id)
  return self.v_hurdle_list[id]
end

function M:check_hurdle_lock(idx)
  local data = self.v_hurdle_list[idx]
  if not data then
    return true
  end
  return data.is_lock
end

function M:check_hurdle_first_suc(idx)
  local data = self.v_hurdle_list[idx]
  if not data then
    return true
  end
  return data.first_reward
end

function M:check_hurdle_complete(idx)
  local data = self.v_hurdle_list[idx]
  if not data then
    return
  end
  return #data.star_map >= 3
end

function M:get_hurdle_score(idx)
  local data = self.v_hurdle_list[idx]
  if not data then
    return
  end
  return data.fraction_num
end

function M:get_hurdle_star_map(idx)
  local list = {}
  local data = self.v_hurdle_list[idx]
  if not data then
    return list
  end
  if not data.star_map then
    return list
  end
  for _, value in pairs(data.star_map) do
    list[value] = true
  end
  return list
end

function M:get_hurdle_star_reward_map(idx)
  local list = {}
  local get_num = 0
  local data = self.v_hurdle_list[idx]
  if not data then
    return list, get_num
  end
  if not data.star_reward then
    return list, get_num
  end
  for _, value in pairs(data.star_reward) do
    list[value] = true
    get_num = get_num + 1
  end
  return list, get_num
end

function M:get_entry_red()
  if not SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.WEEK_ACTY]) or not ActivityMgr:get_activity_is_open(ACTY_TYPE.WEEK_ACTY) then
    return false, true
  end
  if self:check_weekly_pvp_opn() then
    local task_red = self:get_pvp_task_red_num()
    if task_red > 0 then
      return true
    end
    local is_can_get_star_award = self:get_star_award_red_state()
    if is_can_get_star_award then
      return true
    end
  else
    local task_group_id = ShareRes.get_weekly_prepare_war_epi_task_group_id()
    return TaskMgr:get_task_group_red(task_group_id)
  end
  return false
end

function M:get_hurdle_team(hurdle_id, is_pvp, is_temp)
  if not is_pvp then
    return
  end
  local team_data = self:get_pvp_hurdle_team_data(hurdle_id, is_temp)
  local pos_data = {}
  for _, data in pairs(team_data) do
    pos_data[data.buddy_pos] = data
  end
  return team_data, pos_data
end

function M:get_buddy_team_data(hurdle_id, buddy_id, is_pvp)
  local team_data = self:get_hurdle_team(hurdle_id, is_pvp)
  if not team_data then
    return
  end
  local buddy_team_data
  for _, data in pairs(team_data) do
    if data.buddy_id == buddy_id then
      buddy_team_data = data
      break
    end
  end
  return buddy_team_data
end

function M:get_hurdle_history_score(hurdle_id)
  local hurdle_data = self.v_hurdle_list[hurdle_id]
  if not hurdle_data then
    return
  end
  local score = hurdle_data.fraction_num
  return score
end

function M:on_init_weekly_pvp_data(data)
  self:refresh_max_difficulty()
  self.v_weekly_pvp_state = data.acty_pvp_state
  self.v_weekly_pvp_player_data = data.player_data
  self:refresh_stage_epi_data()
  self:request_rank_list(self.max_difficulty, 1, self.once_request_top_rank_count, true)
  MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_UPDATE_PVP_SEGMENT)
end

function M:on_update_week_acty_pvp_data(data)
  if data.acty_pvp_state then
    self.v_weekly_pvp_state = data.acty_pvp_state
  end
  if data.player_data then
    self.v_weekly_pvp_player_data = data.player_data
  end
  self:refresh_stage_epi_data()
end

function M:get_is_new_season()
  return self.v_weekly_pvp_player_data and self.v_weekly_pvp_player_data.is_new
end

function M:get_is_opened_pvp_key()
  local period = M:get_pvp_period()
  return Config.WEEKLY_IS_OPENED_PVP_STATE .. period
end

function M:is_weekly_reset()
  if not SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.WEEK_ACTY]) or not ActivityMgr:get_activity_is_open(ACTY_TYPE.WEEK_ACTY) then
    return false
  end
  local key = M:get_is_opened_pvp_key()
  local value = 0 == LocalStorage:load_int(key, 0, true)
  return value
end

function M:set_weekly_reset_finish()
  local key = M:get_is_opened_pvp_key()
  LocalStorage:save_int(key, 1, true)
end

function M:set_week_new_season_read(type, stage)
  if 0 == type then
    local data = self:get_stage_data(self:get_weekly_stage())
    data.is_new = false
  elseif 1 == type then
    local data = self:get_stage_data(self:get_weekly_stage())
    data.is_pop_reward = false
  elseif 2 == type then
    self.v_weekly_pvp_player_data.is_new = false
  end
  Network:call("c2gs_week_acty_pvp_read", {type = type, stage = stage}, nil)
end

function M:reset_top_rank()
  self.v_top_rank = {}
end

function M:refresh_max_difficulty()
  self.max_difficulty = 0
  local segment_cfg = ShareRes.get_week_acty_segment_cfg()
  for i, cfg in pairs(segment_cfg) do
    if cfg.Id > self.max_difficulty then
      self.max_difficulty = cfg.Id
    end
  end
end

function M:get_max_difficulty()
  return self.max_difficulty
end

function M:get_pvp_period()
  if self.v_weekly_pvp_player_data then
    return self.v_weekly_pvp_player_data.periods or 0
  end
  return 0
end

function M:get_pvp_total_score()
  if self.v_weekly_pvp_player_data then
    return self.v_weekly_pvp_player_data.fraction or 0
  end
  return 0
end

function M:get_pvp_open_difficulty_list()
  if self.v_weekly_pvp_player_data then
    return self.v_weekly_pvp_player_data.open_segment_list
  end
  return nil
end

function M:get_pvp_difficulty_choose_count()
  if self.v_weekly_pvp_player_data then
    return self.v_weekly_pvp_player_data.choose_cnt or 0
  end
  return 0
end

function M:request_change_weekly_pvp_difficulty(difficulty)
  local state = self:get_weekly_pvp_player_state()
  local body = {segment = difficulty}
  if state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE or state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE_CHOOSE_SEGMENT then
    Network:call("c2gs_in_participate_week_acty_pvp", body, function(ok, resp)
      if ok then
        MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_PVP_DIFFICULTY_CHANGE)
      end
    end)
  else
    Network:call("c2gs_change_week_acty_pvp_segment", body, function(ok, resp)
      if ok then
        MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_PVP_DIFFICULTY_CHANGE)
      end
    end)
  end
end

function M:get_task_group_id()
  local cfg = ShareRes.get_weekly_pvp_activity_cfg()
  return cfg.TaskGroup
end

function M:request_rank_list(difficulty, start_pos, count, is_init)
  local rank_name = Util.format_str("{1}-{2}", CommonDefine.RANK_NAME.WEEK_ACTY_PVP_SCORE, difficulty)
  local body = {
    rank_name = rank_name,
    start_pos = start_pos,
    count = count
  }
  Network:call("c2gs_get_rank_list", body, function(ok, resp)
    if ok then
      self:update_rank_data(resp, is_init)
      MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_UPDATE_PVP_RANK_DATA)
      MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_PVP_SETLMENT)
    end
  end)
end

function M:get_task_list()
  local task_group_id = self:get_task_group_id()
  local task_list = ShareRes.get_task_group(task_group_id)
  return task_list
end

function M:get_pvp_task_red_num()
  local red_num = 0
  local task_list = self:get_task_list()
  if not task_list then
    return red_num
  end
  for i, task in pairs(task_list) do
    local task_data = TaskMgr:get_task_by_id(task.Id)
    if task_data.state == NEW_TASK_STATE.receive then
      red_num = red_num + 1
    end
  end
  return red_num
end

function M:get_pvp_task_complete_pro()
  local complete_num = 0
  local no_complete_num = 0
  local task_list = self:get_task_list()
  if not task_list then
    return 0, 0
  end
  for id, task in pairs(task_list) do
    local task_data = TaskMgr:get_task_by_id(task.Id)
    if task_data.state >= NEW_TASK_STATE.received then
      complete_num = complete_num + 1
    else
      no_complete_num = no_complete_num + 1
    end
  end
  return complete_num, no_complete_num
end

function M:get_pvp_team_ui_name(point_id)
  local all_config = ShareRes.create("activity.week_acty_episode")
  for i, epi_group_cfg in pairs(all_config) do
    for i, epi_id in pairs(epi_group_cfg.EpisodeList) do
      if epi_id == point_id then
        return epi_group_cfg.StageName
      end
    end
  end
  return nil
end

function M:get_pvp_stage_total_score(stage)
  local score = 0
  local hurdle_list = self.v_pvp_stage_hurdle_list[stage]
  if hurdle_list then
    for key, data in pairs(hurdle_list) do
      score = (data.epi_fraction or 0) + score
    end
  end
  return score
end

function M:get_pvp_history_score(hurdle_id)
  local data = self.v_pvp_hurdle_data[hurdle_id]
  if not data then
    return 0
  end
  return data.epi_fraction
end

function M:get_pvp_hurdle_rune_group_id(hurdle_id)
  local data = self.v_pvp_hurdle_data[hurdle_id]
  if not data then
    return
  end
  local epi_group_id = data.epi_group_id
  local cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(epi_group_id)
  if not cfg then
    return
  end
  return cfg.RuneGroupId
end

function M:update_rank_data(resp, is_init)
  local rank_info = resp.rank_list
  self.v_mine_rank = rank_info.my_rank
  if is_init then
    self.v_top_rank_list = rank_info.rank_list
  else
    for _, data in ipairs(rank_info.rank_list) do
      self.v_top_rank_list[data.rank] = data
    end
  end
end

function M:get_rank_list(rank_type)
  return self.v_top_rank_list
end

function M:get_mine_rank()
  return self.v_mine_rank
end

function M:refresh_stage_epi_data()
  if not self.v_weekly_pvp_player_data then
    return
  end
  self.epi_list = self.v_weekly_pvp_player_data.epi_list
  self.v_pvp_stage_hurdle_list = {}
  self.v_pvp_hurdle_data = {}
  self.v_pvp_team_data = {}
  self.v_pvp_stage_data = {}
  for _, data in pairs(self.epi_list) do
    self.v_pvp_stage_data[data.epi_stage] = data
    self.v_pvp_stage_hurdle_list[data.epi_stage] = data.epi_data
    self.v_pvp_team_data[data.epi_stage] = data.buddy_team
    for _, epi in pairs(data.epi_data) do
      epi.epi_stage = data.epi_stage
      self.v_pvp_hurdle_data[epi.epi_id] = epi
    end
  end
  self:reset_pvp_temp_hurdle_data()
end

function M:reset_pvp_temp_hurdle_data()
  local temp_epi_list = self:deep_copy(self.epi_list)
  self.v_pvp_temp_stage_hurdle_list = {}
  self.v_pvp_temp_hurdle_data = {}
  self.v_pvp_temp_team_data = {}
  for _, data in pairs(temp_epi_list) do
    self.v_pvp_temp_stage_hurdle_list[data.epi_stage] = data.epi_data
    self.v_pvp_temp_team_data[data.epi_stage] = data.buddy_team
    for _, epi in pairs(data.epi_data) do
      epi.epi_stage = data.epi_stage
      self.v_pvp_temp_hurdle_data[epi.epi_id] = epi
    end
  end
end

function M:get_cur_stage_episode_group_id()
  local cur_stage = self:get_weekly_stage()
  local data = self.v_pvp_stage_data[cur_stage]
  return data.epi_group_id
end

function M:get_stage_data(stage)
  if stage then
    return self.v_pvp_stage_data[stage]
  end
  return self.v_pvp_stage_data
end

function M:get_pvp_hurdle_team_data(hurdle_id, is_temp)
  local data
  if is_temp then
    data = self.v_pvp_temp_hurdle_data[hurdle_id]
  else
    data = self.v_pvp_hurdle_data[hurdle_id]
  end
  if not data or not data.epi_stage then
    return
  end
  local buddy_team
  if is_temp then
    buddy_team = self.v_pvp_temp_team_data[data.epi_stage]
  else
    buddy_team = self.v_pvp_team_data[data.epi_stage]
  end
  return buddy_team
end

function M:get_hurdle_team_data(fight_type, hurdle_id, is_temp, is_pvp)
  local cur_team_data = self:get_hurdle_team(hurdle_id, is_pvp)
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    cur_team_data = self:get_pvp_hurdle_team_data(hurdle_id, is_temp)
  end
  return cur_team_data
end

function M:check_fight_type_is_pvp_weekly(fight_type)
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function M:deep_copy(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key, value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function M:on_update_week_pvp_task_data(data)
  local task = data.task
  local id = task.id
  self.v_task_data[id] = task
  local msg = MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_UPDATE_PVP_TASK)
  msg.mm_x = id
end

function M:get_pvp_state()
  return self.v_weekly_pvp_state
end

function M:get_pvp_stage()
  if self:get_pvp_state() == CommonDefine.WEEK_ACTY_PVP_STATE.OPEN_ONE_STAGE or self:get_pvp_state() >= CommonDefine.WEEK_ACTY_PVP_STATE.OPEN_TWO_STAGE then
    return 1
  end
  return 0
end

function M:check_pvp_end()
  if self.v_weekly_pvp_state == CommonDefine.WEEK_ACTY_PVP_STATE.END or self.v_weekly_pvp_state == CommonDefine.WEEK_ACTY_PVP_STATE.INIT then
    return true
  end
end

function M:get_player_pvp_data()
  return self.v_weekly_pvp_player_data
end

function M:get_cur_pvp_segment()
  if not self.v_weekly_pvp_player_data then
    return
  end
  return self.v_weekly_pvp_player_data.segment
end

function M:get_cur_pvp_add_ratio()
  return self.v_weekly_pvp_player_data and self.v_weekly_pvp_player_data.buddy_add_ratio or 0
end

function M:get_pvp_stage_buddy_team(fixed_stage, is_temp)
  local cur_stage = self:get_weekly_stage()
  cur_stage = fixed_stage or cur_stage
  local team_data = is_temp and self.v_pvp_temp_team_data or self.v_pvp_team_data
  return team_data[cur_stage]
end

function M:check_weekly_pvp_opn()
  local state = self:get_weekly_pvp_player_state()
  if not state then
    return
  end
  return state ~= CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.LOCK
end

function M:get_weekly_pvp_player_state()
  local data = self:get_player_pvp_data()
  if not data then
    return
  end
  return data.state
end

function M:check_enter_weekly_pvp(segment, cb)
  if not self:check_weekly_pvp_opn() then
    return
  end
  local state = self:get_weekly_pvp_player_state()
  if not state then
    return
  end
  if state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.IN_PARTICIPATE then
    return
  end
  local body
  local is_need_request = false
  if state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE then
    body = {}
    is_need_request = true
  elseif state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE_CHOOSE_SEGMENT then
    body = {segment = segment}
    is_need_request = true
  end
  if is_need_request then
    Network:call("c2gs_in_participate_week_acty_pvp", body, function(ok, resp)
      if ok then
        Log.Info("c2gs_in_participate_week_acty_pvp ok")
        MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_UPDATE_PVP_SEGMENT)
      end
    end)
    return true
  end
  return false
end

function M:get_pvp_task_data(task_id)
  return self.v_task_data[task_id]
end

function M:get_cur_task_pro_val(task_data, condition_id)
  local pro_data = task_data.progress
  for _, data in pairs(pro_data) do
    if data.id == condition_id then
      return data.progress
    end
  end
  return 0
end

function M:check_get_pvp_task_reward(task_id)
  local task_data = self.v_task_data[task_id]
  Global.log.Debug("task_data = ", task_data)
  if not task_data then
    return
  end
  local task_cfg = ShareRes.get_task_cfg(task_id)
  for _, condition_id in pairs(task_cfg.Condition) do
    if 0 ~= condition_id then
      local condition_cfg = ShareRes.create("condition.condition", condition_id)
      Util.assert(condition_cfg, "缺少条件配置，id = " .. condition_id)
      local need_pro = condition_cfg.Value
      local cur_pro = self:get_cur_task_pro_val(task_data, condition_id)
      if need_pro > cur_pro then
        return
      end
    end
  end
  return true
end

function M:get_pvp_task_reward(task_id)
  if not self:check_get_pvp_task_reward(task_id) then
    return
  end
  Network:call("c2gs_pvp_task_get_reward", {task_id = task_id}, function(ok, resp)
    if ok then
      self.v_task_data[task_id].state = TASK_STATE.GET_REWARD
    end
  end)
end

function M:get_pvp_open_or_end_time(is_open_time)
  local cfg = ShareRes.get_weekly_pvp_activity_cfg()
  local open_time = cfg.OpenTime and Date.get_time_stamp_by_scheme_id(cfg.OpenTime)
  if not open_time then
    return
  end
  local one_cycle_time = cfg.RefreshPeriod * 24 * 60 * 60
  local curr_period = self:get_pvp_period()
  if is_open_time then
    if 0 == curr_period then
      return open_time
    end
    return open_time + one_cycle_time * (curr_period - 1)
  else
    if 0 == curr_period then
      return open_time + one_cycle_time
    end
    return open_time + one_cycle_time * curr_period
  end
end

function M:get_pvp_remaining_time()
  local curr_time = Date.server_time()
  return self:get_pvp_open_or_end_time() - curr_time
end

function M:get_pvp_award_cfg_with_curr_score()
  local all_cfg = self:get_all_difficulty_award_cfg(true)
  local score = self:get_pvp_total_score()
  local final_cfg
  for idx, cfg_list in pairs(all_cfg) do
    local is_find = false
    for i, cfg in pairs(cfg_list) do
      if not final_cfg and score < cfg.Fraction then
        return nil
      end
      if score >= cfg.Fraction then
        final_cfg = cfg
      end
      if score < cfg.Fraction then
        is_find = true
        break
      end
    end
    if is_find then
      break
    end
  end
  return final_cfg
end

function M:get_award_cfg_list_with_difficulty(difficulty)
  local all_cfg = self:get_all_difficulty_award_cfg(true)
  return all_cfg[difficulty]
end

function M:get_all_difficulty_award_cfg(is_small_to_big)
  local all_cfg = ShareRes.create("activity.segment_fraction_reward")
  local all_cfg_list = {}
  for difficulty, cfg_list in pairs(all_cfg) do
    local difficulty_list = {}
    for i, cfg in pairs(cfg_list) do
      table.insert(difficulty_list, cfg)
    end
    all_cfg_list[difficulty] = difficulty_list
  end
  for i, difficulty_list in pairs(all_cfg_list) do
    table.sort(difficulty_list, function(a, b)
      if is_small_to_big then
        return a.Fraction < b.Fraction
      end
      return a.Fraction > b.Fraction
    end)
  end
  return all_cfg_list
end

function M:get_star_award_list_by_state(difficulty)
  local cfg_list = WeeklyMgr:get_award_cfg_list_with_difficulty(difficulty)
  local curr_all_star = WeeklyMgr:get_periods_max_star()
  local state_list = {}
  for i, cfg in pairs(cfg_list) do
    local data = {}
    data.cfg = cfg
    local star = cfg.Fraction
    local is_get = WeeklyMgr:is_get_pvp_award(star)
    local state = 1
    if curr_all_star < star then
      state = 2
    elseif not is_get then
      state = 1
    else
      state = 3
    end
    data.state = state
    table.insert(state_list, data)
  end
  return state_list
end

function M:get_next_start_left_time(open_time)
  local cur_time = Date.server_time()
  local cur_wday = Date:get_week()
  local next_day = open_time.ResetDay
  local end_time
  if cur_wday ~= next_day then
    end_time = Date.get_time_stamp(1, open_time.ResetHour)
  else
    end_time = Date.get_time_stamp(0, open_time.ResetHour)
  end
  local left_time = end_time - cur_time
  return left_time
end

function M:get_daily_reset_time()
  local date = os.date("!*t", Date.server_time())
  local next_reset_date
  local daily_reset_hour = Global.daily_reset_hour
  if daily_reset_hour > date.hour then
    return Date.to_timestamp({
      year = date.year,
      month = date.month,
      day = date.day,
      hour = daily_reset_hour,
      min = 0,
      sec = 0
    })
  else
    next_reset_date = os.date("!*t", Date.server_time() + ONE_DAY_SECS)
    return Date.to_timestamp({
      year = next_reset_date.year,
      month = next_reset_date.month,
      day = next_reset_date.day,
      hour = daily_reset_hour,
      min = 0,
      sec = 0
    })
  end
end

function M:get_weekly_shop_reset_time(day)
  if 0 == day then
    day = 2
  end
  local next_day_time = self:get_daily_reset_time()
  local date = os.date("!*t", next_day_time)
  if date.wday - 1 == day then
    return next_day_time
  end
  local days = day < date.wday and day + 7 - date.wday or day - date.wday
  return next_day_time + (days + 1) * ONE_DAY_SECS
end

function M:check_pvp_use_buddy(buddy_id, is_temp, epi_id)
  return true
end

function M:get_is_pvp_used(buddy_id)
  local cur_stage = self:get_weekly_stage()
  for index, team_data in pairs(self.v_pvp_team_data) do
    if index == cur_stage then
    elseif not team_data or 0 == #team_data then
    else
      for idx, buddy_info in pairs(team_data) do
        if buddy_id == buddy_info.buddy_id then
          return true
        end
      end
    end
  end
  return false
end

function M:get_now_star()
  local all_hurdle_cfg = ShareRes.get_weekly_prepare_war()
  if not all_hurdle_cfg then
    return 0
  end
  local num = 0
  for idx, cfg in ipairs(all_hurdle_cfg) do
    local star_map = WeeklyMgr:get_hurdle_star_map(cfg.EpiID)
    for idx = 1, 3 do
      local value = star_map[idx]
      if true == value then
        num = num + 1
      end
    end
  end
  return num
end

function M:get_total_star()
  local all_hurdle_cfg = ShareRes.get_weekly_prepare_war()
  if not all_hurdle_cfg then
    return 0
  end
  local num = 0
  for idx, cfg in ipairs(all_hurdle_cfg) do
    num = num + 3
  end
  return num
end

function M:check_weekly_fight(fight_type)
  if fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI or fight_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    return true
  end
  return false
end

function M:get_next_epi_id(type, epi_id)
  local next_epi_id = 0
  if type == CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI then
    local pos = 1
    local all_hurdle_cfg = ShareRes.get_weekly_prepare_war()
    for _, cfg in pairs(all_hurdle_cfg) do
      if cfg.EpiID == epi_id then
        pos = cfg.Pos
        break
      end
    end
    for _, cfg in pairs(all_hurdle_cfg) do
      if cfg.Pos == pos + 1 then
        next_epi_id = cfg.EpiID
        break
      end
    end
  else
    local group_id = self:get_cur_stage_episode_group_id()
    local group_cfg = ShareRes.get_weekly_pvp_epi_pool_cfg(group_id)
    for i, cfg_epi_id in ipairs(group_cfg.EpisodeList) do
      if epi_id < cfg_epi_id then
        next_epi_id = cfg_epi_id
        break
      end
    end
  end
  return next_epi_id
end

local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local week_activity_pvp_open_ui_key = "week_activity_pvp_open_ui_key"

function M:get_week_activity_pvp_opened_key()
  local key = "week_activity_pvp_open_ui_key" .. PlayerMgr:get_player_uid()
  return key
end

function M:set_week_activity_pvp_opened(value)
  UnityPlayerPrefs.SetInt(self:get_week_activity_pvp_opened_key(), value)
end

function M:get_week_activity_pvp_opened()
  local key = self:get_week_activity_pvp_opened_key()
  if UnityPlayerPrefs.HasKey(key) then
    return UnityPlayerPrefs.GetInt(key)
  end
  return 0
end

function M:get_week_enter_icon(area_value)
  local data = ShareRes.create("activity.week_acty_enter_icon", area_value)
  return data.IconPath
end

function M:set_battle_type(value)
  self.battle_type = value
end

function M:get_battle_type()
  if 1 == self.battle_type then
    return CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI
  end
  return CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI
end

function M:get_weekly_target_award()
  local all_hurdle_cfg = ShareRes.get_weekly_prepare_war()
  if not all_hurdle_cfg then
    return
  end
  local complete_num = 0
  for idx, cfg in ipairs(all_hurdle_cfg) do
    local is_complete = self:check_hurdle_complete(cfg.EpiID)
    if is_complete then
      complete_num = complete_num + 1
    end
  end
  return complete_num
end

function M:set_weekly_stage(stage)
  self.v_select_stage = stage
end

function M:get_weekly_stage()
  return self.v_select_stage
end

function M:get_weekly_buddy_list(fight_type, point_id, is_temp)
  local cur_team_data = self:get_hurdle_team_data(fight_type, point_id, is_temp)
  local rune_info = {}
  for key, data in pairs(cur_team_data) do
    local rune_data = {
      buddy_pos = data.buddy_pos,
      buddy_id = data.buddy_id,
      rune_pos = data.rune_pos,
      is_first_pos = data.is_first_pos
    }
    table.insert(rune_info, rune_data)
  end
  return rune_info
end

function M:get_weekly_fight_team(fight_type, point_id, is_temp)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local fight_team_id = point_cfg.FightTeamId
  local fight_team_format = {}
  local buddys = {}
  local weekly_team_data = self:get_hurdle_team_data(fight_type, point_id, is_temp)
  for key, data in pairs(weekly_team_data) do
    if 0 ~= data.buddy_id then
      buddys[data.buddy_pos] = {
        buddy_type = TEAM_BUDDY_TYPE.PLAYER,
        buddy_id = data.buddy_id,
        pos = data.buddy_pos
      }
    end
    if data.is_first_pos then
      fight_team_format.main_pos = data.buddy_pos
    end
  end
  fight_team_format.id = fight_team_id
  fight_team_format.buddys = buddys
  return fight_team_format
end

function M:get_pvp_curr_star(epi_stage)
  if not epi_stage then
    return self.v_weekly_pvp_player_data.all_star or 0
  end
  if not self.v_pvp_stage_data then
    return 0
  end
  local star = 0
  for stage_index, stage_info in pairs(self.v_pvp_stage_data) do
    if stage_info.epi_stage == epi_stage then
      for i, epi_data in pairs(stage_info.epi_data) do
        if epi_data.epi_star then
          for _, condition_index in pairs(epi_data.epi_star) do
            if condition_index > 0 then
              star = star + 1
            end
          end
        end
      end
      break
    end
  end
  return star
end

function M:get_periods_max_star()
  return self.v_weekly_pvp_player_data.periods_max_star
end

function M:get_pvp_total_star(epi_stage)
  local star = 0
  if not self.v_pvp_stage_data then
    return 0
  end
  for stage_index, stage_info in pairs(self.v_pvp_stage_data) do
    if not epi_stage then
      for i, epi_data in pairs(stage_info.epi_data) do
        local conditions = ShareRes.get_point_star_condition(epi_data.epi_id)
        if conditions then
          for _, condition in pairs(conditions) do
            if condition > 0 then
              star = star + 1
            end
          end
        end
      end
    elseif stage_info.epi_stage == epi_stage then
      for i, epi_data in pairs(stage_info.epi_data) do
        local conditions = ShareRes.get_point_star_condition(epi_data.epi_id)
        if conditions then
          for _, condition in pairs(conditions) do
            if condition > 0 then
              star = star + 1
            end
          end
        end
      end
      break
    end
  end
  return star
end

function M:is_get_pvp_award(star)
  local star_award = self.v_weekly_pvp_player_data.star_award
  if not star_award then
    return
  end
  for _, data in ipairs(star_award) do
    if data == star then
      return true
    end
  end
  return false
end

function M:is_all_get_pvp_award(award_cfg)
  local star_award = self.v_weekly_pvp_player_data.star_award
  if not star_award then
    return false
  end
  local final_award_star = award_cfg[#award_cfg].Fraction
  for _, value in ipairs(star_award) do
    if value >= final_award_star then
      return true
    end
  end
  return false
end

function M:get_star_award_red_state()
  local curr_max_star = self:get_periods_max_star()
  local segment = self:get_cur_pvp_segment()
  local star_cfg_list = self:get_award_cfg_list_with_difficulty(segment)
  local is_can_receive = false
  for _, cfg in pairs(star_cfg_list) do
    local is_get = self:is_get_pvp_award(cfg.Fraction)
    if not is_get and curr_max_star >= cfg.Fraction then
      is_can_receive = true
      break
    end
  end
  return is_can_receive
end

function M:start_pvp_fight(point_id)
  local fight_type = CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI
  local fight_team = self:get_weekly_fight_team(fight_type, point_id, false)
  
  local function cb()
    TowerMgr:on_new_enter_tower(fight_type, point_id, 0, nil, fight_team)
  end
  
  FormationMgr:change_fight_team(fight_team.id, fight_team.buddys, fight_team.main_pos)
  FormationMgr:send_save_fight_team(fight_team.id, cb)
end

function M:request_player_info(uuid)
  ChatMgr:request_get_role_snapinfo(uuid, function(player_data)
    if player_data then
      UIMgr:get_ui("ui_player_info"):ui_show(player_data)
    end
  end)
end

function M:request_set_week_acty_pvp_formation(buddy_team, cb)
  local stage = self:get_weekly_stage()
  Network:call("c2gs_set_week_acty_pvp_formation", {buddy_team = buddy_team, stage = stage}, function(ok, resp)
    if ok and cb then
      cb(ok)
    end
  end)
end

function M:request_week_acty_pvp_epi_reset(stage)
  Network:call("c2gs_week_acty_pvp_epi_reset", {stage = stage}, function(ok, resp)
    if ok then
      MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_PVP_SCORE_RESET)
    end
  end)
end

function M:request_week_acty_pvp_periods_award(fraction)
  Network:call("c2gs_get_week_acty_pvp_periods_award", {star = fraction}, function(ok, resp)
    if ok then
      MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_PVP_AWARD_GET)
    end
  end)
end

return M
