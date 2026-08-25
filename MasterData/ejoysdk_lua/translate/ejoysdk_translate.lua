local EH = require("ejoysdk_lua.ejoysdk_holo")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local HTTP = E.HTTP
local M = {}
local TAG = EM.MODULE.TRANSLATE .. "translate"

local function _do_post(url, params, body, cb)
  HTTP.post(url, params, HTTP.CT_JSON, body, function(resp)
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

local function request_translate(content, from_lan, to_lan, content_type, cb)
  local player_token = EH.get_player_token()
  if nil == player_token or "" == player_token then
    local err_msg = "request_translate failed. moment-token is nil, should call this method after set role info!"
    E.LOG.warn(TAG, err_msg)
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PLAYER_TOKEN_INVALID, err_msg)
    return
  end
  local url = EH.holo_url("translate")
  E.LOG.debug(TAG, "request_translate, url:" .. tostring(url))
  assert(url, "request_translate api: translate not found")
  local params = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Moment-Token"] = player_token
    }
  }
  local temp_body = {
    content = content,
    from_lan = from_lan,
    to_lan = to_lan,
    content_type = content_type
  }
  _do_post(url, params, temp_body, function(status, body)
    E.LOG.debug(TAG, "request_translate response, status:" .. tostring(status))
    if 200 == status then
      cb(true, body)
    else
      cb(false, body.code or status, body.message or "")
    end
  end)
end

function M.translate(content, opts, cb)
  local temp_opts = opts or {}
  local from_lang = temp_opts.from_lang or nil
  local to_lang = temp_opts.to_lang or nil
  local content_type = temp_opts.content_type or nil
  if not to_lang or "" == to_lang then
    local err_msg = "translate failed, for to_lan is invalid"
    E.LOG.warn(TAG, err_msg)
    cb(false, CONSTANTS.TRANSLATE_ERROR_CODES.CODE_INVALID_PARAMETERS, err_msg)
    return
  end
  E.LOG.debug(TAG, "begin translate, from_lan:" .. (from_lang or "nil") .. ", to_lan:" .. tostring(to_lang))
  request_translate(content, from_lang, to_lang, content_type, function(succ, ...)
    if succ then
      local body = (...)
      E.LOG.debug(TAG, "translate request_translate succ, body>>")
      cb(true, body)
    else
      local err_code, err_msg = ...
      E.LOG.warn(TAG, "translate request_translate faild, err_code:" .. tostring(err_code) .. ", err_msg:" .. tostring(err_msg))
      cb(false, err_code, err_msg)
    end
  end)
end

return M
