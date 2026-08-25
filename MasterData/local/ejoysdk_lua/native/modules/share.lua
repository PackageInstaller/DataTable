local SOCIAL = require("ejoysdk_lua.social.ejoysdk_social")
local LUTIL = require("ejoysdk_lua.native.utils.Utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.NATIVE .. "modules.share"
local M = {}

function M.share(platform, params, callback)
  local support = SOCIAL.is_support(platform)
  if support then
    SOCIAL.share(platform, params or {}, function(succ, ...)
      if succ then
        LUTIL.notify(callback, true, "share success")
      else
        local code, msg = ...
        LUTIL.notify(callback, false, "share fail", {code = code, msg = msg})
      end
    end)
  else
    LUTIL.notify(callback, false, "platform not support")
  end
end

return M
