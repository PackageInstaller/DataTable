local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local LocalStorage = require("utils.localstorage")
local Activity_Task_Cfg = ShareRes.create("activity.activity_task")
local Catch_cat_Task_Cfg = ShareRes.create("activity.kitten_escape_task")
local Monkey_Typer_Task_Cfg = ShareRes.create("activity.monkey_typewriter_misc")
local Puzzle_Game_Task_Cfg = ShareRes.create("activity.puzzle_game")
local Music_game_Task_Cfg = ShareRes.create("activity.music_mini_game")
local Barbecue_Game_Task_Cfg = ShareRes.create("activity.barbecue_stall_game")
local All_Activity_Cfg = ShareRes.create("activity.routine_activity")
local TASK_STATE = Config.TASK_STATE
local JOURNEY_STATE = Config.CommonDefine.JOURNEY_STATE
local GET_STATE = {
  LOCK = 1,
  CAN_SIGN = 2,
  CAN_GET = 3,
  HAS = 4
}
local GOAL_STATE = {
  NOT = 0,
  CAN = 1,
  HAS = 2
}
local RETURN_ACTIVITY_CFG_ID = {
  SIGN_ACT = 1,
  TASK_ACT = 2,
  GIFT_ACT = 3,
  NEW_CNT_ACT = 4
}
local UI_NAME_TO_REDPOINT_ENUM = {
  ui_novice_signin_1 = RedEnum.SEVEN_SIGN_IN_01,
  ui_novice_signin_2 = RedEnum.SEVEN_SIGN_IN_02,
  ui_novice_signin_3 = RedEnum.SEVEN_SIGN_IN_03,
  ui_novice_signin_4 = RedEnum.SEVEN_SIGN_IN_04,
  ui_skin_tryout = RedEnum.SKIN_TRYOUT,
  ui_skin_tryout_1 = RedEnum.SKIN_TRYOUT_01,
  ui_skin_tryout_2 = RedEnum.SKIN_TRYOUT_02,
  ui_skin_tryout_3 = RedEnum.SKIN_TRYOUT_03
}
local DOUBLETYPE_REDDOT_MAP = {
  [CommonDef.DOUBLE_TYPE.FATEBOOK] = RedEnum.FATEBOOK_DOUBLE_CHALLENGE,
  [CommonDef.DOUBLE_TYPE.MATERIAL] = RedEnum.MATERIAL_DOUBLE_CHALLENGE
}
local ACTIVITY_TYPE = CommonDef.ACTIVITY_TYPE

function M:init_sys()
  Base.init_sys(self)
  self.v_sign_data = {}
  self.v_closed_activiy = {}
  self.v_activity_seven_sign_in_data = {}
  self.v_open_state = {
    [ACTIVITY_TYPE.NB_SIGN_IN] = false,
    [ACTIVITY_TYPE.NB_TASK] = false
  }
  self.v_can_get_award_map = {}
  self.v_get_all_award = false
  self.v_waepon_activity_data_map = {}
  self.v_double_challenge_map = {}
  self.v_award_count = #ShareRes.get_course_award()
  self:sys_mq_bind(Const.MSG_PLAYER_LVUP, self.response_playerlv_update_event, self)
  self:sys_mq_bind(Const.MSG_ON_TASK_UPDATE, self.update_novice_activity_task_award_red, self)
  self.v_novice_task_cfg = ShareRes.create("newbie.newbie_task_group")
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  self.v_return_act_info = {}
end

function M:on_reconnect()
  self.v_sign_data = {}
  self.v_closed_activiy = {}
  self.v_open_state = {
    [ACTIVITY_TYPE.NB_SIGN_IN] = false,
    [ACTIVITY_TYPE.NB_TASK] = false
  }
end

function M:sync_newbie_sign_in_history(data)
  self.v_sign_data = data
  self:_refresh_redpoint()
  MsgGame:mq_publish2(Const.MSG_NOVICE_SIGN_UPDATE)
end

function M:get_activity_seven_sign_in_data(data)
  self.v_activity_seven_sign_in_data[data.activity_sign_in] = data
  self:_seven_sign_in_redpoint_refresh(data.activity_sign_in)
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_SEVEN_SIGNIN)
end

function M:sync_close_activity(data)
  self.v_closed_activiy[data.act_type] = true
  local msg = MsgGame:mq_publish2(Const.MSG_NOVICE_ACTIVE_CLOSE)
  msg.mm_x = data.act_type
end

function M:request_newbie_sign_in(day_num)
  Network:call("c2gs_newbie_sign_in", {day_num = day_num}, function(ok, resp)
    if true ~= ok or 0 == resp.errcode then
    end
  end)
end

function M:request_newbie_receive_award(day_num)
  Network:call("c2gs_newbie_receive_award", {day_num = day_num}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      local status = self.v_sign_data.sign_in_status
      if status and status[day_num] then
        status[day_num] = 1
        self:_refresh_redpoint()
        local ui_activity = UIMgr:try_get_visible_ui("ui_activity")
        if ui_activity then
          ui_activity:on_newbie_receive_award()
        end
        MsgGame:mq_publish2(Const.MSG_NOVICE_SIGN_UPDATE)
      end
    end
  end)
end

