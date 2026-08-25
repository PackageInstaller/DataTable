local E = require("ejoysdk_lua.ejoysdk")
local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
local TAG = "device_id_manager"
local M = {}
local is_init = false
local model

local function is_overseas()
  do return E.CONFIG.get_config end
  return E.CONFIG.get_config, E.CONFIG.KEY.MULTI_REGIONS_ENABLED
end

local function init_model()
  if model then
    return model
  end
  if is_overseas() then
    model = require("ejoysdk_lua.device_id.overseas_device_id")
  else
    model = require("ejoysdk_lua.device_id.aligames_device_id")
  end
  model.init()
end

local build_device_token = AGST_TOKEN.build_agst_token

function M.get_token(cb)
  if not is_init then
    E.LOG.debug(TAG, "get_token not init now start init")
    M.init()
  end
  model:get_device_info(function(pid, ext)
    if pid then
      E.LOG.debug(TAG, "device pid :" .. tostring(pid))
      cb(build_device_token(pid, ext))
    else
      E.LOG.warn(TAG, "get pid failed")
      cb(nil)
    end
  end)
end

function M.current_token_has_risk()
  do return end
  return model.check_token_has_risk, nil
end

function M.init()
  if is_init then
    return
  end
  init_model()
  is_init = true
end

return M
