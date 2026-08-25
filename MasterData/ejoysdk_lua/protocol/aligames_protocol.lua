local E = require("ejoysdk_lua.ejoysdk")
local V = require("ejoysdk_lua.version")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local USER_PROTOCOL = require("ejoysdk_lua.user_center.usercenter_protocol")
local TAG = EM.MODULE.PROTOCOL .. "ds_protocol"
local M = {}
local lx_si
_ejoysdk.log("aligames protocol init")
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.URL_BASE = {
  DS_RES = "https://res.flysdk.cn/client/",
  DS_EJOY_RES = "https://res.flysdk.cn/ejoyclient/",
  DS_ACCOUNT = "https://account.flysdk.cn/client/",
  DS_LOG = "https://agalog.flysdk.cn/client/",
  FX_LOG = "https://meta-service.aligames.com/client/",
  DS_PAY = "https://pay.flysdk.cn/client/",
  DS_WEB_PAY = "https://mall.lingxigames.com/client/",
  LX_ACCOUNT = "https://magic-account.flysdk.cn/client/",
  AC_CENTER = "https://account-api.lingxigames.com",
  DS_REPORT = "https://account.flysdk.cn/ejoyclient/"
}
M.URL_BASE_PRE_RELEASE = {
  DS_RES = "https://res-pre.flysdk.cn/client/",
  DS_EJOY_RES = "https://pre-res.flysdk.cn/ejoyclient/",
  DS_ACCOUNT = "https://pre-dssdk-account.flysdk.cn/client/",
  DS_LOG = "https://pre-agalog.alibaba-inc.com/client/",
  DS_PAY = "https://pay-pre.flysdk.cn/client/",
  DS_WEB_PAY = "https://pre-dssdk-mall.alibaba-inc.com/client/",
  FX_LOG = "http://pre-meta-service.aligames.com/client/",
  LX_ACCOUNT = "https://magic-account.flysdk.cn/client/",
  AC_CENTER = "https://pre-account-api.lingxigames.com",
  DS_REPORT = "http://pre-dssdk-account.flysdk.cn/ejoyclient/"
}
M.URL_BASE_DEBUG = {
  DS_RES = "http://dssdk-res.alibaba.net/client/",
  DS_EJOY_RES = "http://dssdk-res.alibaba.net/ejoyclient/",
  DS_ACCOUNT = "http://dsaccount-game.alibaba.net/client/",
  DS_PAY = "http://dspay.alibaba.net/client/",
  DS_WEB_PAY = "https://dssdk-mall.alibaba.net/client/",
  DS_LOG = "http://agalog.game.alibaba.net/client/",
  FX_LOG = "http://pre-meta-service.aligames.com/client/",
  LX_ACCOUNT = "http://magic-account.game.alibaba.net/client/",
  AC_CENTER = "http://ieu-cn-account-server.alibaba.net",
  DS_REPORT = "http://dsaccount-game.alibaba.net/ejoyclient/"
}
M.SERVICE = {
  CLOUD_RES_LOCK = "cloud.resource.lock",
  ALI_CLOUD_RES_LOCK = "cloud.alicloud.resource.lock",
  CLOUD_CONFIG = "cloud.config.check",
  ACCOUNT_LOGIN = "account.login",
  CREATE_ORDER = "pay.order.create",
  WEB_CREATE_ORDER = "web.order.create",
  PAY_ORDER_NOTIFY = "pay.order.notify",
  LOG = "log.collect.ejoysdklog",
  GAME_COMMUNITY_INFO = "game.community.info",
  CLOUD_MSG_CHECK = "cloud.msg.check",
  FREE_DATA_PKG_CHECK = "cloud.freeMobileData.check",
  FREE_DATA_PKG_RECEIVE = "cloud.freeMobileData.receive",
  FREE_DATA_PKG_RESULT = "cloud.freeMobileData.receive.check",
  GET_LOGIN_USER_INFO = "cddp.get.login.userinfo",
  REALNAME_INFO_REPORT = "realname.info.report",
  ACCOUNT_EVENT_REPORT = "account.event.report",
  ACCOUNT_QUERY_INFO = "query.transfer.info",
  TEAM_PLAY_TICKET = "team.play.ticket"
}
M.PAY_PARAMS_KEY = {
  INT_PRODUCT_UNIT_PRICE = "productUnitPrice",
  INT_PRODUCT_COUNT = "productCount",
  STRING_PAY_PRODUCT_NAME = "productName",
  STRING_PAY_PRODUCT_ID = "productId",
  STRING_PAY_PRODUCT_DESCRIBE = "productDetail",
  STRING_PAY_PRODUCT_TYPE = "productType",
  STRING_PAY_CLIENT_ORDER_EX = "clientOrderEx",
  STRING_PAY_CALLBACK_PARAMS = "cpOrderParam",
  STRING_PAY_CALLBACK_URL = "callbackUrl",
  STRING_PAY_THIRDPARTYTYPE = "thirdPartyType",
  STRING_CP_ORDERID = "cpOrderId",
  INT_PAY_AMOUNT = "amount",
  STRING_FLY_ORDER_ID = "dsOrderId",
  STRING_DS_TOKEN = "token",
  WEB_PAY_GAME_ID = "gameId",
  WEB_PAY_DS_TOKEN = "dsToken",
  WEB_PAY_CHANNEL_ID = "channelId",
  WEB_PAY_PLAYER_INFO = "playerInfo",
  WEB_PAY_PRODUCT_EXT = "product_ext",
  WEB_PAY_AIRLINE_TYPE = "airlineType",
  WEB_PAY_PKG_INFO = "pkgInfo"
}
local SERVICE_MAPPING = {
  [M.SERVICE.CLOUD_RES_LOCK] = "DS_RES",
  [M.SERVICE.ALI_CLOUD_RES_LOCK] = "DS_RES",
  [M.SERVICE.CLOUD_CONFIG] = "DS_RES",
  [M.SERVICE.ACCOUNT_LOGIN] = "DS_ACCOUNT",
  [M.SERVICE.ACCOUNT_QUERY_INFO] = "DS_ACCOUNT",
  [M.SERVICE.TEAM_PLAY_TICKET] = "DS_ACCOUNT",
  [M.SERVICE.CREATE_ORDER] = "DS_PAY",
  [M.SERVICE.WEB_CREATE_ORDER] = "DS_WEB_PAY",
  [M.SERVICE.PAY_ORDER_NOTIFY] = "DS_PAY",
  [M.SERVICE.LOG] = "FX_LOG",
  [M.SERVICE.GAME_COMMUNITY_INFO] = "DS_EJOY_RES",
  [M.SERVICE.CLOUD_MSG_CHECK] = "DS_RES",
  [M.SERVICE.FREE_DATA_PKG_CHECK] = "DS_RES",
  [M.SERVICE.FREE_DATA_PKG_RECEIVE] = "DS_RES",
  [M.SERVICE.FREE_DATA_PKG_RESULT] = "DS_RES",
  [M.SERVICE.GET_LOGIN_USER_INFO] = "FX_LOG",
  [M.SERVICE.REALNAME_INFO_REPORT] = "LX_ACCOUNT",
  [M.SERVICE.ACCOUNT_EVENT_REPORT] = "DS_REPORT",
  [USER_PROTOCOL.SERVICE.LOGIN] = "AC_CENTER",
  [USER_PROTOCOL.SERVICE.IDENTITY_VERIFY_TYPE] = "AC_CENTER",
  [USER_PROTOCOL.SERVICE.IDENTITY_VERIFY] = "AC_CENTER"
}
M.APPID = {FOR_LX_IOS = "404", FOR_LX_ANROID = "403"}
local l_env

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