function M:request_seven_sign_in(id, activity_id, day, callback)
  Network:call("c2gs_activity_seven_sign_in_gain_reward", {id = id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_activity_seven_sign_in_data[activity_id].reward_bit = self.v_activity_seven_sign_in_data[activity_id].reward_bit | 1 << day - 1
      self:_seven_sign_in_redpoint_refresh(activity_id)
      if callback then
        callback()
      end
    end
  end)
end

function M:request_all_seven_sign_in(activity_id, day_list, callback)
  Network:call("c2gs_activity_seven_sign_in_batch_gain", {activity_sign_in = activity_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      for _, day in ipairs(day_list) do
        self.v_activity_seven_sign_in_data[activity_id].reward_bit = self.v_activity_seven_sign_in_data[activity_id].reward_bit | 1 << day - 1
      end
      self:_seven_sign_in_redpoint_refresh(activity_id)
      if callback then
        callback()
      end
    end
  end)
end

function M:request_get_taks_prog_award(progress_id)
  Network:call("c2gs_newbie_task_prog_award", {progress_id = progress_id}, function(ok, resp)
    if true ~= ok or 0 == resp.errcode then
    end
  end)
end

function M:request_get_allTask_prog_award(progress_id_list)
  Network:call("c2gs_newbie_task_prog_award_list", {progress_id_list = progress_id_list}, function(ok, resp)
    if true ~= ok or 0 == resp.errcode then
    end
  end)
end

function M:get_sign_history()
  return self.v_sign_data
end

function M:_refresh_redpoint()
  local flag = false
  for i = 1, self.v_novice_days do
    local state = self:get_reward_get_state(i)
    if state == GET_STATE.CAN_SIGN then
      self:request_newbie_sign_in(i)
    end
    if state == GET_STATE.CAN_GET then
      flag = true
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.NOVICE_SIGN_IN, flag)
end

function M:_seven_sign_in_redpoint_refresh(activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(activity_id)
  local data = self.v_activity_seven_sign_in_data[activity_id]
  local flag = false
  for i = 1, self.v_novice_days do
    local state
    if i > data.login_day then
      state = GET_STATE.LOCK
    else
      local is_received = data.reward_bit >> i - 1 & 1
      state = 1 == is_received and GET_STATE.HAS or GET_STATE.CAN_GET
    end
    if state == GET_STATE.CAN_GET then
      flag = true
    end
  end
  RedPointMgr:enable_redpoint(UI_NAME_TO_REDPOINT_ENUM[activity_cfg.UiName], flag)
end

function M:get_reward_get_state(day_num)
  local status = self.v_sign_data.sign_in_status
  if not status then
    return GET_STATE.LOCK
  end
  if status[day_num] then
    return 0 == status[day_num] and GET_STATE.CAN_GET or GET_STATE.HAS
  else
    if (1 == day_num or status[day_num - 1]) and not self.v_sign_data.today_done then
      return GET_STATE.CAN_SIGN
    end
    return GET_STATE.LOCK
  end
end

function M:get_seven_sign_in_data(activity_id)
  return self.v_activity_seven_sign_in_data[activity_id]
end

function M:get_sys_open_state()
  local info = NewbieTowerMgr:get_newbie_info()
  return (not info.task_open or not self:get_activity_open_state(ACTIVITY_TYPE.NB_TASK)) and info.sign_in_open and self:get_activity_open_state(ACTIVITY_TYPE.NB_SIGN_IN)
end

function M:get_activity_open_state(activity_type)
  if self.v_closed_activiy[activity_type] then
    return false
  end
  return true
end

function M:check_novice_task_is_open()
  local info = NewbieTowerMgr:get_newbie_info()
  if not info.task_open or not self:get_activity_open_state(ACTIVITY_TYPE.NB_TASK) then
    return false
  end
  local is_all_suc = true
  for key, task_cfg in pairs(self.v_novice_task_cfg) do
    if TaskMgr:get_task_group_state(task_cfg.TaskGroupId) ~= Config.TASK_STATE.GET_REWARD then
      is_all_suc = false
      break
    end
  end
  if is_all_suc then
    return false
  end
  return true
end

function M:check_novice_sign_in_is_open()
  local info = NewbieTowerMgr:get_newbie_info()
  if not info.sign_in_open or not self:get_activity_open_state(ACTIVITY_TYPE.NB_SIGN_IN) then
    return false
  end
  local is_all_suc = true
  for i = 1, self.v_novice_days do
    local state = self:get_reward_get_state(i)
    if state ~= GET_STATE.HAS then
      is_all_suc = false
      break
    end
  end
  if is_all_suc then
    return false
  end
  return true
end

function M:get_goal_task_state(progress_id)
  local info = NewbieTowerMgr:get_newbie_info()
  if info.task_progress and info.task_progress[progress_id] then
    return info.task_progress[progress_id].status + 1
  end
  return GOAL_STATE.NOT
end

function M:get_goal_task_point()
  local info = NewbieTowerMgr:get_newbie_info()
  return info.task_point
end

function M:on_get_routine_activity(data)
  self.v_novice_activity_list = {}
  self.v_novice_activity_map = {}
  for _, info in pairs(data.activitys) do
    self.v_novice_activity_list[info.id] = info
    local activity_cfg = All_Activity_Cfg[info.id]
    if activity_cfg then
      local type = activity_cfg.Type
      if not self.v_novice_activity_map[type] then
        self.v_novice_activity_map[type] = {}
      end
      self.v_novice_activity_map[type][info.id] = info
    else
      Log.Error("活动总表中未找到活动id", info.id)
    end
  end
  self.v_ban_activity_map = {}
  if data.ban_activity_list then
    for _, id in pairs(data.ban_activity_list) do
      self.v_ban_activity_map[id] = true
    end
  end
  self:update_activity_id_binding()
  self:update_task_activity_red()
  MsgGame:mq_publish2(Const.MSG_ON_NOVICE_ACTIVITY_OPEN)
end

local on_activity_close = {
  [CommonDef.ROUTINE_ACTIVITY_TYPE.DOUBLE_CHALLENGE] = function(data)
    local double_challenge_cfg = ShareRes.get_double_challenge_cfg(data.activity.id)
    RedPointMgr:enable_redpoint(DOUBLETYPE_REDDOT_MAP[double_challenge_cfg.DoubleType], false)
  end,
  [CommonDef.ROUTINE_ACTIVITY_TYPE.BUDDY_FASHION_PROBATION] = function()
    RedPointMgr:enable_redpoint(RedEnum.SKIN_TRYOUT, false)
  end
}

function M:on_update_routine_activity(data)
  self.v_novice_activity_list = self.v_novice_activity_list or {}
  self.v_novice_activity_list[data.activity.id] = data.activity
  local type = All_Activity_Cfg[data.activity.id].Type
  if not self.v_novice_activity_map[type] then
    self.v_novice_activity_map[type] = {}
  end
  self.v_novice_activity_map[type][data.activity.id] = data.activity
  if 0 ~= data.activity.is_end then
    local close_callback = on_activity_close[All_Activity_Cfg[data.activity.id].Type]
    if close_callback then
      close_callback(data)
    end
  end
  self:update_activity_id_binding()
  self:update_task_activity_red()
  MsgGame:mq_publish2(Const.MSG_ON_NOVICE_ACTIVITY_OPEN)
end

function M:get_novice_activity_list()
  return self.v_novice_activity_list or E
end

function M:get_novice_activity_map(type)
  return (self.v_novice_activity_map or E)[type]
end

function M:get_novice_activity_data(id)
  if id and self.v_novice_activity_list then
    return self.v_novice_activity_list[id]
  end
end

function M:get_novice_activity_active(task_activity_id)
  if not task_activity_id or self:get_activity_ban(task_activity_id) then
    return false
  end
  local activity_cfg = ShareRes.get_activity_cfg(task_activity_id)
  if not activity_cfg then
    return false
  end
  local activity_data = self:get_novice_activity_data(task_activity_id)
  local is_active = activity_data and 0 == activity_data.is_end
  return is_active
end

function M:get_activity_ban(id)
  return self.v_ban_activity_map ~= nil and self.v_ban_activity_map[id] == true
end

function M:on_get_activity_journey_list(data)
  self.v_activity_journey_list = {}
  self.v_activity_journey_max_id = 1
  for _, info in pairs(data.journeys) do
    self.v_activity_journey_list[info.id] = info
    if info.id > self.v_activity_journey_max_id then
      self.v_activity_journey_max_id = info.id
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.NOVICE_COURSE_AWARD, self:check_activity_journey_award())
end

function M:on_update_activity_journey_list(data)
  if self.v_activity_journey_list then
    self.v_activity_journey_list[data.id] = data
    MsgGame:mq_publish2(Const.MSG_ON_UPDATE_JOURNEY_GAIN)
    if data.id > self.v_activity_journey_max_id then
      self.v_activity_journey_max_id = data.id
    end
  end
  if not self:check_activity_journey_state() then
    MsgGame:mq_publish2(Const.MSG_NOVICE_ACTIVITY_CLOSE)
  end
  RedPointMgr:enable_redpoint(RedEnum.NOVICE_COURSE_AWARD, self:check_activity_journey_award())
end

function M:get_activity_journey_state(id)
  if not self.v_activity_journey_list or not self.v_activity_journey_list[id] then
    return 0
  end
  return self.v_activity_journey_list[id].state
end

function M:check_activity_journey_state()
  if self.v_activity_journey_list then
    local count = 0
    for _, info in pairs(self.v_activity_journey_list) do
      if info.state == JOURNEY_STATE.GAINED then
        count = count + 1
      end
    end
    if count == self.v_award_count then
      return false
    else
      return true
    end
  end
  return true
end

function M:check_activity_journey_award()
  if self.v_activity_journey_list then
    for _, info in pairs(self.v_activity_journey_list) do
      if info.state == JOURNEY_STATE.COMPLETE then
        return true
      end
    end
  end
  return false
end

function M:request_get_activity_journey(id)
  if self:get_activity_journey_state(id) ~= JOURNEY_STATE.COMPLETE then
    return
  end
  Network:call("c2gs_activity_journey_gain", {id = id}, function()
    MsgGame:mq_publish2(Const.MSG_ON_UPDATE_JOURNEY_GAIN)
  end)
end

function M:get_cur_activity_journey_state()
  self.v_activity_journey_max_id = self.v_activity_journey_max_id or 1
  if self.v_activity_journey_max_id > 5 then
    self.v_activity_journey_max_id = 5
  end
  return self.v_activity_journey_max_id
end

function M:on_activity_level_award(data)
  self.v_activity_level_award_data = data
  self:activity_level_award_reddot_check()
  if self.v_get_all_award then
    MsgGame:mq_publish2(Const.MSG_NOVICE_ACTIVITY_CLOSE)
  end
end

local SKIN_TRYOUT_OPEN_KEY = "SKIN_TRYOUT_OPEN_KEY_"

function M:on_gs2c_activity_fashion_probation_info(data)
  if not self.v_fashion_probation_data then
    self.v_fashion_probation_data = {}
  end
  self.v_fashion_probation_data[data.activity_id] = data
  self:update_skin_tryout_redpoint(data.activity_id)
end

function M:get_skin_tryout_localdata(activity_id)
  return LocalStorage:load_int(SKIN_TRYOUT_OPEN_KEY .. activity_id, 0, true)
end

function M:set_skin_tryout_localdata(activity_id)
  LocalStorage:save_int(SKIN_TRYOUT_OPEN_KEY .. activity_id, 1, true)
end

function M:update_skin_tryout_redpoint(activity_id)
  local redpoint_status = self:get_skin_tryout_localdata(activity_id)
  local activity_cfg = All_Activity_Cfg[activity_id]
  if 0 == redpoint_status then
    RedPointMgr:enable_redpoint(UI_NAME_TO_REDPOINT_ENUM[activity_cfg.UiName], true)
  else
    local is_need_red = 1 == self.v_fashion_probation_data[activity_id].state
    local skin_cfg = ShareRes.get_skin_tryout_cfg(activity_id)
    if skin_cfg.SecondAwardGroupId and skin_cfg.SecondAwardGroupId > 0 then
      is_need_red = is_need_red or false
    end
    RedPointMgr:enable_redpoint(UI_NAME_TO_REDPOINT_ENUM[activity_cfg.UiName], is_need_red)
  end
end

function M:request_fashion_probation_get_award(activity_id, activity_arg, callback)
  Network:protect_call("c2gs_activity_fashion_probation_get_award", {activity_id = activity_id, activity_arg = activity_arg}, function(ok)
    if true == ok and callback then
      callback()
    end
  end)
end

function M:get_fashion_probation_info(activity_id)
  return self.v_fashion_probation_data[activity_id]
end

function M:response_playerlv_update_event()
  if self.v_activity_level_award_data then
    self:activity_level_award_reddot_check()
  end
end

function M:activity_level_award_reddot_check()
  local player_lv = PlayerMgr:get_role_lv()
  local cfg = ShareRes.get_level_welfare_cfg()
  self.v_get_all_award = #self.v_activity_level_award_data.level_award_list == #cfg
  for index, value in ipairs(cfg) do
    if player_lv >= value.Level then
      self.v_can_get_award_map[value.Id] = true
    end
  end
  for key, id in pairs(self.v_activity_level_award_data.level_award_list) do
    self.v_can_get_award_map[id] = nil
  end
  RedPointMgr:enable_redpoint(RedEnum.LEVEL_WELFARE, not UtilTable.is_empty(self.v_can_get_award_map))
end

function M:get_activity_level_award_data()
  return self.v_activity_level_award_data
end

function M:is_get_all_award()
  return self.v_get_all_award
end

function M:is_get_all_seven_sign_award()
  local novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  local task_cfg = ShareRes.create("newbie.newbie_task_group")
  for i = 1, novice_days do
    local task_cfg = task_cfg[i]
    local task_list = ShareRes.get_task_group(task_cfg.TaskGroupId)
    if task_list then
      if TaskMgr:get_task_group(task_cfg.TaskGroupId) ~= nil then
        for _, info in pairs(task_list) do
          local state = TaskMgr:get_task_state(info.Id)
          if state ~= TASK_STATE.GET_REWARD then
            return false
          end
        end
        if not TaskMgr:is_task_group_award_received(task_cfg.TaskGroupId) then
          return false
        end
      else
        return false
      end
    end
  end
  return true
end

function M:request_activity_level_award_gain(activity_id, level_award_id)
  Network:call("c2gs_activity_level_award_gain", {activity_id = activity_id, level_award_id = level_award_id}, function(ok, resp)
    if true == ok then
      local ui_level_welfare = UIMgr:try_get_visible_ui("ui_level_welfare")
      if ui_level_welfare then
        ui_level_welfare:refresh()
      end
    end
  end)
end

function M:on_update_activity_double_challenge_info(data)
  self.v_double_challenge_map[data.activity_id] = data
  self:double_challenge_reddot_check(data.activity_id)
end

function M:get_double_challenge_count(activity_id)
  return self.v_double_challenge_map[activity_id].double_count
end

function M:is_double_challenge_start(type)
  local is_start, activity_id
  if not self.v_novice_activity_map[CommonDef.ROUTINE_ACTIVITY_TYPE.DOUBLE_CHALLENGE] then
    return false
  end
  for _, info in pairs(self.v_novice_activity_map[CommonDef.ROUTINE_ACTIVITY_TYPE.DOUBLE_CHALLENGE]) do
    local double_challenge_cfg = ShareRes.get_double_challenge_cfg(info.id)
    if double_challenge_cfg.DoubleType == type and not self:get_activity_ban(info.id) then
      is_start = 0 == info.is_end or false
      activity_id = is_start and info.id or nil
      if is_start then
        break
      end
    end
  end
  return is_start, activity_id
end

function M:double_challenge_reddot_check(activity_id)
  local double_challenge_cfg = ShareRes.get_double_challenge_cfg(activity_id)
  local remaining_count = double_challenge_cfg.Limit - self.v_double_challenge_map[activity_id].double_count
  local reddot_type = DOUBLETYPE_REDDOT_MAP[double_challenge_cfg.DoubleType]
  RedPointMgr:enable_redpoint(reddot_type, remaining_count > 0)
end

function M:on_activity_gold_equip_info(data)
  self.v_waepon_activity_data_map[data.activity_id] = data
  self:check_waepon_activity_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_WEAPON_ACTIVITY_UPDATE)
