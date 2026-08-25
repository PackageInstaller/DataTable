local BASE_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.base_interceptor")
local E = require("ejoysdk_lua.ejoysdk")
local INTERCEPTOR_NAME = "GAME_CB_INTERCEPTOR"
local M = BASE_INTERCEPTOR:New(INTERCEPTOR_NAME, true)
local TAG = INTERCEPTOR_NAME

function M.init(listeners, engine_handler)
  for func_key, func in pairs(listeners) do
    M[func_key] = func
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_startup_config_changed] then
    E.LOG.debug(TAG, "call on_startup_config_changed >>>>>")
    M[BASE_INTERCEPTOR.INTERFACES.on_startup_config_changed] = function(_cur_product_code, _is_review, _common_startup_config, _review_startup_config, cb)
      cb(true)
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_request_file_list] then
    E.LOG.debug(TAG, "set game_cb_interceptor on_request_file_list")
    M[BASE_INTERCEPTOR.INTERFACES.on_request_file_list] = function(ext_info, file_list_cb)
      if engine_handler.on_request_file_list then
        engine_handler.on_request_file_list(ext_info, file_list_cb)
      else
        file_list_cb(true, ext_info.file_list, nil, false)
      end
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_show_app_update_ui] then
    M[BASE_INTERCEPTOR.INTERFACES.on_show_app_update_ui] = function(_update_info, close_cb)
      close_cb()
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_res_pre_apply] then
    M[BASE_INTERCEPTOR.INTERFACES.on_res_pre_apply] = function(_engine_context, _res_location, _apply_dest_path, _res_state_infos, cb)
      cb(true)
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_res_valid_check] then
    M[BASE_INTERCEPTOR.INTERFACES.on_res_valid_check] = function(check_cb)
      check_cb(true)
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_res_repair] then
    M[BASE_INTERCEPTOR.INTERFACES.on_res_repair] = function()
    end
  end
  if not M[BASE_INTERCEPTOR.INTERFACES.on_confirm_res_apply] then
    M[BASE_INTERCEPTOR.INTERFACES.on_confirm_res_apply] = function(confirm_cb)
      confirm_cb(true)
    end
  end
end

return M
