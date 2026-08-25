local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local HISTORY = require("ejoysdk_lua.airline_v2.airline_v2_history")
local EM = require("ejoysdk_lua.ejoysdk_module")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local M = {}
local config
local _TAG = EM.MODULE.AIRLINE_V2 .. "config"

local function init_config()
  config = E.CONFIG.get_vendor_config("AIRLINE_V2") or {}
end

function M.get_airline_brand()
  if nil == config or 0 == E_UTILS.tablelength(config) then
    init_config()
  end
  local brand = config.brand or "lingxi"
  return brand
end

function M.get_airline_api_host()
  if nil == config then
    init_config()
  end
  local api_url_base = config.api_url_base
  return api_url_base
end

function M.get_airline_h5_url_host()
  if nil == config then
    init_config()
  end
  local h5_url_base = config.h5_url_base
  return h5_url_base
end

function M.get_config_center_base_url()
  if nil == config then
    init_config()
  end
  local config_center_base_url = config.config_center_base_url
  return config_center_base_url
end

function M.fill_start_up_data(start_up_data)
  if not start_up_data then
    return
  end
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  local AEGIS_DATA = require("ejoysdk_lua.aegis.aegis_collect_data")
  local auth_info = HISTORY.get_auth_info()
  local airlineToken = (auth_info or {}).airlineToken
  local accountId = (auth_info or {}).accountId
  local params_ds_token = gdp.USER_INFO.get("ptoken", airlineToken)
  if not start_up_data.pkg_info then
    start_up_data.pkg_info = E.get_pkg_info()
  end
  if not start_up_data.airlineToken then
    start_up_data.airlineToken = airlineToken
  end
  if not start_up_data.accountId then
    start_up_data.accountId = accountId
  end
  if not start_up_data.ds_token then
    start_up_data.ds_token = params_ds_token
  end
  if not start_up_data.aegis_data then
    start_up_data.aegis_data = AEGIS_DATA.get_encrypt_data()
  end
  if not start_up_data.ejoysdk_ver then
    start_up_data.ejoysdk_ver = E.get_sdk_version_name("EJOYSDK")
  end
end

function M.get_white_hosts()
  local airline_v2_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_CN)
  local res = (airline_v2_config or {}).config or {}.white_host or {}
  local h5_full_url = M.get_airline_h5_url_host()
  if h5_full_url then
    local host = E.HTTP.parse(h5_full_url).host
    if host then
      table.insert(res, host)
    end
  end
  return res
end

return M
