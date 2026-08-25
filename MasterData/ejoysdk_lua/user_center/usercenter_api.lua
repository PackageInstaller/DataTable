local E = require("ejoysdk_lua.ejoysdk")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local TAG = EM.MODULE.USER_CENTER .. "usercenter_api"
local M = {}
M.ENV = {DEBUG = "debug", RELEASE = "release"}
M.URL_BASE_HEARTBEAT = {
  RELEASE = "https://msg.flysdk.cn/ejoyclient/",
  DEBUG = "http://dssdk-msg.alibaba.net/ejoyclient/"
}
M.URL_BASE_EXCHANGE_TOKEN = {
  RELEASE = "https://account.flysdk.cn/ejoyclient/",
  DEBUG = "http://dsaccount-game.alibaba.net/ejoyclient/"
}
local l_env

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  l_env = env
end

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

function M.usercenter_system_config_check(config_check_time, cb)
  E.LOG.debug(TAG, "usercenter_system_config_check begin")
  local params = {}
  params.configCheckTime = config_check_time
  UP.post(UP.SERVICE.CONFIG_CHECK, params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.usercenter_login(third_party_type, third_party_token, agst_token, migrate_token, guest_policy, risk, accountos, cb)
  E.LOG.debug(TAG, "usercenter_login begin")
  local params = {}
  params.thirdPartyType = third_party_type
  params.thirdPartyToken = third_party_token
  params.agstToken = agst_token
  params.guestPolicy = guest_policy or UP.GUEST_POLICY.CHECK
  params.risk = risk
  params.selectAccountOs = accountos
  local ucenter_api_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.UCENTER_API_LOGIN)
  if ucenter_api_login_span then
    local ucenter_api_login_span_id = ucenter_api_login_span:context():get_span_id()
    params.opentracing = {span_id = ucenter_api_login_span_id}
  end
  if migrate_token and "" ~= migrate_token then
    params.migrateToken = migrate_token
  end
  UP.post(UP.SERVICE.LOGIN, params, function(succ, ...)
    if succ then
      local data = (...)
      ATracer.finish_login_sub_span(ucenter_api_login_span, data)
      cb(true, data)
    else
      local code, msg, data = ...
      ATracer.finish_login_sub_span(ucenter_api_login_span, data)
      cb(false, code, msg, data)
    end
  end)
end