end

function M:request_activity_gold_equip_gain(activity_id, index, equip_id, cb)
  Network:call("c2gs_activity_gold_equip_gain", {
    activity_id = activity_id,
    index = index,
    equip_id = equip_id
  }, function(resp, ok)
    if ok and cb then
      cb()
    end
  end)
end

function M:get_cur_open_weapon_activity_id()
  return next(self.v_waepon_activity_data_map)
end

function M:get_weapon_select_count(activity_id)
  local activity_data = self.v_waepon_activity_data_map and self.v_waepon_activity_data_map[activity_id]
  if not activity_data then
    return 0
  end
  local comp_count = activity_data.complete_task_cnt
  local selected_index_map = UtilTable.list2map(activity_data.gained_equip_group_indexs)
  local cfg = ShareRes.get_gold_equip_cfg(activity_data.activity_id)
  if not cfg then
    return 0
  end
  local select_count = 0
  for index, target_count in pairs(cfg.TaskCount) do
    if target_count <= comp_count and not selected_index_map[index] then
      select_count = select_count + 1
    end
  end
  return select_count
end

function M:get_waepon_select_weapon_gourd_id(activity_id)
  local activity_data = self.v_waepon_activity_data_map and self.v_waepon_activity_data_map[activity_id]
  if not activity_data then
    return
  end
  local weapon_gourd_id
  local comp_count = activity_data.complete_task_cnt
  local selected_index_map = UtilTable.list2map(activity_data.gained_equip_group_indexs)
  local cfg = ShareRes.get_gold_equip_cfg(activity_data.activity_id)
  if not cfg then
    return
  end
  local select_index
  for index, target_count in ipairs(cfg.TaskCount) do
    if target_count <= comp_count and not selected_index_map[index] then
      weapon_gourd_id = cfg.EquipGroupId[index]
      select_index = index
      break
    end
  end
  if not weapon_gourd_id then
    weapon_gourd_id, select_index = cfg.EquipGroupId[1], 1
  end
  return weapon_gourd_id, select_index
