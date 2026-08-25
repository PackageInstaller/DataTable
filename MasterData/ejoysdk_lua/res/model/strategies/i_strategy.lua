local Class = require("ejoysdk_lua.ejoysdk_class")
local TAG = "DownloadStrategyInterface"
local M = Class:Inherit(TAG)

function M.register_state_change_listener(_lis, _listen_strategy)
  assert(false, "register_state_change_listener should override by implements")
end

function M.unregister_state_change_listener(_lis)
  assert(false, "unregister_state_change_listener should override by implements")
end

function M.tostring()
  return "not implements"
end

return M
