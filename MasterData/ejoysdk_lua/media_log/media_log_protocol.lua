local E = require("ejoysdk_lua.ejoysdk")
local V = require("ejoysdk_lua.version")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.MEDIA_LOG_PROTOCOL .. "media_log_protocol"
local M = {}
M.MEDIA_LOG_ERROR_CODES = {CODE_RESPONSE_INVALID = 95000999}
M.SERVICE = {
  QUERY_EVENT_SEQ = "queryEventSeq"
}

local function get_url(api)
  api = api or ""
  local base_url = "https://cddp-jp.qookkagames.com"
  local url = base_url .. "/client/" .. api .. "?ver=1.0&df=json&gt=ng&cver=" .. V.LUA_VERSION .. "&os=" .. E.Sysinfo.os()
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
  client.ve = V.LUA_VERSION
  client.os = E.Sysinfo.os()
  local pkg_info = E.get_pkg_info()
  client.gameId = pkg_info.game_id
  client.pkgInfo = pkg_info
  return client
end

local function get_request_body(params)
  local id = get_request_id()
  local client = get_request_client()
  local pkg_info = E.get_pkg_info()
  if pkg_info then
    client.channelId = pkg_info.channel_id
    client.subChannelId = pkg_info.ds_sub_channel_id
  end
  local body = {}
  body.id = id
  body.client = client
  body.data = params
  return body
end

function M.post_to(url, _api, params, cb)
  E.LOG.debug(TAG, "post, url:" .. url)
  local request_body = get_request_body(params)
  E.LOG.debug(TAG, "post, body>>")
  E.LOG.debug(TAG, request_body)
  E.HTTP.post(url, {
    acceptable = E.HTTP.CT_JSON
  }, E.HTTP.CT_JSON, request_body, function(resp)
    E.LOG.debug(TAG, "post response received, url:" .. tostring(url))
    if resp.status == 200 then
      local body_json = resp.body
      if body_json.state then
        E.LOG.debug(TAG, body_json)
        if body_json.state.code == 2000000 then
          E.LOG.debug(TAG, "post response succ, url:" .. tostring(url))
          cb(true, body_json.data)
        else
          E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", code:" .. tostring(body_json.state.code) .. ", msg:" .. tostring(body_json.state.msg))
          cb(false, body_json.state.code, body_json.state.msg, body_json.data)
        end
      else
        E.LOG.warn(TAG, "post response failed, url:" .. tostring(url) .. ", body.state is nil")
        cb(false, M.MEDIA_LOG_ERROR_CODES.CODE_RESPONSE_INVALID, "响应无法解析")
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

return M