function M.usercenter_bind_list(token, cb)
  E.LOG.debug(TAG, "usercenter_bind_list begin")
  local params = {}
  params.token = token
  UP.post(UP.SERVICE.BIND_LIST, params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.usercenter_bind(token, agst_token, third_party_type, third_party_token, cb)
  E.LOG.debug(TAG, "usercenter_bind begin")
  local params = {}
  params.token = token
  params.agstToken = agst_token
  params.thirdPartyType = third_party_type
  params.thirdPartyToken = third_party_token
  UP.post(UP.SERVICE.BIND, params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.user_center_validate_login_auth_code(token, login_auth_code, redirect_uri, gameData, cb)
  local params = {}
  params.token = token
  params.loginAuthCode = login_auth_code
  params.redirectUrl = redirect_uri
  params.gameData = gameData
  E.log(params)
  UP.post(UP.SERVICE.VALIDATE_LOGIN_AUTH_CODE, params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.user_center_get_login_auth_code(token, redirect_uri, game_data, cb)
  local params = {}
  params.token = token
  params.redirectUrl = redirect_uri
  params.gameData = game_data
  E.log(params)
  UP.post(UP.SERVICE.GET_LOGIN_AUTH_CODE, params, function(succ, ...)
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.usercenter_check_version_update(params, cb)
  UP.post(UP.SERVICE.VERSION_UPDATE_CHECK, params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.user_center_heartbeat(params, cb)
  local V = require("ejoysdk_lua.version")
  local api = UP.SERVICE.HEART_BEAT
  local domain = M.URL_BASE_HEARTBEAT.RELEASE
  local _env = get_env()
  if _env == M.ENV.DEBUG then
    domain = M.URL_BASE_HEARTBEAT.DEBUG
  end
  local url = domain .. api .. "?ver=1.0&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
  UP.post_to(url, api, params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.user_center_replace_ptoken(params, cb)
  local V = require("ejoysdk_lua.version")
  local api = UP.SERVICE.TOKEN_EXCHANGE
  local domain = M.URL_BASE_EXCHANGE_TOKEN.RELEASE
  local _env = get_env()
  if _env == M.ENV.DEBUG then
    domain = M.URL_BASE_EXCHANGE_TOKEN.DEBUG
  end
  local url = domain .. api .. "?ver=1.0&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
  UP.post_to(url, api, params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.get_user_ip_info(cb)
  UP.post(UP.SERVICE.GET_USER_IP_INFO, {}, cb or function()
  end)
end

function M.get_remain_time(token, scene, cb)
  E.LOG.debug(TAG, "get try game remain time...")
  local params = {}
  params.token = token
  params.scene = scene
  UP.post(UP.SERVICE.CLOUD_CHECK, params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.get_pre_order_status(platform, type, items, cb)
  local params = {
    bundleId = E.Sysinfo.package_name(),
    bizAppId = E.get_game_id(),
    platform = platform,
    reserveIds = items,
    type = type or ""
  }
  UP.post(UP.SERVICE.RESERVER_CHECK, params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.query_account_subscribe_status(account_id, cb)
  E.LOG.debug(TAG, "query_account_subscribe_status begin")
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local usercenter_user_info = USER.user_info()
  local params = {}
  params.accountId = account_id
  params.token = usercenter_user_info.token
  UP.post(UP.SERVICE.GET_SUBSCRIBE_INFO, params, function(succ, ...)
    E.LOG.debug(TAG, "GET_SUBSCRIBE_INFO return")
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.modify_account_subscribe_status(account_id, status, cb)
  E.LOG.debug(TAG, "modify_account_subscribe_status begin")
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local usercenter_user_info = USER.user_info()
  local params = {}
  params.type = type or 1
  params.accountId = account_id
  params.token = usercenter_user_info.token
  params.status = status
  UP.post(UP.SERVICE.MODIFY_SUBSCRIBE_INFO, params, function(succ, ...)
    E.LOG.debug(TAG, "MODIFY_SUBSCRIBE_INFO return")
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.modify_account_subscribe_status_with_type(subscribe_type, account_id, status, cb)
  E.LOG.debug(TAG, "modify_account_subscribe_status_new begin")
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local usercenter_user_info = USER.user_info()
  local params = {}
  params.type = subscribe_type or 1
  params.accountId = account_id
  params.token = usercenter_user_info.token
  params.status = status
  UP.post(UP.SERVICE.MODIFY_SUBSCRIBE_INFO, params, function(succ, ...)
    E.LOG.debug(TAG, "MODIFY_SUBSCRIBE_INFO return")
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local data = (...)
      cb(true, data)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.has_target_account(target_game_id, cb)
  M.has_target_account_params(target_game_id, nil, cb)
end

function M.has_target_account_params(target_game_id, opts, cb)
  E.LOG.debug(TAG, "has_target_account begin")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local params = {}
  local user_info = EG.user_info()
  if not user_info or user_info and user_info.st == nil then
    local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
    if cb then
      cb(false, CONSTANTS.OFFICIAL_ERR_CODES.CODE_NO_LOGIN, "need login first")
    end
    return
  end
  params.token = user_info.st
  params.targetGameId = target_game_id
  if opts then
    for okey, ovalue in pairs(opts) do
      params[okey] = ovalue
    end
  end
  UP.post(UP.SERVICE.HAS_TARGET_ACCOUNT, params, function(succ, ...)
    if succ then
      local data = (...)
      if cb then
        cb(true, data)
      end
    else
      local code, msg = ...
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

function M.query_steam_account_status(steam_app_id, steam_account_id, account_token, cb)
  E.LOG.debug(TAG, "query_steam_account_status begin")
  local params = {}
  params.appId = steam_app_id
  params.steamId = steam_account_id
  params.token = account_token
  UP.post(UP.SERVICE.QUERY_STEAM_USER_INFO, params, function(succ, ...)
    E.LOG.debug(TAG, "QUERY_STEAM_USER_INFO return result----")
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local data = (...)
      if cb then
        cb(true, data)
      end
    else
      local code, msg = ...
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

function M.get_account_attribution(token, channel_params, cb)
  local params = channel_params
  params.token = token
  UP.post(UP.SERVICE.GET_ACCOUNT_ATTRIBUTION, params, function(succ, ...)
    E.LOG.debug(TAG, "GET_ACCOUNT_ATTRIBUTION return result----")
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local data = (...)
      if cb then
        cb(true, data)
      end
    else
      local code, msg = ...
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

return M
