local E = require("ejoysdk_lua.ejoysdk")
local V = require("ejoysdk_lua.version")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
local TAG = EM.MODULE.USER_CENTER .. "usercenter_protocol"
local usercenter_si = ""
_ejoysdk.log("usercenter protocol init")
local M = {}
M.SERVICE = {
  BIND = "account.thirdParty.bind",
  BIND_LIST = "account.thirdParty.list",
  LOGIN = "account.thirdParty.login",
  CONFIG_CHECK = "system.config.check",
  SYS_DEVICE_INIT = "system.device.init",
  VERSION_UPDATE_CHECK = "resource.game.check",
  GET_USER_IP_INFO = "resolve.userIp.info",
  SDK_RES_CHECK = "sdk.res.check",
  HEART_BEAT = "msg.ejoy.check",
  TOKEN_EXCHANGE = "token.ejoy.exchange",
  CLOUD_RES_LOCK = "cloud.resource.lock",
  CLOUD_CONFIG = "cloud.config.check",
  CLOUD_CHECK = "cloud.msg.check",
  GAME_DISPLAY_INFOS = "game.display.info",
  REFRESH_TOKEN = "account.refresh.token",
  ST_LOGIN = "account.loginWithServiceTicket",
  GWPC_ORDER_CREATE = "gwpc.order.create",
  GUEST_LOGIN = "guest.guestLogin",
  RESERVER_CHECK = "reserve.check",
  IDENTITY_VERIFY_TYPE = "get.identityVerify.type4Client",
  IDENTITY_VERIFY = "identityVerify.list.verify4Client",
  GET_SUBSCRIBE_INFO = "get.subscribeInfo.by.account",
  MODIFY_SUBSCRIBE_INFO = "update.subscribe.status",
  QUERY_STEAM_USER_INFO = "steam.user.info",
  GET_ACCOUNT_ATTRIBUTION = "get.account.attribution"
}
M.SERVICE_TYPE = {
  ACCOUNT_CENTER = "account",
  EDGE_CENTER = "edge",
  DS_PAY = "dspay"
}
M.SERVICE_TYPE_MAPPING = {
  [M.SERVICE.BIND] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.BIND_LIST] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.LOGIN] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.CONFIG_CHECK] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.VERSION_UPDATE_CHECK] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.GET_USER_IP_INFO] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.SDK_RES_CHECK] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.SYS_DEVICE_INIT] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.GUEST_LOGIN] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.GET_SUBSCRIBE_INFO] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.MODIFY_SUBSCRIBE_INFO] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.QUERY_STEAM_USER_INFO] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.GET_ACCOUNT_ATTRIBUTION] = M.SERVICE_TYPE.ACCOUNT_CENTER,
  [M.SERVICE.CLOUD_RES_LOCK] = M.SERVICE_TYPE.EDGE_CENTER,
  [M.SERVICE.CLOUD_CONFIG] = M.SERVICE_TYPE.EDGE_CENTER,
  [M.SERVICE.CLOUD_CHECK] = M.SERVICE_TYPE.EDGE_CENTER,
  [M.SERVICE.GWPC_ORDER_CREATE] = M.SERVICE_TYPE.DS_PAY,
  [M.SERVICE.RESERVER_CHECK] = M.SERVICE_TYPE.EDGE_CENTER
}
M.SERVICE_PATH = {CLIENT = "client", EJOY_CLIENT = "ejoyclient"}
M.SERVICE_PATH_MAPPING = {
  [M.SERVICE_TYPE.DS_PAY] = M.SERVICE_PATH.EJOY_CLIENT
}
M.GUEST_POLICY = {
  CHECK = "check",
  BIND = "bind",
  IGNORE = "ignore"
}
local type_urlbase_map = {}
local api_urlbase_map = {}

local function get_url(api)
  local url
  api = api or ""
  local url_base
  local service_type = M.SERVICE_TYPE_MAPPING[api]
  if service_type then
    url_base = type_urlbase_map[service_type]
    if not url_base or "" == url_base then
      local current_cdn_config = EGC.get_current_cdn_config()
      if current_cdn_config then
        if service_type == M.SERVICE_TYPE.ACCOUNT_CENTER then
          url_base = current_cdn_config.account_center
        elseif service_type == M.SERVICE_TYPE.EDGE_CENTER then
          url_base = current_cdn_config.edge_center
        end
      end
      E.LOG.warn(TAG, "get_url with api not found now check in cdn, url:" .. tostring(url_base))
    end
  end
  if UTILS.STR.is_empty(url_base) then
    url_base = api_urlbase_map[api]
  end
  if url_base then
    local path = M.SERVICE_PATH_MAPPING[service_type] or M.SERVICE_PATH.CLIENT
    url = url_base .. "/" .. path .. "/" .. api .. "?ver=1.0&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
  else
    local temp_usercenter = E.CONFIG.get_config(E.CONFIG.KEY.DOMAIN_ACCOUNT_CENTER)
    if not temp_usercenter then
      temp_usercenter = E.CONFIG.DOMAIN_CONFIG.USER_CENTER
      E.LOG.debug(TAG, "强更域名未设置，使用默认的域名，domain = " .. tostring(temp_usercenter))
    else
      E.LOG.debug(TAG, "强更可以使用设置的域名，domain = " .. tostring(temp_usercenter))
    end
    if temp_usercenter then
      url = temp_usercenter .. "/ejoyclient/" .. api .. "?ver=1.0&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
    end
  end
  return url
end