local function inner_update_ac_center_host(host)
  if host and "" ~= host then
    E.LOG.debug(TAG, "update ac center host >> " .. tostring(host))
    M.URL_BASE.AC_CENTER = host
    E.LOG.debug(TAG, "update ac center host to usercenter >> " .. tostring(host))
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.LOGIN, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.IDENTITY_VERIFY_TYPE, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.IDENTITY_VERIFY, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.CONFIG_CHECK, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.GET_ACCOUNT_ATTRIBUTION, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.HAS_TARGET_ACCOUNT, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.VALIDATE_LOGIN_AUTH_CODE, host)
    USER_PROTOCOL.set_url_base_with_api(USER_PROTOCOL.SERVICE.GET_LOGIN_AUTH_CODE, host)
  end
end

local function init_url()
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    return
  end
  _ejoysdk.log("t_url_base_with_type init url ")
  local env = get_env()
  local api = USER_PROTOCOL.SERVICE.LOGIN
  local server = SERVICE_MAPPING[api]
  _ejoysdk.log("env = " .. tostring(env))
  local url_base
  if env == M.ENV.RELEASE then
    url_base = M.URL_BASE[server]
  elseif env == M.ENV.PRE_RELEASE then
    url_base = M.URL_BASE_PRE_RELEASE[server]
  else
    url_base = M.URL_BASE_DEBUG[server]
  end
  _ejoysdk.log("set_url_base_with_api: " .. url_base)
  inner_update_ac_center_host(url_base)
  local AIRLINE_V2_CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")
  local ac_center_host = AIRLINE_V2_CONFIG.get_airline_api_host()
  E.LOG.debug(TAG, "ac_center_host: " .. tostring(ac_center_host))
  if type(ac_center_host) == "string" and "" ~= ac_center_host then
    inner_update_ac_center_host(ac_center_host)
  end
  USER_PROTOCOL.set_si(E.Sysinfo.utdid())