end

function M:get_weapon_next_select_task_count(activity_id)
  local need_task_count = 0
  local activity_data = self.v_waepon_activity_data_map and self.v_waepon_activity_data_map[activity_id]
  if not activity_data then
    return need_task_count
  end
  local comp_count = activity_data.complete_task_cnt
  local selected_index_map = UtilTable.list2map(activity_data.gained_equip_group_indexs)
  local cfg = ShareRes.get_gold_equip_cfg(activity_data.activity_id)
  if not cfg then
    return need_task_count
  end
  local get_suc = false
  for index, target_count in ipairs(cfg.TaskCount) do
    if target_count > comp_count and not selected_index_map[index] then
      need_task_count = target_count
      get_suc = true
      break
    end
  end
  if not get_suc then
    need_task_count = cfg.TaskCount[1]
  end
  return need_task_count
end

function M:check_waepon_activity_redpoint()
  local is_red = false
  for key, activity_data in pairs(self.v_waepon_activity_data_map) do
    local comp_count = activity_data.complete_task_cnt
    local selected_index_map = UtilTable.list2map(activity_data.gained_equip_group_indexs)
    local cfg = ShareRes.get_gold_equip_cfg(activity_data.activity_id)
    if cfg then
      for index, target_count in pairs(cfg.TaskCount) do
        if target_count <= comp_count and not selected_index_map[index] then
          is_red = true
          break
        end
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.WAEPON_ACTIVITY, is_red)
end

function M:check_waepon_activity_finish()
  local is_finish = true
  for key, activity_data in pairs(self.v_waepon_activity_data_map) do
    local comp_count = activity_data.complete_task_cnt
    local selected_index_map = UtilTable.list2map(activity_data.gained_equip_group_indexs)
    local cfg = ShareRes.get_gold_equip_cfg(activity_data.activity_id)
    if cfg then
      for index, target_count in pairs(cfg.TaskCount) do
        if not selected_index_map[index] then
          return false
        end
      end
    end
  end
  return true
end

local FIRST_RED_UI_DEFINE = {
  task_activity_1 = "ui_task_activity_1",
  task_activity_2 = "ui_task_activity_2",
  task_activity_3 = "ui_task_activity3",
  catch_cat_activity = "ui_catch_cat_activity",
  monkey_typer_activity = "ui_monkey_typer_activity",
  puzzle_game_activity = "puzzle_game_stage_panel",
  music_game_activity = "music_game_main_panel",
  ui_activity_daily1 = "ui_activity_daily1",
  barbecue_game_activity = "barbecue_game_main_panel"
}
local UI_DEFINE_REVERSE = {
  [FIRST_RED_UI_DEFINE.task_activity_1] = true,
  [FIRST_RED_UI_DEFINE.task_activity_2] = true,
  [FIRST_RED_UI_DEFINE.task_activity_3] = true,
  [FIRST_RED_UI_DEFINE.catch_cat_activity] = true,
  [FIRST_RED_UI_DEFINE.monkey_typer_activity] = true,
  [FIRST_RED_UI_DEFINE.puzzle_game_activity] = true,
  [FIRST_RED_UI_DEFINE.music_game_activity] = true,
  [FIRST_RED_UI_DEFINE.ui_activity_daily1] = true,
  [FIRST_RED_UI_DEFINE.barbecue_game_activity] = true
}
local ACT_2_TASK_CFG = {
  [FIRST_RED_UI_DEFINE.task_activity_1] = {
    task_cfg = Activity_Task_Cfg,
    first_red = RedEnum.FATE_BOOK_TASK_FIRST,
    task_group_key = {"TaskGroup"},
    task_red = {
      RedEnum.FATE_BOOK_TASK_AWARD
    }
  },
  [FIRST_RED_UI_DEFINE.task_activity_2] = {
    task_cfg = Activity_Task_Cfg,
    first_red = RedEnum.WEEKLY_ACT_TASK_FIRST,
    task_group_key = {"TaskGroup"},
    task_red = {
      RedEnum.WEEKLY_ACT_TASK_AWARD
    }
  },
  [FIRST_RED_UI_DEFINE.task_activity_3] = {
    task_cfg = Activity_Task_Cfg,
    first_red = RedEnum.PUZZLE_ACT_FIRST,
    task_group_key = {"TaskGroup"},
    task_red = {
      RedEnum.PUZZLE_ACT_TASK_AWARD
    }
  },
  [FIRST_RED_UI_DEFINE.catch_cat_activity] = {
    task_cfg = Catch_cat_Task_Cfg,
    first_red = RedEnum.CATCH_CAT_ACT_FIRST,
    task_group_key = {"TaskGroup"},
    task_red = {
      RedEnum.CATCA_CAT_ACT_AWARD
    }
  },
  [FIRST_RED_UI_DEFINE.monkey_typer_activity] = {
    task_cfg = Monkey_Typer_Task_Cfg,
    first_red = RedEnum.MONKEY_TYPER_ACT_FIRST,
    task_group_key = {
      "TaskGroupId",
      "ProgressTaskGroupId"
    },
    task_red = {
      RedEnum.MONKEY_TYPER_ACT_AWARD_TASK,
      RedEnum.MONKEY_TYPER_ACT_AWARD_PROGRESS
    }
  },
  [FIRST_RED_UI_DEFINE.puzzle_game_activity] = {
    task_cfg = Puzzle_Game_Task_Cfg,
    first_red = RedEnum.PUZZLE_GAME_ACT_FIRST,
    task_group_key = {
      "TaskGroupId"
    },
    task_red = {
      RedEnum.PUZZLE_GAME_ACT_AWARD
    }
  },
  [FIRST_RED_UI_DEFINE.music_game_activity] = {
    task_cfg = Music_game_Task_Cfg,
    first_red = RedEnum.MUSIC_GAME_ACT_FIRST,
    task_group_key = {
      "TaskGroupId",
      "HardTaskGroupId"
    },
    task_red = {
      RedEnum.MUSIC_GAME_ACT_TASK_AWARD_1,
      RedEnum.MUSIC_GAME_ACT_TASK_AWARD_2
    }
  },
  [FIRST_RED_UI_DEFINE.barbecue_game_activity] = {
    task_cfg = Barbecue_Game_Task_Cfg,
    task_group_key = {
      "TaskGroupId"
    },
    task_red = {
      RedEnum.BBQ_GAME_TASK_AWARD
    }
  }
}