local function get_request_id()
  local random_mills = math.random(1, 1000)
  local sys_clock = os.time() * 1000
  local random_time_in_mills = sys_clock + random_mills
  E.LOG.debug(TAG, "get_request_id :" .. tostring(random_time_in_mills) .. ", sys_clock:" .. tostring(sys_clock) .. ", random_mills:" .. tostring(random_mills))
  return random_time_in_mills
end

local function get_request_client()
  local client = {}
  client.si = usercenter_si
  client.ve = V.LUA_VERSION
  client.os = E.Sysinfo.os()
  local pkg_info = E.get_pkg_info()
  client.gameId = pkg_info.game_id
  client.pkgInfo = pkg_info
  return client
end

local function _get_request_game()
  local pkg_info = E.get_pkg_info()
  local game = {}
  game.gameId = pkg_info.game_id
  game.channelId = pkg_info.ds_sub_channel_id or "DG_2"
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = gdp.PLAYER_INFO.get()
  if player_info then
    game.roleId = player_info.player_id
    game.zoneId = player_info.server_id
  end
  return game
end

local function get_lx_body(params)
  local id = get_request_id()
  local client = get_request_client()
  local body = {}
  body.id = id
  body.client = client
  body.data = params
  return body
end

local function get_request_params()
  local md5_utdid
  local utdid = E.Sysinfo.utdid() or ""
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_utdid = _ejoysdk_crypt.md5(utdid)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_utdid = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(utdid))
  end
  local request_params = {
    trace = true,
    headers = {
      did = md5_utdid,
      gid = E.get_pkg_info().game_id,
      gver = E.get_pkg_info().versions.app_version_name,
      os = E.get_pkg_info().os,
      ch = "",
      cver = E.get_pkg_info().versions.lua_version
    }
  }
  for k, v in pairs(E.get_pkg_info().versions) do
    request_params.headers[k] = v
  end
  E.LOG.debug(TAG, "get_request_params >>")
  E.LOG.debug(TAG, request_params)
  return request_params
end

function M.set_si(si)
  E.LOG.debug(TAG, "> update protocol si: " .. (si or "nil"))
  usercenter_si = si or ""
end

function M.set_url_base_with_type(service_type, url_base)
  if not service_type or "" == service_type then
    E.LOG.warn(TAG, "set_url_base_with_type failed, with service_type nil")
    return
  end
  E.LOG.debug(TAG, "set_url_base_with_type type:" .. tostring(service_type) .. ", url_base:" .. tostring(url_base))
  type_urlbase_map[service_type] = url_base
end

function M.set_url_base_with_api(api, url_base)
  if UTILS.STR.is_empty(api) then
    E.LOG.warn(TAG, "set_url_base_with_api failed, with api nil")
    return
  end
  E.LOG.debug(TAG, "set_url_base_with_type type:" .. tostring(api) .. ", url_base:" .. tostring(url_base))
  api_urlbase_map[api] = url_base
end

function M.post_to(url, api, params, cb, _log_config)
  E.LOG.debug(TAG, "post, url:" .. url)
  local lx_body = get_lx_body(params)
  local temp_usercenter_si = lx_body.client.si
  if (api == M.SERVICE.VERSION_UPDATE_CHECK or api == M.SERVICE.HEART_BEAT or api == M.SERVICE.TOKEN_EXCHANGE or api == M.SERVICE.SDK_RES_CHECK or api == M.SERVICE.ST_LOGIN or api == M.SERVICE.REFRESH_TOKEN) and (not temp_usercenter_si or "" == temp_usercenter_si) then
    lx_body.client.si = E.Sysinfo.utdid()
  end
  local pkg_info = E.get_pkg_info()
  if lx_body and lx_body.client and pkg_info then
    lx_body.client.channelId = pkg_info.channel_id
    lx_body.client.subChannelId = pkg_info.ds_sub_channel_id
  end
  E.LOG.debug(TAG, "post, body>>")
  E.LOG.debug(TAG, lx_body)
  local request_params = get_request_params()
  local config_check_init_span
  if api == M.SERVICE.CONFIG_CHECK then
    config_check_init_span = ETracer.start_span("init_config")
    if config_check_init_span then
      local config_check_init_span_id = config_check_init_span:context():get_span_id()
      request_params.opentracing = {span_id = config_check_init_span_id}
    end
  elseif params.opentracing then
    request_params.opentracing = params.opentracing
  end
  if _log_config then
    request_params._log_config = _log_config
  end
  E.HTTP.post(url, request_params, E.HTTP.CT_JSON, lx_body, function(resp)
    E.LOG.debug(TAG, "post response received, url:" .. tostring(url))
    E.LOG.debug(TAG, resp)
    if config_check_init_span then
      ETracer.finish_span(config_check_init_span:context():get_span_id(), resp)
    end
    if resp.status == 200 then
      local body_json = resp.body
      if type(resp.body) == "string" then
        body_json = JSON.decode(resp.body)
      end
      if body_json.state then
        if body_json.state.code == 2000000 then
          E.LOG.debug(TAG, "post response succ, url:" .. tostring(url))
          cb(true, body_json.data)
        else
          E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", code:" .. tostring(body_json.state.code) .. ", msg:" .. tostring(body_json.state.msg))
          cb(false, body_json.state.code, body_json.state.msg, body_json.data)
        end
      else
        E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", body.state is nil")
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_RESPONSE_INVALID, "响应无法解析")
      end
    else
      E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", status:" .. tostring(resp.status))
      cb(false, resp.status, "请求出错")
    end
  end)
end

function M.post(api, params, cb)
  local url = get_url(api)
  M.post_to(url, api, params, cb)
end

M.get_url = get_url
return M
