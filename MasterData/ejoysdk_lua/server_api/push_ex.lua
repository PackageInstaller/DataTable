local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_config")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local pusher_api = BASE_API:New("pusher")
local M = {COLLECT_TYPE_ACCOUNT = "account", COLLECT_TYPE_PLAYERID = "player_id"}

local function server_collect(type, api_path, body, cb)
  assert(type == M.COLLECT_TYPE_ACCOUNT or type == M.COLLECT_TYPE_PLAYERID, "server collect type wrong")
  assert(api_path, "api_path can not be nil")
  body = body or {}
  cb = cb or function()
  end
  local api
  if EC.is_force_use_rule_service_splice_in_path("pusher") then
    api = api_path
  else
    local product = E.CONFIG.get_config("product"):lower()
    api = "/pusher/" .. product .. api_path
  end
  local opt = {}
  if M.COLLECT_TYPE_ACCOUNT == type then
    opt.use_ejoy_token = true
  else
    opt.use_moment_token = true
  end
  pusher_api:post(api, {}, body, opt, cb)
end

function M.bind_channel(channel, type, value)
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
  local body = {
    bind_channel = channel,
    type = type,
    value = value
  }
  server_collect(type, "/manage/bind_v2", body, function(succ)
    if succ then
      local log_params = {
        channel = tostring(channel),
        type = tostring(type),
        value = tostring(value),
        cause = "bind_channel_succ"
      }
      log_mgr.debug({}, "push", "bind_channel", log_params, {})
    else
      local log_params = {
        channel = tostring(channel),
        type = tostring(type),
        value = tostring(value),
        cause = "server_collect_fail"
      }
      log_mgr.warn({}, "push_bind_channel_fail", log_params, {})
      ESTAT.stat_action("push", "bind_channel", false, log_params)
    end
  end)
end

function M.inc_msg_subscribe(channel, template_id)
  local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
  local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
  local body = {bind_channel = channel, template_id = template_id}
  server_collect(M.COLLECT_TYPE_ACCOUNT, "/manage/inc_msg_subscribe", body, function(succ)
    if succ then
      local log_params = {
        channel = tostring(channel),
        template_id = tostring(template_id),
        cause = "inc_msg_subscribe_succ"
      }
      log_mgr.debug({}, "push", "inc_msg_subscribe", log_params, {})
    else
      local log_params = {
        channel = tostring(channel),
        template_id = tostring(template_id),
        cause = "server_collect_fail"
      }
      log_mgr.warn({}, "push_inc_msg_subscribe_fail", log_params, {})
      ESTAT.stat_action("push", "inc_msg_subscribe", false, log_params)
    end
  end)
end

return M