function M:update_activity_id_binding()
  self.v_unique_act_id = {}
  if not self.v_novice_activity_map then
    return
  end
  for type, same_type_act in pairs(self.v_novice_activity_map) do
    for id, data in pairs(same_type_act) do
      local ui_name = All_Activity_Cfg[id].UiName
      if 0 == data.is_end and UI_DEFINE_REVERSE[ui_name] then
        if self.v_unique_act_id[ui_name] then
          Log.Error("红点处理异常，活动在生命周期不唯一, id:", id)
          break
        end
        self.v_unique_act_id[ui_name] = id
      end
    end
  end
end

function M:get_task_act_id(ui_name)
  if self.v_unique_act_id then
    return self.v_unique_act_id[ui_name]
  end
end

function M:update_task_activity_red()
  self:update_novice_activity_first_red()
  self:update_novice_activity_task_award_red()
  MonkeyTyperMgr:refresh_overheat_red()
  self:refresh_flyback_red()
end

function M:update_novice_activity_task_award_red()
  for ui_name, v in pairs(ACT_2_TASK_CFG) do
    if not v.task_red then
    else
      local activity_id = self:get_task_act_id(ui_name)
      local is_active = self:get_novice_activity_active(activity_id)
      for idx, task_group_key in ipairs(v.task_group_key) do
        local can_receive = false
        local cfg = v.task_cfg[activity_id]
        local task_group_id = cfg and cfg[task_group_key]
        if is_active and task_group_id then
          can_receive = TaskMgr:get_task_group_red(task_group_id)
        end
        RedPointMgr:enable_redpoint(v.task_red[idx], can_receive)
      end
    end
  end
end

function M:update_novice_activity_first_red()
  for ui_name, v in pairs(ACT_2_TASK_CFG) do
    if v.first_red then
      RedPointMgr:enable_redpoint(v.first_red, self:get_novice_activity_first_red(ui_name))
    end
  end
end

local FIRST_RED_KEY = "novice_activity_first_red_"

