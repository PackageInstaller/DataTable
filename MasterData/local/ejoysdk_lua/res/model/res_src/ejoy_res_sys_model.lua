local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local MODEL_NAME = "EjoyResSysModel"
local M = RTM:Inherit(MODEL_NAME)
M.RES_NAMES = {
  IOS_CLOUD_GAME_RES = "IOS_CLOUD_GAME_RES"
}

function M:_init()
  self._data = {}
  self:log_debug("_init begin:")
end

function M:get_model_name()
  return MODEL_NAME
end

function M:check_res_update(_cb)
end

function M:prepare_res_list_for_download(_res_name, _cb)
end

function M:check_local_res_state(_res_name, _cb)
end

function M:get_res_location()
end

function M:register_res_state_listener()
end

function M:remove_res()
end

function M:start_download(_cb)
end

return M
