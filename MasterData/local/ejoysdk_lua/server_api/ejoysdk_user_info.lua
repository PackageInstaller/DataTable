local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local user_info_api = BASE_API:New("user-info")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local HTTP = E.HTTP
local TAG = EM.MODULE.SERVER_API .. "user_info"
local ALGORITHM_TYPE_DH1 = "dh1"

function M.get_punishment(cb)
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local player_token = holo.get_player_token()
  if nil == player_token then
    cb(false, -1, "player token is nil")
    return
  end
  E.LOG.debug(TAG, "get_punishment")
  local opt = {use_moment_token = true, trace = true}
  local url = "/player_api/get_punishments"
  user_info_api:post(url, {}, {}, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.punishments)
    else
      cb(false, ...)
    end
  end)
end

function M.get_punishment_details(player_id_list, cb)
  local body = {}
  local body_json_str
  local id_list = player_id_list
  local JSON = require("ejoysdk_lua.ejoysdk_json")
  if id_list and next(id_list) == nil then
    body.player_id_list = JSON.newArray()
    body_json_str = JSON.encode_with_option(body, {encode_empty_array = true})
  else
    body.player_id_list = id_list
    body_json_str = JSON.encode(body)
  end
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:post("/client_api/get_punishment_details", {}, body_json_str, opt, function(succ, ...)
    if succ then
      local result = (...)
      cb(true, result.players_punishment_details)
    else
      cb(false, ...)
    end
  end)
end

local function get_player_token_http_inner(player_id, cb)
  E.LOG.debug(TAG, "get_player_token_http")
  local client_private = _ejoysdk_crypt.randomkey()
  local client_public = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.dhexchange(client_private))
  local body = {
    player_id = player_id,
    secret_exchange_data = {algorithm_type = ALGORITHM_TYPE_DH1, public_key = client_public}
  }
  local opt = {use_ejoy_token = true, trace = true}
  local url = "/client_api/get_player_token"
  local http_finish = false
  local time_out = false
  E.Timer.once(30, function()
    time_out = true
    if not http_finish then
      E.LOG.error(TAG, "get_player_token, succ=false, time out")
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REQUEST_TIMEOUT, "time out")
    end
  end)
  user_info_api:post(url, {}, body, opt, function(succ, ...)
    http_finish = true
    if time_out then
      return
    end
    if succ then
      local resp = (...)
      if resp and resp.moment_token and #resp.moment_token > 0 then
        user_info_api:save_secret(client_private, resp.moment_token, resp.secret_exchange_data, resp.signature_versions)
        cb(true, resp)
        return
      end
    end
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    E.LOG.debug(TAG, "获取 player token 失败，失败 player id: " .. tostring(player_id) .. " ,uid: " .. (gangplank.user_info().uid or ""))
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.get_player_token_http(player_id, cb)
  if not E.did_sync_sever_time() then
    E.LOG.debug(TAG, "get_server_time is not ready, will request get_server_time")
    local EGK = require("ejoysdk_lua.ejoysdk_gangplank")
    EGK.sync_server_time(function(succ, ...)
      if not succ then
        local status, body = ...
        local full_msg = "status:" .. tostring(status) .. ", code:" .. tostring(body and body.code) .. ", msg:" .. tostring(body and body.message)
        E.LOG.debug(TAG, "get_server_time request fail," .. tostring(full_msg))
      end
      get_player_token_http_inner(player_id, cb)
    end)
  else
    get_player_token_http_inner(player_id, cb)
  end
end

function M.get_players2(cb)
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:get("/client_api/get_players", {}, {}, opt, function(succ, ...)
    if succ then
      local result = (...)
      cb(true, result.players)
    else
      cb(succ, ...)
    end
  end)
end

function M.get_players(token, cb)
  E.LOG.debug(TAG, "get_players token : " .. tostring(token))
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:get("/client_api/get_players", {}, {}, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.players)
      return
    end
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.get_players_v2(params, cb)
  local opt = {use_ejoy_token = true, trace = true}
  if params and params.born_publish_area_list then
    params.born_publish_area = params.born_publish_area or params.born_publish_area_list
    params.born_publish_area_list = nil
  end
  user_info_api:post("/client_api/get_players", {}, params, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.players)
      return
    end
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.get_user_info_list(params, cb)
  local opt = {use_moment_token = true}
  user_info_api:post("/player_api/get_user_info_list", {}, params, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.user_list)
      return
    end
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.get_players_with_query(query, cb)
  local url = "/client_api/get_players"
  query = query or {}
  local url_query = HTTP.urlencode2(query)
  if url_query and "" ~= url_query then
    url = url .. "?" .. url_query
  end
  E.LOG.debug(TAG, "get_players_with_query url : " .. tostring(url))
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:get(url, {}, {}, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.players)
      return
    end
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.get_global_players(cb)
  local ejoysdk_gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
  assert(ejoysdk_gangplank.user_info().token, "need login")
  local url = "/client_api/get_global_players"
  E.LOG.debug(TAG, "get_global_players request url:" .. url)
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:get(url, {}, {}, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.players)
      return
    end
    local code, msg = ...
    cb(false, code, msg)
  end)
end

function M.set_label(params, cb)
  local url = "/client_api/set_label"
  E.LOG.debug(TAG, "set_label request url: " .. url)
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:post(url, {}, params, opt, function(succ, ...)
    if succ then
      cb(true, ...)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.set_label_ext_info(params, cb)
  local url = "/client_api/set_label_ext_info"
  E.LOG.debug(TAG, "set_label_ext_info request url: " .. url)
  local opt = {use_ejoy_token = true, trace = true}
  user_info_api:post(url, {}, params, opt, function(succ, ...)
    if succ then
      cb(true, ...)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.get_thirdparty_player_token(thirdparty_info, cb)
  E.LOG.debug(TAG, "get_thirdparty_player_token")
  local body = {thirdparty_info = thirdparty_info}
  local opt = {trace = true}
  local url = "/before_login_client_api/get_thirdparty_player_token"
  user_info_api:post(url, {}, body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      if resp and resp.token_data and resp.token_data.moment_token and #resp.token_data.moment_token > 0 then
        cb(true, resp)
        return
      else
        E.LOG.debug(TAG, "获取 get_thirdparty_player_token 失败, code:" .. tostring(CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_EXPECTED) .. ", msg: responce moment_token is nil")
        cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_EXPECTED, "responce moment_token is nil")
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "获取 get_thirdparty_player_token 失败, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.get_last_login_player(params, cb)
  E.LOG.debug(TAG, "get_last_login_info")
  params = params or {}
  local opt = {trace = true, use_ejoy_token = true}
  local url = "/client_api/get_last_login_player"
  E.log("get_last_login_player")
  E.log(params)
  user_info_api:post(url, {}, params, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp)
    else
      local code, msg, err_body = ...
      E.LOG.debug(TAG, "获取 get_last_login_info 失败, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg, err_body)
    end
  end)
end

return M