end

init_url()

function M.set_env(_env)
  E.LOG.debug(TAG, "set_env: " .. tostring(_env))
  l_env = _env
  init_url()
end

function M.update_ac_center_host(host)
  inner_update_ac_center_host(host)
end

function M.enable_log_service_fx(enable_fx)
  if enable_fx then
    SERVICE_MAPPING[M.SERVICE.LOG] = "FX_LOG"
  else
    SERVICE_MAPPING[M.SERVICE.LOG] = "DS_LOG"
  end
  E.LOG.debug(TAG, "enable_log_service_fx:" .. tostring(enable_fx) .. ", service:" .. tostring(SERVICE_MAPPING[M.SERVICE.LOG]))
end

local function get_api_type(api)
  local service_type = SERVICE_MAPPING[api or ""] or nil
  if service_type then
    do return string.sub, service_type or "", 1 end
    return string.sub, service_type or "", 1, 2
  end
  return api
end

local function get_url(api, use_scene)
  local url_base
  local server = SERVICE_MAPPING[api]
  local _env = get_env()
  if _env == M.ENV.RELEASE then
    url_base = M.URL_BASE[server]
  elseif _env == M.ENV.PRE_RELEASE then
    url_base = M.URL_BASE_PRE_RELEASE[server]
  else
    url_base = M.URL_BASE_DEBUG[server]
  end
  local url
  if url_base then
    local ft_version = ""
    if _ejoysdk.os() ~= "harmonyos" and _ejoysdk.os() ~= "weixin" and _ejoysdk.os() ~= "douyin" then
      local aligames = require("ejoysdk_lua.vendors.aligames")
      ft_version = aligames.get_ft_version()
    end
    if "" == ft_version then
      ft_version = "1.0.0"
    end
    url = url_base .. api .. "?ver=1.0&df=json&cver=" .. ft_version .. "&os=" .. E.Sysinfo.os()
    if "LX" == get_api_type(api) then
      url = url .. "&gt=ng"
    end
    if use_scene and type(use_scene) == "string" then
      url = url .. "&use_scene=" .. use_scene
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

local function get_request_game(api_type)
  local pkg_info = E.get_pkg_info()
  local game = {}
  game.gameId = pkg_info.game_id
  if "DS" == api_type then
    game.channelId = pkg_info.channel_id
    game.subChannelId = pkg_info.ds_sub_channel_id
  elseif "LX" == api_type then
    game.channelId = "DG_2"
    if pkg_info.ds_sub_channel_id and pkg_info.ds_sub_channel_id ~= "" then
      game.channelId = pkg_info.ds_sub_channel_id
    end
  end
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = gdp.PLAYER_INFO.get()
  if player_info then
    game.roleId = player_info.player_id
    game.zoneId = player_info.server_id
  end
  return game
end