function M:get_novice_activity_first_red(ui_name)
  local activity_id = self:get_task_act_id(ui_name)
  local is_active = self:get_novice_activity_active(activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(activity_id)
  if 9 == activity_cfg.Type then
    local activity_data = self:get_novice_activity_data(activity_id)
    if not activity_data and activity_cfg.TimeType == self.ACTIVITY_TIME_TYPE.UNLIMITEDTIME then
      is_active = true
    end
  end
  local is_first = is_active and 0 == LocalStorage:load_int(FIRST_RED_KEY .. activity_id, 0, true)
  if not is_first then
    return false
  end
  local data = ACT_2_TASK_CFG[ui_name]
  local all_received = true
  for _, task_group_key in ipairs(data.task_group_key) do
    local cfg = data.task_cfg[activity_id]
    local task_group_id = cfg and cfg[task_group_key]
    if not TaskMgr:check_task_list_all_received(task_group_id) then
      all_received = false
    end
  end
  return not all_received
end

function M:read_novice_activity(task_activity_id)
  if not task_activity_id then
    return
  end
  local is_first = 0 == LocalStorage:load_int(FIRST_RED_KEY .. task_activity_id, 0, true)
  if is_first then
    LocalStorage:save_int(FIRST_RED_KEY .. task_activity_id, 1, true)
    self:update_novice_activity_first_red()
  end
end

local ACT_DAILY_OPEN_STORAGE_KEY = "ACT_DAILY_OPEN_STORAGE_KEY"

function M:get_catch_cat_act_daily_open()
  local activity_id = self:get_task_act_id(FIRST_RED_UI_DEFINE.catch_cat_activity)
  return self:check_act_daily_open(activity_id)
end

function M:get_monkey_typer_act_daily_open()
  local activity_id = self:get_task_act_id(FIRST_RED_UI_DEFINE.monkey_typer_activity)
  return self:check_act_daily_open(activity_id)
end

function M:get_puzzle_game_act_daily_open()
  local activity_id = self:get_task_act_id(FIRST_RED_UI_DEFINE.puzzle_game_activity)
  return self:check_act_daily_open(activity_id)
end

function M:check_act_daily_open(activity_id)
  local is_active = self:get_novice_activity_active(activity_id)
  if not is_active then
    return false
  end
  local last_open_timestamp = LocalStorage:load_int(ACT_DAILY_OPEN_STORAGE_KEY .. activity_id, 0, true)
  return Date.is_daily_first(last_open_timestamp)
end

function M:mark_act_daily_open(activity_id)
  LocalStorage:save_int(ACT_DAILY_OPEN_STORAGE_KEY .. activity_id, Date.server_time(), true)
end

function M:get_catch_cat_activity_open()
  local activity_id = self:get_task_act_id(FIRST_RED_UI_DEFINE.catch_cat_activity)
  return self:get_novice_activity_active(activity_id)
end

M.ACTIVITY_TIME_TYPE = {
  DESIGNATED_PERIOD = 1,
  DURATION = 2,
  UNLIMITEDTIME = 3
}

function M:get_time_remaining(time_type, stop_time_id, open_time, sustain_day)
  if time_type == self.ACTIVITY_TIME_TYPE.DESIGNATED_PERIOD then
    local stop_time = Date.get_time_stamp_by_scheme_id(stop_time_id)
    return stop_time - Date.server_time()
  elseif time_type == self.ACTIVITY_TIME_TYPE.DURATION then
    return open_time + sustain_day * 24 * 60 * 60 - Date.server_time()
  end
end

function M:get_time_remaining_for_ret_act()
  local time_length = self.v_return_act_info.end_time - Date.server_time()
  if not time_length then
    return
  end
  if time_length then
    return Date.get_time_format_7(time_length)
  end
end

function M:on_gs2c_activity_flyback_info(data)
  self.v_return_act_info = data
  PopUpWindowMgr:insert_return_act_pop()
  self:refresh_flyback_red()
end

function M:get_activity_flyback_info()
  return self.v_return_act_info
end

function M:chech_activity_flyback_open()
  if self.v_return_act_info.end_time == nil then
    return false
  end
  local total_sec = self.v_return_act_info.end_time - Date.server_time()
  if total_sec <= 0 then
    return false
  else
    return true
  end
end

function M:get_sign_award_is_get(sign_day_param)
  local sign_in_reward_bit = self.v_return_act_info.sign_in_reward_bit
  if not sign_in_reward_bit then
    return false
  end
  return 1 == (sign_in_reward_bit >> sign_day_param - 1) % 2
end

function M:request_activity_flyback_sign_award(sign_day_param)
  local sign_day = self.v_return_act_info.sign_in_day
  if not sign_day then
    return
  end
  if sign_day_param > sign_day then
    return
  end
  if self:get_sign_award_is_get(sign_day_param) then
    return
  end
  Network:call("c2gs_activity_flyback_gain_day_award", {day = sign_day_param}, function(ok)
    if true == ok then
      MsgGame:mq_publish2(Const.ON_RET_ACT_SIGN_AWARD)
    end
  end)
end

function M:get_activity_flyback_sign_award_num(AwardTotal)
  if self.v_return_act_info.sign_in_day == nil then
    return 0
  end
  local award_num = self.v_return_act_info.sign_in_reward_bit or 0
  local count = 0
  for i = 1, AwardTotal do
    if 1 == (award_num >> i - 1) % 2 then
      count = count + 1
    end
  end
  local max_award = self.v_return_act_info.sign_in_day
  if AwardTotal < max_award then
    max_award = AwardTotal
  end
  return max_award - count
end

function M:get_flyback_gain_progress_award(progress_id_param)
  Network:call("c2gs_activity_flyback_gain_progress_award", {progress_id = progress_id_param}, function(ok)
    if true == ok then
      MsgGame:mq_publish2(Const.ON_RET_ACT_SIGN_AWARD)
    end
  end)
end

function M:check_close_activity_ui(activity_id, ui_name, force_close, go_to_main)
  local is_active = self:get_novice_activity_active(activity_id)
  if not is_active then
    if force_close then
      NextFrameMgr:add_next_update(function()
        if go_to_main then
          UIMgr:go_to_main()
        else
          UIMgr:try_hide_ui(ui_name)
        end
      end)
    else
      local function confirmCb()
        if go_to_main then
          UIMgr:go_to_main()
        else
          UIMgr:try_hide_ui(ui_name)
        end
      end
      
      Util.show_notify_popup_message(confirmCb, "活动已结束", nil, "确定", nil, nil, true)
    end
    return true
  end
end

function M:check_return_act_red_point()
  return true
end

function M:load_local_table_data(save_key)
  return LocalStorage:load_table(save_key, true) or {}
end

function M:save_local_table_data(save_key, save_table)
  LocalStorage:save_table(save_key, save_table, true)
end

local RET_ACT_SAVE_KEY = "RET_ACT_SAVE_KEY"

function M:clear_ret_act_red()
  if not self.v_return_act_info.open_time then
    return
  end
  local save_table = self:load_local_table_data(RET_ACT_SAVE_KEY)
  save_table.open_time = self.v_return_act_info.open_time
  save_table.red_point = 1
  self:save_local_table_data(RET_ACT_SAVE_KEY, save_table)
end

function M:get_red_state()
  if not self.v_return_act_info.open_time then
    return
  end
  local save_table = self:load_local_table_data(RET_ACT_SAVE_KEY)
  if save_table.open_time == self.v_return_act_info.open_time then
    return 0 == save_table.red_point
  else
    return true
  end
end

function M:clear_ret_act_story()
  if not self.v_return_act_info.open_time then
    return
  end
  local save_table = self:load_local_table_data(RET_ACT_SAVE_KEY)
  save_table.open_time = self.v_return_act_info.open_time
  save_table.act_story = 1
  self:save_local_table_data(RET_ACT_SAVE_KEY, save_table)
end

function M:get_story_state()
  if not self.v_return_act_info.open_time then
    return
  end
  local save_table = self:load_local_table_data(RET_ACT_SAVE_KEY)
  if save_table.open_time == self.v_return_act_info.open_time then
    return 0 == save_table.act_story
  else
    return true
  end
end

function M:get_task_red_state()
  if not self.v_return_act_info.open_time then
    return false
  end
  local day_data_map = ShareRes.get_task_group(ShareRes.get_return_activity_hold_task().TaskGroupId)
  for _, task_cfg in pairs(day_data_map) do
    local task_status = TaskMgr:get_task_state(task_cfg.Id)
    if task_status == TASK_STATE.COMPLETE then
      return true
    end
  end
  local progress_item_id = ShareRes.get_return_activity_hold_task().ProgressItemId
  local progress_item_num = BagMgr:get_item_num(progress_item_id)
  local cfg = ShareRes.get_return_activity_task_progress()
  for index, data in ipairs(cfg) do
    if progress_item_num > data.ItemCount and 1 ~= (self.v_return_act_info.progress_reward_bit >> index - 1) % 2 then
      return true
    end
  end
  return false
end

function M:get_task_award_num()
  local cfg = ShareRes.get_return_activity_task_progress()
  local progress_item_id = ShareRes.get_return_activity_hold_task().ProgressItemId
  local progress_item_num = BagMgr:get_item_num(progress_item_id)
  local count = 0
  for index, data in ipairs(cfg) do
    if progress_item_num >= data.ItemCount then
      count = count + 1
    end
  end
  return count
end

function M:get_ret_act_open()
  return self:chech_activity_flyback_open()
end

function M:refresh_flyback_red()
  local has_red = false
  local cfg_main_view = ShareRes.get_return_activity_main_view_cfg(RETURN_ACTIVITY_CFG_ID.SIGN_ACT)
  if self:get_activity_flyback_sign_award_num(cfg_main_view.AwardTotal) > 0 then
    has_red = true
  end
  if self:get_red_state() then
    has_red = true
  end
  if self:get_task_red_state() then
    has_red = true
  end
  RedPointMgr:enable_redpoint(RedEnum.RET_ACT_MAIN, has_red)
end

function M:update_all_fish_game_data(data)
  self.v_fish_game_data = {}
  self.v_fish_game_act_id = data.activity_id
  for _, temp in pairs(data.fish_episode) do
    self.v_fish_game_data[temp.episode_id] = temp
  end
  self:update_fish_game_red_data()
  MsgGame:mq_publish2(Const.ON_FISH_GAME_REFRESH)
  local red_show = self:get_fish_game_has_red()
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_BTN_1, red_show)
end

