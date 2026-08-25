local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ML = require("ejoysdk_lua.vendors.media_log")
local TAG = EM.MODULE.NATIVE .. "modules.logbus"
local M = {}

function M.commit_event(event_name, param, opts)
  opts = opts or {}
  if opts[ML.OPT_KEY.COMMIT_ONLY_ONCE] == nil then
    opts[ML.OPT_KEY.COMMIT_ONLY_ONCE] = false
  end
  if nil == opts[ML.OPT_KEY.MEDIAS] and nil == opts[ML.OPT_KEY.INCLUDE_ALL_MEDIAS] then
    opts[ML.OPT_KEY.INCLUDE_ALL_MEDIAS] = true
    opts[ML.OPT_KEY.MEDIAS] = {"JF"}
  end
  E.LOG.debug(TAG, "commit_event:" .. tostring(event_name))
  E.log(param)
  E.log(opts)
  ML.commit_event(event_name, param, opts)
end

return M
