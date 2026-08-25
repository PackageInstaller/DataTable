local GAME_CB_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.game_cb_interceptor")
local SUB_PKG_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.sub_pkg_interceptor.sub_pkg_interceptor")
local SPLIT_PKG_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "UPDATE_INTERCEPTORS"
local interceptors = {}

function M.add_interceptor(interceptor)
  local next_interceptor = M.get_last_interceptor()
  interceptor:set_next_interceptor(next_interceptor)
  E.LOG.debug(TAG, "set next interceptor, interceptor is " .. tostring(interceptor:get_interceptor_name()) .. ", next interceptor is " .. tostring(next_interceptor:get_interceptor_name()))
  table.insert(interceptors, interceptor)
end

function M.get_interceptors()
  return interceptors
end

function M.init(res_info, listeners)
  local is_sub_pkg_interceptor_enable = SUB_PKG_INTERCEPTOR.enable_interceptor()
  local is_split_pkg_interceptor_enable = SPLIT_PKG_INTERCEPTOR.enable_interceptor()
  interceptors = {}
  if is_sub_pkg_interceptor_enable or is_split_pkg_interceptor_enable then
    GAME_CB_INTERCEPTOR.init(listeners, res_info.engine_handler)
    table.insert(interceptors, 1, GAME_CB_INTERCEPTOR)
    if is_sub_pkg_interceptor_enable then
      M.add_interceptor(SUB_PKG_INTERCEPTOR)
    elseif is_split_pkg_interceptor_enable then
      M.add_interceptor(SPLIT_PKG_INTERCEPTOR)
    end
  end
end

function M.get_last_interceptor()
  if next(interceptors) then
    local last_interceptor = interceptors[#interceptors]
    return last_interceptor
  end
end

return M
