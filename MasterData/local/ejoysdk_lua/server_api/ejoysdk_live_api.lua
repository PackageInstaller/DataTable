local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local holo_api = BASE_API:New("holo")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local TAG = "live#ejoysdk_live_api"
local M = {}

function M.get_topical_scheds(topic_id, cb)
  if not topic_id then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "invalid topic_id")
    return
  end
  local params = {topic_id = topic_id}
  M.get_topical_scheds_with_params(params, cb)
end

function M.get_topical_scheds_with_params(params, cb)
  local headers = {}
  local query_params = params or {}
  local opt = {use_moment_token = true, use_ejoy_token = true}
  holo_api:get("/live_sched/openapi/get_topical_scheds", headers, query_params, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp and resp.data)
    else
      E.LOG.debug(TAG, "get_topical_scheds fail")
      cb(false, ...)
    end
  end)
end

function M.live_sched_tick(sched_id, cb)
  if not sched_id then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "invalid sched_id")
    return
  end
  local params = {sched_id = sched_id}
  M.live_sched_tick_with_params(params, cb)
end

function M.live_sched_tick_with_params(params, cb)
  local headers = {}
  local body = params or {}
  local opt = {use_moment_token = true, use_ejoy_token = true}
  holo_api:post("/live_sched/api/tick", headers, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp and resp.data)
    else
      E.LOG.debug(TAG, "live_sched_tick fail")
      cb(false, ...)
    end
  end)
end

M.default_tick_interval = 180
M.default_log_interval = 5
local current_next_interval = M.default_tick_interval
local current_sched_id, current_sched_info, current_timer_id
local current_sched_info_ext = {}

local function log_live_action(bizid, _sched_id)
  local jf_params = {
    schedId = _sched_id,
    [ESTAT.STAT_KEY.JF_ONLY] = true
  }
  if current_sched_info and type(current_sched_info) == "table" then
    jf_params.schedStatus = current_sched_info.sched_status or ""
  end
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local playerInfo = EG.player_info()
  if playerInfo then
    jf_params.roleId = playerInfo.player_id
  end
  if current_sched_info_ext and type(current_sched_info_ext) == "table" then
    for k, v in pairs(current_sched_info_ext) do
      jf_params[k] = v
    end
  end
  ESTAT.stat_bizid(bizid, "0", "0", jf_params)
end

function M.set_quality_type(quality_type)
  M.set_live_log_ext("qualityType", quality_type)
end

function M.set_live_log_ext(log_key, log_value)
  if current_sched_info_ext then
    current_sched_info_ext[log_key] = log_value
  end
end

function M.get_live_log_ext()
  return current_sched_info_ext
end

function M.start_live_sched_loop_tick(sched_id, loop_tick_handler)
  if sched_id and current_sched_id ~= sched_id then
    current_sched_id = sched_id
    local tick_live_timer
    
    function tick_live_timer(loop_tick_sched_id, loop_timer_id)
      if loop_tick_sched_id then
        M.live_sched_tick(loop_tick_sched_id, function(suc, ...)
          if loop_tick_sched_id ~= current_sched_id or loop_timer_id ~= current_timer_id then
            E.LOG.debug(TAG, "sched_id or timer changed, loop_tick_sched_id:" .. tostring(loop_tick_sched_id) .. ", current_sched_id:" .. tostring(current_sched_id) .. ", loop_timer_id:" .. tostring(loop_timer_id) .. ", current_timer_id:" .. tostring(current_timer_id))
            return
          end
          if suc then
            local data = (...)
            if data then
              if data.sched_info and type(data.sched_info) == "table" then
                current_sched_info = data.sched_info
              end
              if loop_tick_handler then
                loop_tick_handler(data)
              end
              if -1 == data.next_interval then
                E.LOG.debug(TAG, "sched_id is not enable(next_interval: -1), stop tick")
                M.stop_live_sched_loop_tick()
                return
              else
                current_next_interval = data.next_interval or M.default_tick_interval
                if current_next_interval < 10 then
                  current_next_interval = 10
                end
              end
            end
          end
          if current_next_interval > 0 then
            E.Timer.once(current_next_interval, function()
              if current_sched_id and tick_live_timer and loop_tick_sched_id == current_sched_id and loop_timer_id == current_timer_id then
                tick_live_timer(loop_tick_sched_id, loop_timer_id)
              else
                E.LOG.debug(TAG, "timer changed, loop_tick_sched_id:" .. tostring(loop_tick_sched_id) .. ", current_sched_id:" .. tostring(current_sched_id) .. ", loop_timer_id:" .. tostring(loop_timer_id) .. ", current_timer_id:" .. tostring(current_timer_id))
              end
            end)
          end
        end)
      end
    end
    
    local uuid = require("ejoysdk_lua.ejoysdk_uuid")
    current_timer_id = uuid()
    if tick_live_timer then
      tick_live_timer(current_sched_id, current_timer_id)
    end
    local log_live_timer
    
    function log_live_timer(loop_tick_sched_id, loop_timer_id)
      if loop_tick_sched_id then
        E.Timer.once(M.default_log_interval, function()
          if current_sched_id and log_live_timer and loop_tick_sched_id == current_sched_id and loop_timer_id == current_timer_id then
            if current_sched_info_ext and current_sched_info_ext.startTime then
              local duration = E.time_ms() - current_sched_info_ext.startTime
              M.set_live_log_ext("duration", duration)
              log_live_action("duration.live.online", loop_tick_sched_id)
              pcall(log_live_timer, loop_tick_sched_id, loop_timer_id)
            end
          else
            E.LOG.debug(TAG, "log timer changed, loop_tick_sched_id:" .. tostring(loop_tick_sched_id) .. ", current_sched_id:" .. tostring(current_sched_id) .. ", loop_timer_id:" .. tostring(loop_timer_id) .. ", current_timer_id:" .. tostring(current_timer_id))
          end
        end)
      end
    end
    
    if log_live_timer then
      pcall(log_live_timer, current_sched_id, current_timer_id)
    end
    M.set_live_log_ext("startTime", E.time_ms())
    log_live_action("live.user.online", current_sched_id)
  end
end

function M.stop_live_sched_loop_tick()
  current_sched_id = nil
  current_timer_id = nil
  current_sched_info = nil
  current_sched_info_ext = {}
end

function M.enter(sched_id, cb)
  if not sched_id then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "invalid sched_id")
    return
  end
  local params = {sched_id = sched_id}
  M.enter_with_params(params, cb)
end

function M.enter_with_params(params, cb)
  local headers = {}
  local body = params or {}
  local opt = {use_moment_token = true, use_ejoy_token = true}
  holo_api:post("/live_sched/api/enter", headers, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp and resp.data)
    else
      E.LOG.debug(TAG, "live_sched enter fail")
      cb(false, ...)
    end
  end)
end

function M.exit(sched_id, cb)
  if not sched_id then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "invalid sched_id")
    return
  end
  local params = {sched_id = sched_id}
  M.exit_with_params(params, cb)
end

function M.exit_with_params(params, cb)
  local headers = {}
  local body = params or {}
  local opt = {use_moment_token = true, use_ejoy_token = true}
  holo_api:post("/live_sched/api/exit", headers, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp and resp.data)
    else
      E.LOG.debug(TAG, "live_sched exit fail")
      cb(false, ...)
    end
  end)
end

return M
