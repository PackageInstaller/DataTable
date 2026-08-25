local E = require("ejoysdk_lua.ejoysdk")
local V = require("ejoysdk_lua.version")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = EM.MODULE.PROTOCOL .. "cddp_protocol"
local M = {}
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.URL_BASE = {
  CP_CDDP_CBC = "https://cddp-cbc.lingxigames.com/client/"
}
M.URL_BASE_PRE_RELEASE = {
  CP_CDDP_CBC = "http://cddp-cbc.alibaba.net/client/"
}
M.URL_BASE_DEBUG = {
  CP_CDDP_CBC = "http://cddp-cbc.alibaba.net/client/"
}
M.SERVICE = {
  CDDP_QUERY_RULE = "queryRule",
  CDDP_CALLBACK_CONTROL = "callbackControl"
}
local SERVICE_MAPPING = {
  [M.SERVICE.CDDP_QUERY_RULE] = "CP_CDDP_CBC",
  [M.SERVICE.CDDP_CALLBACK_CONTROL] = "CP_CDDP_CBC"
}
local l_env

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

function M.set_env(_env)
  E.LOG.debug(TAG, "set_env: " .. tostring(_env))
  l_env = _env
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

local function get_request_game()
  local pkg_info = E.get_pkg_info()
  local game = {}
  game.gameId = pkg_info.game_id
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = gdp.PLAYER_INFO.get()
  if player_info then
    game.roleId = player_info.player_id
    game.zoneId = player_info.server_id
  end
  return game
end

local function get_request_client()
  local client = {}
  client.ve = V.LUA_VERSION
  client.os = E.Sysinfo.os()
  if client.os == "android" then
    client.fr = client.os .. " " .. E.Sysinfo.os_version()
  elseif client.os == "ios" then
    client.fr = E.Sysinfo.machine()
  elseif client.os == "windows" or client.os == "harmonyos" or client.os == "weixin" or client.os == "douyin" then
    client.fr = client.os .. " " .. E.Sysinfo.os_version()
  end
  local game = get_request_game()
  client.gameId = game.gameId
  return client
end

local function get_body(request_data)
  local id = get_request_id()
  local client = get_request_client()
  local body = {}
  body.id = id
  body.client = client
  body.data = request_data or {}
  return body
end

local function get_request_params()
  return {trace = true}
end

function M.post(api, params, cb, src, use_scene)
  local url = get_url(api, use_scene)
  E.LOG.debug(TAG, "post url:" .. tostring(url))
  local ds_body = get_body(params)
  if src and type(src) == "string" then
    ds_body.client = ds_body.client or {}
    ds_body.client.src = src
  end
  E.LOG.debug(TAG, {post_body = ds_body})
  local request_params = get_request_params()
  E.HTTP.post(url, request_params, E.HTTP.CT_JSON, ds_body, function(resp)
    if resp.status == 200 then
      local body = resp.body
      if body and type(body) == "table" then
        if body.state.code == 2000000 then
          E.LOG.debug(TAG, "CDDP, post response succ, url:" .. tostring(url))
          cb(true, body.data)
        else
          E.LOG.warn(TAG, "CDDP, post response failed, url:" .. tostring(url) .. ", code:" .. tostring(body.state.code) .. ", msg:" .. tostring(body.state.msg))
          cb(false, body.state.code, body.state.msg)
        end
      else
        E.LOG.warn(TAG, "CDDP, post response parse failed, resp.body is nil, url:" .. tostring(url))
        cb(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_JSON_DECODE_ERROR, "body is nil")
      end
    else
      E.LOG.warn(TAG, "post response failed, url:" .. url .. ", status:" .. tostring(resp.status))
      cb(false, resp.status, "请求出错")
    end
  end)
end

return M