local function get_request_client(api_type, request_params)
  local client = {}
  client.ve = V.LUA_VERSION
  client.os = E.Sysinfo.os()
  local pkg_info = E.get_pkg_info()
  client.ex = {}
  client.ex.model = E.Sysinfo.model()
  client.ex.net = E.Sysinfo.network_type()
  client.ex.resX = E.Sysinfo.screen().width
  client.ex.resY = E.Sysinfo.screen().height
  client.ex.utdid = pkg_info.utdid
  client.ex.luaVersion = V.LUA_VERSION
  local product_code = E.CONFIG.get_config("product")
  if product_code and "" ~= product_code then
    client.ex.productCode = product_code:lower()
  end
  if client.os == "android" then
    client.fr = client.os .. " " .. E.Sysinfo.os_version()
    client.ex.imei = pkg_info.imei
    client.ex.mf = E.Sysinfo.get_manufacturer()
    client.ex.osId = E.Sysinfo.android_id()
  elseif client.os == "ios" then
    client.fr = E.Sysinfo.machine()
    client.ex.idfa = E.Sysinfo.idfa()
    client.ex.uniqueid = E.Sysinfo.uuid()
    client.ex.sysinfo_ejoy_ext_info = E.Sysinfo.sysinfo_ejoy_ext_info()
  elseif client.os == "windows" or client.os == "harmonyos" or client.os == "weixin" or client.os == "douyin" then
    client.fr = client.os .. " " .. E.Sysinfo.os_version()
  end
  if "DS" == api_type or "FX" == api_type then
    client.si = "123"
    if E.Sysinfo.os() == "ios" then
      client.si = E.Sysinfo.utdid() or ""
    end
    local game = get_request_game(api_type)
    client.gameId = game.gameId
    if request_params and request_params.channelId and "" ~= request_params.channelId then
      client.channelId = request_params.channelId
    else
      client.channelId = game.channelId
    end
    client.pkgInfo = pkg_info
    client.ex.subChannelId = game.subChannelId
    client.ex.dpfr = pkg_info.versions.os_version
    client.ex.packageName = pkg_info.pkg_name
    client.ex.versionName = pkg_info.versions.app_version_name
    client.ex.versionCode = pkg_info.versions.app_version_code
    client.ex.luaVersion = V.LUA_VERSION
    local stat = require("ejoysdk_lua.ejoysdk_stat")
    local trace_id = stat.get_trace_id()
    client.ex.traceId = stat.get_trace_id()
    E.LOG.debug(TAG, "request trace_id:" .. tostring(trace_id))
  elseif "LX" == api_type then
    client.si = lx_si
    if client.os == "android" then
      client.appId = M.APPID.FOR_LX_ANROID
    elseif client.os == "ios" then
      client.appId = M.APPID.FOR_LX_IOS
    end
  end
  return client
end

local function get_body(api, request_data)
  local api_type = get_api_type(api)
  local id = get_request_id(api_type)
  local client = get_request_client(api_type, request_data)
  local body = {}
  body.id = id
  body.client = client
  body.data = request_data or {}
  if "LX" == api_type then
    body.game = get_request_game(api_type)
  end
  return body
end

local function get_request_params()
  return {trace = true}
end

function M.set_si(si)
  if si then
    E.LOG.debug(TAG, "set_si success: " .. tostring(si))
    lx_si = si
  else
    E.LOG.warn(TAG, "set_si failed for si is nil")
  end
end

function M.post(api, params, cb, src, use_scene)
  local url = get_url(api, use_scene)
  E.LOG.debug(TAG, "post url:" .. tostring(url))
  local ds_body = get_body(api, params)
  if src and type(src) == "string" then
    ds_body.client = ds_body.client or {}
    ds_body.client.src = src
  end
  E.LOG.debug(TAG, {post_body = ds_body})
  local request_params = get_request_params()
  E.HTTP.post(url, request_params, E.HTTP.CT_JSON, ds_body, function(resp)
    if resp.status == 200 then
      local api_type = get_api_type(api)
      if "LX" == api_type then
        local body_json = JSON.decode(resp.body)
        if 1 == body_json.state.code then
          E.LOG.debug(TAG, "LX, post response succ, url:" .. url)
          cb(true, body_json.data)
        else
          E.LOG.warn(TAG, "LX, post response failed, url:" .. url .. ", code:" .. body_json.state.code .. ", msg:" .. body_json.state.msg)
          cb(false, body_json.state.code, body_json.state.msg)
        end
      elseif resp.body and #resp.body > 0 then
        local start_with = E.Utils.start_with
        local valid_table = start_with(resp.body, "{")
        if valid_table then
          local body_json = JSON.decode(resp.body)
          body_json = body_json or {}
          E.LOG.debug(TAG, body_json)
          if body_json.state.code == 2000000 then
            E.LOG.debug(TAG, "DS, post response succ, url:" .. tostring(url))
            cb(true, body_json.data)
          else
            E.LOG.warn(TAG, "DS, post response failed, url:" .. tostring(url) .. ", code:" .. tostring(body_json.state.code) .. ", msg:" .. tostring(body_json.state.msg))
            cb(false, body_json.state.code, body_json.state.msg)
          end
        else
          E.LOG.debug(TAG, "DS server resp: " .. tostring(resp.body))
          E.LOG.warn(TAG, "DS, post response parse failed, not a valid json, url:" .. tostring(url))
          cb(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_JSON_DECODE_ERROR, "body not a valid json")
        end
      end
    else
      E.LOG.warn(TAG, "post response failed, url:" .. url .. ", status:" .. tostring(resp.status))
      cb(false, resp.status, "请求出错")
    end
  end)
end

return M
