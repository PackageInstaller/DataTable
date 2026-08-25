local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local config

local function init_config()
  config = E.CONFIG.get_vendor_config("NOONE") or {}
end

function M.get_noone_h5_api_host()
  if nil == config then
    init_config()
  end
  local h5_url_base = config.h5_url_base
  return h5_url_base
end

function M.get_noone_secret()
  if nil == config then
    init_config()
  end
  local secret = config.secret
  return secret
end

function M.get_noone_auto_login()
  if nil == config then
    init_config()
  end
  local auto_login = config.auto_login
  return auto_login
end

return M
