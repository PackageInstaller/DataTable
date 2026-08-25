local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EJ_SIGN = require("ejoysdk_lua.libs.signature")
local M = Class:Inherit("SERVER_BASE_API")
local HTTP = E.HTTP
local TAG = EM.MODULE.LIBS .. "base_api"
M.CT_URLENCODED = HTTP.CT_URLENCODED
M.CT_JSON = HTTP.CT_JSON
M.CT_FORMDATA = HTTP.CT_FORMDATA
local default_content_type = M.CT_JSON
local default_acceptable = M.CT_JSON
local CONTENT_TYPE = "Content-Type"

local function create_http_params(headers, opt)
  local params = {
    trace = opt.trace,
    headers = headers
  }
  params.headers[CONTENT_TYPE] = headers[CONTENT_TYPE] or default_content_type
  if opt.use_ejoy_token then
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    params.headers["Ejoy-Token"] = EG.user_info().token
  end
  if opt.use_moment_token then
    local HOLO = require("ejoysdk_lua.ejoysdk_holo")
    local m_token = HOLO.get_player_token()
    params.headers["moment-Token"] = m_token
  end
  params.enable_sign_headers_for_request = opt and opt.enable_sign_headers_for_request or false
  params.enable_sign_headers_for_response = opt and opt.enable_sign_headers_for_response or false
  params.acceptable = default_acceptable
  return params
end

local function create_http_resp_handler(cb)
  return function(resp)
    if resp.status == 200 then
      if resp.body and 0 == resp.body.code or resp.body and 200 == resp.body.code then
        cb(true, resp.body)
      else
        cb(false, resp.body and resp.body.code, resp.body and resp.body.message, resp.body)
      end
    else
      cb(false, resp.status, "HTTP error")
    end
  end
end

function M:post(api, headers, body, opt, cb)
  assert(api, "base server post request, api is nil!")
  local url = E.CONFIG.get_config(self.service) .. api
  headers = headers or {}
  body = body or {}
  opt = opt or {}
  local params = create_http_params(headers, opt)
  local handler = create_http_resp_handler(cb)
  E.LOG.debug(TAG, params.headers)
  HTTP.post(url, params, params.headers[CONTENT_TYPE], body, handler)
end

function M:get(api, headers, query, opt, cb)
  assert(api, "base server get request, api is nil!")
  local url = E.CONFIG.get_config(self.service) .. api
  headers = headers or {}
  query = query or {}
  opt = opt or {}
  local url_query = HTTP.urlencode2(query)
  if url_query and "" ~= url_query then
    url = url .. "?" .. url_query
  end
  local params = create_http_params(headers, opt)
  local handler = create_http_resp_handler(cb)
  HTTP.get(url, params, handler)
end

function M:save_secret(client_private, m_token, exchange_data, signature_versions)
  EJ_SIGN.save_secret(client_private, m_token, exchange_data, signature_versions)
end

function M:_init(service_name)
  assert(service_name, "service_name empty!")
  self.service = service_name
  local CONFIG = require("ejoysdk_lua.ejoysdk_config")
  CONFIG.register_service(self.service)
end

return M
