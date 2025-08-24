local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local test_data = {need_read_story = true, need_pass_nb_tower = true}

function M:init_sys()
  Base.init_sys(self)
  self.v_newbie_info = {}
  self.is_enter_newbie_tower = false
end

function M:on_reconnect()
  self.is_enter_newbie_tower = false
end

function M:on_enter_newbie_tower()
  if self.v_newbie_info.need_pass_nb_tower then
    self:request_enter_newbie_tower()
  else
    Global.scene_mgr:on_enter_main_scene()
  end
end

function M:play_story()
  local story_id = ShareRes.get_comm_value("CreateAccountStory")
  StoryMgr:on_start(story_id)
  SDKManager:track_adjust_event("08_prologue_cinema")
end

function M:on_newbie_info(data)
  self:check_need_send_privilege_close_msg(data.privilege_data)
  local privilege_data = self.v_newbie_info.privilege_data
  self.v_newbie_info = data
  self.v_newbie_info.privilege_data = privilege_data
  self:refresh_give_energy_value_red()
  MsgGame:mq_publish2(Const.MSG_NOVICE_INFO_UPDATE)
end

function M:check_need_send_privilege_close_msg(privilege_data)
  if self:get_privilege_is_open() and privilege_data and not privilege_data.is_open then
    local msg = MsgGame:mq_publish2(Const.MSG_NOVICE_ACTIVITY_CLOSE)
    msg.mm_x = Config.ACTIVITY_TYPE.PRIVILEGE
  end
end

function M:update_newbie_read_story()
  Network:call("c2gs_newbie_read_story", {}, function(ok)
    if ok then
      self.v_newbie_info.need_read_story = false
    end
  end)
end

function M:request_enter_newbie_tower()
  if self.is_enter_newbie_tower then
    return
  end
  Network:call("c2gs_newbie_enter_tower", {}, function(ok, resp)
    if ok then
      TowerMgr:on_enter_tower(resp.tower_id)
      self.is_enter_newbie_tower = true
    end
  end)
end

function M:reset_newbie_tower_state()
  self.is_enter_newbie_tower = false
end

function M:check_enter_newbie_tower()
  return self.is_enter_newbie_tower
end

function M:on_update_pass_newbie_tower()
  Network:call("c2gs_newbie_pass_tower", {})
end

function M:need_read_story()
  return self.v_newbie_info.need_read_story
end

function M:is_pass_tower()
  return self.v_newbie_info.need_pass_nb_tower
end

function M:set_newbie_tower_pass()
  self.v_newbie_info.need_read_story = false
  self.v_newbie_info.need_pass_nb_tower = false
  self:on_update_pass_newbie_tower()
  GuideMgr:force_finish_cur_guide()
end

function M:get_newbie_info()
  return self.v_newbie_info
end

function M:on_privilege_update(data)
  self.v_newbie_info = self.v_newbie_info or {}
  self:check_need_send_privilege_close_msg(data)
  self.v_newbie_info.privilege_data = data
end

function M:get_privilege_data()
  return self.v_newbie_info and self.v_newbie_info.privilege_data
end

function M:get_privilege_is_open()
  if self.v_newbie_info and self.v_newbie_info.privilege_data then
    return self.v_newbie_info.privilege_data.is_open
  else
    return false
  end
end

function M:get_privilege_last_reward_time(privilege_id)
  if not self:get_privilege_is_open() then
    return
  end
  if self.v_newbie_info.privilege_data.get_reward_list and self.v_newbie_info.privilege_data.get_reward_list[privilege_id] then
    return self.v_newbie_info.privilege_data.get_reward_list[privilege_id].last_reward_time
  end
end

function M:get_privilege_end_time()
  if not self:get_privilege_is_open() then
    return
  end
  local end_time = self.v_newbie_info.privilege_data.end_time
  if end_time then
    local now_time = Date.server_time()
    return Date.get_time_formate_2(end_time - now_time)
  end
end

function M:check_have_resolve_privilege()
  if not self:get_privilege_is_open() then
    return false
  end
  local all_privilege_cfg = ShareRes.get_all_privilege_cfg()
  for key, privilege_cfg in pairs(all_privilege_cfg) do
    if privilege_cfg.Type == Config.PRIVILEGE_TYPE.WEAPON_RESOLVE and privilege_cfg.IsOn then
      return true, privilege_cfg.Id
    end
  end
  return false
end

function M:check_is_privilege_gift(page, gift_id)
  local is_open = self:get_privilege_is_open()
  local all_privilege_cfg = ShareRes.get_all_privilege_cfg()
  local is_privilege_gift, privilege_id
  for key, privilege_cfg in pairs(all_privilege_cfg) do
    if privilege_cfg.IsOn then
      local arg1 = privilege_cfg.Arg
      if privilege_cfg.Type == Config.PRIVILEGE_TYPE.MALL_GIFT_PAGING then
        is_privilege_gift = page == arg1
      elseif privilege_cfg.Type == Config.PRIVILEGE_TYPE.MALL_GIFT_GIFT then
        is_privilege_gift = nil ~= arg1[gift_id]
      end
      if is_privilege_gift then
        privilege_id = is_open and privilege_cfg.Id
        break
      end
    end
  end
  return is_privilege_gift, is_open, privilege_id
end

function M:check_in_get_give_energy_value(privilege_id, show_tips)
  if not self:get_privilege_is_open() then
    return false
  end
  local privilege_cfg = ShareRes.get_privilege_cfg(privilege_id)
  if not privilege_cfg and not privilege_id then
    local all_privilege_cfg = ShareRes.get_all_privilege_cfg()
    for key, cfg in pairs(all_privilege_cfg) do
      if cfg.Type == Config.PRIVILEGE_TYPE.GIVE_ENERGY_VALUE and cfg.IsOn then
        privilege_cfg = cfg
        break
      end
    end
  end
  if not privilege_cfg then
    return false
  end
  local last_time = NewbieTowerMgr:get_privilege_last_reward_time(privilege_cfg.Id)
  local last_time_tb
  if last_time then
    last_time_tb = os.date("*t", last_time)
  end
  local time_table = {}
  for index = 3, #privilege_cfg.Arg do
    table.insert(time_table, privilege_cfg.Arg[index])
  end
  local is_in_time = false
  local remain_time = Date.get_left_time(time_table, last_time)
  if remain_time <= 0 then
    return true
  end
  for index = 3, #privilege_cfg.Arg do
    local time_tb = privilege_cfg.Arg[index]
    local start_time = time_tb[1]
    local end_time = time_tb[2]
    local server_in_time, temp_left_time = Date.is_in_time2(Date.server_time(), start_time, end_time)
    if server_in_time then
      is_in_time = true
    end
  end
  if show_tips then
    if is_in_time then
      Util.show_message_tip(2086)
    else
      Util.show_message_tip(2087)
    end
  end
  return false
end

function M:refresh_give_energy_value_red()
  local in_time = self:check_in_get_give_energy_value()
  RedPointMgr:enable_redpoint(RedEnum.GIVE_ENERGY_VALUE, in_time)
end

function M:req_get_privilege_award(privilege_id, cb)
  Network:call("c2gs_get_privilege_reward", {privilege_id = privilege_id}, function(ok, resp)
    if ok and cb then
      cb()
    end
  end)
end

return M