function M:update_single_fish_game_data(data)
  local temp = data.episode_data
  self.v_fish_game_data = self.v_fish_game_data or {}
  self.v_fish_game_data[temp.episode_id] = temp
  self:update_fish_game_red_data()
  MsgGame:mq_publish2(Const.ON_FISH_GAME_REFRESH)
  local red_show = self:get_fish_game_has_red()
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_BTN_1, red_show)
end

function M:upload_fish_game_data(data)
  Network:call("c2gs_activity_pass_fish_game_episode", {
    episode_id = data.episode_id,
    soce = data.soce,
    pass_time = data.pass_time,
    finsh_star = data.finsh_star,
    activity_id = data.activity_id
  }, function(ok)
    if true == ok then
      MsgGame:mq_publish2(Const.ON_FISH_GAME_REFRESH)
    end
  end)
end

local FISH_GAME_RED_KEY = "FISH_GAME_RED_KEY"

function M:set_fish_game_red(act_id, epi_id)
  local tbl = LocalStorage:load_table(FISH_GAME_RED_KEY, true) or {}
  tbl[act_id] = tbl[act_id] or {}
  tbl[act_id][epi_id] = 1
  self.v_fish_game_red = tbl[act_id]
  LocalStorage:save_table(FISH_GAME_RED_KEY, tbl, true)
  self:update_fish_game_red_data()
  local red_show = self:get_fish_game_has_red()
  RedPointMgr:enable_redpoint(RedEnum.SUMMER_ACTIVITY_BTN_1, red_show)
end

function M:get_fish_game_red_save_tbl(act_id)
  if self.v_fish_game_red == nil then
    local tbl = LocalStorage:load_table(FISH_GAME_RED_KEY, true) or {}
    if nil ~= tbl[act_id] then
      self.v_fish_game_red = tbl[act_id]
    else
      self.v_fish_game_red = {}
    end
  end
  return self.v_fish_game_red
end

function M:get_fish_game_has_red()
  if self:check_fish_game_red_state() then
    return true
  end
  local ACT_ID = self:get_fish_game_act_id()
  local cfg = ShareRes.get_fish_game_fish_game_cfg(ACT_ID)
  local hold_data_map = ShareRes.get_task_group(cfg.TaskGroupId)
  for _, data in pairs(hold_data_map) do
    local task_id = data.Id
    local task_state = TaskMgr:get_task_state(task_id)
    if task_state == TASK_STATE.COMPLETE then
      return true
    end
  end
end

function M:update_fish_game_red_data()
  self.v_fish_game_epi_red = self.v_fish_game_epi_red or {}
  local ACT_ID = self:get_fish_game_act_id()
  local activity_cfg = ShareRes.get_activity_cfg(ACT_ID)
  local end_time = activity_cfg.PlayStopTime and Date.get_time_stamp_by_scheme_id(activity_cfg.PlayStopTime) or 0
  local total_sec = end_time - Date.server_time()
  local red_tbl = self:get_fish_game_red_save_tbl(ACT_ID)
  for episo_id, data in pairs(self.v_fish_game_data) do
    local cfg = ShareRes.get_fish_game_stage_by_id(episo_id)
    local pre_episo_id = cfg.FrontEpisodeId
    self.v_fish_game_epi_red[episo_id] = false
    local count_down_time = -1
    if cfg.StartTime then
      count_down_time = Date.get_time_stamp_by_scheme_id(cfg.StartTime) - Date.server_time()
    end
    if count_down_time > 0 then
      self.v_fish_game_epi_red[episo_id] = false
    elseif data.is_pass then
      self.v_fish_game_epi_red[episo_id] = false
    elseif end_time > 0 and total_sec > 0 then
      if nil ~= pre_episo_id then
        if self.v_fish_game_data[pre_episo_id] ~= nil and self.v_fish_game_data[pre_episo_id].is_pass then
          self.v_fish_game_epi_red[episo_id] = nil == red_tbl[episo_id]
        end
      else
        self.v_fish_game_epi_red[episo_id] = nil == red_tbl[episo_id]
      end
    else
      self.v_fish_game_epi_red[episo_id] = false
    end
  end
end

function M:get_fish_game_red_state(stage_id)
  return self.v_fish_game_epi_red[stage_id] or false
end

function M:check_fish_game_red_state()
  local res = false
  for _, data in pairs(self.v_fish_game_epi_red) do
    if data then
      res = true
    end
  end
  return res
end

function M:get_fish_game_act_id()
  return self.v_fish_game_act_id
end

function M:get_fish_game_data(episode_id)
  return self.v_fish_game_data[episode_id]
end

function M:on_activity_ponder_list(data)
  self.v_maze_activity_data_list = self.v_maze_activity_data_list or {}
  self.v_maze_activity_data_list[data.activity_id] = self.v_maze_activity_data_list[data.activity_id] or {}
  local activity_data = self.v_maze_activity_data_list[data.activity_id]
  activity_data.ponder_points = data.ponder_points
  activity_data.pass_fight_nodes = UtilTable.list2map(data.pass_fight_nodes)
  activity_data.ponder_id_list = UtilTable.list2map(data.ponder_id_list)
  self:refresh_maze_point_red(data.activity_id)
end

function M:on_activity_ponder_update(data)
  self.v_maze_activity_data_list = self.v_maze_activity_data_list or {}
  self.v_maze_activity_data_list[data.activity_id] = self.v_maze_activity_data_list[data.activity_id] or {}
  local activity_data = self.v_maze_activity_data_list[data.activity_id]
  activity_data.ponder_points = activity_data.ponder_points or {}
  for id, point_data in pairs(data.ponder_points) do
    activity_data.ponder_points[id] = point_data
  end
end

function M:on_activity_ponder_pass_fight_node_update(data)
  self.v_maze_activity_data_list = self.v_maze_activity_data_list or {}
  self.v_maze_activity_data_list[data.activity_id] = self.v_maze_activity_data_list[data.activity_id] or {}
  local activity_data = self.v_maze_activity_data_list[data.activity_id]
  activity_data.pass_fight_nodes = activity_data.pass_fight_nodes or {}
  activity_data.pass_fight_nodes[data.pass_fight_node] = data.pass_fight_node
end

function M:close_maze_point_click_red(activity_id, point_id)
  if not self.v_maze_activity_data_list or not self.v_maze_activity_data_list[activity_id] then
    return
  end
  local activity_data = self.v_maze_activity_data_list[activity_id]
  local point_data = activity_data.ponder_points and activity_data.ponder_points[point_id]
  if point_data then
    point_data.is_red = false
  end
  self:refresh_maze_point_red(activity_id)
end

