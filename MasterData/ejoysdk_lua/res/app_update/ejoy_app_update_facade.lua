local AUM = require("ejoysdk_lua.res.app_update.app_update_manager")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "APP_UPDATE#ejoy_app_update_presenter"

function M.check_update(params, listeners, cb)
  params = params or {}
  AUM.set_game_listeners(listeners)
  E.LOG.debug(TAG, "get_configs_with_options start")
  params.need_show_install_guide = false
  AUM.request_config_and_run_update(params, cb)
end

return M
