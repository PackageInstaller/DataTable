local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local friend_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local friend_log_util = require("ejoysdk_lua.friend.ejoysdk_friend_log_util")
local url_items = {
  get_favors_by_ids = "/favor/get_favors_by_ids",
  get_topn_favors = "/favor/get_topn_favors"
}
local TAG = EM.MODULE.FRIEND .. "favor"
local M = {}
local module_inited = false

local function require_params()
  local player_token = EH.get_player_token()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    }
  }
end

local function post(url, params, cb)
  E.HTTP.post(url, require_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(200, resp.body)
      else
        cb(resp.body.code, resp.body)
      end
    else
      cb(resp.status, resp.body or {})
    end
  end)
end

local function favor_post(type, params, cb)
  local favor_url_prefix = E.CONFIG.get_config("friend")
  local url = favor_url_prefix .. url_items[type]
  post(url, params, cb)
end

local function player_online_handler(_player_token)
  ET.publish(ET.favor.INITED, true)
end

function M.init()
  friend_log.call_api(friend_log_util.header(), TAG, "init", friend_log.LOG_LEVEL.HIGH, {})
  if module_inited then
    return
  end
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
  module_inited = true
end

function M.get_favors_by_ids(user_type, user_ids, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_favors_by_ids", friend_log.LOG_LEVEL.LOW, {}, user_type, user_ids, cb)
  local params = {user_type = user_type, user_ids = user_ids}
  favor_post("get_favors_by_ids", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.data.list)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_favors_by_ids", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.data.list)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_favors_by_ids", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_topn_favors(user_type, topn, skip, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_topn_favors", friend_log.LOG_LEVEL.LOW, {}, user_type, topn, skip, cb)
  local params = {
    user_type = user_type,
    topn = topn,
    skip = skip
  }
  favor_post("get_topn_favors", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.data.list)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_topn_favors", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.data.list)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_topn_favors", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

return M
