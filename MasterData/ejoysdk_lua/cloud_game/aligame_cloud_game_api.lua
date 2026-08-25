local BCGA = require("ejoysdk_lua.cloud_game.base_cloud_game_api")
local E = require("ejoysdk_lua.ejoysdk")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = BCGA
local TAG = EM.MODULE.CLOUD_GAME .. "alg_cloud_game_api"

function M._init_cloud_native(cb)
  E.LOG.debug(TAG, "_init_cloud_native begin")
  local trid = "0"
  if STAT.get_trace_id then
    trid = STAT.get_trace_id()
  end
  local server_play_configs = M.get_server_play_configs()
  local params = {trace_id = trid, play_config = server_play_configs}
  E.LOG.debug(TAG, "init_cloud trace_id:" .. tostring(trid))
  local vendor_name = M.get_vendor_name()
  UNI.async_call(vendor_name, M.ASYNC_INIT_CLOUD_GAME, params, nil, function(succ, ...)
    local body = (...)
    E.LOG.debug(TAG, "init ASYNC_INIT_CLOUD_GAME succ >>")
    E.LOG.debug(TAG, body)
    cb(succ, ...)
  end)
end

function M._request_cloud_res(cb)
  E.LOG.debug(TAG, "_request_cloud_res begin")
  CSTAT.stat_action("mini_client_request_source")
  M.request_cloud_service(M.SERVICE.CLOUD_RES_LOCK, {}, function(succ, ...)
    if succ then
      CSTAT.stat_action("mini_client_request_source_recieve", nil, true, nil)
    else
      local code, msg = ...
      CSTAT.stat_action_fail("mini_client_request_source_recieve", nil, code, msg)
    end
    cb(succ, ...)
  end)
end

local function cache_cloud_res_data(res_data)
  local cloud_schedule_config = res_data
  M.set_server_schedule_config(cloud_schedule_config)
  E.LOG.debug(TAG, "cloud_schedule_config >>")
  E.LOG.debug(TAG, cloud_schedule_config)
  local ex = res_data[M.RES_KEY.EX]
  local server_play_configs = {}
  if ex and ex[M.RES_KEY.EX_PLAY_CONFIG] then
    server_play_configs = ex[M.RES_KEY.EX_PLAY_CONFIG]
  end
  M.set_server_play_configs(server_play_configs)
  E.LOG.debug(TAG, "play_config >>")
  E.LOG.debug(TAG, server_play_configs)
  if ex and ex[M.RES_KEY.EX_SDK_CONFIG] then
    local sdk_config = ex[M.RES_KEY.EX_SDK_CONFIG]
    if sdk_config then
      local restrict_rules = sdk_config[M.RES_KEY.EX_RESTRICT_RULES]
      M.set_server_restrict_rules(restrict_rules)
      E.LOG.debug(TAG, "restrict_rules >>")
      E.LOG.debug(TAG, restrict_rules)
      local skip_time_before_restrict_check_sec = sdk_config[M.RES_KEY.EX_SKIP_TIME_BEFORE_CHECK_RESTRICT_SEC] or 0
      M.set_server_skip_time_before_restrict_check_sec(skip_time_before_restrict_check_sec)
    end
  end
end

function M._request_cloud_config(cb)
  E.LOG.debug(TAG, "_request_cloud_config begin")
  M.request_cloud_service(DSP.SERVICE.CLOUD_RES_LOCK, {}, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "_request_cloud_config succ")
      local res_data = (...)
      cache_cloud_res_data(res_data)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "_request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M._get_schedule_start_params(cb)
  E.LOG.debug(TAG, "start_game begin, start_mode is scheduling, now start request_cloud_res")
  local cloud_schedule_config = M.get_server_schedule_config()
  if cloud_schedule_config and cloud_schedule_config[M.RES_KEY.SCHEDULE_ID] and cloud_schedule_config[M.RES_KEY.TOKEN] then
    E.LOG.debug(TAG, "cloud_schedule_config not nil, use it directly")
    local params = {
      token = cloud_schedule_config[M.RES_KEY.TOKEN],
      schedule_id = cloud_schedule_config[M.RES_KEY.SCHEDULE_ID]
    }
    cb(true, params)
  else
    E.LOG.debug(TAG, "cloud_schedule_config is nil, now request for cloud_res")
    M._request_cloud_res(function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "request_cloud_res succ")
        local res_data = (...)
        local tok = res_data[M.RES_KEY.TOKEN]
        local sch_id = res_data[M.RES_KEY.SCHEDULE_ID]
        E.LOG.debug(TAG, ">>>>>>>> res_data>>")
        E.log(res_data)
        local params = {token = tok, schedule_id = sch_id}
        cb(true, params)
      else
        local code, msg = ...
        E.LOG.warn(TAG, "request_cloud_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg)
      end
    end)
  end
end

return M
