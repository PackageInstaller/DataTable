local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CS = require("ejoysdk_lua.chat.ejoysdk_chat_socket")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local TAG = EM.MODULE.CHAT .. "socket_heartbeat"
local M = Class:Inherit("ChatSocketHeartbeat")
local HEARTBEAT_TICK_INTERVAL = 2
local DEFAULT_MAX_FAIL_COUNT = 2
local DEFAULT_MAX_HEARTBEAT_TIMEOUT_COUNT = 5
local DEFAULT_HEARTBEAT_INTERVAL = 60

function M:_init(handlers, options)
  self.destroy_flag = false
  self.heartbeat_timer_running = false
  self.handlers = handlers
  self.options = options or {}
  self:reset_config()
end

function M:reset_config()
  self.options = self.options or {}
  self.max_fail_count = self.options.max_fail_count or DEFAULT_MAX_FAIL_COUNT
  self.max_heartbeat_timeout = self.options.max_heartbeat_timeout or DEFAULT_MAX_HEARTBEAT_TIMEOUT_COUNT
  self.heartbeat_interval = self.options.heartbeat_interval or DEFAULT_HEARTBEAT_INTERVAL
  self.is_calling_heartbeat = false
  self.last_rpc_time = E.time()
  self.fail_history = {}
  self.fail_times = 0
  self.first_timeout = 0
end

function M:on_rpc_result(cmd, is_timeout, trace_id, code, cost)
  if self.destroy_flag then
    return
  end
  if not is_timeout then
    self.fail_times = 0
    self.last_rpc_time = E.time()
  else
    table.insert(self.fail_history, {
      cmd = cmd,
      trace_id = trace_id,
      ts = E.time()
    })
    if #self.fail_history > 5 then
      table.remove(self.fail_history, 1)
    end
    if "heartbeat" == cmd then
      if 0 == self.fail_times then
        self.first_timeout = E.system_ms()
      end
      self.fail_times = self.fail_times + 1
    end
    self.last_rpc_time = 0
  end
  local ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
  if ok and code and cmd and m_api_stats and m_api_stats.count_game_rpc_call then
    m_api_stats.count_game_rpc_call("sdk." .. cmd, 0 == code, code, cost, "ejoysdk.chat")
  end
end

function M:start_heartbeat()
  if self.destroy_flag then
    return false
  end
  if self.heartbeat_timer_running then
    return false
  end
  self.heartbeat_timer_running = true
  self:timer(self:_heartbeat_action())
  return true
end

function M:is_heartbeat_timer_running()
  return self.heartbeat_timer_running
end

function M:_heartbeat_action()
  local action
  
  function action()
    if not self.heartbeat_timer_running then
      return -1
    end
    if self.destroy_flag then
      self.heartbeat_timer_running = false
      return -1
    end
    local SESSION_MGR = require("ejoysdk_lua.chat.ejoysdk_chat_session_manager")
    if not SESSION_MGR.has_running_session() or SESSION_MGR.get_status() ~= CS.CHAT_CONNECTED then
      self.heartbeat_timer_running = false
      return -1
    end
    local current_fail_times = self.fail_times
    if current_fail_times >= self.max_fail_count then
      if self.handlers and self.handlers.on_heartbeat_timeout_reach_max_count then
        self.handlers.on_heartbeat_timeout_reach_max_count({
          fail_history = self.fail_history,
          fail_times = current_fail_times,
          first_timeout = self.first_timeout or 0,
          cost = E.system_ms() - (self.first_timeout or 0)
        })
      end
      return current_fail_times
    end
    if E.time() - self.last_rpc_time >= self.heartbeat_interval and not self.is_calling_heartbeat then
      local heartbeat_timeout = math.min(self.max_heartbeat_timeout, 2 * self.fail_times + math.random(2, 6))
      self.is_calling_heartbeat = true
      local chat_server = require("ejoysdk_lua.chat.ejoysdk_chat_server")
      chat_server.rpc_chat({cmd = "heartbeat", _sdk_rpc_timeout_second = heartbeat_timeout}, function(ret)
        self.is_calling_heartbeat = false
        if self.destroy_flag then
          self.heartbeat_timer_running = false
          return
        end
        if 0 == ret.code then
          E.LOG.debug(TAG, "heartbeat succ")
          return
        end
        if ret.code ~= CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT then
          chat_log.warn(chat_log_util.header(), TAG, "heartbeat_error", {
            code = ret.code,
            msg = ret.msg
          })
          return
        end
      end)
      self.last_rpc_time = E.time()
      return current_fail_times
    end
    return current_fail_times
  end
  
  return action
end

function M:timer(callback)
  local tick
  
  function tick()
    if callback then
      callback()
    end
    if self.heartbeat_timer_running then
      E.Timer.once(HEARTBEAT_TICK_INTERVAL, tick)
    end
  end
  
  E.Timer.once(HEARTBEAT_TICK_INTERVAL, tick)
end

function M:destroy()
  if not self.destroy_flag then
    self.destroy_flag = true
    self:reset_config()
    self.heartbeat_timer_running = false
    self.handlers = nil
  end
end

return M
