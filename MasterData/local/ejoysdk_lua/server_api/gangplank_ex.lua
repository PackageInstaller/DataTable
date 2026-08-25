local BASE_API = require("ejoysdk_lua.libs.base_api")
local gangplank_api = BASE_API:New("gangplank")
local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_config")
local TAG = EM.MODULE.SERVER_API .. "gangplank_ex"
local M = {}

local function gangplank_v2_api(api)
  local product = E.CONFIG.get_config("product"):lower()
  api = "/v2" .. api
  if EC.is_force_use_rule_service_splice_in_path("gangplank") then
    return api
  end
  return "/gp/" .. product .. api
end

M.get_players2 = user_info_api.get_players2

function M.validate_qrcode_uuid_http(uuid, extra_params, cb)
  local body = {uuid = uuid}
  for key, value in pairs(extra_params) do
    body[key] = value
  end
  local opt = {}
  opt.enable_sign_headers_for_request = true
  opt.enable_sign_headers_for_response = EG.check_if_prevent_replay_status_open()
  gangplank_api:post(gangplank_v2_api("/validate_uuid"), {}, body, opt, cb)
end

function M.validate_qrcode_uuid_http_v2(uuid, extra_params, cb)
  local body = {uuid = uuid}
  for key, value in pairs(extra_params) do
    body[key] = value
  end
  local opt = {}
  opt.enable_sign_headers_for_request = true
  opt.enable_sign_headers_for_response = EG.check_if_prevent_replay_status_open()
  gangplank_api:post(gangplank_v2_api("/qrcode/login/query"), {}, body, opt, function(succ, ...)
    local _body, code, msg
    if succ then
      E.LOG.debug(TAG, "validate_qrcode_uuid_http_v2 succ")
      _body = (...)
    else
      code, msg, _body = ...
      E.LOG.debug(TAG, "validate_qrcode_uuid_http_v2 failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    _body = _body or {}
    _body.scan_type = "login_v2"
    if succ then
      cb(true, _body)
    else
      cb(false, code, msg, _body)
    end
  end)
end

function M.get_login_qrcode_http(cb)
  local body = {
    game_code = E.CONFIG.get_config("product"),
    scan_type = "LOGIN"
  }
  gangplank_api:post(gangplank_v2_api("/gen_uuid"), {}, body, {}, cb)
end

function M.get_login_qrcode_http_v2(cb)
  E.LOG.debug(TAG, "get_login_qrcode_http_v2 begin")
  local body = {
    pkg_info = E.get_pkg_info()
  }
  gangplank_api:post(gangplank_v2_api("/qrcode/login/acquire"), {}, body, {}, cb)
end

function M.grant_login_uuid_http(uuid, cb)
  E.LOG.debug(TAG, "grant_login_uuid_http")
  local body = {}
  body.uuid = uuid
  body.grant_type = "LOGIN"
  body.token = EG.user_info().token
  body.game = E.CONFIG.get_config("product")
  local tempExt = {}
  tempExt.ptoken = EG.user_info().ptoken or ""
  body.ext = tempExt
  local opt = {}
  opt.enable_sign_headers_for_request = true
  opt.enable_sign_headers_for_response = EG.check_if_prevent_replay_status_open()
  gangplank_api:post(gangplank_v2_api("/grant_uuid_access"), {}, body, opt, cb)
end

function M.grant_login_uuid_http_v2(uuid, cb)
  E.LOG.debug(TAG, "grant_login_uuid_http_v2")
  local body = {}
  body.uuid = uuid
  local user_info = EG.user_info()
  body.token = user_info.token
  local authorized_infos = {
    with = user_info.with,
    region = user_info.region,
    ptoken = user_info.ptoken,
    platform = user_info.platform,
    guest = user_info.guest,
    game = user_info.game,
    pid = user_info.pid,
    ext = user_info.ext,
    appname = E.Sysinfo.app_name(),
    client_params = "ext info"
  }
  body.authorized_infos = authorized_infos
  E.LOG.debug(TAG, "before grant >>")
  E.log(authorized_infos)
  local opt = {}
  opt.enable_sign_headers_for_request = true
  opt.enable_sign_headers_for_response = EG.check_if_prevent_replay_status_open()
  gangplank_api:post(gangplank_v2_api("/qrcode/login/authorize"), {}, body, opt, cb)
end

function M.get_protocol(params, cb)
  gangplank_api:get("/policy/protocol", {
    acceptable = E.HTTP.CT_JSON
  }, params, {}, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "get protocol fail")
      cb(false, ...)
    end
  end)
end

function M.get_game_protocol(params, cb)
  gangplank_api:get("/game_agreement/protocol_data", {
    acceptable = E.HTTP.CT_JSON
  }, params, {}, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp and resp.data)
    else
      E.LOG.debug(TAG, "get game protocol fail")
      cb(false, ...)
    end
  end)
end

return M
