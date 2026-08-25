local E = require("ejoysdk_lua.ejoysdk")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local MODULE_NAME = SC.STARTUP_CORE_MODULE_NAME.SELF_UPDATE_FLOW
local TAG = MODULE_NAME
local M = FLOW_TASK:new(MODULE_NAME)

function M:_init(_module_mgr_instance)
  self._data = {module_instance = _module_mgr_instance}
end

function M:run()
  E.LOG.d(TAG, "begin run")
  self:run_next()
end

return M