function M:get_ponder_maze_point_is_comp(activity_id, point_id)
  if not self.v_maze_activity_data_list then
    return false
  end
  local data_list = self.v_maze_activity_data_list
  local activity_data = data_list[activity_id]
  if activity_data then
    local point_data = activity_data.ponder_points and activity_data.ponder_points[point_id]
    return nil ~= point_data and point_data.is_passed
  end
  return false
end

function M:get_ponder_maze_node_battle_pass(activity_id, battle_param)
  if not self.v_maze_activity_data_list then
    return false
  end
  local data_list = self.v_maze_activity_data_list
  local activity_data = data_list[activity_id]
  if activity_data then
    return activity_data.pass_fight_nodes and activity_data.pass_fight_nodes[battle_param] ~= nil
  end
  return false
end

function M:get_ponder_is_unlock(activity_id, ponder_id)
  if not self.v_maze_activity_data_list then
    return false
  end
  local data_list = self.v_maze_activity_data_list
  local activity_data = data_list[activity_id]
  if activity_data then
    return activity_data.ponder_id_list and activity_data.ponder_id_list[ponder_id] ~= nil
  end
  return false
end

function M:refresh_maze_point_red(activity_id)
  local is_red = false
  local maze_activity_cfg = ShareRes.get_ponder_maze_activity_cfg(activity_id)
  local point_list = maze_activity_cfg.Point
  if point_list then
    for _, point_id in pairs(point_list) do
      if self:is_ponder_maze_point_red(activity_id, point_id) then
        is_red = true
        break
      end
    end
  end
  RedPointMgr:enable_dynamic_redpoint(RedEnum.MAZE_ACT, RedEnum.TIME_LIMITED_ACTIVITY_BTN_5_1_2, is_red)
end

function M:is_ponder_maze_point_red(activity_id, point_id)
  if not self.v_maze_activity_data_list then
    return false
  end
  local data_list = self.v_maze_activity_data_list
  local activity_data = data_list[activity_id]
  if activity_data then
    local point_data = activity_data.ponder_points and activity_data.ponder_points[point_id]
    return nil ~= point_data and point_data.is_red
  end
  return false
end

function M:start_ponder_maze_game(activity_id, point_id)
  self:stop_ponder_maze_game()
  local script = require("gamelogic.novice.ponder_maze_mgr")
  self.ponder_maze_mgr = script:new()
  self.ponder_maze_mgr:start_game(activity_id, point_id)
end

function M:stop_ponder_maze_game()
  if self.ponder_maze_mgr then
    self.ponder_maze_mgr:on_destroy()
    self.ponder_maze_mgr = nil
  end
end

function M:set_maze_game_story_state(story_id, state)
  LocalStorage:save_int("NEED_PLAY_MAZE_GAME_STORY" .. story_id, state, true)
end

function M:get_maze_game_story_state(story_id)
  local state = LocalStorage:load_int("NEED_PLAY_MAZE_GAME_STORY" .. story_id, CommonDef.MAZE_GAME_STORY_STATE.NO_PLAY, true)
  return state
end

function M:check_maze_game_story()
  local cfg_list = ShareRes.get_ponder_maze_story_cfg()
  local is_need_play = false
  local need_play_story_list = {}
  for story_id, cfg in pairs(cfg_list) do
    if cfg.StoryType == CommonDef.MAZE_GAME_TRIGGER_TYPE.DEFAULT_UNLOCK and NoviceMgr:get_maze_game_story_state(story_id) == CommonDef.MAZE_GAME_STORY_STATE.NO_PLAY or NoviceMgr:get_maze_game_story_state(story_id) == CommonDef.MAZE_GAME_STORY_STATE.NEED_PLAY then
      table.insert(need_play_story_list, cfg)
    end
  end
  table.sort(need_play_story_list, function(a, b)
    return a.Priority < b.Priority
  end)
  if #need_play_story_list > 0 then
    local cb
    if #need_play_story_list > 1 then
      function cb()
        self:check_maze_game_story()
      end
    end
    self:play_maze_game_story(need_play_story_list[1].Id, cb)
  end
end

function M:play_maze_game_story(story_id, finish_cb)
  NoviceMgr:set_maze_game_story_state(story_id, CommonDef.MAZE_GAME_STORY_STATE.PLAY_FINISH)
  StoryMgr:on_start(story_id, nil, nil, nil, nil, finish_cb)
end

function M:check_maze_game_tips_and_story(activity_id)
  local function cb()
    NoviceMgr:check_maze_game_story()
  end
  
  if NoviceMgr:get_is_need_show_maze_game_settle_tips() then
    UIMgr:get_ui("ui_maze_game_settle_tips"):ui_show(nil, activity_id, cb)
  else
    cb()
  end
end

function M:get_is_need_show_maze_game_settle_tips()
  return 1 == LocalStorage:load_int("IS_NEED_OPEN_SETTLE_TIPS", 0, true)
end

function M:set_is_need_show_maze_game_settle_tips(value)
  LocalStorage:save_int("IS_NEED_OPEN_SETTLE_TIPS", true == value and 1 or 0, true)
end

function M:set_maze_game_settle_tips_ponder_id(value)
  LocalStorage:save_int("MAZE_GAME_SETTLE_TIPS_PONDER_ID", value, true)
end

function M:get_maze_game_settle_tips_ponder_id()
  return LocalStorage:load_int("MAZE_GAME_SETTLE_TIPS_PONDER_ID", 0, true)
end

local PONDER_MAZE_ACTIVITY_ILL_RED = "PONDER_MAZE_ACTIVITY_ILL_RED"

function M:check_ill_item_red(activity_id, id, key)
  self.v_maze_activity_ill_red = self.v_maze_activity_ill_red or LocalStorage:load_table(PONDER_MAZE_ACTIVITY_ILL_RED, true) or {}
  local red_key = activity_id * 100 + id .. key
  return self.v_maze_activity_ill_red[red_key] == nil
end

function M:close_ill_item_red(activity_id, id, key)
  self.v_maze_activity_ill_red = self.v_maze_activity_ill_red or LocalStorage:load_table(PONDER_MAZE_ACTIVITY_ILL_RED, true) or {}
  local red_key = activity_id * 100 + id .. key
  if not self.v_maze_activity_ill_red[red_key] then
    self.v_maze_activity_ill_red[red_key] = 1
    LocalStorage:save_table(PONDER_MAZE_ACTIVITY_ILL_RED, self.v_maze_activity_ill_red, true)
  end
end

function M:request_activity_ponder_click_red(activity_id, point_id)
  Network:protect_call("c2gs_activity_ponder_click_red", {activity_id = activity_id, id = point_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self:close_maze_point_click_red(activity_id, point_id)
    end
  end)
end

function M:request_activity_ponder_report_pass_point(activity_id, point_id, is_win, cb)
  Network:protect_call("c2gs_activity_ponder_report_pass_point", {
    activity_id = activity_id,
    id = point_id,
    is_win = is_win
  }, function(ok, resp)
    if true == ok and 0 == resp.errcode and cb then
      cb()
    end
  end)
end

return M
