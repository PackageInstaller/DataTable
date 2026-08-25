local E = require("ejoysdk_lua.ejoysdk")
local TAG = "system_info"
local M = {}

function M.get_cutout_info(cb)
  E.Sysinfo.cutout_async(function(cutout_info)
    E.LOG.debug(TAG, "cutout_async received >>")
    E.log(cutout_info)
    cb(cutout_info)
  end)
end

function M.get_time_ms(cb)
  cb(tostring(E.time_ms()))
end

return M
