local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local M = Class:Inherit("START_UP_RES_BASE_INTERCEPTOR")
local TAG = "START_UP_RES_BASE_INTERCEPTOR"
local INTERFACES = {
  on_confirm_res_update = "on_confirm_res_update",
  on_startup_update_complete = "on_startup_update_complete",
  on_res_download_progress_change_listener = "on_res_download_progress_change_listener",
  on_res_apply_progress_change_listener = "on_res_apply_progress_change_listener",
  on_startup_config_changed = "on_startup_config_changed",
  on_res_repair = "on_res_repair",
  on_res_pre_apply = "on_res_pre_apply",
  on_res_valid_check = "on_res_valid_check",
  on_request_file_list = "on_request_file_list",
  on_show_app_update_ui = "on_show_app_update_ui",
  on_confirm_res_apply = "on_confirm_res_apply",
  on_splitpkg_res_update_complete = "on_splitpkg_res_update_complete",
  on_game_exit = "on_game_exit"
}
M.INTERFACES = INTERFACES

function M:_init(interceptor_name, is_end_interceptor)
  self.interceptor_name = interceptor_name
  if not is_end_interceptor then
    for _, interface in pairs(INTERFACES) do
      self[interface] = function(...)
        self:proceed_next_intercept(interface, ...)
      end
    end
  end
end

function M:set_next_interceptor(interceptor)
  self.next_interceptor = interceptor
end

function M:get_interceptor_name()
  return self.interceptor_name
end

function M:proceed_next_intercept(interface_name, ...)
  if not self.next_interceptor then
    E.LOG.debug(TAG, tostring(self.interceptor_name) .. ": no next interceptor, should not call " .. tostring(interface_name))
    return
  end
  if self.next_interceptor[interface_name] then
    E.LOG.debug(TAG, "has next interceptor and has implemented interface, interceptor name is " .. tostring(self.next_interceptor:get_interceptor_name()) .. ", interface: " .. tostring(interface_name))
    self.next_interceptor[interface_name](...)
  else
    E.LOG.debug(TAG, tostring(self.interceptor_name) .. ": next interceptor, not implemented interface: " .. tostring(interface_name))
  end
end

return M
