local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local M = {}
local TAG = "jym_token_transmission_helper"

local function load_cgs_properties()
  local files_path = "/data/data/" .. E.Sysinfo.package_name() .. "/cgs_temporary.properties"
  do return utils.load_properties end
  return utils.load_properties, files_path
end

local function try_load_update_event(ds_token)
  local cgs_properties = load_cgs_properties()
  E.log(cgs_properties)
  if cgs_properties and cgs_properties.lx_account_id_fetch_token then
    local params = {
      deviceToken = cgs_properties.lx_account_id_fetch_token,
      token = ds_token
    }
    E.LOG.d(TAG, {ds_request_data = params})
    local request_data = {
      event = "jym.account.authorize.bind",
      params = params
    }
    DSP.post(DSP.SERVICE.ACCOUNT_EVENT_REPORT, request_data, function(succ, ...)
      E.LOG.debug(TAG, "account event report, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
    end)
  else
    E.LOG.debug(TAG, "cgs_properties is empty")
  end
end

function M.init()
  ET.subscribe(ET.gangplank.AUTH_SUCC, function(user_info)
    E.LOG.debug(TAG, "aligames auth_handler ")
    if user_info and user_info.ptoken then
      E.LOG.debug(TAG, "user info ptoken >> " .. tostring(user_info.ptoken))
      pcall(try_load_update_event, user_info.ptoken)
    end
  end)
end

return M
