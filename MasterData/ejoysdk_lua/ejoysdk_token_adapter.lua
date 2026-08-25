local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
local GP = require("ejoysdk_lua.ejoysdk_gangplank")
local TAG = "moment_token_adapter"
local M = {}
M.PLAYER_TOKEN_TYPE = {DEFAUT_TYPE = 1, THIRDPARTY_TYPE = 2}
M.THIRDPARTY_KEY = {
  TOKEN_DATA = "token_data",
  PLAYER_INFO = "player_info"
}
local _token_type = M.PLAYER_TOKEN_TYPE.DEFAUT_TYPE
local _thirdparty_token_body

function M.setup_player_token_type(token_type)
  _token_type = token_type
end

function M.get_player_token_type()
  return _token_type
end

function M.get_player_token()
  if _thirdparty_token_body then
    local moment_token = _thirdparty_token_body and _thirdparty_token_body.moment_token
    return moment_token
  end
  return nil
end

function M.gen_thirdparty_noone_token(n_secret, player_id)
  local md5_token
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_token = _ejoysdk_crypt.md5(player_id .. n_secret)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_token = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(player_id .. n_secret))
  end
  E.log("md5_token:" .. tostring(md5_token))
  return md5_token
end

function M.get_thirdparty_player_token(thirdparty_info, cb)
  if thirdparty_info.id == "noone" and thirdparty_info.secret and thirdparty_info.ext and thirdparty_info.ext.player_login_param and thirdparty_info.ext.player_login_param.player_id then
    thirdparty_info.token = M.gen_thirdparty_noone_token(thirdparty_info.secret, thirdparty_info.ext.player_login_param.player_id)
  end
  user_info_api.get_thirdparty_player_token(thirdparty_info, cb)
end

function M.thirdparty_player_login(player_info, cb)
  if not player_info then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "player_info can not be nil")
    return
  end
  if player_info.server_id == nil or nil == player_info.player_id or nil == player_info.player_name or nil == player_info.player_token then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "server_id , player_id , player_name and player_token can not be nil")
    return
  end
  local expire_time
  if player_info.expire_time and tonumber(player_info.expire_time) then
    expire_time = tonumber(player_info.expire_time)
  else
    expire_time = E.time() + 604800
  end
  if _thirdparty_token_body then
    local GDP = require("ejoysdk_lua.gangplank_data_provider")
    local current_player_id = GDP.PLAYER_INFO.get("player_id")
    local current_player_token = GDP.PLAYER_INFO.get("player_token")
    if current_player_id == player_info.player_id and current_player_token ~= player_info.player_token then
      GP.player_offline()
    end
  end
  _thirdparty_token_body = {
    player_token = player_info.player_token,
    moment_token = player_info.player_token,
    expire_time = expire_time
  }
  GP.set_player_info(player_info, nil, function(succ2, ...)
    if succ2 then
      E.LOG.debug(TAG, "set_player_info succ")
      cb(true, _thirdparty_token_body or {})
    else
      local error_body = (...)
      E.LOG.debug(TAG, "set_player_info false, code:" .. tostring(error_body and error_body.code) .. ", msg:" .. tostring(error_body and error_body.msg))
      cb(false, error_body or {})
    end
  end)
end

function M.get_player_token_facade(player_id, cb)
  if _token_type == M.PLAYER_TOKEN_TYPE.THIRDPARTY_TYPE then
    cb(true, _thirdparty_token_body or {})
  else
    user_info_api.get_player_token_http(player_id, cb)
  end
end

return M
