local M = Util.create_class()
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_STATE = ActivityCfg.ACTY_STATE

function M:_init(activity_id, act_time_id)
  if not activity_id then
    Log.Error("create activity failure!")
    return
  end
  self.v_msg_handles = {}
  self.activity_id = activity_id
  if act_time_id then
    self:_set_activity_time(act_time_id)
  end
end

function M:_set_activity_time(act_time_id)
  local time_cfg = ShareRes.create("activity.activity_time", act_time_id)
  if not time_cfg then
    return
  end
  self.v_left_time = time_cfg.EndTime - Date.server_time()
  self.v_start_time = time_cfg.StartTime
  if time_cfg.PlayEndTime then
    self.v_game_time = time_cfg.PlayEndTime - Date.server_time()
  end
end

function M:update(delta_time)
  if self:get_activity_open_state() ~= ACTY_STATE.ACTY_OPEN then
    return
  end
  if self.v_left_time then
    self.v_left_time = self.v_left_time - delta_time
  end
  if self.v_game_time and self.v_game_time > 0 then
    self.v_game_time = self.v_game_time - delta_time
  end
end

function M:sys_mq_bind(msg_type, callback, cbdata)
  local msg_handle = MsgGame:mq_bind(msg_type, callback, cbdata)
  self.v_msg_handles[msg_handle] = msg_type
  return msg_handle
end

function M:sys_all_mq_unbind()
  for msg_handle, _ in pairs(self.v_msg_handles) do
    MsgGame:mq_unbind(msg_handle)
  end
  self.v_msg_handles = {}
end

function M:close_activity()
  self:sys_all_mq_unbind()
end

function M:get_activity_open_state()
  if self.v_start_time and self.v_start_time < Date.server_time() then
    return self.v_left_time > 0 and ACTY_STATE.ACTY_OPEN or ACTY_STATE.UNOPEN
  end
  return ACTY_STATE.UNOPEN
end

function M:get_remain_time()
  return self.v_left_time
end

function M:get_game_open_state()
  if self.v_game_time and self:get_activity_open_state() > ACTY_STATE.UNOPEN then
    return self.v_game_time > 0 and ACTY_STATE.PLAY_OPEN or ACTY_STATE.ACTY_OPEN
  end
  return ACTY_STATE.UNOPEN
end

function M:get_game_remain_time()
  return self.v_game_time
end

return M
